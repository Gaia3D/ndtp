var SpatialAnalysis = function(magoInstance) {
	var magoManager = magoInstance.getMagoManager();
	var viewer = magoInstance.getViewer();
	var entities = viewer.entities;
	var entityObject = {};
	
	$('#analysisRasterProfile .drawUserLine').click(function() {
		
		var id = 'analysisRasterProfile';
		$('#analysisRasterProfile .coordsText').empty();
		
		if(entityObject[id]) {
			if(entityObject[id]['vertex']) {
				remove(entityObject[id]['vertex']);
				
				entityObject[id]['vertex'] = null;
			}
			
			if(entityObject[id]['line']) {
				remove(entityObject[id]['line']);
				
				entityObject[id]['line'] = null;
			}
		}
	});
	
	$('#analysisRasterProfile').on('click','span.coordText button', function() {
		console.info($(this).data());
		var data =$(this).data();
		
		var lon = parseFloat(data.lon);
		var lat = parseFloat(data.lat);
		
		viewer.camera.flyTo({
		    destination : Cesium.Cartesian3.fromDegrees(lon, lat, 1500.0)
		});
	});
	
	// TODO: mago3djs draw interaction 으로 devlope 예정
	magoManager.on(Mago3D.MagoManager.EVENT_TYPE.MOUSEMOVE, function(result) {
		var selectedBtn = $('#analyticsContent button[class*="draw"].on');
		var drawType = selectedBtn.data('drawType');
		if($('#analyticsContent').is(':visible') && drawType) {
			if(drawType === 'LINE') {
				var parentDiv = selectedBtn.parents('div:first');
				var analysisType = parentDiv.attr('id');
				
				if(entityObject[analysisType] && entityObject[analysisType]['vertex']) {
					if(!entityObject[analysisType]['line']) {
						entityObject[analysisType]['line'] = [];
					}
					
					var cursorWorldCoord = result.endEvent.worldCoordinate;
					var cursorCartesianCoord = new Cesium.Cartesian3(cursorWorldCoord.x, cursorWorldCoord.y, cursorWorldCoord.z);
					
					var vertexIds = entityObject[analysisType]['vertex'];
					var vertexLength = vertexIds.length;
					var lastVertexId = vertexIds[vertexLength-1];
					var lastVertex = entities.getById(lastVertexId).position.getValue();
					var lineIds = entityObject[analysisType]['line'];
					var lineLength = lineIds.length;
					
					if((vertexLength - lineLength) === 1) {
						var lineGraphic = new Cesium.PolylineGraphics({
							positions: [lastVertex, cursorCartesianCoord],
							width: 3,
							material: Cesium.Color.AQUAMARINE
						})
						var addedEntity = viewer.entities.add({
							polyline : lineGraphic
						});
						lineIds.push(addedEntity.id);
					} else if(vertexLength === lineLength) {
						var lastLineId = lineIds[lineLength-1];
						var line = entities.getById(lastLineId).polyline;
						var lastLinePosition = line.positions.getValue();
						
						lastLinePosition[lastLinePosition.length - 1] = cursorCartesianCoord;
						line.positions = lastLinePosition;
					}
				}
			}
		}
	});
	magoManager.on(Mago3D.MagoManager.EVENT_TYPE.RIGHTCLICK, function(result) {
		var selectedBtn = $('#analyticsContent button[class*="draw"].on');
		var drawType = selectedBtn.data('drawType');
		if($('#analyticsContent').is(':visible') && drawType) {
			if(drawType === 'LINE') {
				var parentDiv = selectedBtn.parents('div:first');
				var analysisType = parentDiv.attr('id');
				
				if(entityObject[analysisType] && entityObject[analysisType]['vertex'] && entityObject[analysisType]['line']) {
					selectedBtn.removeClass('on');
					var vertexIds = entityObject[analysisType]['vertex'];
					var positions = [];
					for(var i in vertexIds) {
						var vertexId = vertexIds[i];
						var vertexPosition = entities.getById(vertexId).position.getValue();
						positions.push(vertexPosition);
						
						entities.removeById(vertexId);
					}
					entityObject[analysisType]['vertex'] = null;
					
					var lineIds = entityObject[analysisType]['line'];
					for(var i in lineIds) {
						entities.removeById(lineIds[i]);
					}
					
					var corridorGraphic = new Cesium.CorridorGraphics({
						positions: positions,
						width: 8,
						material: Cesium.Color.AQUAMARINE,
						clampToGround: true
					})
					var addedEntity = viewer.entities.add({
						corridor : corridorGraphic
					});
					
					entityObject[analysisType]['line'] = addedEntity.id;
				}
			}
		}
	});
	
	magoManager.on(Mago3D.MagoManager.EVENT_TYPE.CLICK, function(result) {
		if($('#analyticsContent').is(':visible') && !magoManager.isDragging()) {
			var selectedBtn = $('#analyticsContent button[class*="draw"].on');
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
				
				var tempString = geographicCoord.longitude.toFixed(5) + ',' + geographicCoord.latitude.toFixed(5);
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
				
				removeAnotherEntity(analysisType, pointType, true);
				removeAnotherUI('analysisRasterProfile');
				
				if(!entityObject[analysisType]) {
					entityObject[analysisType] = {};
				}
				entityObject[analysisType][pointType] = addedEntity.id;
				selectedBtn.removeClass('on');
			} else if(drawType === 'LINE') {
				removeAnotherEntity(analysisType, drawType, false);
				
				if(!entityObject[analysisType]) {
					entityObject[analysisType] = {};
				}
				if(!entityObject[analysisType]['vertex']) {
					entityObject[analysisType]['vertex'] = [];
				}
				
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
				entityObject[analysisType]['vertex'].push(addedEntity.id);
				
				var tempString = geographicCoord.longitude.toFixed(5) + ',' + geographicCoord.latitude.toFixed(5)
				
				var html = '<span class="coordText">';
				html += tempString;
				html += '<button type="button" class="btnText coordBtn" data-lon="' + geographicCoord.longitude +'" data-lat="' + geographicCoord.latitude + '">보기</button>';
				html += '</span>';
				
				$('#' + analysisType + ' .coordsText').append(html);
			} else {
				//POLYGON
			}
			
		}
	});
	
	function removeAnotherEntity(id, type, withPrev) {
		var analTypes = Object.keys(entityObject);
		if(analTypes.length > 0) {
			for(var i in analTypes) {
				var analType = analTypes[i];
				
				var analysis = entityObject[analType];
				if(analType !== id) {
					var entityTypes = Object.keys(analysis);
					for(var j in entityTypes) {
						var entityType = entityTypes[j];
						var stored = analysis[entityType];
						remove(stored);

						analysis[entityType] = null;
						$('#' + analType + ' .' + entityType + 'Point').val('').siblings('input').val('');
					}
				} else {
					if(withPrev) {
						if(analysis[type]) {
							remove(analysis[type]);
						}
						analysis[type] = null;
					}
				}				
			}
		}
	}
	function remove(entityStored) {
		if(Array.isArray(entityStored)) {
			for(var i in entityStored){
				remove(entityStored[i]);
			}
		} else {
			entities.removeById(entityStored);
		}
	}
	function removeAnotherUI(id) {
		switch(id) {
			case 'analysisRasterProfile' : {
				$('#analysisRasterProfile .coordsText').empty();
			}
		}
	}
}