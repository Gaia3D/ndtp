var civilVoice = civilVoice || {};

function CivilVoice(magoInstance) {
	var viewer = magoInstance.getViewer();
	civilVoice = $.extend(civilVoice, new CivilVoiceControll(magoInstance, viewer));
}

function CivilVoiceControll(magoInstance, viewer) {
	var that = this;
	var magoManager = magoInstance.getMagoManager();

	var store = {
		contents: {
			list: $("#civilVoiceListContent"),
			input: $("#civilVoiceInputContent"),
			modify: $("#civilVoiceModifyContent"),
			detail: $("#civilVoiceDetailContent")
		},
		marker: {
			// 마커 색상 - https://cesium.com/docs/cesiumjs-ref-doc/Color.html
			color: Cesium.Color.DARKORANGE,
			size: 52
		},
		beforeEntity: null
	}

	function toggleContent(target) {
		var viewList = store.contents;
		// hide all
		for(var property in viewList) {
			var content = viewList[property];
			content.hide();
		}
		// show target
		var targetContent = viewList[target];
		targetContent.show();
	}

	function removeStoredEntity() {
		if(store.beforeEntity) {
			viewer.entities.removeById(store.beforeEntity);
			store.beforeEntity = null;
		}
	}


	// public
	return {
		/************************** Map ***************************/
		cluster: {
			list: null,
			refresh: function() {
				getCivilVoiceListAll();
			},
		},
		clear: function() {
			removeStoredEntity();

		},
		flyToLocation: function(longitude, latitude, commentCount) {
			this.flyTo(longitude, latitude);
			this.drawMarker(longitude, latitude);
			this.updateMarker(commentCount);
		},
		flyTo: function(longitude, latitude) {
			var altitude = 100;
			var duration = 5;
			magoManager.flyTo(longitude, latitude, altitude, duration);
		},
		drawMarker: function(longitude, latitude) {
			removeStoredEntity();

			var x = Number(longitude);
	   		var y = Number(latitude);

	   		var pinBuilder = new Cesium.PinBuilder();
	   		var addedEntity = viewer.entities.add({
	   		    name : 'Location',
	   		    position : Cesium.Cartesian3.fromDegrees(x, y),
	   		    billboard : {
	   	        	disableDepthTestDistance : Number.POSITIVE_INFINITY,
	   				heightReference: Cesium.HeightReference.CLAMP_TO_GROUND,
	   		        image : pinBuilder.fromColor(store.marker.color, store.marker.size).toDataURL(),
	   	            horizontalOrigin : Cesium.HorizontalOrigin.CENTER,
	   	            verticalOrigin : Cesium.VerticalOrigin.BOTTOM
	   		    }
	   		});

			store.beforeEntity = addedEntity.id;
		},
		updateMarker: function(count) {
			if(store.beforeEntity) {
				var entity = viewer.entities.getById(store.beforeEntity);
				if(entity) {
					var pinBuilder = new Cesium.PinBuilder();
					var markerImage = pinBuilder.fromText(count, store.marker.color, store.marker.size).toDataURL();
					entity.billboard.image.setValue(markerImage);
				}
			}
		},
		getGeographicCoord: function() {
			magoManager.once(Mago3D.MagoManager.EVENT_TYPE.CLICK, function(result) {
				var geographicCoord = result.clickCoordinate.geographicCoordinate;
				civilVoice.drawMarker(geographicCoord.longitude, geographicCoord.latitude);
				$('#civilVoiceContent [name=longitude]:visible').val(geographicCoord.longitude);
				$('#civilVoiceContent [name=latitude]:visible').val(geographicCoord.latitude);
			});
		},
		/********************************************************/
		currentPage: null,
		currentCivilVoiceId: null,
		showContent: toggleContent,
		initFormContent: function(formId) {
			$('#' + formId + ' input').val("");
			$('#' + formId + ' textarea').val("");
		},
		drawHandlebarsHtml: function(data, templateId, targetId) {
			var source = $('#' + templateId).html();
			var template = Handlebars.compile(source);
			var html = template(data);
			$('#' + targetId).empty().append(html);
		}
	}
}


