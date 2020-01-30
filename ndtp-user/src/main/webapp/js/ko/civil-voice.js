$(document).ready(function (){
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
	$("#civilVoiceList.comment li").click(function(){
		$("#civilVoiceListContent").hide();
		$("#civilVoiceDetailContent").show();
	});
});
