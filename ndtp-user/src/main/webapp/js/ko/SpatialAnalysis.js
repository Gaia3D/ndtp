var SpatialAnalysis = function(magoInstance) {
	console.info(magoInstance);
	var magoManager = magoInstance.getMagoManager();
	
	magoManager.on(Mago3D.MagoManager.EVENT_TYPE.CLICK, function(result) {
		if($('#spatialContent').is(':visible')) {
			console.info('공간분석 위치 선택 이벤트 처리');
			var selectedBtn = $('#spatialContent button[class*="draw"].on');
			var drawType = selectedBtn.data('drawType');
			var geographicCoord = result.clickCoordinate.geographicCoordinate
			
			//POINT (127.26878074384061 36.63103860210486)
			
			if(drawType === 'POINT') {
				
				var wkt = Mago3D.ManagerUtils.geographicToWkt(geographicCoord);
				selectedBtn.siblings('input[type="hidden"]').val(wkt);
				
				var tempString = geographicCoord.longitude.toFixed(5) + ',' + geographicCoord.latitude.toFixed(5)
				selectedBtn.siblings('input[type="text"]').val(tempString);
				
				selectedBtn.removeClass('on');
			} else if(drawType === 'LINE') {
				
			} else {
				//POLYGON
			}
			
		}
	});
	
}