$(document).ready(function() {
	getCivilVoiceList();
	getCivilVoiceListAll();
});

// 시민참여 탭 클릭시 조회
$('#civilVoiceMenu').on('click', function() {
	if($(this).hasClass('on')){
		getCivilVoiceList();
		getCivilVoiceListAll();
	}
});

// 시민참여 위치보기
$('#civilVoiceList').on('click', '.goto', function(e) {
	e.stopPropagation();
	var longitude = $(this).data('longitude');
	var latitude = $(this).data('latitude');
	var commentCount = $(this).data('count');
	civilVoice.flyToLocation(longitude, latitude, commentCount);
});

// 시민참여 상세보기
$('#civilVoiceContent').on('click', 'li.comment', function() {
	civilVoice.showContent('detail');
	// set current id
	var id = $(this).data('id');
	civilVoice.currentCivilVoiceId = id;
	// get data
	getCivilVoiceDetail();
	getCivilVoiceCommentList();
});

// 시민참여 등록 화면 이동
$("#civilVoiceInputButton").on('click', function(){
	civilVoice.showContent('input');
	civilVoice.clear();
});

// 시민참여 수정 화면 이동
$('#civilVoiceContent').on('click', '#civilVoiceModifyButton', function(){
	civilVoice.showContent('modify');
	getCivilVoiceModify();
});

// 시민참여 취소 / 목록 보기
$('#civilVoiceContent').on('click', '[data-goto=list]', function(){
	civilVoice.showContent('list');
	getCivilVoiceList(civilVoice.currentPage);
});

// 시민참여 취소 / 상세 보기
$('#civilVoiceContent').on('click', '[data-goto=detail]', function(){
	civilVoice.showContent('detail');
});

// 시민참여 목록 조회
function getCivilVoiceList(page) {
	if(!page) page = 1;
	civilVoice.currentPage = page;
	civilVoice.currentCivilVoiceId = null;
	civilVoice.clear();

	var formId = 'civilVoiceSearchForm';
	var formData = $('#' + formId).serialize();

	$.ajax({
		url: '/civil-voices',
		type: 'GET',
		headers: {'X-Requested-With': 'XMLHttpRequest'},
		data: formData + '&pageNo='+page,
		dataType: 'json',
		success: function(res){
			if(res.statusCode <= 200) {
				$('#civilVoiceTotalCount').text(res.totalCount);
				$('#civilVoiceCurrentPage').text(res.pagination.pageNo);
				$('#civilVoiceLastPage').text(res.pagination.lastPage);
				civilVoice.drawHandlebarsHtml(res, 'templateCivilVoiceList', 'civilVoiceList');
				civilVoice.drawHandlebarsHtml(res, 'templateCivilVoicePagination', 'civilVoicePagination');
			} else {
				alert(JS_MESSAGE[res.errorCode]);
				console.log("---- " + res.message);
				}
		},
		error: function(request, status, error) {
			alert(JS_MESSAGE["ajax.error.message"]);
		}
	});
}

// 시민참여 전체 목록 조회
function getCivilVoiceListAll() {
	$.ajax({
		url: '/civil-voices/all',
		type: 'GET',
		headers: {'X-Requested-With': 'XMLHttpRequest'},
		dataType: 'json',
		success: function(res){
			if(res.statusCode <= 200) {
				civilVoice.cluster.list = res.civilVoiceList;
			} else {
				alert(JS_MESSAGE[res.errorCode]);
				console.log("---- " + res.message);
			}
		},
		error: function(request, status, error) {
			alert(JS_MESSAGE["ajax.error.message"]);
		}
	});
}

