var MapDataControll = function(magoInstance) {
	
	var magoManager = magoInstance.getMagoManager();
	var $dataControlWrap = $('#dataControllWrap');
	var $header = $dataControlWrap.find('h3');
	var projectId;
	var dataKey;
	//지도상에서 데이터 all 선택 시 
    magoManager.on(Mago3D.MagoManager.EVENT_TYPE.SELECTEDF4D, function(result) {
    	var f4d = result.f4d;
		if(f4d) {
			clearDataControl();
			
			var data = f4d.data;
			dataKey = data.nodeId;
			projectId = data.projectId;
			var title = '선택된 데이터 :  ' + projectId + ' / ' + dataKey;
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
	
	var holdInterval;
	$('#dcAltUp,#dcAltDown').on('mousedown',function() {
		var $this = $(this);
		holdInterval = setInterval(function(){
			var type = $this.data('type');
			var offset = parseFloat($('#dcAltitudeOffset').val());
			offset = (type==='up') ? offset : -offset;
			
			var alt = parseFloat($('#dcAltitude').val());
			$('#dcAltitude').val(alt + offset);
			
			changeF4d();
		});
		
	})
	$('#dcAltUp,#dcAltDown').on('mouseup mouseleave',function() {
		clearInterval(holdInterval);
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
		dataKey = undefined;
		projectId = undefined;
		$header.empty();
	}
}