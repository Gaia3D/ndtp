$(document).ready(function (){

	$('#civilVoiceMenu').on('click', function() {
		// 초기 레이어 트리 그리기
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
		$("#civilVoiceListContent").hide();
		$("#civilVoiceDetailContent").show();
	});
});

// 시민참여 목록 조회
function getCivilVoiceList() {
	$.ajax({
		url: '/civil-voices',
		type: 'GET',
		headers: {'X-Requested-With': 'XMLHttpRequest'},
		contentType: "application/json; charset=utf-8",
		dataType: 'json',
		success: function(res){
			if(res.statusCode <= 200) {
				var count = res.civilVoiceList.length;
				$('#civilVoiceTotalCount').text(count);

				if(count > 0) {
					// html 생성
					createCivilVoiceHtml(res.civilVoiceList);
				} else {

				}
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

// 시민참여 HTML 렌더링
function createCivilVoiceHtml(res) {
	var source = $("#templateCivilVoiceList").html();
	var template = Handlebars.compile(source);
	var html = template(res);
	$('#civilVoiceList').empty().append(html);
}