// 시민참여 상세 조회
function getCivilVoiceDetail() {
	var id = civilVoice.currentCivilVoiceId;

	$.ajax({
		url: '/civil-voices/' + id,
		type: 'GET',
		headers: {'X-Requested-With': 'XMLHttpRequest'},
		contentType: "application/json; charset=utf-8",
		dataType: 'json',
		success: function(res){
			if(res.statusCode <= 200) {
				civilVoice.drawHandlebarsHtml(res, 'templateCivilVoiceView', 'civilVoiceView');
				civilVoice.flyToLocation(res.civilVoice.longitude, res.civilVoice.latitude, res.civilVoice.commentCount);
			} else {
				alert(JS_MESSAGE[res.errorCode]);
				console.log("---- " + res.message);
				}
		},
		error: function(request, status, error) {
			alert(JS_MESSAGE["ajax.error.message"]);
		}
	});
}

// 시민참여  수정 화면 요청
function getCivilVoiceModify() {
	var id = civilVoice.currentCivilVoiceId;

	$.ajax({
		url: '/civil-voices/' + id,
		type: 'GET',
		headers: {'X-Requested-With': 'XMLHttpRequest'},
		contentType: "application/json; charset=utf-8",
		dataType: 'json',
		data: {readOnly: false},
		success: function(res){
			if(res.statusCode <= 200) {
				civilVoice.drawHandlebarsHtml(res, 'templateCivilVoiceModify', 'civilVoiceModify');
			} else {
				alert(JS_MESSAGE[res.errorCode]);
				console.log("---- " + res.message);
				}
		},
		error: function(request, status, error) {
			alert(JS_MESSAGE["ajax.error.message"]);
		}
	});
}

// 시민참여 댓글 조회
function getCivilVoiceCommentList(page) {
	if(!page) page = 1;
	var id = civilVoice.currentCivilVoiceId;

	$.ajax({
		url: '/civil-voice-comments/' + id,
		type: 'GET',
		headers: {'X-Requested-With': 'XMLHttpRequest'},
		contentType: "application/json; charset=utf-8",
		dataType: 'json',
		data: {pageNo: page},
		success: function(res){
			if(res.statusCode <= 200) {
				$('#civilVoiceCommentTotalCount').text(res.totalCount);
				civilVoice.drawHandlebarsHtml(res, 'templateCivilVoiceComment', 'civilVoiceComment');
				civilVoice.drawHandlebarsHtml(res, 'templateCivilVoiceCommentPagination', 'civilVoiceCommentPagination');

				civilVoice.updateMarker(res.totalCount);
			} else {
				alert(JS_MESSAGE[res.errorCode]);
				console.log("---- " + res.message);
			}
		},
		error: function(request, status, error) {
			alert(JS_MESSAGE["ajax.error.message"]);
		}
	});
}

// 시민참여 등록
var insertCivilVoiceFlag = true;
function saveCivilVoice() {
	if(!civilVoiceValidation($('#civilVoiceForm'))) return false;

	if(insertCivilVoiceFlag) {
		insertCivilVoiceFlag = false;
		var url = "/civil-voices";
		var formId = 'civilVoiceForm';
		var formData = $('#' + formId).serialize();

		$.ajax({
			url: url,
			type: "POST",
			headers: {"X-Requested-With": "XMLHttpRequest"},
			data: formData,
			dataType: "json",
			success: function(msg) {
				if(msg.statusCode <= 200) {
					alert("저장 되었습니다.");
					civilVoice.initFormContent(formId);
					civilVoice.showContent('list');
					civilVoice.clear();
					getCivilVoiceList();
				} else {
					alert(msg.message);
					console.log("---- " + msg.message);
				}
				insertCivilVoiceFlag = true;
			},
	        error: function(request, status, error) {
	        	alert(JS_MESSAGE["ajax.error.message"]);
	        	insertCivilVoiceFlag = true;
	        }
		});
	} else {
		alert("진행 중입니다.");
		return;
	}
}

