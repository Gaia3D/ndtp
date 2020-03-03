
var Simulation = function(magoInstance, viewer, $) {
	var that = this;
	var CAMERA_MOVE_NEED_DISTANCE = 5000;
	console.log(viewer);

	var _viewer = viewer;
	// _viewer.selectionIndicator = false;
	// _viewer.selectionIndicator.viewModel.isVisible = false;
    var _scene = viewer.scene;
    var _polylines = [];
    var _labels = [];   
    var _polygons = [];
    var _camera_scene = [];
    var _cityPlanModels = [];
    var _bsConstructProcessModels = [];
    let _sejongDataGroupList = [];
    var _geojsonSample = null;
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
    var locaMonitor = false;
	var magoManager = magoInstance.getMagoManager();
	var f4dController = magoInstance.getF4dController();

    var runAllocBuildStat = "";

    var cityPlanTargetArea = 0; // 기준 면적
    var cityPlanStdFloorCov = 0; // 기준 용적률
    var floorCoverateRatio = 0; // 용적률
    var cityPlanStdBuildCov = 0; // 기준 건폐율
    var buildCoverateRatio = 0; // 건폐율
    
    var stdFairRate = 0;

    var locationList = {
    	"seoul": [126.9282132, 37.5201354],
		"sejong": [127.2739454, 36.5268601],
		"pusan": [129.0015885, 35.1645701],
	};
	setTimeout(()=> {
		_viewer.camera.flyTo({
			destination : Cesium.Cartesian3.fromDegrees(locationList["seoul"][0],  locationList["seoul"][1], 2000)
		});
	}, 1000);

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
			_viewer.softShadows = true 
			for(var i=1;i<25;i++) {
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
	
	$('#constUploadBtn').click(function() {
		constProcUploadDialog.dialog("open");
		$('#cons_proc_lon').text($('#monitorLon').val());
		$('cons_proc_lat').text($('#monitorLon').val());
		$('cons_proc_alt').text($('#monitorLon').val());
	});
	
	var cache = {};

	var SEJONG_TILE_NAME = 'sejong_time_series_tiles';
	var BUSAN_TILE_NAME = 'busan_time_series_tiles';
	// var SEJONG_TILE_NAME = 'SEJONG_TILE';
	var slider;
	var simulating = false;

	const consBuildSlider =  {
		consType: 0,
		saveFileType: '',
		sliderSejongInit: () => {
			if(!slider) {
				slider = new KotSlider('rangeInput');
			}
			//레인지, 레전드 보이기
			$('#csRange, #constructionProcess .profileInfo').show();
			$('#saRange').hide();

			var html = '';
			html += '<span>1단계</span>';
			html += '<span>2단계</span>';
			html += '<span>3단계</span>';
			html += '<span>4단계</span>';
			html += '<span>5단계</span>';
			html += '<span>6단계</span>';
			whole_viewer.scene.camera.flyTo({
				destination : Cesium.Cartesian3.fromDegrees(127.249979, 36.4799635, 1000)
			});

			$('#csRange .rangeWrapChild.legend').html(html);

			$('#csRange .rangeWrapChild.legend').on('click','span',function() {
				slider.setValue($(this).index());
			});

			$('#rangeInput').on('change', function(data) {
				if(_sejongDataGroupList.length !== 0)
					clearAllDataAPI(MAGO3D_INSTANCE);
				/*
				for(const sejgonObj of _sejongDataGroupList) {
					MAGO3D_INSTANCE.getF4dController().deleteF4dGroup(sejgonObj);
				}*/

				_sejongDataGroupList = [];
				var index = parseInt($('#rangeInput').val());
				var consTypeString = $('input[name="cpProtoArea"]:checked').val();
				for( let i = 0 ; i < index+1; i++) {
					consBuildSlider.sejongDataReq(i, consTypeString);
				}
			})
		},
		sejongDataReq: (step, cityType) => {
			const reqParam = {
				consTypeString : step + "",
				cityTypeString : cityType
			};
			console.log(step, ', ', cityType);
			$.ajax({
				url: "/data/simulation-rest/cityConstProcSelect",
				type: "GET",
				data: reqParam,
				dataType: "json",
				success: function (msg) {
					_sejongDataGroupList.push(msg.data_key);
					const f4dObject = f4dDataGenMaster.initGml(msg);
					var f4dController = MAGO3D_INSTANCE.getF4dController();
					f4dController.addF4dGroup(f4dObject);
					const lon = f4dDataGenMaster.avg_lon;
					const lat = f4dDataGenMaster.avg_lat;
					console.log(lon, ', ' ,lat);
				}
			});
		}
	};

	consBuildSlider.sliderSejongInit();

	//건설공정 조회
	$('#constructionProcess .execute').click(function() {
		var targetArea = $('input[name="cpProtoArea"]:checked').val();
		var dataName;
		var initPosition;

		if(targetArea === 's') {
			var msj = makeSampleJson();
			var policy = Mago3D.MagoConfig.getPolicy();
			var initLat = parseFloat(policy.initLatitude);
			var initLon = parseFloat(policy.initLongitude);
			var childs = msj.children;
			f4dController.addF4dGroup(msj);

			let objPinBuilder = new Cesium.PinBuilder();
			// let objLon = msj.children[0].longitude;
			// let objLat = msj.children[0].latitude;
			// let objHeight = msj.children[0].height;
			let objLon = getAverage(msj.children, "longitude");
			let objLat = getAverage(msj.children, "latitude");
			let objHeight = getAverage(msj.children, "height");

			let objPosition = Cesium.Cartesian3.fromDegrees(objLon, objLat, objHeight-2);
			console.log("objPosition   >> lon=", objLon, " lat=", objLat, " h=", objHeight);

			// let clampPosition = whole_viewer.scene.clampToHeight(objPosition);
			// let clampCarto  = Cesium.Ellipsoid.WGS84.cartesianToCartographic(clampPosition);
			// let clampLon = Cesium.Math.toDegrees(clampCarto.longitude);
			// let clampLat = Cesium.Math.toDegrees(clampCarto.latitude);
			// let clampHeight = clampCarto.height;
			// console.log("clampPosition >> lon=", clampLon, " lat=", clampLat, " h=", clampHeight);

			_viewer.entities.add({
				billboard : {
					image : objPinBuilder.fromText('!', Cesium.Color.BLACK, 48).toDataURL(),
					verticalOrigin: Cesium.VerticalOrigin.BOTTOM,
					eyeOffset: new Cesium.Cartesian3(0, objHeight, 0)
				},
				position : objPosition,
			});

			_viewer.camera.flyTo({
			    destination : Cesium.Cartesian3.fromDegrees(126.9785978787040,  37.56690158584144, 100)
			});
		} else if (targetArea === "p") {
			initConsturctProcessModel(); 
			dataName = BUSAN_TILE_NAME;
			if(!slider) {
				slider = new KotSlider('rangeInput');
			}
			//레인지, 레전드 보이기
			$('#csRange, #constructionProcess .profileInfo').show();
			$('#saRange').hide();
			if(!cache[dataName]) {
				if(dataName.indexOf('tiles') > 0) {
//					magoManager.getObjectIndexFileSmartTileF4d(dataName);

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
					$('#rangeInput').on('change', function(data) {
						var index = $('#rangeInput').val();
						dispConstructProcessModel(parseInt(index));
					})
				}
			}
			dispConstructProcessModel(0);
//			genBillboard(126.90497956470877, 37.521051475771344);
			_viewer.camera.flyTo({
			    destination : Cesium.Cartesian3.fromDegrees(126.90497956470877,  37.521051475771344, 100)
			});
		} else if (targetArea === "etc") {
			console.log("etc");
		}
	});
	
	
	
	//건설공정 취소
	$('#constructionProcess .reset').click(function(){
		constructionProcessReset();
	});
	
	//경관 분석 위치지정
	$('#solarAnalysis .drawObserverPoint').click(function(){
		notyetAlram();
	});

	// 업로드
	$('#upload_cityplan').click(function() {
        // Get form
        var form = $('#file_upload')[0];
        startLoading();
	    // Create an FormData object 
        var data = new FormData(form);
        $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            url: "http://localhost/data/simulation-rest/cityPlanUpload",
            data: data,
            processData: false,
            contentType: false,
            cache: false,
            timeout: 600000,
            success: function (data) {
            	$.growl.notice({
            		message: "파일업로드가 완료되었습니다",
            		duration: 1000
            	});
            	stopLoading();
            },
            error: function (e) {
                console.log("ERROR : ", e);
                alert("fail");
            	stopLoading();
            }
        });
	});
	
	//건물 높이에 대해서 확정을 하는 로직, 용적률과 연관
	//고도에 대한 불확실성
	$('#set_height_building').click(function(e) {

		floorNum = parseInt($('#height_building_input').val());
		var floorSize = floorNum * 3;
		selectEntity.id.polygon.extrudedHeight = floorSize;
		selectEntity.id.polygon.floorNum = floorNum;
		for(var i = 0; i < _polygons.length; i++) {
			if(_polygons[i].id === selectEntity.id._id) {
				_polygons[i].extrudedHeight = floorSize;
				_polygons[i].floorNum = floorNum;
				break;
			} 
		}
		calcFloorCoverage();
		selectBuildDialog.dialog( "close" );
		heightBuildingInput = 0;
	})
	
	// 용적률 계산
	function calcFloorCoverage() {
		// 각층 바닥 면접의 합
		// 각층 * 바닥 면접 
		var floorCoverSum = 0;
		for(var i = 0; i < _polygons.length; i++) {
			if(_polygons[i].floorNum === undefined) {
				continue;
			}
			var areaVal = _polygons[i].areaVal * _polygons[i].floorNum;
			floorCoverSum += areaVal;
		}
		
		for(var i = 0; i < _cityPlanModels.length; i++) {
			if(_cityPlanModels[i].floorNum === undefined) {
				continue;
			}
			var areaVal = _cityPlanModels[i].areaVal * _cityPlanModels[i].floorNum;
			floorCoverSum += areaVal;
		}
		
		floorCoverateRatio = parseInt(floorCoverSum / cityPlanTargetArea * 100);
		$('#floorCoverateRatio').text('용적율 : ' + floorCoverateRatio + '%');
	}
	
	// 가시화
	$('#run_cityplan').click(function() {
        startLoading();
        sejeonjochiwonPoly();
	});

	var viewModel = {
		standardFloorCount: 0,
		buildingHeight: 40,
		buildingAdjust: 0,
	};
	var allObject = {};
	var pickedName = "";
	a=allObject;

	var standardHeight = parseInt(viewModel.buildingHeight);
	var smulationToolbar = document.getElementById('smulationToolbar');
	Cesium.knockout.track(viewModel);
	Cesium.knockout.applyBindings(viewModel, smulationToolbar);

	$("#districtDisplay").change(value => {
		let val = value.target.value;
		if (pickedName === "") {
			alert("지역을 먼저 선택해 주시기 바랍니다.");
			return;
		}
		switch (val) {
			case "disable":
				if (allObject[pickedName].terrain.show === true) {
					allObject[pickedName].terrain.show = !allObject[pickedName].terrain.show;
				}
				break;
			case "enable":
				if (allObject[pickedName].terrain.show === false) {
					allObject[pickedName].terrain.show = !allObject[pickedName].terrain.show;
				}
				break;
			default:
				console.log("아무것도 선택되지 않았습니다.");
		}
	});
	$("#curLocation").change((value) => {
		let val = value.target.value;
		let height = 2000;

		_viewer.scene.camera.flyTo({
			destination : Cesium.Cartesian3.fromDegrees(locationList[val][0], locationList[val][1], height)
		});
	});
	$("#selectPiece").change((value) => {
		let val = value.target.value;
		switch (val) {
			case "sejong6_4":
				var layers = viewer.scene.imageryLayers;

				layers.addImageryProvider(new Cesium.SingleTileImageryProvider({
					url : '/images/mapgeoref.png',
					rectangle : Cesium.Rectangle.fromDegrees(127.2603901, 36.5187878, 127.2875007, 36.5349324)
				}));

				_viewer.scene.camera.flyTo({
					destination : Cesium.Cartesian3.fromDegrees(127.2739454, 36.5268601, 600.0)
				});
				break;
			default:
				console.log("val is empty or undefined");
		}
	});

	$("#selectDistrict").change(value => {
		let val = value.target.value;
		pickedName = val;
		if( val === "sejong_apartmentComplex1") {
			if (allObject[val] !== undefined) {
				buildingToLandRatioCalc();
				floorAreaRatioCalc();
				settingDistrictDisplay();
				_viewer.selectedEntity = allObject[pickedName].terrain;
				return;
			}
			allObject[val] = {
				terrain: "",   		// single entity
				buildings: [], 		// [] entity
				plottage: 0, 		// 대지 면적
				totalFloorArea: 0, 	// 빌딩들의 총 건축면적
			};

			const fileName = "Parcel6-4.geojson";
			const obj = {
				width : 5,
				leadTime : 0,
				trailTime : 100,
				resolution : 5,
				strokeWidth: 0,
				stroke: Cesium.Color.AQUA.withAlpha(0.0),
				fill: Cesium.Color.AQUA.withAlpha(0.8),
			};
			let url = "http://localhost/data/simulation-rest/drawGeojson?fileName=" + fileName;

			Cesium.GeoJsonDataSource.load(url, obj).then(function(dataSource) {
				let entitis = dataSource.entities._entities._array;

				for(let index in entitis) {
					let entitiyObj = entitis[index];
					let registeredEntity = _viewer.entities.add(entitiyObj);
					registeredEntity.name = "sejong_apartmentComplex1";

					Cesium.knockout.getObservable(viewModel, 'standardFloorCount').subscribe(
						function(newValue) {
							registeredEntity.polygon.extrudedHeight = newValue;
						}
					);
					allObject[val].terrain = registeredEntity;
				}
				settingDistrictDisplay();
				// setTimeout(()=>{
					_viewer.selectedEntity = allObject[pickedName].terrain;
				// }, 500);
			}, function(err) {
				console.log(err);
			});
		}
		else if(val === "sejong_church1") {
			if (allObject[val] !== undefined) {
				buildingToLandRatioCalc();
				floorAreaRatioCalc();
				settingDistrictDisplay();
				_viewer.selectedEntity = allObject[pickedName].terrain;
				return;
			}
			allObject[val] = {
				terrain: "",   		// single entity
				buildings: [], 		// [] entity
				plottage: 0, 		// 대지 면적
				totalFloorArea: 0, 	// 빌딩들의 총 건축면적
			};

			const fileName = "schoolphill.geojson";
			const obj = {
				width : 5,
				leadTime : 0,
				trailTime : 100,
				resolution : 5,
				strokeWidth: 0,
				stroke: Cesium.Color.AQUA.withAlpha(0.0),
				fill: Cesium.Color.AQUA.withAlpha(0.8),
			};
			let url = "http://localhost/data/simulation-rest/drawGeojson?fileName=" + fileName;

			Cesium.GeoJsonDataSource.load(url, obj).then(function(dataSource) {
				let entitis = dataSource.entities._entities._array;

				for(let index in entitis) {
					let entitiyObj = entitis[index];
					let registeredEntity = _viewer.entities.add(entitiyObj);
					registeredEntity.name = "sejong_church1";

					Cesium.knockout.getObservable(viewModel, 'standardFloorCount').subscribe(
						function(newValue) {
							registeredEntity.polygon.extrudedHeight = newValue;
						}
					);
					allObject[val].terrain = registeredEntity;
				}
				settingDistrictDisplay();
				// setTimeout(()=>{
					_viewer.selectedEntity = allObject[pickedName].terrain;
				// }, 500);
			}, function(err) {
				console.log(err);
			});
		} else {
			console.log("val is empty or undefined");
		}
	});
	$("#districtType").change((value) => {
		let val = value.target.value;
		if (pickedName === "") {
			alert("지역을 먼저 선택해 주시기 바랍니다.");
			$("#districtType").val("");
			return;
		}
		switch (val){
			case "dType1":
				allObject[pickedName].terrain.polygon.material.color=Cesium.Color.YELLOW.withAlpha(0.6);
				$("#standardFloorAreaRatio").val(140).trigger("change");
				$("#standardBuildingToLandRatio").val(50).trigger("change");
				$("#standardFloorCount").val(25).trigger("change");
				break;
			case "dType2":
				allObject[pickedName].terrain.polygon.material.color=Cesium.Color.ORANGERED.withAlpha(0.6);
				$("#standardFloorAreaRatio").val(120).trigger("change");
				$("#standardBuildingToLandRatio").val(40).trigger("change");
				$("#standardFloorCount").val(15).trigger("change");
				break;
			case "dType3":
				allObject[pickedName].terrain.polygon.material.color=Cesium.Color.MEDIUMTURQUOISE.withAlpha(0.6);
				$("#standardFloorAreaRatio").val(80).trigger("change");
				$("#standardBuildingToLandRatio").val(20).trigger("change");
				$("#standardFloorCount").val(10).trigger("change");
				break;
			case "dType4":
				allObject[pickedName].terrain.polygon.material.color=Cesium.Color.YELLOWGREEN.withAlpha(0.6);
				$("#standardFloorAreaRatio").val(50).trigger("change");
				$("#standardBuildingToLandRatio").val(25).trigger("change");
				$("#standardFloorCount").val(40).trigger("change");
				break;
			default:
				console.log("아무것도 선택되지 않았습니다.");
		}
	});

	$("#create3dModel").click(()=> {
		let val = $("#selectDistrict").val();
		if (allObject[val] === undefined) {
			alert("지역을 먼저 선택해 주시기 바랍니다.");
			return;
		}
		if (pickedName !== "sejong_apartmentComplex1") {
			alert("현재는 세종시 아파트만 지원됩니다.");
			return;
		}

		const fileName = "Parcel6-4-Buidling.geojson";
		const obj = {
			width : 5,
			leadTime : 0,
			trailTime : 100,
			resolution : 5,
			stroke: Cesium.Color.BLUEVIOLET,
			fill: Cesium.Color.BLUEVIOLET,
		};
		let url = "http://localhost/data/simulation-rest/drawGeojson?fileName=" + fileName;

		Cesium.GeoJsonDataSource.load(url, obj).then(function(dataSource) {
			let entitis = dataSource.entities._entities._array;
			let sumFloorArea = 0;

			for(let index in entitis) {
				let entitiyObj = entitis[index];
				let registeredEntity = _viewer.entities.add(entitiyObj);
				registeredEntity.name = "아파트_" + index;
				registeredEntity.polygon.extrudedHeight = parseInt(viewModel.buildingHeight);

				let buildingFloorArea = parseFloat(getArea(registeredEntity.polygon._hierarchy._value.positions));	// 건축면적
				let totalBuildingFloorArea = buildingFloorArea * registeredEntity.polygon.extrudedHeight;  // 건축면적 * 층수 = 연면적
				registeredEntity.buildingFloorArea = buildingFloorArea; // 건축면적
				registeredEntity.totalBuildingFloorArea = totalBuildingFloorArea; // 연면적
				sumFloorArea += buildingFloorArea;

				// todo: 임시
				allObject[pickedName].buildings.push(registeredEntity);

				let intIndex = parseInt(index);
				if (intIndex % 2 === 0) {
					Cesium.knockout.getObservable(viewModel, 'buildingHeight').subscribe(
						function(newValue) {
							// let curHeight = parseInt(registeredEntity.polygon.extrudedHeight.getValue());
							let newVal = parseInt(newValue);
							let customizing = parseInt($("#inputCustomizing").val());

							registeredEntity.polygon.extrudedHeight = newVal + customizing;

							// 변경된 연면적 계산
							registeredEntity.totalBuildingFloorArea = registeredEntity.buildingFloorArea * registeredEntity.polygon.extrudedHeight;
							standardHeight = parseInt(newValue);
						}
					);
					Cesium.knockout.getObservable(viewModel, 'buildingAdjust').subscribe(
						function(newValue) {
							let newVal = parseInt(newValue);
							registeredEntity.polygon.extrudedHeight = standardHeight + newVal;

							// 변경된 연면적 계산
							registeredEntity.totalBuildingFloorArea = registeredEntity.buildingFloorArea * registeredEntity.polygon.extrudedHeight;
						}
					);
				} else {
					Cesium.knockout.getObservable(viewModel, 'buildingHeight').subscribe(
						function(newValue) {
							// let curHeight = parseInt(registeredEntity.polygon.extrudedHeight.getValue());
							let newVal = parseInt(newValue);
							let customizing = parseInt($("#inputCustomizing").val());

							registeredEntity.polygon.extrudedHeight = newVal - customizing;

							// 변경된 연면적 계산
							registeredEntity.totalBuildingFloorArea = registeredEntity.buildingFloorArea * registeredEntity.polygon.extrudedHeight;
							standardHeight = parseInt(newValue);
						}
					);
					Cesium.knockout.getObservable(viewModel, 'buildingAdjust').subscribe(
						function(newValue) {
							let newVal = parseInt(newValue);
							registeredEntity.polygon.extrudedHeight = standardHeight - newVal;

							// 변경된 연면적 계산
							registeredEntity.totalBuildingFloorArea = registeredEntity.buildingFloorArea * registeredEntity.polygon.extrudedHeight;
						}
					);
				}
			}
			// $("#inputBuildingHeight").trigger("change");
			allObject[pickedName].totalFloorArea = sumFloorArea;
			allObject[pickedName].plottage = getArea(allObject[pickedName].terrain.polygon._hierarchy._value.positions);

			buildingToLandRatioCalc();
			floorAreaRatioCalc();
		}, function(err) {
			console.log(err);
		});
	});

	$("#inputBuildingHeight").change(()=> {
		floorAreaRatioCalc();
	});
	$("#inputCustomizing").change(() => {
		floorAreaRatioCalc();
	});

	// 건폐율 계산 및 view (건축면적 / 대지면적)
	function buildingToLandRatioCalc() {
		if (pickedName === "") {
			alert("오브젝트를 먼저 선택해 주시기 바랍니다.");
			return;
		}
		let plottage = parseFloat(allObject[pickedName].plottage); // 대지면적
		let totalFloorArea = parseFloat(allObject[pickedName].totalFloorArea); // 총 건축면적

		if (plottage === 0.0) {
			return;
		}
		let result = (totalFloorArea / plottage) * 100.0;
		$("#curBuildingToLandRatio").val(result.toFixed(2));
	}
	// 용적율 계산 및 view (연면적 / 대지면적)
	function floorAreaRatioCalc() {
		if (pickedName === "") {
			alert("오브젝트를 먼저 선택해 주시기 바랍니다.");
			return;
		}
		let plottage = parseFloat(allObject[pickedName].plottage); // 대지면적
		let totalArea = totalAreaCalc(allObject[pickedName].buildings); // 총 연면적

		if (plottage === 0.0) {
			return;
		}
		let result = (totalArea / plottage) * 100.0;
		$("#curFloorAreaRatio").val(result.toFixed(2));
	}
	// 모든 빌딩들의 연면적 합
	function totalAreaCalc(entityArray) {
		let sum = 0;
		entityArray.forEach(entity => {
			sum += entity.totalBuildingFloorArea;
		});
		return sum;
	}
	function settingDistrictDisplay() {
		if (allObject[pickedName].terrain.show) {
			$("#districtDisplay").val("enable");
		} else {
			$("#districtDisplay").val("disable");
		}
	}




	$('#run_sample_raster').click(function() {
		var layers = viewer.scene.imageryLayers;

		layers.addImageryProvider(new Cesium.SingleTileImageryProvider({
			url : '/images/mapgeoref.png',
			rectangle : Cesium.Rectangle.fromDegrees(127.2603901, 36.5187878, 127.2875007, 36.5349324)
		}));

		_viewer.scene.camera.flyTo({
			destination : Cesium.Cartesian3.fromDegrees(127.2739454, 36.5268601, 600.0)
		});
	});
	
	function sejeonjochiwonPoly() {
		Cesium.GeoJsonDataSource.load('http://localhost/data/simulation-rest/select', {
			width : 5,
			leadTime : 0,
			trailTime : 100,
			resolution : 5,
			fill: Cesium.Color.PINK
		}).then(function(dataSource) {
			var entitis = dataSource.entities._entities._array;
			
			for(var index in entitis) {
				var entitiyObj = entitis[index];

				let destrictPositions = entitiyObj.polygon._hierarchy._value.positions;
				let destrictArea = getArea(destrictPositions);
				//todo: save this in Object
				// console.log(destrictArea);

//				entitiyObj.polygon.extrudedHeight = 10; 
				var glowingLine = _viewer.entities.add(entitiyObj)
			}
			setTimeout(function() {
				stopLoading();
		        _viewer.scene.camera.flyTo({
		            destination : Cesium.Cartesian3.fromDegrees(127.297938703110319, 36.601598278028625, 600.0) // 세종 조치원
//		            destination : new Cesium.Cartesian3(226572.677000000141561, 344541.028999999165535, 6000000.0) // 세종 조치원
		            
		        });
			},4000);
		}, function(err) {
			stopLoading();
		});
	}
	
	function echdeltaLinString() {
		Cesium.GeoJsonDataSource.load('http://localhost/data/simulation-rest/select', {
			width : 5,
			leadTime : 0,
			trailTime : 100,
			resolution : 5,
		  fill: Cesium.Color.PINK,
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
			setTimeout(function() {
				stopLoading();
		        _viewer.scene.camera.flyTo({
		            destination : Cesium.Cartesian3.fromDegrees(128.91143708415015, 35.120229675016795, 600.0) // 에코 델타
		        });
			},4000);
		}, function(err) {
			stopLoading();
		});
	}
	
	$('#move_cityplan').click(function() {
	});

	$("#run_work_state").change(function(value){
		runAllocBuildStat = value.target.value;
		if(value.target.value === 'imsiBuild') {
    		$('#run_work_state').toggleClass('on'); // 버튼 색 변경
    		$('#run_work_state').trigger('afterClick');
		} else if(value.target.value === 'autoBuild') {
    		$('#run_work_state').toggleClass('on'); // 버튼 색 변경
    		$('#run_work_state').trigger('afterClick');
		}  else if(value.target.value === 'location') {
			
		}  else if(value.target.value === 'imsiBuildSelect') {
    		$('#run_work_state').removeClass('on');
            drawingMode = 'line';
		} else {
    		$('#run_work_state').removeClass('on');
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

	var smartTileLoaEndCallbak = function(evt) {
		var nodes = evt.tile.nodesArray;
		for(var i in nodes) {
			var node = nodes[i];
			var data = node.data;
			
			if(!cache[node.data.nodeId]) {
				cache[node.data.nodeId] = true;
			} else {
				return;
			}
			/**
			 * TODO: 스마트타일링 이슈
			 * 세종시 스마트타일링 데이터 높이값 보정 코드.
			 * 문제 : 노드가 로드 완료된 시점에서 처리하려하는데 해당 시점에는 bbox와 geoLocationDataManager가 존재하지 않음
			 * 해결 : 일단 억지로 끼워 넣음.
			 * 추후 목표 : 강제로 데이터 로드시 해당 부분을 미리 생성하는 옵션을 추가, 원래는 데이터가 표출될 때 처리되는 부분.
			 */
			/*var metaData = data.neoBuilding.metaData;
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
			
			node.changeLocationAndRotation(geo.latitude, geo.longitude, newHeight, heading, pitch, roll,magoManager);*/

			node.setRenderCondition(function(data){
				var attributes = data.attributes; 
				if(!simulating) {
					attributes.isVisible = true;
					data.isColorChanged = false;
				} else {
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
								//effectType      : pitch > 0 ? "zBounceLinear":"zBounceSpring",
								effectType      : "zBounceSpring",
								durationSeconds : 0.4
							}));
							magoManager.effectsManager.addEffect(dataId, new Mago3D.Effect({
								effectType      : 'borningLight',
								durationSeconds : 0.6
							}));
						}
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
//                  material: new Cesium.ColorMaterialProperty(Cesium.Color.GRAY.withAlpha(0.8)),
                  material: new Cesium.ColorMaterialProperty(Cesium.Color.GRAY),
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
    
    // 건폐율 계산
    function clacArea() {
    	var sumArea = 0;
    	for(var i = 0; i < _polygons.length; i++) {
    		sumArea += _polygons[i].areaVal;
    	}
    	for(var i = 0; i < _cityPlanModels.length; i++) {
    		sumArea += _cityPlanModels[i].areaVal;
    	}
    	buildCoverateRatio = parseInt(sumArea/cityPlanTargetArea * 100);
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
        handler = new Cesium.ScreenSpaceEventHandler(_viewer.canvas);
        var dynamicPositions = new Cesium.CallbackProperty(function () {
            return new Cesium.PolygonHierarchy(activeShapePoints);
        }, false);
        
        handler.setInputAction(function (event) {
            var earthPosition = _viewer.scene.pickPosition(event.position);

        	if(locaMonitor) {
                var ellipsoid = _viewer.scene.globe.ellipsoid;
                var cartographic = ellipsoid.cartesianToCartographic(earthPosition);
                var longitudeString = Cesium.Math.toDegrees(cartographic.longitude);
                var latitudeString = Cesium.Math.toDegrees(cartographic.latitude);
            	$('#monitorLon').text(longitudeString);
            	$('#monitorLat').text(latitudeString);	
        	}
			console.log('1. 폴리곤 : ', longitudeString, latitudeString);

            if (Cesium.defined(earthPosition)) {
                var cartographic = Cesium.Cartographic.fromCartesian(earthPosition);
                var tempPosition = Cesium.Cartesian3.fromDegrees(Cesium.Math.toDegrees(cartographic.longitude), Cesium.Math.toDegrees(cartographic.latitude));
                if(runAllocBuildStat === "imsiBuild") {
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
                } else if (runAllocBuildStat === "autoBuild") {
                	genBuild(Cesium.Math.toDegrees(cartographic.longitude), Cesium.Math.toDegrees(cartographic.latitude), 0, 10, "7M6_871.gltf")
                } else if(runAllocBuildStat === "imsiBuildSelect") {
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
                } else {
					var pickedFeature = viewer.scene.pick(event.position);

					if(pickedFeature) {
						pickedName = pickedFeature.id.name;
						allObject[pickedName].terrain = pickedFeature.id;
						allObject[pickedName].plottage = getArea(allObject[pickedName].terrain.polygon._hierarchy._value.positions);

						$("#selectDistrict").val(allObject[pickedName].terrain.name).trigger("change");
						// $("#districtDisplay").val("enable").trigger("change");
					} else {
						pickedName = "";
					}

				}
                /*else {

					var pickedFeature = _viewer.scene.pick(event.position);
					if(pickedFeature) {
//						const imsi = pickedFeature.id.polygon.hierarchy._value.positions.map(function(key,index){
//							pickedFeature.id.polygon.hierarchy._value.positions[index].x = key.x * 0.1
//							pickedFeature.id.polygon.hierarchy._value.positions[index].y = key.y * 0.1
//							console.log(pickedFeature.id.polygon.hierarchy._value.positions[key]);
//						})
						_viewer.entities.remove(pickedFeature.id);
						setTimeout(function() {
							// 좌상단 찾기
							var finish = false;
							
							// 1. 중심좌표를 찾는다.
							var center = Cesium.BoundingSphere.fromPoints(pickedFeature.id.polygon.hierarchy.getValue().positions).center;

							// 2. 횟수만큼 돈다
							for(var i = 0; i < pickedFeature.id.polygon.hierarchy._value.positions.length; i++) {
								// 3. 폴리곤 좌표정보를 찾는다.
								const pro = pickedFeature.id.polygon.hierarchy._value.positions[i];
								var d = Cesium.Cartesian3.distance(pro, center);
								resaclePoly(center.x, center.y, pro);
							}
							
					        // Cesium.Cartesian3.fromDegrees(longitudeString, latitudeString)
							// Cart2LonLat을 통한 크기 조절
//							for(var i = 0; i < pickedFeature.id.polygon.hierarchy._value.positions.length; i++) {
//								const pro = pickedFeature.id.polygon.hierarchy._value.positions[i];
//								var d = Cesium.Cartesian3.distance(pro, center); 
//								var cartePos = carteToLonLat(pro);
//
//								if(cartePos.lon <= carteCen.lon && cartePos.lat >= carteCen.lat) {
//									// 외쪽 상단 위도 + 경도 -
//									cartePos.lon += 0.00001;
//									cartePos.lat -= 0.00001;
//								} else if(cartePos.lon >= carteCen.lon && cartePos.lat >= carteCen.lat) {
//									// 우측 상단 위도 - 경도 -
//									cartePos.lon -= 0.00001;
//									cartePos.lat -= 0.00001;
//								} else if(cartePos.lon <= carteCen.lon && cartePos.lat <= carteCen.lat) {
//									// 좌측 하단  위도 + 경도 +
//									cartePos.lon += 0.00001;
//									cartePos.lat += 0.00001;
//								}  else if(cartePos.lon >= carteCen.lon && cartePos.lat <= carteCen.lat) {
//									// 우측 하단 위도 - 경도 +
//									cartePos.lon -= 0.00001;
//									cartePos.lat += 0.00001;
//								}
//								const resultPos = Cesium.Cartesian3.fromDegrees(cartePos.lon, cartePos.lat);
//								pickedFeature.id.polygon.hierarchy._value.positions[i] = resultPos;
//							}

							_viewer.entities.add(pickedFeature.id);

							console.log(pickedFeature.id.polygon.hierarchy._value.positions[0]);
							
							var pinBuilder = new Cesium.PinBuilder();

							var bluePin = viewer.entities.add({
							    name : 'Blank blue pin',
							    position : center,
							    billboard : {
							        image : pinBuilder.fromColor(Cesium.Color.ROYALBLUE, 48).toDataURL(),
							        verticalOrigin : Cesium.VerticalOrigin.BOTTOM
							    }
							});
							
							},1000);
						
						// pickedFeature.id.polygon.hierarchy._value.positions.forEach(function(e) {
						//
						// });
//						getCommentList(pickedFeature.id);
					}
				}*/
            }
        }, Cesium.ScreenSpaceEventType.LEFT_CLICK);

        handler.setInputAction(function (event) {
            var earthPosition = _viewer.scene.pickPosition(event.position);
        	console.log('2. 폴리곤 : ', earthPosition);
            terminateShape();
            _polygons.push(nowPolygon);
            clacArea();
        }, Cesium.ScreenSpaceEventType.RIGHT_CLICK);
    }

	function resaclePoly(centerX, centerY, polyObj) {
		// 해당 좌표들을 가중치만큼 재 조정한다.
		if(polyObj.x <= centerX && polyObj.y >= centerY) {
			// 외쪽 상단 위도 + 경도 -
			polyObj.x += 1;
			polyObj.y -= 1;
		} else if(polyObj.x >= centerX && polyObj.y >= centerY) {
			// 우측 상단 위도 - 경도 -
			polyObj.x -= 1;
			polyObj.y -= 1;
		} else if(polyObj.x <= centerX && polyObj.y <= centerY) {
			// 좌측 하단  위도 + 경도 +
			polyObj.x += 1;
			polyObj.y += 1;
		}  else if(polyObj.x >= centerX && polyObj.y <= centerY) {
			// 우측 하단 위도 - 경도 +
			polyObj.x -= 1;
			polyObj.y += 1;
		}
	}
	
    function carteToLonLat(carte) {
        var ellipsoid = _viewer.scene.globe.ellipsoid;
        var cartographic = ellipsoid.cartesianToCartographic(carte);
        var longitudeString = Cesium.Math.toDegrees(cartographic.longitude);
        var latitudeString = Cesium.Math.toDegrees(cartographic.latitude);
        return {lon : longitudeString, lat : latitudeString};
    }
    
    $('#set_target_area').click(function() {
    	cityPlanTargetArea = parseInt($('#target_area_input').val());
    	cityPlanStdFloorCov = parseInt($('#target_floor_cov').val());
        cityPlanStdBuildCov = parseInt($('#target_build_cov').val());
        $('#targetfloorCoverateRatio').text('기준 용적율 : ' + cityPlanStdFloorCov + '%');
        $('#targetbuildCoverateRatio').text('기준 건폐율 : ' + cityPlanStdBuildCov + '%');
    });
    
    // 결과 산출
    $('#result_build').click(() => {

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
        };

        var takeScreenshot = function(){
            scene.postRender.removeEventListener(takeScreenshot);
            var canvas = scene.canvas;

            $("#cityplanImg").attr("src", canvas.toDataURL());
            viewer.resolutionScale = 1.0;
            stopLoading();
            openCityPlanResultDlg();
//            canvas.toBlob(function(blob){
//                var url = URL.createObjectURL(blob);
//            });
        };
        scene.preRender.addEventListener(prepareScreenshot);
    	
    });
    
    function openCityPlanResultDlg() {
        simCityPlanDlgInit();
    }
    
    function dispCameraSceneList() {
    	for(var i = _camera_scene.length-1; i < _camera_scene.length; i++ ) {
        	var obj = '<option value="'+i+'">'+ '경관정보-'+ i +'</option>';
        	$('#camera_scene_list').append(obj);
    	}
    }
    
    $('#cameraLocaMove').click(function() {
    	var index = $('#camera_scene_list').val();
    	var cameraObj = _camera_scene[index];
		_viewer.camera.flyTo({
		    destination : cameraObj.position,
		    orientation : {
		        direction : cameraObj.direction,
		        up : cameraObj.up,
		        right : cameraObj.right,
		    }
		});
    });

    // 카메라 위치 저장
    $("#cameraLocaSave").click(function() {
    	var camera = _viewer.scene.camera;
        var store = {
          position: camera.position.clone(),
          direction: camera.direction.clone(),
          up: camera.up.clone(),
          right: camera.right.clone(),
          transform: camera.transform.clone(),
          frustum: camera.frustum.clone()
        };
        
        _camera_scene.push(store);
        dispCameraSceneList();

        var windowPosition = new Cesium.Cartesian2(_viewer.container.clientWidth / 2, _viewer.container.clientHeight / 2);
        var pickRay = _viewer.scene.camera.getPickRay(windowPosition);
        var pickPosition = _viewer.scene.globe.pick(pickRay, _viewer.scene);
        var pickPositionCartographic = _viewer.scene.globe.ellipsoid.cartesianToCartographic(pickPosition);
        console.log(pickPositionCartographic.longitude * (180/Math.PI));
        console.log(pickPositionCartographic.latitude * (180/Math.PI));

        var position =  {
    		x: pickPositionCartographic.longitude * (180/Math.PI),
    		y: pickPositionCartographic.latitude * (180/Math.PI),
    		z: pickPositionCartographic.height
        }
        
        $.growl.notice({
            message: "카메라 위치가 저장되었습니다",
            duration: 1000
        });
    })

	// F4D파일을 통한 표출
	function genBuildByF4D() {
		
	}

	function genF4DFileConvert(url) {

	}
    
    function genBuild(lon, lat, alt, scale, fileName) {
    	var position = Cesium.Cartesian3.fromDegrees(lon, lat, alt);
	    var modelMatrix = Cesium.Transforms.eastNorthUpToFixedFrame(position);
	    // fromGltf 함수를 사용하여 key : value 값으로 요소를 지정
	    var name = '슬퍼하지마NONONO'; 
	    // GLTF 모델 데이터 삽입

	    var _model = Cesium.Model.fromGltf({
	        url : 'http://localhost/data/simulation-rest/cityPlanModelSelect?FileName='+fileName,
	        modelMatrix : modelMatrix,
	        scale : scale,
	        debugWireframe: true,
	        shadows : 1,
	        name : name,
	        show: false
	    });
	    _model.areaVal = 714;
	    _model.floorNum = 6;
	    _cityPlanModels.push(_model);
	    
	    var primiti_model = _viewer.scene.primitives.add(_model);
	    
	    viewer.scene.primitives.add(primiti_model);
	    Cesium.when(primiti_model.readyPromise).then(function(model) {
	    	  clacArea();
	    	  calcFloorCoverage();
	  		model._nodeCommands.forEach(function(data) {
	  			data.show = false;
	  		})
	  		model.show = true;

	  		for(var i = 0; i < model._nodeCommands.length; i++) {
	  			var timedata = 100 * i;
	  			function showAnimationModel(i) {
		  			setTimeout(function() {
			  			model._nodeCommands[i].show = true;
			    	}, timedata);
	  			}
	  			showAnimationModel(i);
	    	}
	    	}).otherwise(function(error){
	    	  window.alert(error);
    	});
    }
    
    // 부산공정관리 빌딩 생성
    function genConsProcBuild(lon, lat, alt, scale, fileName, fairRate) {
    	var position = Cesium.Cartesian3.fromDegrees(lon, lat, alt);
//	    var modelMatrix = Cesium.Transforms.eastNorthUpToFixedFrame(position);
    	var defaultModel = null;
    	var pinBuilder = new Cesium.PinBuilder();
    	if(stdFairRate < fairRate) {
        	defaultModel = new Cesium.ModelGraphics({
                uri : 'http://localhost/data/simulation-rest/cityPlanModelSelect?FileName='+fileName,
                scale : scale,
                minimumPixelSize : 128,
                maximumScale : 20000
        	})
    	} else {
    		var color = Cesium.Color['RED'];
    		var colorAlpha = Cesium.Color.fromAlpha(color, parseFloat(0.3));
    		var blend = Cesium.ColorBlendMode['MIX'];
        	defaultModel = new Cesium.ModelGraphics({
                uri : 'http://localhost/data/simulation-rest/cityPlanModelSelect?FileName='+fileName,
                scale : scale,
                minimumPixelSize : 128,
                color : colorAlpha,
                colorBlendMode : blend,
                colorBlendAmount : parseFloat(0.7),
        	})
    	    
    	}

//    	var entitiyObj = new Cesium.Entity({
//	    	position: position,
//	        billboard : {
//	            image : pinBuilder.fromText('?', Cesium.Color.BLACK, 48).toDataURL(),
//	            verticalOrigin: Cesium.VerticalOrigin.BOTTOM,
//	            eyeOffset: new Cesium.Cartesian3(0, 3.0504106, 0)
//	        },
//	        model : defaultModel,
//	        show : false
//	    });

    	var entitiyObj = new Cesium.Entity({
	    	position: position,
	        model : defaultModel,
	        show : false
	    });
    	
    	entitiyObj.type = "constructionProcess"
    	_bsConstructProcessModels.push(entitiyObj);
    	
	    var entity = viewer.entities.add(_bsConstructProcessModels[_bsConstructProcessModels.length-1]);
	    
    }

	function genAcceptBuild(lon, lat, alt) {
    	var pinBuilder = new Cesium.PinBuilder();
    	var questionPin = viewer.entities.add({
	    name : 'Question mark',
	    position : Cesium.Cartesian3.fromDegrees(lon, lat),
	    billboard : {
	        image : pinBuilder.fromText('?', Cesium.Color.BLACK, 48).toDataURL(),
	        verticalOrigin : Cesium.VerticalOrigin.BOTTOM
	    }
    	});
	}
    
	
	// 다이얼로그 객체
    var selectBuildDialog = $( "#selectBuildDialog" ).dialog({
		autoOpen: false,
		width: 200,
		height: 200,
		modal: true,
		overflow : "auto",
		resizable: false
	});
    
    var constProcUploadDialog = $('#constructionProcessUploadDialog').dialog({
		autoOpen: false,
		modal: true,
		overflow : "auto",
		resizable: false
	});
    
	var resultCityPlanDialog = $( "#resultCityPlanDialog" ).dialog({
		autoOpen: false,
		width: 1100,
		height: 550,
		modal: true,
		overflow : "auto",
		resizable: false
	});
	
	function simCityPlanDlgInit() {
		if (pickedName === "") {
			alert("지역을 먼저 선택해 주시기 바랍니다.");
			return;
		}

		let loc = $("#selectDistrict option:selected").text();
		cityPlanTargetArea = allObject[pickedName].plottage.toFixed(2);// 대지면적
		cityPlanStdFloorCov = parseFloat($("#standardFloorAreaRatio").val());		// 기준 용적률
		floorCoverateRatio = parseFloat($("#curFloorAreaRatio").val());				// 용적률
		cityPlanStdBuildCov = parseFloat($("#standardBuildingToLandRatio").val());	// 기준 건폐율
		buildCoverateRatio = parseFloat($("#curBuildingToLandRatio").val());		// 건폐율

		$("#loc").text(loc);
		$('#cityPlanDlgArea').text(cityPlanTargetArea + "㎡");
		$('#cityPlanDlgStdFloorCov').text(cityPlanStdFloorCov + ".0%");
		$('#cityPlanDlgFloorCov').text(floorCoverateRatio + "%");
		$('#cityPlanDlgStdBuildCov').text(cityPlanStdBuildCov + ".0%");
		$('#cityPlanDlgBuildCov').text(buildCoverateRatio + "%");

		if(cityPlanStdFloorCov < floorCoverateRatio) {
			$('#chkCityPlanDlgFloorCov').text("부적합").css("color", "red").css("font-weight", "bold");
		} else {
			$('#chkCityPlanDlgFloorCov').text("적합").css("color", "blue").css("font-weight", "bold");
		}

		if(cityPlanStdBuildCov < buildCoverateRatio) {
			$('#chkcityPlanDlgBuildCov').text("부적합").css("color", "red").css("font-weight", "bold");
		} else {
			$('#chkcityPlanDlgBuildCov').text("적합").css("color", "blue").css("font-weight", "bold");
		}

		resultCityPlanDialog.dialog( "open" );
	}
	
	$("#resultCityPlanDlgReg").click(function() {
		var cityPlanResult = new FormData();
		cityPlanResult.append('cityPlanTargetArea', cityPlanTargetArea.toString());
		cityPlanResult.append('cityPlanStdFloorCov', cityPlanStdFloorCov.toString());
		cityPlanResult.append('floorCoverateRatio', floorCoverateRatio.toString());
		cityPlanResult.append('cityPlanStdBuildCov', cityPlanStdBuildCov.toString());
		cityPlanResult.append('buildCoverateRatio', buildCoverateRatio.toString());

		// 실제 데이터는 iVBO...부터이므로 split한다.
		var imgData = atob($('#cityplanImg').attr('src').split(',')[1]);
		var len = imgData.length;
		var buf = new ArrayBuffer(len); // 비트를 담을 버퍼를 만든다.
		var view = new Uint8Array(buf); // 버퍼를 8bit Unsigned Int로 담는다.
		var blob, i;

		for (i = 0; i < len; i++) {
		  view[i] = imgData.charCodeAt(i) & 0xff // 비트 마스킹을 통해 msb를 보호한다.
		}
		// Blob 객체를 image/png 타입으로 생성한다. (application/octet-stream도 가능)
		blob = new Blob([view], { type: "image/png" });

		cityPlanResult.append("files", blob, "aaa.png");
		// cityPlanResult.files = blob;
		$.ajax({
			url: "/data/simulation-rest/cityPlanResultInsert",
			type: "POST",
			data: cityPlanResult,
			dataType: "json",
		    contentType: false,
		    processData: false,
			success: function(msg){
				// if(msg.statusCode <= 200) {
				// 	alert(JS_MESSAGE["insert"]);
				// } else {
				// 	alert(JS_MESSAGE[msg.errorCode]);
				// }

				// $("#converterCheckIds").val("");
				// $("#title").val("");
				// $(":checkbox[name=uploadDataId]").prop("checked", false);
				// saveConverterJobFlag = true;
				alert("저장이 완료되었습니다.");
				resultCityPlanDialog.dialog( "close" );
			},
			error:function(request,status,error){
				alert(JS_MESSAGE["ajax.error.message"]);
			}
		});
	});
	$("#resultCityPlanDlgCle").click(()=>{
		resultCityPlanDialog.dialog( "close" );
	});
	
	$("#locaMonitorChk").change(function(data) {
		if(this.checked) {
			locaMonitor = true;
		} else {
			locaMonitor = false;
		}
//		if($("input:checkbox[id='locaMonitorChk']").is(":checked") === true)
	})
	
	$('#upload_constructionProcess').click(function() {
        var form = $('#construc_proc_file_upload')[0];
        startLoading();
	    // Create an FormData object 
        var data = new FormData(form);
        $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            url: "http://localhost/data/simulation-rest/cityConstProcUpload",
            data: data,
            processData: false,
            contentType: false,
            cache: false,
            timeout: 600000,
            success: function (data) {
                $.growl.notice({
                    message: "파일업로드가 완료되었습니다",
                    duration: 1000
                });
            	stopLoading();
            },
            error: function (e) {
                $.growl.notice({
                    message: "오류가 발생했습니다." + e,
                    duration: 1000
                });
            	stopLoading();
            }
        });
	})
	
	document.addEventListener('keydown', function(e) {
	    setKey(e);
	}, false);
	
	function setKey(event) {
	    var horizontalDegrees = 10.0;
	    var verticalDegrees = 10.0;
	    var viewRect = _viewer.camera.computeViewRectangle();
	    var viewDirection = _viewer.camera.direction;

	    if (Cesium.defined(viewRect)) {
	        horizontalDegrees *= Cesium.Math.toDegrees(viewRect.east - viewRect.west) / 360.0;
	        verticalDegrees *= Cesium.Math.toDegrees(viewRect.north - viewRect.south) / 180.0;
	    }
	    
	    if (event.keyCode === 40) {  // right arrow 
	    	_viewer.camera.rotateRight(Cesium.Math.toRadians(horizontalDegrees) /1000);
	    } else if (event.keyCode === 38) {  // left arrow
	    	_viewer.camera.rotateLeft(Cesium.Math.toRadians(horizontalDegrees) /1000);
	    } else if (event.keyCode === 37) {  // up arrow
	    	_viewer.camera.rotateUp(Cesium.Math.toRadians(verticalDegrees) /1000);
	    } else if (event.keyCode === 39) {  // down arrow
	    	_viewer.camera.rotateDown(Cesium.Math.toRadians(verticalDegrees) /1000);
	    } else if (event.keyCode === 104) {  // yaw  8
	    	viewDirection.x *= -1
	    } else if (event.keyCode === 100) {  // pitch 4
	    	viewDirection.y *= -1
	    } else if (event.keyCode === 102) {  // row  6
	    	viewDirection.z *= -1
	    }
	}

    startDrawPolyLine();

	function getCommentList(objectName) {
		let commentData = {
			objectName: objectName
		};
		$.ajax({
			url: "/data/simulation-rest/commentList",
			type: "POST",
			headers: {"X-Requested-With": "XMLHttpRequest"},
			data: commentData,
			dataType: "json",
			success: function(commentList){
				const commentListViewer = document.getElementById("commentListViewer");
				commentListViewer.setAttribute("objectName", commentData.objectName);
				const abc = document.getElementById("commentViewDialog");
				abc.setAttribute("title", "의견 교환창" + commentData.objectName);

				commentViewFunc(commentList);

				$("#commentContent").val("");
				commentViewDialog.dialog("open");
			},
			error:function(request,status,error) {
				console.log("err=", request, status, error);
			}
		});
	}
	
	function initConsturctProcessModel() {
		for(var index = 0; index < 6; index++) {
			genConsProcBuild(126.90497956470877, 37.521051475771344, -5, 0.0025, "NewFeatureType"+index+".gltf", 80);
		}
	}
	
	function dispConstructProcessModel(index) {
		for(var i = 0; i < 6; i++) {
			_viewer.entities.getById(_bsConstructProcessModels[i].id).show = false
		}
		for(var i = 0; i < index+1; i++) {
			_viewer.entities.getById(_bsConstructProcessModels[i].id).show = true
		}
	}

	function getAverage(list, type) {
		let sum = 0;
		let length = list.length;
		if (length === 0) {
			console.log("msj list size is ", length);
			return 0;
		}
		if (list[0][type] === undefined) {
			console.log("msj list is not contained type:", type);
			return 0;
		}
		for(let i=0; i<length; i++) {
			sum += list[i][type];
		}
		return sum/length;
	}

	$('#acceptCompleteBuildList').change(function(event) {
		var selectSeqBuild = event.target.value;
		acceptMakeBuilding(selectSeqBuild);
	});

	initAcceptBuild('N');
	initAcceptBuild('Y');

	function initAcceptBuild(permReqType) {
		const permReqParam = {
			isComplete: permReqType
		};
		$.ajax({
			url: "/data/simulation-rest/getPermRequest",
			type: "POST",
			data: permReqParam,
			headers: {"X-Requested-With": "XMLHttpRequest"},
			dataType: "json",
			success: function(permList){
				var perDomItems = "";
				for (let i = 0; i<permList.length; i++) {
					var permName = permList[i].constructor + ' - ' + permList[i].permSeq;
					perDomItems += "<option value=" + permList[i].permSeq + ">" + permName + "</option>";
				}
				if(permReqType === 'N') {
					$("#acceptBuildList").append(perDomItems);
				} else {
					$("#acceptCompleteBuildList").append(perDomItems);
				}
			},
			error:function(request,status,error) {
				console.log("err=", request, status, error);
			}
		});
	}

	// 진행
	$('#permCompleteView').click(function() {
		let data = {
			permSeq: $('#acceptCompleteBuildList').val()
		};
		$.ajax({
			url: "/data/simulation-rest/getPermRequestByConstructor",
			type: "POST",
			headers: {"X-Requested-With": "XMLHttpRequest"},
			data: data,
			dataType: "json",
			success: function(msg){
				console.log("getPermRequestByConstructor msg=", msg);
				$("#permViewDialog #constructor").get(0).value = msg.constructor;
				$("#permViewDialog #constructor_type").get(0).value = msg.constructorType;
				$("#permViewDialog #constructor_type").get(0).disabled = true;
				$("#permViewDialog #birthday").get(0).value = msg.birthday;
				$("#permViewDialog #license_num").get(0).value = msg.licenseNum;
				// $("#permViewDialog #phone_number").get(0).value = msg.phoneNumber;
				$("#permViewDialog #district_unit_plan").get(0).value = msg.saveFileName;

				permViewDialog.dialog("open");
			},
			error:function(request,status,error) {
				alert('error');
				console.log("err=", request, status, error);
			}
		});
	});

	$('#permSend').click(function(event) {
		const notSuitableReason = $('#notSuitableReason').text();
		const suitable = $('#suitableCheck').val();
		const PermSend = {
			permSeq: 0,
			isComplete: 'Y',
			suitable: suitable,
			notSuitableReason: notSuitableReason
	};

	$.ajax({
		url: "/data/simulation-rest/putPemSend",
		type: "PUT",
		data: PermSend,
		headers: {"X-Requested-With": "XMLHttpRequest"},
		dataType: "json",
		success: function(permList){
			var perDomItems = "";
			for (let i = 0; i<permList.length; i++) {
				var permName = permList[i].constructor + ' - ' + permList[i].permSeq;
				perDomItems += "<option value=" + permList[i].permSeq + ">" + permName + "</option>";
			}
			$("#acceptBuildList").append(perDomItems);
		},
		error:function(request,status,error) {
			console.log("err=", request, status, error);
		}
	});
	});
}

