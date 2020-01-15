var SpatialAnalysis = function(magoInstance) {
	console.info(magoInstance);
	var magoManager = magoInstance.getMagoManager();
	var viewer = magoInstance.getViewer();
	var entities = viewer.entities;
	var entityObject = {};
	
	magoManager.on(Mago3D.MagoManager.EVENT_TYPE.CLICK, function(result) {
		if($('#spatialContent').is(':visible')) {
			console.info('공간분석 위치 선택 이벤트 처리');
			var selectedBtn = $('#spatialContent button[class*="draw"].on');
			var parentDiv = selectedBtn.parents('div:first');
			
			var analysisType = parentDiv.attr('id');
			var drawType = selectedBtn.data('drawType');
			var geographicCoord = result.clickCoordinate.geographicCoordinate
			var worldCoordinate = result.clickCoordinate.worldCoordinate;
			
			//POINT (127.26878074384061 36.63103860210486)
			
			if(drawType === 'POINT') {
				var pointType = selectedBtn.attr('class').indexOf('Observer') > 0 ? 'observer' : 'target';
				var wkt = Mago3D.ManagerUtils.geographicToWkt(geographicCoord);
				selectedBtn.siblings('input[type="hidden"]').val(wkt);
				
				var tempString = geographicCoord.longitude.toFixed(5) + ',' + geographicCoord.latitude.toFixed(5)
				selectedBtn.siblings('input[type="text"]').val(tempString);
				
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
				
				removeAnotherAnalEntity(analysisType, pointType);
				
				if(!entityObject[analysisType]) {
					entityObject[analysisType] = {};
				}
				entityObject[analysisType][pointType] = addedEntity.id;
				console.info(entityObject);
				selectedBtn.removeClass('on');
			} else if(drawType === 'LINE') {
				
			} else {
				//POLYGON
			}
			
		}
	});
	
	function removeAnotherAnalEntity(id, type) {
		var analTypes = Object.keys(entityObject);
		if(analTypes.length > 0) {
			for(var i in analTypes) {
				var analType = analTypes[i];
				var analysis = entityObject[analType];
				if(analType !== id) {
					var entityTypes = Object.keys(analysis);
					for(var j in entityTypes) {
						var entityType = entityTypes[j];
						var entityId = analysis[entityType];
						
						entities.removeById(entityId);
						analysis[entityType] = null;
						
						$('#' + analType + ' .' + entityType + 'Point').val('').siblings('input').val('');
					}
				} else {
					if(analysis[type]) {
						entities.removeById(analysis[type]);
					}
					analysis[type] = null;
				}				
			}
		}
	}

}