// 시민참여 수정
var updateCivilVoiceFlag = true;
function updateCivilVoice() {
	if(!civilVoiceValidation($('#civilVoiceModifyForm'))) return false;
	var id = civilVoice.currentCivilVoiceId;

	if(updateCivilVoiceFlag) {
		updateCivilVoiceFlag = false;
		var url = "/civil-voices/" + id;
		var formId = 'civilVoiceModifyForm';
		var formData = $('#' + formId).serialize();

		$.ajax({
			url: url,
			type: "POST",
			headers: {"X-Requested-With": "XMLHttpRequest"},
			data: formData,
			dataType: "json",
			success: function(msg) {
				if(msg.statusCode <= 200) {
					alert("저장 되었습니다.");
					civilVoice.initFormContent(formId);
					civilVoice.showContent('detail');
					civilVoice.clear();
					getCivilVoiceDetail(id);
				} else {
					alert(msg.message);
					console.log("---- " + msg.message);
				}
				updateCivilVoiceFlag = true;
			},
	        error: function(request, status, error) {
	        	alert(JS_MESSAGE["ajax.error.message"]);
	        	updateCivilVoiceFlag = true;
	        }
		});
	} else {
		alert("진행 중입니다.");
		return;
	}
}

// 시민참여 삭제
var deleteCivilVoiceFlag = true;
function deleteCivilVoice(id) {
	if(!deleteWarning()) return false;

	if(deleteCivilVoiceFlag) {
		deleteCivilVoiceFlag = false;
		var url = "/civil-voices/" + id;

		$.ajax({
			url: url,
			type: "DELETE",
			headers: {"X-Requested-With": "XMLHttpRequest"},
			dataType: "json",
			success: function(msg) {
				if(msg.statusCode <= 200) {
					alert("삭제 되었습니다.");
					civilVoice.showContent('list');
					getCivilVoiceList();
				} else {
					alert(msg.message);
					console.log("---- " + msg.message);
				}
				deleteCivilVoiceFlag = true;
			},
	        error: function(request, status, error) {
	        	alert(JS_MESSAGE["ajax.error.message"]);
	        	deleteCivilVoiceFlag = true;
	        }
		});
	} else {
		alert("진행 중입니다.");
		return;
	}
}

// 시민참여 댓글 등록
var insertCivilVoiceCommentFlag = true;
function saveCivilVoiceComment() {
	if(insertCivilVoiceCommentFlag) {
		insertCivilVoiceCommentFlag = false;
		var id = civilVoice.currentCivilVoiceId;
		var url = "/civil-voice-comments";
		var formId = 'civilVoiceCommentForm';
		var formData = $('#' + formId).serialize();

		$.ajax({
			url: url,
			type: "POST",
			headers: {"X-Requested-With": "XMLHttpRequest"},
			data: formData + '&civilVoiceId=' + id,
			dataType: "json",
			success: function(msg) {
				if(msg.statusCode <= 200) {
					alert("등록 되었습니다.");
					civilVoice.initFormContent(formId);

					getCivilVoiceCommentList();
				} else {
		        	alert(JS_MESSAGE[msg.errorCode]);
					console.log("---- " + msg.message);
				}
				insertCivilVoiceCommentFlag = true;
			},
	        error: function(request, status, error) {
	        	alert(JS_MESSAGE["ajax.error.message"]);
	        	insertCivilVoiceCommentFlag = true;
	        }
		});
	} else {
		alert("진행 중입니다.");
		return;
	}
}

// validation
function civilVoiceValidation(form) {
	if(!form.find('[name=title]').val()) {
		alert("제목을 입력하여 주십시오.");
		form.find('[name=title]').focus();
		return false;
	}
	if(!form.find('[name=longitude]').val() || !form.find('[name=latitude]').val()) {
		alert("위치를 지정하여 주십시오.");
		form.find('[name=longitude]').focus();
		return false;
	}
	if(!form.find('[name=contents]').val()) {
		alert("내용을 입력하여 주십시오.");
		form.find('[name=contents]').focus();
		return false;
	}
	return true;
}
