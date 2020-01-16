var SpatialAnalysis = function(magoInstance) {
	
	var magoManager = magoInstance.getMagoManager();
	var viewer = magoInstance.getViewer();
	var entities = viewer.entities;
	var entityObject = {};

	//취소 버튼 클릭 시 해당 분석 위치 입력값 초기화.
	$('#spatialContent .reset').click(function() {
		var parentDiv = $(this).parents('div:first');
		var analysisType = parentDiv.attr('id');
		removeByDivId(analysisType);
	});
	
	//지형 단면 분석 사용자 입력 선분 버텍스 위치 보기.
	$('#analysisRasterProfile').on('click','span.coordText button', function() {
		var data =$(this).data();
		
		var lon = parseFloat(data.lon);
		var lat = parseFloat(data.lat);
		
		viewer.camera.flyTo({
		    destination : Cesium.Cartesian3.fromDegrees(lon, lat, 1500.0),
		    duration:0
		});
	});
	
	// 지형 최고/최저 점 면적 타입 변경 시 
	// 좀 더 생각해봐야함.
	$('#analysisRasterHighLowPoints .areaType').change(function() {
		var changeVal = $(this).val();
		var wrapCropShape = $('#analysisRasterHighLowPoints li.wrapCropShape');
		
		if(changeVal === 'useArea') {
			wrapCropShape.show();
		} else {
			wrapCropShape.find('input.cropShape').val('');
			wrapCropShape.hide();
		}
	});
	
	// TODO: mago3djs draw interaction 으로 devlope 예정
	magoManager.on(Mago3D.MagoManager.EVENT_TYPE.MOUSEMOVE, function(result) {
		var selectedBtn = $('#spatialContent button[class*="draw"].on');
		var drawType = selectedBtn.data('drawType');
		if($('#spatialContent').is(':visible') && drawType) {
			if(drawType === 'LINE' || drawType === 'POLYGON') {
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
		var selectedBtn = $('#spatialContent button[class*="draw"].on');
		var drawType = selectedBtn.data('drawType');
		if($('#spatialContent').is(':visible') && drawType) {
			if(drawType === 'LINE' || drawType === 'POLYGON') {
				var parentDiv = selectedBtn.parents('div:first');
				var analysisType = parentDiv.attr('id');
				
				if(entityObject[analysisType] && entityObject[analysisType]['vertex'] && entityObject[analysisType]['line']) {
					
					var vertexIds = entityObject[analysisType]['vertex'];
					
					if(drawType === 'POLYGON' && vertexIds.length < 3) {
						alert('최소 3개점이 필요합니다.');
						return false;
					}
					
					selectedBtn.removeClass('on');
					
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
					
					var addedEntity;
					if(drawType === 'LINE') {
						var corridorGraphic = new Cesium.CorridorGraphics({
							positions: positions,
							width: 16,
							material: Cesium.Color.AQUAMARINE,
							clampToGround: true
						})
						addedEntity = viewer.entities.add({
							corridor : corridorGraphic
						});
					} else {
						var polygonHierarchy = new Cesium.PolygonHierarchy(positions);
						var polygonGraphic = new Cesium.PolygonGraphics({
							hierarchy: polygonHierarchy,
							material: Cesium.Color.AQUAMARINE.withAlpha(0.5),
							outline:true,
							outlineColor:Cesium.Color.WHITE,
							outlineWidth:2,
							clampToGround: true
						})
						addedEntity = viewer.entities.add({
							polygon : polygonGraphic
						});
						
					}
					var geographics = []
					for(var i in positions) {
						var pos = positions[i];
						var geog = Cesium.Cartographic.fromCartesian(pos);
						
						geographics.push({longitude:Cesium.Math.toDegrees(geog.longitude), latitude : Cesium.Math.toDegrees(geog.latitude)});
					}
					var wkt = Mago3D.ManagerUtils.geographicToWkt(geographics, drawType);
					selectedBtn.siblings('input[type="hidden"]').val(wkt);
					
					entityObject[analysisType]['line'] = addedEntity.id;
				}
			}
		}
	});
	
	magoManager.on(Mago3D.MagoManager.EVENT_TYPE.CLICK, function(result) {
		if($('#spatialContent').is(':visible') && !magoManager.isDragging()) {
			var selectedBtn = $('#spatialContent button[class*="draw"].on');
			var parentDiv = selectedBtn.parents('div:first');
			
			var analysisType = parentDiv.attr('id');
			var drawType = selectedBtn.data('drawType');
			
			if(!drawType) return false;
			
			var geographicCoord = result.clickCoordinate.geographicCoordinate
			var worldCoordinate = result.clickCoordinate.worldCoordinate;
			
			if(drawType === 'POINT') {
				var pointType = selectedBtn.attr('class').indexOf('Observer') > 0 ? 'observer' : 'target';
				var wkt = Mago3D.ManagerUtils.geographicToWkt(geographicCoord, 'POINT');
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
			} else {
				removeAnotherEntity(analysisType, drawType, false);
				
				if(!entityObject[analysisType]) {
					entityObject[analysisType] = {};
				}
				if(!entityObject[analysisType]['vertex']) {
					entityObject[analysisType]['vertex'] = [];
				}
				if(entityObject[analysisType]['vertex'].length === 0 && entityObject[analysisType]['line']) {
					removeByDivId(analysisType);
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
				
				if(drawType === 'LINE') {
					var tempString = geographicCoord.longitude.toFixed(5) + ',' + geographicCoord.latitude.toFixed(5)
					
					var html = '<span class="coordText">';
					html += tempString;
					html += '<button type="button" class="btnText coordBtn" data-lon="' + geographicCoord.longitude +'" data-lat="' + geographicCoord.latitude + '">보기</button>';
					html += '</span>';
					
					$('#' + analysisType + ' .coordsText').append(html);
				}
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
					removeByDivId(analType);
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
			case 'analysisRadialLineOfSight':
			case 'analysisLinearLineOfSight':
			case 'analysisRangeDome': {
				$('#'+id).find('input.withBtn,input[type="hidden"]').val('');
				break;
			}
			case 'analysisRasterProfile' : {
				$('#analysisRasterProfile').find('input[type="hidden"]').val('');
				$('#analysisRasterProfile .coordsText').empty();
				break;
			}
			case 'analysisRasterHighLowPoints' : {
				$('#analysisRasterHighLowPoints').find('input[type="hidden"]').val('');
			}
		}
	}
	
	function removeByDivId(id) {
		removeAnotherUI(id);
		
		var $div = $('#'+id);
		if(entityObject[id]) {
			var entityTypes = Object.keys(entityObject[id]);
			if(entityTypes.length > 0) {
				for(var i in entityTypes) {
					var entityType = entityTypes[i];
					
					remove(entityObject[id][entityType]);
					entityObject[id][entityType] = null;
				}
			}
		}
	}
}