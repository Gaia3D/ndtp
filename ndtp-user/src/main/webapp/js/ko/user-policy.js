var UserPolicy = function(magoInstance) {
	
	//객체정보 변경
	$("input[name='datainfoDisplay']").change(function(e){
		var flag = JSON.parse($(this).val().toLowerCase());
		changeObjectInfoViewModeAPI(magoInstance, flag);
	});
	
	//오리진 표시 유무 변경
	$("input[name='originDisplay']").change(function(e){
		var flag = JSON.parse($(this).val().toLowerCase());
		changeOriginAPI(magoInstance, flag);
	});
	
	//바운딩박스 표시 유무 변경
	$("input[name='bboxDisplay']").change(function(e){
		var flag = JSON.parse($(this).val().toLowerCase());
		changeBoundingBoxAPI(magoInstance, flag);
	});
	
	//lod 변경
	$('#changeLodButton').click(function(e){
		
	});
	
	//ssao 변경
	$('#changeSsaoButton').click(function(e){
		var ssao = $('#ssaoRadius').val();
		if(isNaN(ssao)) {
			alert('숫자만 입력 가능합니다.');
			return;
		} 
		
		changeSsaoRadiusAPI(magoInstance, ssao);
	});
}