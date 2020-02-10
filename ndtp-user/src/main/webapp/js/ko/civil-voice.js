$(document).ready(function (){

	$('#civilVoiceMenu').on('click', function() {
		// 초기 시민참여 조회
		getCivilVoiceList();
	});

	// 의견등록 버튼 이벤트
	$("#civilVoiceInputButton").click(function(){
		$("#civilVoiceListContent").hide();
		$("#civilVoiceInputContent").show();
	});

	// 등록취소 버튼 이벤트
	$("#civilVoiceCancleButton").click(function(){
		$("#civilVoiceListContent").show();
		$("#civilVoiceInputContent").hide();
	});

	// 목록보기 버튼 이벤트
	$("#civilVoiceListButton").click(function(){
		$("#civilVoiceListContent").show();
		$("#civilVoiceDetailContent").hide();
	});

	// 의견 목록 선택시 상세보기 이벤트
	$('#civilVoiceList').on('click', 'li.comment', function(){
		var id = $(this).data('id');
		$('#civilVoiceId').val(id);
		$("#civilVoiceListContent").hide();
		$("#civilVoiceDetailContent").show();

		getCivilVoiceDetail();
		getCivilVoiceCommentList();
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

function drawHandlebarsHtml(data, templateId, targetId) {
	var source = $('#' + templateId).html();
	var template = Handlebars.compile(source);
	var html = template(data);
	$('#' + targetId).empty().append(html);
}