var SpatialAnalysis = function(magoInstance) {
	
	//본인 환경에 맞게 일단은 수정바람...
	var WPS_URL = 'http://localhost:8082/geoserver/wps';
	var magoManager = magoInstance.getMagoManager();
	var viewer = magoInstance.getViewer();
	var entities = viewer.entities;
	var entityObject = {};
	var layerDEM = 'mago3d:dem';
	var rasterProfileChart = null;
	var domeIds = [];

	//취소 버튼 클릭 시 해당 분석 위치 입력값 초기화.
	$('#spatialContent .reset').click(function() {
		var parentDiv = $(this).parents('div:first');
		var analysisType = parentDiv.attr('id');
		removeByDivId(analysisType);
		removeDataSource(analysisType);
		
		//특이 케이스 처리
		switch(analysisType) {
			case 'analysisRasterProfile' : {
				$('#analysisRasterProfile .profileInfo .legend').empty();
				$('.analysisGraphic .closeGraphic').trigger('click');
				break;
			}
			
			case 'analysisRangeDome':{
				if(domeIds.length > 0) {
					for(var i in domeIds) {
						entities.removeById(domeIds[i]);
					}
					domeIds = [];
				}
				break;
			}
		}
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
	
	// 방사형 가시권 분석 - 분석실행
	$('#analysisRadialLineOfSight .execute').click(function(e) {

		var observerOffset = $('#analysisRadialLineOfSight .observerOffset').val();
	    var radius = $('#analysisRadialLineOfSight .radius').val();
	    var sides = $('#analysisRadialLineOfSight .sides').val();
		var observerPoint = $("#analysisRadialLineOfSight .observerPoint").val();

	    if (observerPoint == "") {
	        alert("Please select an observer point!!");
	        return;
	    }
	    startLoading();
		var extent = getViewExtentLonLat();
		
		var xml = requestBodyRadialLineOfSight(layerDEM, observerPoint, observerOffset, radius, sides, extent);
		
		var resource = requestPostResource(xml);
	    resource.then(function (res) {
	        var promise = Cesium.GeoJsonDataSource.load(JSON.parse(res));
	        promise.then(function (ds) {
				ds.id = 'analysisRadialLineOfSight';
				ds.name = 'analysisRadialLineOfSight';
				ds.type = 'analysis';
				viewer.dataSources.add(ds);

	            var entities = ds.entities.values;
	            for (var i = 0; i < entities.length; i++) {
	                var entity = entities[i];
					
					entity.corridor = entity.polyline;
					entity.corridor.material = Cesium.Color.fromCssColorString('rgb(255, 0, 0, .8)');
					entity.corridor.width = 1;
					if (entity.properties.Visible.getValue()===1) {
						entity.corridor.material = Cesium.Color.fromCssColorString('rgb(0, 255, 0, .8)');
					}
					entity.polyline = undefined;
	            }
	            // viewer.flyTo(entities);
	        });
	    }).otherwise(function (error) {
	        window.alert('Invalid selection');
	    }).always(function(){
	    	stopLoading();
	    });
	});
	// 방사형 가시권 분석 - 클리어
	/*$('#analysisRadialLineOfSight .reset').click(function(e) {
		
	});*/
	
	// 가시선 분석 - 실행
	$('#analysisLinearLineOfSight .execute').click(function(e) {
		var observerOffset = $('#analysisLinearLineOfSight .observerOffset').val();
	    var observerPoint = $('#analysisLinearLineOfSight .observerPoint').val();
	    var targetPoint = $('#analysisLinearLineOfSight .targetPoint').val();

	    if (observerPoint == "") {
	        alert("Please select an observer point!!");
	        return;
	    }

		if (targetPoint == "") {
			alert("Please select a target point!!");
			return;
		}
		startLoading();
		var extent = getViewExtentLonLat();

		var xml = requestBodyLinearLineOfSight(layerDEM, observerOffset, observerPoint, targetPoint, extent);

		var resource = requestPostResource(xml);
		resource.then(function (res) {
	        var promise = Cesium.GeoJsonDataSource.load(JSON.parse(res));
			promise.then(function (ds) {
				ds.id = 'analysisLinearLineOfSight';
				ds.name = 'analysisLinearLineOfSight';
				ds.type = 'analysis';
				viewer.dataSources.add(ds);

				var entities = ds.entities.values;
	            for (var i = 0; i < entities.length; i++) {
	                var entity = entities[i];
					
					entity.corridor = entity.polyline;
					entity.corridor.material = Cesium.Color.fromCssColorString('rgb(255, 0, 0, .8)');
					entity.corridor.width = 5;
					if (entity.properties.Visible.getValue()===1) {
						entity.corridor.material = Cesium.Color.fromCssColorString('rgb(0, 255, 0, .8)');
					}
					entity.polyline = undefined;
	            }
	            // viewer.flyTo(entities);
	        });
	    }).otherwise(function (error) {
	        window.alert('Invalid selection');
	    }).always(function(){
	    	stopLoading();
	    });;
	});
	
	// 연직분석 - 실행
	$('#analysisRasterProfile .execute').click(function(e) {
		var inputCoverage = layerDEM;
		var interval = $('#analysisRasterProfile .interval').val();
		var userLine = $('#analysisRasterProfile .userLine').val();

		if (userLine == "") {
			alert("Please select an user line!!");
			return;
		}
		startLoading();
		var extent = getViewExtentLonLat();

		var xml = requestBodyRasterProfile(inputCoverage, interval, userLine, extent);

		var resource = requestPostResource(xml);
		resource.then(function (res) {
	        var promise = Cesium.GeoJsonDataSource.load(JSON.parse(res));
	        promise.then(function (ds) {
				ds.id = 'analysisRasterProfile';
				ds.name = 'analysisRasterProfile';
				ds.type = 'analysis';
				viewer.dataSources.add(ds);

	            var entities = ds.entities.values;
	            var temp = [];
	            for (var i = 0; i < entities.length; i++) {
	                var entity = entities[i];
	                temp.push(Cesium.Cartesian3.fromArray([
						entity.position._value.x,
						entity.position._value.y,
						entity.position._value.z
					]));
	            }

	            ds.entities.add({
	                corridor: {
	                    positions: temp,
	                    width: 10,
						material: Cesium.Color.fromCssColorString(hex2rgb('#2c82ff')),
						// material: Cesium.Color.RED,
	                    clampToGround: true
	                }
	            });

				colors = createGraduatedColorStyle(ds.entities.values, "value");
				createProfileGraph(ds.entities.values, colors);

				$('.analysisGroup .profileInfo').show();
				$('#magoContainer .analysisGraphic').show();

	            // viewer.flyTo(layerRasterProfile.entities);
	        }).otherwise(function (error) {
		        console.info(error);
		    });
	    }).otherwise(function (error) {
	        window.alert('Invalid selection');
	    }).always(function(){
	    	stopLoading();
	    });;
	});
	
	//지형 단면 분석 실행 결과 그래프 제거
	$('#magoContainer .analysisGraphic .closeGraphic').click(function() {
		rasterProfileChart.destroy();
		$('#magoContainer .analysisGraphic').hide();
	});
	
	// 최고/최저 지점찾기 - 분석실행
	$('#analysisRasterHighLowPoints .execute').click(function(e) {
		var inputCoverage = layerDEM;
		var cropShape = $('#analysisRasterHighLowPoints .cropShape').val();
		var valueType = $('#analysisRasterHighLowPoints .valueType').val();

		var typeKorName = $('#analysisRasterHighLowPoints .valueType option:selected').text();
		if ($('#analysisRasterHighLowPoints .cropShape').val() == "") {
			alert("Please select a crop shape!!");
			return;
		}
		startLoading();
		// 임시로 사용 현재 위치 extent
		var extent = getViewExtentLonLat();

		var xml = requestBodyRasterHighLowPoints(inputCoverage, cropShape, valueType, extent);

		var resource = requestPostResource(xml);
		resource.then(function (res) {
	        var promise = Cesium.GeoJsonDataSource.load(JSON.parse(res));
	        promise.then(function (ds) {

				//removeAnalysisDataSource(layerRasterHighLowPointsId);

				ds.id = 'analysisRasterHighLowPoints';
				ds.name = 'analysisRasterHighLowPoints';
				ds.type = 'analysis';
				viewer.dataSources.add(ds);

	            var entities = ds.entities.values;
	            for (var i = 0; i < entities.length; i++) {
	                var entity = entities[i];
	                entity.billboard = undefined;
	                entity.point = new Cesium.PointGraphics({
	                    color: Cesium.Color.fromCssColorString("rgba(255, 0, 0)"),
	                    pixelSize: 20,
	                    outlineColor: Cesium.Color.BLACK,
	                    outlineWidth: 1,
						heightReference : Cesium.HeightReference.CLAMP_TO_GROUND
	                });
	                if(i===0) {
	                	entity.label = new Cesium.LabelGraphics({
	 	                	text : typeKorName + ' : ' + entity.properties.val.getValue() + 'm',
	 	                	pixelOffset : new Cesium.Cartesian2(10,10),
	 	                	style: Cesium.LabelStyle.FILL_AND_OUTLINE,
	 	                	disableDepthTestDistance: Number.POSITIVE_INFINITY,
	 	                	font: 'bold 20px sans-serif',
	 	                	heightReference: Cesium.HeightReference.RELATIVE_TO_GROUND
	 	                });
	                }
	               
	            }
	            // viewer.flyTo(ds.entities);
	        });
	    }).otherwise(function (error) {
			window.alert('Invalid selection');
	    }).always(function(){
	    	stopLoading();
	    });
	});
	
	// 화망 분석 - 분석실행
	$('#analysisRangeDome .execute').click(function(e) {
	    var radius = $('#analysisRangeDome .radius').val();
		var observerPoint = $("#analysisRangeDome .observerPoint").val();

	    if (observerPoint == "") {
	        alert("Please select the observer point!!");
	        return;
	    }
	    var coords = Mago3D.ManagerUtils.getCoordinateFromWKT(observerPoint,'POINT');

        var dome = viewer.entities.add({
            name : 'Threat Dome('+radius+'m)',
            position: Cesium.Cartesian3.fromDegrees(parseFloat(coords[0]), parseFloat(coords[1]), 0.0),
            ellipsoid : {
                radii : new Cesium.Cartesian3(radius, radius, radius),
                material : Cesium.Color.RED.withAlpha(0.5),
                outline : true,
                outlineColor : Cesium.Color.BLACK
            }
        });
        domeIds.push(dome.id);
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
	
	function removeDataSource(type) {
		var dataSources = viewer.dataSources;
		var resultDataSources = dataSources.getByName(type);
		for(var i in resultDataSources) {
			dataSources.remove(resultDataSources[i], true);
		}
	}
	
	function getViewExtentLonLat() {
	    var cl2 = new Cesium.Cartesian2(0, 0);
	    var leftTop = viewer.scene.camera.pickEllipsoid(cl2, viewer.scene.globe.ellipsoid);

	    cr2 = new Cesium.Cartesian2(viewer.scene.canvas.width, viewer.scene.canvas.height);
	    var rightDown = viewer.scene.camera.pickEllipsoid(cr2, viewer.scene.globe.ellipsoid);

	    if (leftTop != null && rightDown != null) {
	        leftTop = viewer.scene.globe.ellipsoid.cartesianToCartographic(leftTop);
	        rightDown = viewer.scene.globe.ellipsoid.cartesianToCartographic(rightDown);

			var extent = new Cesium.Rectangle(leftTop.longitude, rightDown.latitude, rightDown.longitude, leftTop.latitude);
			var west = Cesium.Math.toDegrees(extent.west).toFixed(7);
			var south = Cesium.Math.toDegrees(extent.south).toFixed(7);
			var east = Cesium.Math.toDegrees(extent.east).toFixed(7);
			var north = Cesium.Math.toDegrees(extent.north).toFixed(7);

			return [west, south, east, north];

	    } else { //The sky is visible in 3D
	        console.log("Sky is visible");
	        return null;
	    }
	}
	
	function requestPostResource(xml) {
		var resource = new Cesium.Resource.post({
			url: WPS_URL,
			headers: {
				'Content-Type': 'text/xml;charset=utf-8'
			},
			data: xml
		});

		return resource;
	}
	
	function createGraduatedColorStyle(vectorLayer, field) {
		// var colors_blues = ['#eff3ff', '#bdd7e7', '#6baed6', '#3182bd', '#08519c'];
		var colors_brewer = ['#ffffb2', '#fecc5c', '#fd8d3c', '#f03b20', '#bd0026'];

	    var classBreaks = getClassBreaks(vectorLayer, field, colors_brewer.length, colors_brewer);

		var colors = [];

	    for (var i = 0; i < vectorLayer.length-1; i++) {
	        var entity = vectorLayer[i];
	        var fillColor = colors_brewer[0];
	        var val = entity.properties[field];
	        for (var j = 0; j < classBreaks.length; j++) {
	            if (val >= classBreaks[j] && val < classBreaks[j + 1]) {
	                fillColor = colors_brewer[j];
	                break;
	            }
	        }

	        fillColor = hex2rgb(fillColor);
	        var strokeColor = hex2rgb("#ffffff");
	        entity.billboard = undefined;
	        entity.point = new Cesium.PointGraphics({
	            color: Cesium.Color.fromCssColorString(fillColor),
	            pixelSize: 10,
	            outlineColor: Cesium.Color.fromCssColorString(strokeColor),
	            outlineWidth: 1,
				heightReference : Cesium.HeightReference.CLAMP_TO_GROUND
	        });

			colors.push(fillColor);
	    }

		return colors;
	}
	
	function getClassBreaks(features, field, bin, colors) {
	    var minValue = Number.MAX_VALUE;
	    var maxValue = Number.MIN_VALUE;
	    var items = new Array();

		try {
			for (var i = 0; i<features.length-1; i++) {
		        var value = features[i].properties[field].getValue();
		        if (isNaN(value)) {
		            continue;
		        }

		        items[i] = Number(value).toFixed(7);
		        minValue = Math.min(value, minValue);
		        maxValue = Math.max(value, maxValue);
		    }
		} catch (e) {
			console.log(e);
		}

	    var breaks;
	    var stat = new geostats(items);
	    stat.setPrecision(6);

	    breaks = stat.getClassEqInterval(bin);

	    breaks[0] = minValue - 0.1;
	    breaks[breaks.length - 1] = maxValue + 0.1;

	    var statHtml = stat.getHtmlLegend(colors, "Legend", true);
		$('.analysisGroup .profileInfo .legend').html(statHtml);

	    return breaks;
	}
	
	function createProfileGraph(vectorLayer, colors) {

		var data = [];

		var distances = [];
		var elevations = [];

		for (var i=0; i<vectorLayer.length-1; i++) {
			try {
				elevation = vectorLayer[i].properties.value.getValue();
				distance = vectorLayer[i].properties.distance.getValue();

				if (i == 0) {
					distances.push(0);
				} else {
					from = positionToLonLat(vectorLayer[0].position._value);
					to = positionToLonLat(vectorLayer[i].position._value);

					length = distanceByLonLat(from[0], from[1], to[0], to[1]);
					distances.push(length.toFixed(2));
				}

				elevations.push(elevation);

			} catch (e) {
				consoel.log(e);
			}
		}

		if (rasterProfileChart != null) {
			rasterProfileChart.destroy();
		}
		rasterProfileChart = new Chart(document.getElementById("analysisGraphic"), {
		    type: 'line',
		    data: {
				labels: distances,
		        datasets: [{
					// label: '',
		            data: elevations,
		            // backgroundColor: [
					// 	'rgba(0,0,255,0.5)'
		            // ],
		            borderColor: [
		                'rgba(44,130,255,1)'
		            ],
					pointBackgroundColor: [
						'rgba(255,0,255,0.5)',
						'rgba(255,0,150,0.5)',
						'rgba(255,150,0,0.5)'
					],
					pointBackgroundColor: colors,
					pointRadius: 5,
					pointHoverRadius: 10,
					pointHitRadius: 10,
					pointStyle: 'circle'
		        }]
		    },
		    options: {
				responsive: true,
				maintainAspectRatio: false,
				legend: {
					display: false,
					position: 'top',
					labels: {
						boxWidth: 80,
						fontColor: 'black'
					}
				},
				hover: {
					mode: 'index',
					intersect: true
				},
				tooltips: {
					enabled: true,
					mode: 'nearest',
					intersect: false,
					callbacks: {
						label: function(item, data) {
							var dataSource = viewer.dataSources.getByName('analysisRasterProfile');
							var entities = dataSource[0].entities.values;
							for (var i=0; i<entities.length-1; i++) {
								if (item.index == i) {
									entities[i].point.pixelSize = 20;
									entities[i].point.outlineWidth = 2;
									entities[i].point.outlineColor = Cesium.Color.fromCssColorString(hex2rgb("#000"));
								} else {
									entities[i].point.pixelSize = 10;
									entities[i].point.outlineWidth = 1;
									entities[i].point.outlineColor = Cesium.Color.fromCssColorString(hex2rgb("#fff"));
								}
							}

							return item.yLabel + 'm';
						}
					}
				},
		        scales: {
					xAxes: [{
						display: true,
						scaleLabel: {
							display: true,
							labelString: 'distance(km)'
						},
						ticks: {
							autoSkip: true,
							minRotation: 0
						}
					}],
		            yAxes: [{
						display: true,
						stacked: true,
						scaleLabel: {
							display: true,
							labelString: 'height'
						},
						ticks: {
							autoSkip: true,
							minRotation: 0
						}
		            }]
		        }
		    }
		});
	}
	function positionToLonLat(position) {

		var ellipsoid = viewer.scene.globe.ellipsoid;
		var pos = ellipsoid.cartesianToCartographic(position);

		var coordinates = [];
		coordinates.push(Number(Cesium.Math.toDegrees(pos.longitude)));
		coordinates.push(Number(Cesium.Math.toDegrees(pos.latitude)));

		return coordinates;
	}
	function distanceByLonLat(lat1, lon1, lat2, lon2) {

	    var R = 6378.137; // Radius of earth in KM
	    var dLat = lat2 * Math.PI / 180 - lat1 * Math.PI / 180;
	    var dLon = lon2 * Math.PI / 180 - lon1 * Math.PI / 180;
	    var a = Math.sin(dLat/2) * Math.sin(dLat/2) +
	    Math.cos(lat1 * Math.PI / 180) * Math.cos(lat2 * Math.PI / 180) *
	    Math.sin(dLon/2) * Math.sin(dLon/2);
	    var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
	    var d = R * c;

		return d;	//km
	    // return d * 1000; // meters
	}
}