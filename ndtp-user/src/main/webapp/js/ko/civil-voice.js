$(document).ready(function (){

	// 탭 클릭시 시민참여 조회
	$('#civilVoiceMenu').on('click', function() {
		if($(this).hasClass('on')){
			getCivilVoiceList();
		}
	});

	// 시민참여 입력 폼 조회
	$("#civilVoiceInputButton").click(function(){
		$("#civilVoiceListContent").hide();
		$("#civilVoiceInputContent").show();
	});

	// 시민참여 등록
	$('#civilVoiceCreateButton').click(function() {
		saveCivilVoice();
	});

	// 시민참여 등록 취소
	$("#civilVoiceCancleButton").click(function(){
		$("#civilVoiceListContent").show();
		$("#civilVoiceInputContent").hide();
	});

	// 시민참여 목록 보기
	$("#civilVoiceListButton").click(function(){
		$("#civilVoiceListContent").show();
		$("#civilVoiceDetailContent").hide();

		getCivilVoiceList();
	});

	// 시민참여 상세보기
	$('#civilVoiceList').on('click', 'li.comment', function(){
		var id = $(this).data('id');
		$('#civilVoiceId').val(id);
		$("#civilVoiceListContent").hide();
		$("#civilVoiceDetailContent").show();

		getCivilVoiceDetail();
		getCivilVoiceCommentList();
	});

	// 시민참여 댓글 등록
	$('#civilVoiceAgree').on('click', function() {
		saveCivilVoiceComment();
	});
});

// 시민참여 목록 조회
function getCivilVoiceList(page) {
	if(!page) page = 1;

	$.ajax({
		url: '/civil-voices',
		type: 'GET',
		headers: {'X-Requested-With': 'XMLHttpRequest'},
		contentType: "application/json; charset=utf-8",
		dataType: 'json',
		data: {pageNo: page},
		success: function(res){
			if(res.statusCode <= 200) {
				$('#civilVoiceTotalCount').text(res.totalCount);
				$('#civilVoiceCurrentPage').text(res.pagination.pageNo);
				$('#civilVoiceLastPage').text(res.pagination.lastPage);
				drawHandlebarsHtml(res, 'templateCivilVoiceList', 'civilVoiceList');
				drawHandlebarsHtml(res, 'templateCivilVoicePagination', 'civilVoicePagination');
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
function getCivilVoiceDetail(id) {
	var id = $('#civilVoiceId').val();

	$.ajax({
		url: '/civil-voices/' + id,
		type: 'GET',
		headers: {'X-Requested-With': 'XMLHttpRequest'},
		contentType: "application/json; charset=utf-8",
		dataType: 'json',
		success: function(res){
			if(res.statusCode <= 200) {
				var data = res.civilVoice;
				$('#civilVoiceTitle').text(data.title);
				$('#civilVoiceContents').text(data.contents);
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
	var id = $('#civilVoiceId').val();

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
				drawHandlebarsHtml(res, 'templateCivilVoiceComment', 'civilVoiceComment');
				drawHandlebarsHtml(res, 'templateCivilVoiceCommentPagination', 'civilVoiceCommentPagination');
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
					initFormContent(formId);

					$("#civilVoiceListContent").show();
					$("#civilVoiceInputContent").hide();
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

// 시민참여 댓글 등록
var insertCivilVoiceCommentFlag = true;
function saveCivilVoiceComment() {
	if(insertCivilVoiceCommentFlag) {
		insertCivilVoiceCommentFlag = false;
		var id = $('#civilVoiceId').val();
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
					initFormContent(formId);

					getCivilVoiceCommentList();
				} else {
					alert(msg.message);
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

// 등록 폼 초기화
function initFormContent(formId) {
	$('#' + formId + ' input').val("");
	$('#' + formId + ' textarea').val("");
}

// 핸들바 HTML 생성
function drawHandlebarsHtml(data, templateId, targetId) {
	var source = $('#' + templateId).html();
	var template = Handlebars.compile(source);
	var html = template(data);
	$('#' + targetId).empty().append(html);
}