const f4dDataGenMaster = {
	avg_lon: 0,
	avg_lat: 0,
	rootObject: function(f4dObject) {
		return  {
			"attributes": {
				"isPhysical": false,
				"nodeType": " root ",
				"projectType": "collada",
				"specularLighting": true
			},
			"children": [],
			"parent": 0,
			"depth": 1,
			"view_order": 2,
			"data_key": f4dObject.data_key,
			"data_name": f4dObject.data_name,
			"mapping_type": "origin"
		};
	},
	initIfc: (f4dObject, lon, lat, alt, head, pich, roll) => {
		const rootObj = f4dDataGenMaster.rootObject(f4dObject);
		rootObj.children = f4dDataGenMaster.genIfcChild(f4dObject.f4dSubList, lon, lat, alt, head, pich, roll);
		return rootObj;
	},
	initGml: (f4dObject) => {
		const rootObj = f4dDataGenMaster.rootObject(f4dObject);
		rootObj.children = f4dDataGenMaster.genGmlChild(f4dObject.f4dSubList);
		return rootObj;
	},
	genIfcChild: function(f4dSubObject, lon, lat, alt, head, pich, roll) {
		arr = [];
		for(var i = 0; i < f4dSubObject.length; i++) {
			var obj = f4dSubObject[i];
			var imsiF4dSubObject = {
				"attributes": {
					"isPhysical": true,
					"nodeType": "daejeon",
					"flipYTexCoords": true
				},
				"children": [],
				"data_key": obj.data_key,
				"data_name": obj.data_key,
				"mapping_type":"origin",
				"longitude": lon,
				"latitude": lat,
				"height": alt,
				"heading": head,
				"pitch": pich,
				"roll": roll
			};
			arr.push(imsiF4dSubObject);
		}
		return arr;
	},

	genGmlChild: function(f4dSubObject) {
		arr = [];
		arr_lon = [];
		arr_lat = [];
		for(var i = 0; i < f4dSubObject.length; i++) {
			var obj = f4dSubObject[i];
			var imsiF4dSubObject = {
				"attributes": {
					"isPhysical": true,
					"nodeType": "daejeon",
					"flipYTexCoords": true
				},
				"children": [],
				"data_key": obj.data_key,
				"data_name": obj.data_key,
				"mapping_type":"origin",
				"longitude": obj.longitude,
				"latitude": obj.latitude,
				"height": -40,
				"heading": obj.heading,
				"pitch": obj.pitch,
				"roll": obj.roll
			};
			arr_lon.push(obj.longitude);
			arr_lat.push(obj.latitude);
			arr.push(imsiF4dSubObject);
		}
		this.avg_lon = arr_lon.reduce((prev, curr) => prev + curr) / arr_lon.length;
		this.avg_lat = arr_lat.reduce((prev, curr) => prev + curr) / arr_lat.length;
		return arr;
	},
};

