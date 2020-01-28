var MapDataControll = function(magoInstance) {
	
	var magoManager = magoInstance.getMagoManager();
	var $dataControlWrap = $('#dataControllWrap');
	var $header = $dataControlWrap.find('.layerDivTit span');
	var projectId;
	var dataKey;
	var dataId;
	//지도상에서 데이터 all 선택 시 
    magoManager.on(Mago3D.MagoManager.EVENT_TYPE.SELECTEDF4D, function(result) {
    	var f4d = result.f4d;
		if(f4d) {
			clearDataControl();
			
			var data = f4d.data;
			dataId = data.dataId;
			dataKey = data.nodeId;
			projectId = data.projectId;
			var title = projectId + ' / ' + (data.data_name || data.nodeId);
			$header.text(title);
			
			var currentGeoLocData = f4d.getCurrentGeoLocationData();
			
			var currentGeoCoord = currentGeoLocData.geographicCoord;
			$('#dcLongitude').val(currentGeoCoord.longitude);
			$('#dcLatitude').val(currentGeoCoord.latitude);
			$('#dcAltitude').val(currentGeoCoord.altitude);
			
			$('#dcPitch,#dcPitchRange').val(currentGeoLocData.pitch);
			$('#dcHeading,#dcHeadingRange').val(currentGeoLocData.heading);
			$('#dcRoll,#dcRollRange').val(currentGeoLocData.roll);
			
			var hex;
			if(data.aditionalColor && data.isColorChanged) {
				hex = data.aditionalColor.getHexCode();
			} else {
				hex = '#000000';
			}
			$('#dcColorPicker').val(hex).change();
			
			if(!$('#mapPolicy').hasClass('on')) {
				$('#mapPolicy').trigger('click');
			}
			$dataControlWrap.show();
		}
	});
  	//선택된 데이터 이동 시 결과 리턴
    magoManager.on(Mago3D.MagoManager.EVENT_TYPE.SELECTEDF4DMOVED, function(result) {
		var item = result.result;
		
		$('#dcLongitude').val(item.longitude);
		$('#dcLatitude').val(item.latitude);
		$('#dcAltitude').val(item.altitude);
		
		$('#dcPitch,#dcPitchRange').val(item.pitch);
		$('#dcHeading,#dcHeadingRange').val(item.heading);
		$('#dcRoll,#dcRollRange').val(item.roll);
	});

  	//지도상에서 데이터 all 선택해제시 
	magoManager.on(Mago3D.MagoManager.EVENT_TYPE.DESELECTEDF4D, function(result) {
		clearDataControl();
		$dataControlWrap.hide();
	});
	
	//색상변경 적용
	$('#dcColorApply').click(function() {
		if(!projectId || !dataKey) {
			alert('데이터 선택을 해주십시오.');
			return;
		}
		
		var rgbArray = hex2rgbArray($('#dcColorInput').val());
		changeColorAPI(magoInstance, projectId, dataKey, null, 'isPhysical=true', rgbArray.join(','));
	});
	//색상변경 취소
	$('#dcColorCancle').click(function() {
		deleteAllChangeColorAPI(magoInstance);
	});
	$('#dcColorPicker').change(function(){
		var color = $('#dcColorPicker').val(); 
		$('#dcColorInput').val(color).css('color',color);
	});
	
	//회전 변경 range 조절
	$('#dcPitchRange,#dcHeadingRange,#dcRollRange').on('input change',function(){
		var val = $(this).val();
		var type = $(this).data('type');
		$('#dc' + type).val(val);
		
		changeF4d();
	});
	
	//회전 변경 버튼 조절
	var rotBtnHoldInterval
	$('.dcRangeBtn').on('mousedown',function() {
		var $this = $(this);
		rotBtnHoldInterval = setInterval(function(){
			var type = $this.data('type');
			var range = (type ==='prev') ?  $this.next() : $this.prev();
			var offset = (type ==='prev') ? -1 : 1;
			var curVal = parseFloat(range.val()); 
			range.val(curVal + offset).change();
		},50);
	});
	$('.dcRangeBtn').on('mouseup mouseleave',function() {
		clearInterval(rotBtnHoldInterval);
	});
	
	//데이터 높이 이벤트
	var locAltholdInterval;
	$('#dcAltUp,#dcAltDown').on('mousedown',function() {
		var $this = $(this);
		locAltholdInterval = setInterval(function(){
			var type = $this.data('type');
			var offset = parseFloat($('#dcAltitudeOffset').val());
			offset = (type==='up') ? offset : -offset;
			
			var alt = parseFloat($('#dcAltitude').val());
			$('#dcAltitude').val(alt + offset);
			
			changeF4d();
		},50);
	});
	$('#dcAltUp,#dcAltDown').on('mouseup mouseleave',function() {
		clearInterval(locAltholdInterval);
	});
	//속성조회
	$('#dcShowAttr').click(function(){
		detailDataInfo(dataId);
	});
	//위치회전정보 저장
	$('#dcSavePosRot').click(function() {
		if(confirm('현재 입력된 위치와 회전 정보를 db에 저장하시겠습니까?')) {
			if(!dataId) {
				alert('선택된 데이터가 없습니다.');
				return false;
			}
			startLoading();
			var formData = $('#dcRotLocForm').serialize();
			$.ajax({
				url: "/datas/" + dataId,
				type: "POST",
				headers: {"X-Requested-With": "XMLHttpRequest"},
				data: formData,
				success: function(msg){
					if(msg.statusCode <= 200) {
						alert(JS_MESSAGE["update"]);
					} else {
						alert(JS_MESSAGE[msg.errorCode]);
						console.log("---- " + msg.message);
					}
					updateDataInfoFlag = true;
				},
				error:function(request, status, error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updateDataInfoFlag = true;
				}
			}).always(stopLoading);
		} else {
			alert('no');
		}
	});
	
	var changeF4d = function() {
		var lat = parseFloat($('#dcLatitude').val());
		var lon = parseFloat($('#dcLongitude').val());
		var alt = parseFloat($('#dcAltitude').val());
		var heading = parseInt($('#dcHeading').val());
		var pitch = parseInt($('#dcPitch').val());
		var roll = parseInt($('#dcRoll').val());
		
		changeLocationAndRotationAPI(magoInstance, projectId, dataKey, 
				lat, lon, alt, heading, pitch, roll);
	}
	
	var clearDataControl = function() {
		dataId = undefined;
		dataKey = undefined;
		projectId = undefined;
		$header.empty();
	}
}