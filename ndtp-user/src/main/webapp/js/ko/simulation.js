
var Simulation = function(magoInstance, viewer, $) {
	var that = this;
	var CAMERA_MOVE_NEED_DISTANCE = 5000;
	console.log(viewer);

	var _viewer = viewer;
    var _scene = viewer.scene;
    var _polylines = [];
    var _labels = [];   
    var _polygons = [];
    var mesurPolyList = [];
    var handler = null;
    var drawingMode = 'line';
    var activeShapePoints = [];
    var activeShape;
    var activeLabel;
    var heightBuildingInput;
    var echodeltaDataSource;
    var targetArea;
    var nowPolygon;
    var selectEntity;
	var magoManager = magoInstance.getMagoManager();
	

    var runAllocBuildChkStat = false;

    var cityPlanTargetArea = 0;
    var cityPlanTargetFloorCov = 0;
    var cityPlanTargetBuildCov = 0;
	
	var observer;
	var observerTarget = document.getElementById('simulationContent');
	var observerConfig = { attributes: true};
	
	
	var datepicker = new tui.DatePicker('#solayDatePicker', {
        date: new Date(),
        input: {
            element: '#datepicker-input',
            format: 'yyyy-MM-dd'
        }
    });

    var clearMap = function () {
        lengthInMeters = 0;
        areaInMeters = 0
        if (Cesium.defined(handler)) {
            handler.destroy();
            handler = null;
        }
        for (var i = 0, len = this._polylines.length; i < len; i++) {
            _viewer.entities.remove(this._polylines[i]);
        }
        for (var i = 0, len = this._labels.length; i < len; i++) {
        	_viewer.entities.remove(this._labels[i]);
        }

        _viewer.entities.remove(activeShape);
        _viewer.entities.remove(activeLabel);

        activeShape = undefined;
        activeLabel = undefined;
        activeShapePoints = [];

        this._polylines = [];
        this._labels = [];
    }
	var timeSlider;
	var solarMode = false;
	//일조분석 조회
	$('#solarAnalysis .execute').click(function() {
		if(!timeSlider) {
			timeSlider = new KotSlider('timeInput');
			timeSlider.setMin(1);
			timeSlider.setMax(24);
			timeSlider.setDuration(200);
			var html = '';
			_viewer.shadows = true
			for(var i=1;i<25;i++){
				if(i === 1 || 1 === 10) {
					html += '<span style="margin-left:22px;">' + i + '</span>';
				} else if(i < 10) {
					html += '<span style="margin-left:27px;">' + i + '</span>';
				} else {
					html += '<span style="margin-left:19px;">' + i + '</span>';
				}
				
			}
			
			$('#saRange .rangeWrapChild.legend').html(html);
			$('#saRange .rangeWrapChild.legend').on('click','span',function(){
				timeSlider.setValue(parseInt($(this).index())+1);
			});
		}
		
		var currentHour = new Date().getHours();
		currentHour  = currentHour === 0 ? 24 : currentHour;
		timeSlider.setValue(currentHour);
		
		//레인지 보이기
		$('#saRange').show();
		$('#csRange').hide();
		magoInstance.getViewer().scene.globe.enableLighting = true;
		magoManager.sceneState.setApplySunShadows(true);
		solarMode = true;
		
		changeDateTime();
	});
	
	//경관 분석 취소
	$('#solarAnalysis .reset').click(function(){
		setDate(new Date());
		$('#saRange').hide();
		magoInstance.getViewer().scene.globe.enableLighting = false;
		magoManager.sceneState.setApplySunShadows(false);
	});

	datepicker.on('change', function() {
		changeDateTime();
	});
	
	//회전 변경 range 조절
	$('#timeInput').on('input change',function(){
		changeDateTime();
	});
	
	var changeDateTime = function() {
		var date = datepicker.getDate();
		var hours = $('#timeInput').val();
		date.setHours(hours);
		setDate(date);
	}
	
	var setDate = function(date){
		var jd = Cesium.JulianDate.fromDate(date, jd);
		magoInstance.getViewer().clock.currentTime = jd;
		magoManager.sceneState.sunSystem.setDate(date);
	}
	
	var cache = {};
	var SEJONG_TILE_NAME = 'sejong_time_series_tiles';
	var SEJONG_POSITION = new Cesium.Cartesian3(-3108649.1049808883, 4086368.566202183, 3773910.6726226895);
	var slider;
	var simulating = false;
	//zBounceSpring zBounceLinear
	//건설공정 조회
	$('#constructionProcess .execute').click(function(){
		var targetArea = $('input[name="cpProtoArea"]:checked').val();
		
		var dataName;
		var initPosition;
		if(targetArea === 's') {
			dataName = SEJONG_TILE_NAME;
			initPosition = SEJONG_POSITION;
		} else {
			notyetAlram();
			return;
		}
		if(!slider) {
			slider = new KotSlider('rangeInput');
		}
		//레인지, 레전드 보이기
		$('#csRange, #constructionProcess .profileInfo').show();
		$('#saRange').hide();
		
		//slider.setValue(0);
		simulating = true;
		
		if(!cache[dataName]) {
			if(dataName.indexOf('tiles') > 0) {
				magoManager.getObjectIndexFileSmartTileF4d(dataName);
				magoManager.on(Mago3D.MagoManager.EVENT_TYPE.SMARTTILELOADEND, smartTileLoaEndCallbak);
				
				var html = '';
				html += '<span>1단계</span>';
				html += '<span>2단계</span>';
				html += '<span>3단계</span>';
				html += '<span>4단계</span>';
				html += '<span>5단계</span>';
				html += '<span>6단계</span>';
				
				$('#csRange .rangeWrapChild.legend').html(html);
				$('#csRange .rangeWrapChild.legend').on('click','span',function(){
					slider.setValue($(this).index());
				});
			}
		}
		
		var dis = Math.abs(Cesium.Cartesian3.distance(initPosition, MAGO3D_INSTANCE.getViewer().camera.position));
		if(dis > CAMERA_MOVE_NEED_DISTANCE) {
			magoInstance.getViewer().camera.flyTo({
				destination:initPosition,
				duration : 1
			});
		}
		setObserver();
	});
	
	//건설공정 취소
	$('#constructionProcess .reset').click(function(){
		constructionProcessReset();
	});
	
	//경관 분석 위치지정
	$('#solarAnalysis .drawObserverPoint').click(function(){
		notyetAlram();
	});
	
	$('#upload_cityplan').click(function() {
		
	});
	
	//건물 높이에 대해서 확정을 하는 로직
	$('#set_height_building').click(function(e) {
		floorNum = parseInt($('#height_building_input').val());
		floorSize = floorNum * 3;
		selectEntity.id.polygon.extrudedHeight = floorSize;
		floorCoverSum = selectEntity.id.areaVal * floorSize;
		$('#floorCoverateRatio').text('용적율 : ' + parseInt(floorCoverSum / cityPlanTargetArea * 100) + '%');
		
		selectBuildDialog.dialog( "close" );
		heightBuildingInput = 0;
	})
	
	// 에코델타 데이터 가지고와서 뿌리는 로직
	$('#run_cityplan').click(function() {
		Cesium.GeoJsonDataSource.load('http://localhost/data/simulation-rest/select', {
			width : 5,
			leadTime : 0,
			trailTime : 100,
			resolution : 5,
	        material : new Cesium.PolylineGlowMaterialProperty({
	            glowPower : 0.2,
	            rgba : [23, 184, 190,255]
	        })
		}).then(function(dataSource) { 
			var entitis = dataSource.entities._entities._array;
			for(var index in entitis) {
				var glowingLine = _viewer.entities.add({
				    name : 'Glowing blue line on the surface',
				    polyline : {
				        positions : entitis[index]._polyline.positions,
						width : 5,
						leadTime : 10,
						trailTime : 100,
						resolution : 5,
				        material : new Cesium.PolylineGlowMaterialProperty({
				            glowPower : 0.2,
				            rgba : [23, 184, 190,255]
				        })
				    }
				})
			}
		});
	});
	
	$('#move_cityplan').click(function() {
        _viewer.scene.camera.flyTo({
            destination : Cesium.Cartesian3.fromDegrees(128.91143708415015, 35.120229675016795, 600.0)
        });
	})
	
	$("#run_work_state").change(function(value){
		if(value.target.value === 'build') {
    		$('#run_work_state').toggleClass('on'); // 버튼 색 변경
    		$('#run_work_state').trigger('afterClick');
    		runAllocBuildChkStat = true;
		} else if(value.target.value === 'location') {
			
		} else {
    		$('#run_work_state').removeClass('on');
    		runAllocBuildChkStat = false;
            drawingMode = 'line';
		}
    });

    $('#run_work_state').bind('afterClick', function () {
        console.log("맵컨트롤 : 면적");
        //clearMap();
        drawingMode = 'polygon';

        if ($('#run_work_state').hasClass('on')) {
            startDrawPolyLine();
        }
    });
    
	var smartTileLoaEndCallbak = function(evt){
		var nodes = evt.tile.nodesArray;
		for(var i in nodes){
			var node = nodes[i];
			var data = node.data;
			
			if(!cache[node.data.nodeId]) {
				cache[node.data.nodeId] = true;
			}else {
				return;
			}
			/**
			 * TODO: 스마트타일링 이슈
			 * 세종시 스마트타일링 데이터 높이값 보정 코드.
			 * 문제 : 노드가 로드 완료된 시점에서 처리하려하는데 해당 시점에는 bbox와 geoLocationDataManager가 존재하지 않음
			 * 해결 : 일단 억지로 끼워 넣음.
			 * 추후 목표 : 강제로 데이터 로드시 해당 부분을 미리 생성하는 옵션을 추가, 원래는 데이터가 표출될 때 처리되는 부분.
			 */
			var metaData = data.neoBuilding.metaData;
			if (metaData.fileLoadState === Mago3D.CODE.fileLoadState.LOADING_FINISHED) 
			{
				var auxBytesReaded = 0;
				data.neoBuilding.parseHeader(data.neoBuilding.headerDataArrayBuffer, auxBytesReaded);

			}
			if(!data.geoLocDataManager) {
				data.geoLocDataManager = new Mago3D.GeoLocationDataManager();
				data.geoLocDataManager.newGeoLocationData("deploymentLoc");
			}

			var bbox = data.neoBuilding.bbox;
			data.bbox = bbox;
			// 여기까지.
			
			var rotDeg = data.rotationsDegree;
			var pitch = rotDeg.x;
			var heading = rotDeg.z;
			var roll = rotDeg.y;
			var geo = data.geographicCoord;
			
			var offset;
			if(pitch > 0 ){
				 offset = bbox.getYLength() / 2;
			} else {
				offset = bbox.getZLength() / 2;
			}
			var newHeight = offset + geo.altitude;
			
			node.changeLocationAndRotation(geo.latitude, geo.longitude, newHeight, heading, pitch, roll,magoManager);
			
			magoManager.effectsManager.addEffect(data.nodeId, new Mago3D.Effect({
				effectType      : pitch > 0 ? "zBounceLinear":"zBounceSpring",
				durationSeconds : 0.4
			}));
			magoManager.effectsManager.addEffect(data.nodeId, new Mago3D.Effect({
				effectType      : "borningLight",
				durationSeconds : 0.6
			}));
			
			node.setRenderCondition(function(data){
				var attributes = data.attributes; 
				if(!simulating) {
					attributes.isVisible = false;
					return;
				} 
				var sliderValue = slider.getValue();
				
				var dataId =data.nodeId;
				var refNum = parseInt(dataId.split('_')[2]);
				var specify = refNum % 6;
				
				if(sliderValue >= specify) {
					attributes.isVisible = true;
					
					if(data.currentLod < 4) {
						data.isColorChanged = false;
					} else {
						data.isColorChanged = true;
						if(!data.aditionalColor) {
							data.aditionalColor = new Mago3D.Color();
							
							switch(specify) {
								case 0 : data.aditionalColor.setRGB(230/255,8/255,0);break; 
								case 1 : data.aditionalColor.setRGB(255/255,100/255,28/255);break;
								case 2 : data.aditionalColor.setRGB(141/255,30/255,77/255);break;
								case 3 : data.aditionalColor.setRGB(125/255,44/255,121/255);break;
								case 4 : data.aditionalColor.setRGB(255/255,208/255,9/255);break;
								case 5 : data.aditionalColor.setRGB(0,169/255,182/255);break;
							}
						}
					}
				} else {
					attributes.isVisible = false;
					if(!magoManager.effectsManager.hasEffects(dataId)) {
						magoManager.effectsManager.addEffect(dataId, new Mago3D.Effect({
							effectType      : pitch > 0 ? "zBounceLinear":"zBounceSpring",
							durationSeconds : 0.4
						}));
						magoManager.effectsManager.addEffect(dataId, new Mago3D.Effect({
							effectType      : 'borningLight',
							durationSeconds : 0.6
						}));
					}
				}
			})
		}
	}
	var setObserver = function(){
		if(!observer) {
			observer = new MutationObserver(function(mutations) {
				var mutation = mutations[0];
				var display = mutation.target.style.display;
				if(display === 'none') {
					constructionProcessReset();
					this.disconnect();
				}
			});
		}
		observer.observe(observerTarget, observerConfig);
	}
	var constructionProcessReset = function() {
		simulating = false;
		//레인지, 레전드 끄기
		$('#csRange, #constructionProcess .profileInfo').hide();
	}

    function createPoint(worldPosition) {
        var entity = _viewer.entities.add({
            position: worldPosition,
            point: {
                color: Cesium.Color.GRAY,
                pixelSize: 5,
                outlineColor: Cesium.Color.BLACK,
                outlineWidth: 2,
                disableDepthTestDistance: Number.POSITIVE_INFINITY,
                heightReference: Cesium.HeightReference.CLAMP_TO_GROUND
            }
        });
        return entity;
    }

    var dynamicCenter = new Cesium.CallbackProperty(function () {
        var bs = Cesium.BoundingSphere.fromPoints(activeShapePoints);
        return Cesium.Ellipsoid.WGS84.scaleToGeodeticSurface(bs.center);
    }, false);

    var dynamicLabel = new Cesium.CallbackProperty(function () {
        return formatArea(getArea(activeShapePoints));
    }, false);

    function drawShape(positionData) {
        var shape;
        if (drawingMode === 'line') {
            shape = _viewer.entities.add({
                corridor: {
                    // polyline: {
                    positions: positionData,
                    material: new Cesium.ColorMaterialProperty(Cesium.Color.GRAY),
                    //heightReference: Cesium.HeightReference.CLAMP_TO_GROUND,
                    // followSurface: true,
                    // clampToGround : true,
                    width: 3
                }
            });
        }
        // 폴리곤 생성
        else if (drawingMode === 'polygon') {
            var bs = Cesium.BoundingSphere.fromPoints(activeShapePoints);
            var position = Cesium.Ellipsoid.WGS84.scaleToGeodeticSurface(bs.center);
            var areaVal = parseInt(getArea(activeShapePoints));
            shape = _viewer.entities.add({
                name     : "Polygon for area measurement",
                areaVal : areaVal,
                polygon: {
                    shadows: 1,
                    areaVal : areaVal,
                    hierarchy: positionData,
                    extrudedHeight: heightBuildingInput,
                    material: new Cesium.ColorMaterialProperty(Cesium.Color.GRAY.withAlpha(0.8)),
                    /* height: 0.1, */
                    //heightReference: Cesium.HeightReference.CLAMP_TO_GROUND
                }
            });
            nowPolygon = shape;
        }
        return shape;
    }

    // use scratch object to avoid new allocations per frame.
    var startCartographic = new Cesium.Cartographic();
    var endCartographic = new Cesium.Cartographic();
    var scratch = new Cesium.Cartographic();
    var geodesic = new Cesium.EllipsoidGeodesic();

    function getLineLength(positions) {
        lengthInMeters = 0;
        for (var i = 1, len = positions.length; i < len; i++) {
            var startPoint = positions[i - 1];
            var endPoint = positions[i];

            lengthInMeters += Cesium.Cartesian3.distance(startPoint, endPoint);
        }
        return formatDistance(lengthInMeters);
    }

    function getArea(positions) {
        areaInMeters = 0;
        if (positions.length >= 3)
        {
            var points = [];
            for(var i = 0, len = positions.length; i < len; i++)
            {
                var cartographic = Cesium.Cartographic.fromCartesian(positions[i]);
                points.push(new Cesium.Cartesian2(cartographic.longitude, cartographic.latitude));
            }
            if(Cesium.PolygonPipeline.computeWindingOrder2D(points) === Cesium.WindingOrder.CLOCKWISE)
            {
                points.reverse();
            }

            var triangles = Cesium.PolygonPipeline.triangulate(points);

            for(var i = 0, len = triangles.length; i < len; i+=3)
            {
                areaInMeters += calArea(points[triangles[i]], points[triangles[i + 1]], points[triangles[i + 2]]);
            }
        }
        return areaInMeters;
    }
    
    function calArea(t1, t2, t3, i) {
        var r = Math.abs(t1.x * (t2.y - t3.y) + t2.x * (t3.y - t1.y) + t3.x * (t1.y - t2.y)) / 2;
		var cartographic = new Cesium.Cartographic((t1.x + t2.x + t3.x) / 3, (t1.y + t2.y + t3.y) / 3);
		var cartesian = _viewer.scene.globe.ellipsoid.cartographicToCartesian(cartographic);
        var magnitude = Cesium.Cartesian3.magnitude(cartesian);
        return r * magnitude * magnitude * Math.cos(cartographic.latitude)
    }

    function drawLabel(positionData) {
        var label;
            label = _viewer.entities.add({
                position: positionData,
                label: {
                    text: getLineLength(activeShapePoints),
                    font: 'bold 20px sans-serif',
                    fillColor: Cesium.Color.GRAY,
                    style: Cesium.LabelStyle.FILL,
                    verticalOrigin: Cesium.VerticalOrigin.BOTTOM,
                    disableDepthTestDistance: Number.POSITIVE_INFINITY,
                    heightReference: Cesium.HeightReference.CLAMP_TO_GROUND 
                }
            });
        return label;
    }

    //영역 계산 라벨
    function drawAreaLabel() {
        var label;
        var bs = Cesium.BoundingSphere.fromPoints(activeShapePoints);
        var position = Cesium.Ellipsoid.WGS84.scaleToGeodeticSurface(bs.center);
        var areaVal = getArea(activeShapePoints);
        var text = formatArea(areaVal);
        label = _viewer.entities.add({
            name     : "Label for area measurement",
            position: position,
            label: {
                text: text,
                font: 'bold 20px sans-serif',
                fillColor: Cesium.Color.BLUE,
                style: Cesium.LabelStyle.FILL,
                verticalOrigin: Cesium.VerticalOrigin.BOTTOM,
                disableDepthTestDistance: Number.POSITIVE_INFINITY,
                heightReference: Cesium.HeightReference.CLAMP_TO_GROUND
            }
        });
        
        mesurPolyList.push(areaVal);
        return label;
    }
    
    function clacArea() {
    	var sumArea = 0;
    	for(var i = 0; i < _polygons.length; i++) {
    		sumArea += _polygons[i].areaVal;
    	}
    	var buildCoverateRatio = parseInt(sumArea/cityPlanTargetArea * 100);
    	$('#buildCoverateRatio').text('건폐율 : ' + buildCoverateRatio + '%');
    }

    // Redraw the shape so it's not dynamic and remove the dynamic shape.
    function terminateShape() {
        // activeShapePoints.pop();
        lengthInMeters = 0;
        areaInMeters = 0
        this._polylines.push(drawShape(activeShapePoints));
        if (drawingMode === 'polygon') {
        	this._labels.push(drawAreaLabel());
        }

        _viewer.entities.remove(activeShape);
        _viewer.entities.remove(activeLabel);
        
        activeShape = undefined;
        activeLabel = undefined;
        activeShapePoints = [];
    }

    function startDrawPolyLine() {
    	debugger;
        handler = new Cesium.ScreenSpaceEventHandler(_viewer.canvas);
        var dynamicPositions = new Cesium.CallbackProperty(function () {
            return new Cesium.PolygonHierarchy(activeShapePoints);
        }, false);
        
        handler.setInputAction(function (event) {
        	debugger;
            var earthPosition = _viewer.scene.pickPosition(event.position);
            
        	console.log('폴리곤 : ', earthPosition);
            if (Cesium.defined(earthPosition)) {
                var cartographic = Cesium.Cartographic.fromCartesian(earthPosition);
                var tempPosition = Cesium.Cartesian3.fromDegrees(Cesium.Math.toDegrees(cartographic.longitude), Cesium.Math.toDegrees(cartographic.latitude));
                if(runAllocBuildChkStat) {
                    activeShapePoints.push(tempPosition);
                    
                    if (activeShapePoints.length === 1) {
                        activeShape = drawShape(dynamicPositions);
                        if (drawingMode === 'polygon') {
    	                    activeLabel = _viewer.entities.add({
    	                        name     : "TempLabel for area measurement",
    	                        position: dynamicCenter,
    	                        label: {
    	                            text: dynamicLabel,
    	                            font: 'bold 20px sans-serif',
    	                            fillColor: Cesium.Color.BLUE,
    	                            style: Cesium.LabelStyle.FILL,
    	                            verticalOrigin: Cesium.VerticalOrigin.BOTTOM,
    	                            disableDepthTestDistance: Number.POSITIVE_INFINITY,
    	                            heightReference: Cesium.HeightReference.CLAMP_TO_GROUND
    	                        }
    	                    });
                        }
                    }
                    else {
                        //this._labels.push(drawLabel(tempPosition));
                    }
                    this._polylines.push(createPoint(tempPosition));	
                } else {
                	// 새로운 모델 선택
                    var pickedFeature = viewer.scene.pick(event.position);
                    if(pickedFeature) {
                		selectBuildDialog.dialog( "open" );
                		selectEntity =pickedFeature;
                    } else {
                    	selectEntity = undefined;
                    }
//                    ;
//                    _viewer._selectedEntity = pickedFeature.id.polygon;
                }
            }
        }, Cesium.ScreenSpaceEventType.LEFT_CLICK);

        handler.setInputAction(function (event) {
            var earthPosition = _viewer.scene.pickPosition(event.position);
        	console.log('폴리곤 : ', earthPosition);
            terminateShape();
            _polygons.push(nowPolygon);
            clacArea();
        }, Cesium.ScreenSpaceEventType.RIGHT_CLICK);
    }
    
    $('#set_target_area').click(function() {
    	cityPlanTargetArea = parseInt($('#target_area_input').val());
    	cityPlanTargetFloorCov = parseInt($('#target_floor_cov').val());
        cityPlanTargetBuildCov = parseInt($('#target_build_cov').val());
        $('#targetfloorCoverateRatio').text('기준 용적율 : ' + cityPlanTargetFloorCov + '%');
        $('#targetbuildCoverateRatio').text('기준 건폐율 : ' + cityPlanTargetBuildCov + '%');;
    })
    
    $('#result_build').click(function() {
    	// console.log("맵컨트롤 : 저장");
        var targetResolutionScale = 1.0;
        var timeout = 500; // in ms

        var scene =that._scene;
        if (!scene) {
            console.error("No scene");
        }

        // define callback functions
        var prepareScreenshot = function(){
            var canvas = scene.canvas;
            viewer.resolutionScale = targetResolutionScale;
            scene.preRender.removeEventListener(prepareScreenshot);
            // take snapshot after defined timeout to allow scene update (ie. loading data)
            startLoading();
            setTimeout(function(){
                scene.postRender.addEventListener(takeScreenshot);
            }, timeout);
        }

        var takeScreenshot = function(){
            scene.postRender.removeEventListener(takeScreenshot);
            var canvas = scene.canvas;
            debugger;
            $("#cityplanImg").attr("src", canvas.toDataURL());
            viewer.resolutionScale = 1.0;
            stopLoading();
        	resultCityPlanDialog.dialog( "open" );
//            canvas.toBlob(function(blob){
//                var url = URL.createObjectURL(blob);
//            });
            
        }

        scene.preRender.addEventListener(prepareScreenshot);
    	
    })

    var selectBuildDialog = $( "#selectBuildDialog" ).dialog({
		autoOpen: false,
		width: 200,
		height: 200,
		modal: true,
		overflow : "auto",
		resizable: false
	});
    
	var resultCityPlanDialog = $( "#resultCityPlanDialog" ).dialog({
		autoOpen: false,
		width: 1100,
		height: 650,
		modal: true,
		overflow : "auto",
		resizable: false
	});
}