//4fd sample data structure
const f4dJsonStudySample = {
	makeSampleJson: function() {
		var object = {
			"attributes": {
				"isPhysical": false,
				"nodeType": " root ",
				"projectType": "collada",
				"specularLighting": true
			},
			"children": [],
			"parent": 0,
			"depth": 1,
			"view_order": 2,
			"data_key": "conversionResult",
			"data_name": "conversionResult",
			"mapping_type": "origin"
		}
		const sampleJsonSejon = f4dJsonStudySample.SampleChildrenData();
		for(var i = 0; i < sampleJsonSejon.length; i++) {
			var obj = sampleJsonSejon[i];
			var dataKey = obj.data_key;
			var lat = obj.latitude;
			var lon = obj.longitude;

			var sampleRootObject = {
				"attributes": {
					"isPhysical": true,
					"nodeType": "daejeon",
					"flipYTexCoords": true
				},
				"children": [],
				"data_key": "7D6_1",
				"data_name": "7D6_1",
				"mapping_type":"origin",
				"longitude": 0.0,
				"latitude": 0.0,
				"height": 0.0,
				"heading": 0.000000,
				"pitch": 0.000000,
				"roll": 0.000000
			};

			sampleRootObject.data_key = dataKey;
			sampleRootObject.data_name = dataKey;
			sampleRootObject.latitude = lat;
			sampleRootObject.longitude = lon;
			object.children.push(sampleRootObject);
		}
		return object;
	},

	SampleChildrenData : () => {
		return [
			{
				"data_key" : "KSJ_100_0_0",
				"latitude" : 37.56690158584144,
				"longitude" : 126.9785978787040
			},
			{
				"data_key" : "KSJ_100_0_1",
				"latitude" : 37.56690158584144,
				"longitude" : 126.9785978787040
			}
		];
	}

};