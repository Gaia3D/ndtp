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
		beforeEntity: null
	}

	function showContent(target) {
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

	function remove(storedEntity) {
		viewer.entities.removeById(storedEntity);
	}


	// public
	return {
		/*********************** cluster ************************/
		cluster: {
			list: null,
			refresh: function() {
				getCivilVoiceListAll();
			}
		},
		/********************************************************/
		currentPage: null,
		currentCivilVoiceId: null,
		show: showContent,
		initFormContent: function(formId) {
			$('#' + formId + ' input').val("");
			$('#' + formId + ' textarea').val("");
		},
		drawHandlebarsHtml: function(data, templateId, targetId) {
			var source = $('#' + templateId).html();
			var template = Handlebars.compile(source);
			var html = template(data);
			$('#' + targetId).empty().append(html);
		},
		flyTo: function(longitude, latitude) {
			var altitude = 100;
			var duration = 5;
			magoManager.flyTo(longitude, latitude, altitude, duration);
		},
		getGeographicCoord: function() {
			magoManager.once(Mago3D.MagoManager.EVENT_TYPE.CLICK, function(result) {
				if(store.beforeEntity) {
					remove(store.beforeEntity);
				}

				var geographicCoord = result.clickCoordinate.geographicCoordinate;
				var worldCoordinate = result.clickCoordinate.worldCoordinate;

				var pointGraphic = new Cesium.PointGraphics({
					pixelSize : 10,
					heightReference : Cesium.HeightReference.CLAMP_TO_GROUND,
					color : Cesium.Color.AQUAMARINE,
					outlineColor : Cesium.Color.WHITE,
					outlineWidth : 2
				});

				var addedEntity = viewer.entities.add({
					position : new Cesium.Cartesian3(worldCoordinate.x, worldCoordinate.y, worldCoordinate.z),
					point : pointGraphic
				});

				store.beforeEntity = addedEntity.id;
				$('#civilVoiceContent [name=longitude]:visible').val(geographicCoord.longitude);
				$('#civilVoiceContent [name=latitude]:visible').val(geographicCoord.latitude);
			});
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
	civilVoice.flyTo(longitude, latitude);
});

// 시민참여 상세보기
$('#civilVoiceContent').on('click', 'li.comment', function() {
	civilVoice.show('detail');
	// set current id
	var id = $(this).data('id');
	civilVoice.currentCivilVoiceId = id;
	// get data
	getCivilVoiceDetail();
	getCivilVoiceCommentList();
});

// 시민참여 등록 화면 이동
$("#civilVoiceInputButton").on('click', function(){
	civilVoice.show('input');
});

// 시민참여 수정 화면 이동
$('#civilVoiceContent').on('click', '#civilVoiceModifyButton', function(){
	civilVoice.show('modify');
	getCivilVoiceModify();
});

// 시민참여 취소 / 목록 보기
$('#civilVoiceContent').on('click', '[data-goto=list]', function(){
	civilVoice.show('list');
	getCivilVoiceList(civilVoice.currentPage);
});

// 시민참여 취소 / 상세 보기
$('#civilVoiceContent').on('click', '[data-goto=detail]', function(){
	civilVoice.show('detail');
});

// 시민참여 목록 조회
function getCivilVoiceList(page) {
	if(!page) page = 1;
	civilVoice.currentPage = page;
	civilVoice.currentCivilVoiceId = null;

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
					civilVoice.show('list');
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
					civilVoice.show('detail');
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
					civilVoice.show('list');
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
