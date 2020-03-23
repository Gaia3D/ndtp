
const consBuildBillboard = [];
const arrIotLonlat = {
	drone: [],
	car: []
};

const consBuildBoardClick = {
	click: function constructProcessChat(objectName) {
		console.log("clicked objectName=", objectName);
		let commentData = {
			objectName: objectName
		};
		selectedObjectName = objectName;
		$.ajax({
			url: "/data/simulation-rest/commentListConstructProcess",
			type: "POST",
			headers: {"X-Requested-With": "XMLHttpRequest"},
			data: commentData,
			dataType: "json",
			success: function(commentList){
				const commentListViewer = document.getElementById("commentListViewer2");
				commentListViewer.setAttribute("objectName", commentData.objectName);
				const abc = document.getElementById("commentViewDialog");
				abc.setAttribute("title", "의견 교환창" + commentData.objectName);

				commentViewFunc2(commentList);

				$("#commentContent2").val("");
				commentViewDialog2.dialog("open");
			},
			error:function(request,status,error) {
				console.log("err=", request, status, error);
			}
		});
	}
};
var Simulation = function(magoInstance, viewer, $) {
	var that = this;
	var CAMERA_MOVE_NEED_DISTANCE = 5000;
	console.log(viewer);

	var _viewer = viewer;
    var _scene = viewer.scene;
    var _polylines = [];
    var _labels = [];   
    var _polygons = [];
    var _camera_scene = [];
	_camera_scene.push({
		position: new Cesium.Cartesian3(-3107345.027821688, 4083739.5239106035, 3775320.287267596),
		direction: new Cesium.Cartesian3(0.8466982690724006, 0.525809087065172, -0.08140543660893416),
		up: new Cesium.Cartesian3(-0.38560682428610626, 0.7118195365554574, 0.5870437159547471),
		right: new Cesium.Cartesian3(0.3666189005135779, -0.4656584062783194, 0.805451941737402)
	});
	_camera_scene.push({
		position: new Cesium.Cartesian3(-3280627.778688929, 4062537.6806924795, 3650266.004010676),
		direction: new Cesium.Cartesian3(0.5356198313576546, -0.6225088213202119, 0.5706085905723101),
		up: new Cesium.Cartesian3(-0.3513729530836468, 0.45014645898935396, 0.8209172999155416),
		right: new Cesium.Cartesian3(-0.7678856972868262, -0.6401960112636337, 0.02237460758222004)
	});
	_camera_scene.push({
		position: new Cesium.Cartesian3(-3280626.779031388, 4062552.2818159657, 3650218.004230461),
		direction: new Cesium.Cartesian3(0.398749006838372, -0.5183446964191867, 0.7565170224386978),
		up: new Cesium.Cartesian3(-0.47659122165829726, 0.5876566876099041, 0.6538504606908275),
		right: new Cesium.Cartesian3(-0.783492206077165, -0.6212715937506359, -0.012711011560142732)
	});
	buildingMetaData = getBuildingMetaData();

	var _cityPlanModels = [];
    var _bsConstructProcessModels = [];
    let _sejongDataGroupList = [];
	const consBuildStepInfo = {};
	const consBuildBillboardStepInfo = [];
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
	const htmlBillboard = new HtmlBillboardCollection(viewer.scene);
	var magoManager = magoInstance.getMagoManager();
	var f4dController = magoInstance.getF4dController();

	initDeltaBillboard(128.9219740546607, 35.13631787332174, 3,0, 3, 30);
	function initDeltaBillboard(lon, lat, alt, near, far, ratio) {
		const cart3 = Cesium.Cartesian3.fromDegrees(lon, lat, alt);
		var ch = htmlBillboard.add();
		ch.position = cart3;
		ch.offsetLeft = -15;
		ch.offsetTop = 3;
		const condiParam = {
			near: near,
			far: far
		};
		ch.distanceDisplayCondition = condiParam;
		ch.element.style.width = '30px';
		ch.element.style.height = '30px';
		ch.element.style.display = 'flex';
		ch.element.style.alignItems = 'center';
		ch.element.style.justifyContent = 'center';
		const dataId = "delta";
		ch.element.innerHTML = "" +
			"<div class='tooltip' onclick=consBuildBoardClick.click('"+dataId+"')><svg height='20' width='20' viewBox='0 0 20 20'>\n" +
			"  <circle r='10' cx='10' cy='10' fill='white' />\n" +
			"  <circle r='5' cx='10' cy='10' fill='transparent'\n" +
			"          stroke='tomato'\n" +
			"          stroke-width='10'\n" +
			"          stroke-dasharray='calc(" + (ratio * 31.4 / 100) + ") 31.4'\n" +
			"          transform='rotate(-90) translate(-20)' />\n" +
			"</svg>" +
			"<span class='tooltiptext'>공정률 &nbsp; : "+ ratio +"%</span>" +
			"</div>";

		return ch;
	}

	magoManager.on(Mago3D.MagoManager.EVENT_TYPE.F4DLOADEND, F4DLoadEnd);
	function F4DLoadEnd(evt) {
		const _projectsMap = MAGO3D_INSTANCE.getMagoManager().hierarchyManager.projectsMap;
		for(const obj of evt.f4d){
			const rootNode = _projectsMap[obj.data.projectFolderName];
			const node = rootNode[obj.data.nodeId];
			const dataId = node.data.nodeId;
			if(rootNode.attributes.consType === 'CONSTPROCSEJON') {
				if(!magoManager.effectsManager.hasEffects(dataId)) {
					magoManager.effectsManager.addEffect(dataId, new Mago3D.Effect({
						effectType      : "zBounceSpring",
						durationSeconds : 0.4
					}));
					magoManager.effectsManager.addEffect(dataId, new Mago3D.Effect({
						effectType      : 'borningLight',
						durationSeconds : 0.6
					}));
				}

				/*node.setRenderCondition(function(data){
					node.data.isColorChanged = true;
					let colorRed = 0;
					let colorGreen = 0;
					let colorBlue = 0;
					if (parseInt(rootNode.attributes.step) === 0) {
						colorRed = 230/255;
						colorGreen = 8/255;
						colorBlue = 0;
					} else if (parseInt(rootNode.attributes.step) === 1) {
						colorRed = 255/255;
						colorGreen = 100/255;
						colorBlue = 28/255;
					} else if (parseInt(rootNode.attributes.step) === 2) {
						colorRed = 141/255;
						colorGreen = 30/255;
						colorBlue = 77/255;
					} else if (parseInt(rootNode.attributes.step) === 3) {
						colorRed = 125/255;
						colorGreen = 44/255;
						colorBlue = 121/255;
					} else if (parseInt(rootNode.attributes.step) === 4) {
						colorRed = 255/255;
						colorGreen = 208/255;
						colorBlue = 9/255;
					} else if (parseInt(rootNode.attributes.step) === 5) {
						colorRed = 0;
						colorGreen = 208/255;
						colorBlue = 182/255;
					}

					if(!node.data.aditionalColor) {
						node.data.aditionalColor = new Mago3D.Color();
						node.data.aditionalColor.setRGB(colorRed,colorGreen,colorBlue);
					}
				});*/

			} else if(rootNode.attributes.consType === 'CONSTPROCGEUMGANG') {
				magoManager.effectsManager.addEffect(dataId, new Mago3D.Effect({
					effectType      : "zBounceSpring",
					durationSeconds : 1.5
				}));
			}
			if(node.data.attributes.ratio < 50 && rootNode.attributes.consType === 'CONSTPROCSEJON') {
				const lon = node.data.geographicCoord.longitude;
				const lat = node.data.geographicCoord.latitude;
				const alt = node.data.geographicCoord.altitude + 40;
				const ch = initDeltaBillboard(lon, lat, alt,0, 400, node.data.attributes.ratio);
				consBuildBillboardStepInfo.push([parseInt(rootNode.attributes.step), ch]);
			}
		}
	}

    var runAllocBuildStat = "";
    var cityPlanTargetArea = 0; // 기준 면적
    var cityPlanStdFloorCov = 0; // 기준 용적률
    var floorCoverateRatio = 0; // 용적률
    var cityPlanStdBuildCov = 0; // 기준 건폐율
    var buildCoverateRatio = 0; // 건폐율
    var stdFairRate = 0;
    var locationList = {
		"sejong": [127.2739454, 36.5268601],
		"pusan": [128.917388, 35.1434585],
	};
/*
	setTimeout(() => {
		_viewer.camera.flyTo({
			destination : Cesium.Cartesian3.fromDegrees(locationList["sejong"][0],  locationList["sejong"][1], 2000)
		});
	}, 1000);
*/

	$("#sejong_lod1_buildings").click(() => {
		let fileName = "integrated_sejong.geojson";
		let obj = {
			width : 5,
			leadTime : 0,
			trailTime : 100,
			resolution : 5,
			strokeWidth: 0,
			stroke: Cesium.Color.BLUEVIOLET.withAlpha(0.0),
			fill: Cesium.Color.BLUEVIOLET.withAlpha(0.8),
			clampToGround: true
		};
		let url = "/data/simulation-rest/drawGeojson?fileName=" + fileName;

		Cesium.GeoJsonDataSource.load(url, obj).then(function(dataSource) {
			let entitis = dataSource.entities._entities._array;

			for(let index in entitis) {
				let entitiyObj = entitis[index];
				let registeredEntity = _viewer.entities.add(entitiyObj);
				registeredEntity.name = "integrated_sejong";
				registeredEntity.polygon.heightReference = 1;

				let height = entitiyObj.properties.HEIGHT.getValue();
				if (height === 0 || height === 0.0) {
					height = 10;
				}
				registeredEntity.polygon.extrudedHeight = height;
			}
		}, function(err) {
			console.log(err);
		});
	});

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
			_viewer.shadows = true;
			_viewer.softShadows = true;
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
	};
	
	var setDate = function(date){
		var jd = Cesium.JulianDate.fromDate(date, jd);
		magoInstance.getViewer().clock.currentTime = jd;
		magoManager.sceneState.sunSystem.setDate(date);
	};
	
	$('#constUploadBtn').click(function() {
		constProcUploadDialog.dialog("open");
		$('#cons_proc_lon').text($('#monitorLon').val());
		$('cons_proc_lat').text($('#monitorLon').val());
		$('cons_proc_alt').text($('#monitorLon').val());
	});
	
	var cache = {};

	var slider;
	var simulating = false;

	const consBuildSlider =  {
		// type s, p, other
		targetArea: 's',
		consType: 0,
		saveFileType: '',
		sliderSejongInit: () => {
			if(!slider) {
				slider = new KotSlider('rangeInput');
			}

			var html = '';
			html += '<span>1단계</span>';
			html += '<span>2단계</span>';
			html += '<span>3단계</span>';
			html += '<span>4단계</span>';
			html += '<span>5단계</span>';
			html += '<span>6단계</span>';

			$('#csRange .rangeWrapChild.legend').html(html);

			$('#csRange .rangeWrapChild.legend').on('click','span',function() {
				slider.setValue($(this).index());
			});

			$('#rangeInput').on('change', function(data) {
				
				_sejongDataGroupList = [];
				var index = parseInt($('#rangeInput').val());
				// var consTypeString = $('input[name="cpProtoArea"]:checked').val();
				var consTypeString = $('#consBuildLoca').val();

				let procStepNum = [];
				// dic를 탐색하여 현재 값 -1 의 자료들을 찾아 없으면 요청한다.
				for( let i = 0 ; i < index; i++) {
					if(consBuildStepInfo[i] === undefined) {
						procStepNum.push(i);
					}
				}
				for (let procObj of procStepNum) {
					consBuildSlider.consBuildDataReq(procObj, consTypeString);
				}
				changeLodButton
				// 현재 INDEX 있는 값을 제거하고 다시 요청한다
				consBuildSlider.consBuildDataReq(index, consTypeString);
				if(consBuildBillboardStepInfo !== undefined) {
					for(const obj_index in consBuildBillboardStepInfo) {
						var obj = consBuildBillboardStepInfo[obj_index];
						if(parseInt(obj[0]) ===  index){
							htmlBillboard.remove(obj[1]);
							consBuildBillboardStepInfo.splice(obj_index, 1)
						}
					}
				}

				//  현재 값 이후에 있는 데이터 들은 모두 제거한다.
				var f4dController = MAGO3D_INSTANCE.getF4dController();
				for( const obj in consBuildStepInfo) {
					if (index < parseInt(obj)) {
						for ( const dataKeyObj of consBuildStepInfo[parseInt(obj)]) {
							const dataKey = dataKeyObj.data_key;
							f4dController.deleteF4dGroup(dataKey);
						}
						delete consBuildStepInfo[obj];
					}
				}
				if(consBuildBillboardStepInfo !== undefined) {
					for(const obj_index in consBuildBillboardStepInfo) {
						const obj = consBuildBillboardStepInfo[obj_index];
						if (parseInt(obj[0]) > index) {
							htmlBillboard.remove(obj[1]);
							consBuildBillboardStepInfo.splice(obj_index, 1)
						}
					}
				}
			})
		},
		sliderSejongShow: function() {
			$('#csRange, #constructionProcess').show();
			// $('#csRange, #constructionProcess .profileInfo').show();
			$('#saRange').hide();
		},
		consBuildDataReq: (step, cityType) => {
			const reqParam = {
				consTypeString : step + "",
				cityTypeString : cityType
			};
			$.ajax({
				url: "/data/simulation-rest/cityConstProcSelect",
				type: "GET",
				data: reqParam,
				dataType: "json",
				success: function (msg_list) {
					
					if(msg_list.length === 0)
						return;
					consBuildStepInfo[step] = msg_list;
					dispConsGroup(msg_list);
				}
			});
		}
	};

	consBuildSlider.sliderSejongInit();

	function dispConsGroup ( msg_list ) {
		for (const msg of msg_list) {
			var f4dController = MAGO3D_INSTANCE.getF4dController();
			f4dController.deleteF4dGroup(msg.data_key);
			_sejongDataGroupList.push(msg.data_key);
			
			const f4dObject = f4dDataGenMaster.initGml(msg);
			f4dController.addF4dGroup(f4dObject);
			const lon = f4dDataGenMaster.avg_lon;
			const lat = f4dDataGenMaster.avg_lat;
			console.log(lon, ', ' ,lat);
		}
	}

	//건설공정 조회
	$('#constructionProcess .execute').click(function() {
		//var targetArea = $('input[name="cpProtoArea"]:checked').val();
		var targetArea = $('#consBuildLoca').val();
		
		// Typer s -> Sejong, p -> busan, g -> gumgang....
		consBuildSlider.sliderSejongShow();
		consBuildSlider.targetArea = targetArea;
		consBuildSlider.consBuildDataReq(0, consBuildSlider.targetArea);
		if(targetArea === 's') {
			/*whole_viewer.scene.camera.flyTo({
				destination : Cesium.Cartesian3.fromDegrees(127.26701,  36.52569, 1000)
			});*/
		} else if (targetArea === 'p') {
			whole_viewer.scene.camera.flyTo({
				destination : Cesium.Cartesian3.fromDegrees(128.9219706156745,  35.13632619486047 , 1000)
			});
		} else if (targetArea === 'g') {
			whole_viewer.scene.camera.flyTo({
				destination : Cesium.Cartesian3.fromDegrees(127.2857722,  36.48363827, 1000)
			});
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
            url: "/data/simulation-rest/cityPlanUpload",
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
		buildingHeight: 20,
		buildingAdjust: 0,
	};
	var allObject = {};
	var pickedName = "";
	a=allObject;

	var standardHeight = parseInt(viewModel.buildingHeight);
	var smulationToolbar = document.getElementById('smulationToolbar');
	Cesium.knockout.track(viewModel);
	Cesium.knockout.applyBindings(viewModel, smulationToolbar);

	$("#buildingShadow").change(value => {
		let val = value.target.value;
		if (pickedName === "") {
			alert("지역을 먼저 선택해 주시기 바랍니다.");
			return;
		}
		switch (val) {
			case "disable":
				allObject[pickedName].shadowView = false;
				_viewer.shadows = false;
				_viewer.softShadows = false;
				_viewer.scene.globe.enableLighting = false;
				allObject[pickedName].buildings.forEach((val, idx) => {
					val.polygon.shadows = Cesium.ShadowMode.DISABLED;
				});
				break;
			case "enable":
				allObject[pickedName].shadowView = true;
				_viewer.shadows = true;
				_viewer.softShadows = true;
				_viewer.scene.globe.enableLighting = true;
				allObject[pickedName].buildings.forEach((val, idx) => {
					val.polygon.shadows = Cesium.ShadowMode.ENABLED;
				});
				break;
			default:
				console.log("아무것도 선택되지 않았습니다.");
		}
	});

	$("#districtDisplay").change(value => {
		let val = value.target.value;
		if (pickedName === "") {
			alert("지역을 먼저 선택해 주시기 바랍니다.");
			return;
		}
		switch (val) {
			case "disable":
				if (pickedName === "ecodelta_district") {
					allObject[pickedName].terrains.forEach(val => {
						if (val.show === true) {
							val.show = !val.show;
						}
					});
				} else {
					if (allObject[pickedName].terrain.show === true) {
						allObject[pickedName].terrain.show = !allObject[pickedName].terrain.show;
					}
				}
				break;
			case "enable":
				if (pickedName === "ecodelta_district") {
					allObject[pickedName].terrains.forEach(val => {
						if (val.show === false) {
							val.show = !val.show;
						}
					});
				} else {
					if (allObject[pickedName].terrain.show === false) {
						allObject[pickedName].terrain.show = !allObject[pickedName].terrain.show;
					}
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
				let layers = viewer.scene.imageryLayers;

				layers.addImageryProvider(new Cesium.SingleTileImageryProvider({
					url : '/images/mapgeoref.png',
					rectangle : Cesium.Rectangle.fromDegrees(127.26024, 36.5189, 127.288, 36.5349)
				}));
				break;
			case "ecoDelta":
				let eco_layer = viewer.scene.imageryLayers;
				eco_layer.addImageryProvider(new Cesium.SingleTileImageryProvider({
					url : '/images/ecoDelta.png',
					rectangle : Cesium.Rectangle.fromDegrees(128.902068642, 35.113207854, 128.949046811, 35.164342720)
				}));
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
				settingBuildingShadow();
				_viewer.selectedEntity = allObject[pickedName].terrain;
				return;
			}
			allObject[val] = {
				terrain: "",   		// single entity
				buildings: [], 		// [] entity
				plottage: 0, 		// 대지 면적
				totalFloorArea: 0, 	// 빌딩들의 총 건축면적
				shadowView: false	// building shadow
			};

			// const fileName = "Parcel6-4.geojson";
			const fileName = "6-4_disApart.geojson";
			const obj = {
				width : 5,
				leadTime : 0,
				trailTime : 100,
				resolution : 5,
				strokeWidth: 0,
				stroke: Cesium.Color.AQUA.withAlpha(0.0),
				fill: Cesium.Color.AQUA.withAlpha(0.8),
				clampToGround: true
			};
			let url = "/data/simulation-rest/drawGeojson?fileName=" + fileName;

			Cesium.GeoJsonDataSource.load(url, obj).then(function(dataSource) {
				let entitis = dataSource.entities._entities._array;

				for(let index in entitis) {
					let entitiyObj = entitis[index];
					let registeredEntity = _viewer.entities.add(entitiyObj);
					registeredEntity.name = "sejong_apartmentComplex1";

					registeredEntity.polygon.extrudedHeightReference = 2;
					// registeredEntity.polygon.heightReference = 1;

					Cesium.knockout.getObservable(viewModel, 'standardFloorCount').subscribe(
						function(newValue) {
							registeredEntity.polygon.extrudedHeight = newValue * 4;
						}
					);
					allObject[val].terrain = registeredEntity;
				}
				settingDistrictDisplay();
				settingBuildingShadow();
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
				settingBuildingShadow();
				_viewer.selectedEntity = allObject[pickedName].terrain;
				return;
			}
			allObject[val] = {
				terrain: "",   		// single entity
				buildings: [], 		// [] entity
				plottage: 0, 		// 대지 면적
				totalFloorArea: 0, 	// 빌딩들의 총 건축면적
				shadowView: false	// building shadow
			};

			// const fileName = "schoolphill.geojson";
			const fileName = "6-4_disSchool.geojson";
			const obj = {
				width : 5,
				leadTime : 0,
				trailTime : 100,
				resolution : 5,
				strokeWidth: 0,
				stroke: Cesium.Color.AQUA.withAlpha(0.0),
				fill: Cesium.Color.AQUA.withAlpha(0.8),
				clampToGround: true
			};
			let url = "/data/simulation-rest/drawGeojson?fileName=" + fileName;

			Cesium.GeoJsonDataSource.load(url, obj).then(function(dataSource) {
				let entitis = dataSource.entities._entities._array;

				for(let index in entitis) {
					let entitiyObj = entitis[index];
					let registeredEntity = _viewer.entities.add(entitiyObj);
					registeredEntity.name = "sejong_church1";

					// registeredEntity.polygon.extrudedHeightReference = 1;
					registeredEntity.polygon.heightReference = 2;

					Cesium.knockout.getObservable(viewModel, 'standardFloorCount').subscribe(
						function(newValue) {
							registeredEntity.polygon.extrudedHeight = newValue * 4;
						}
					);
					allObject[val].terrain = registeredEntity;
				}
				settingDistrictDisplay();
				settingBuildingShadow();
				// setTimeout(()=>{
					_viewer.selectedEntity = allObject[pickedName].terrain;
				// }, 500);
			}, function(err) {
				console.log(err);
			});
		}
		else if(val === "ecodelta_district") {
			if (allObject[val] !== undefined) {
				buildingToLandRatioCalc();
				floorAreaRatioCalc();
				settingDistrictDisplay();
				settingBuildingShadow();
				_viewer.selectedEntity = allObject[pickedName].terrain;
				return;
			}
			allObject[val] = {
				terrain: "",   		// single entity
				terrains: [],
				buildings: [], 		// [] entity
				plottage: 0, 		// 대지 면적
				totalFloorArea: 0, 	// 빌딩들의 총 건축면적
				shadowView: false	// building shadow
			};

			// const fileName = "schoolphill.geojson";
			const fileName = "eco_district.geojson";
			const obj = {
				width : 5,
				leadTime : 0,
				trailTime : 100,
				resolution : 5,
				strokeWidth: 0,
				stroke: Cesium.Color.AQUA.withAlpha(0.0),
				fill: Cesium.Color.AQUA.withAlpha(0.8),
				clampToGround: true
			};
			let url = "/data/simulation-rest/drawGeojson?fileName=" + fileName;

			Cesium.GeoJsonDataSource.load(url, obj).then(function(dataSource) {
				let entitis = dataSource.entities._entities._array;

				for(let index in entitis) {
					let entitiyObj = entitis[index];
					let registeredEntity = _viewer.entities.add(entitiyObj);
					registeredEntity.name = "ecodelta_district";

					// registeredEntity.polygon.extrudedHeightReference = 1;
					registeredEntity.polygon.heightReference = 2;

					Cesium.knockout.getObservable(viewModel, 'standardFloorCount').subscribe(
						function(newValue) {
							registeredEntity.polygon.extrudedHeight = newValue * 4;
						}
					);
					allObject[val].terrain = registeredEntity;
					allObject[val].terrains.push(registeredEntity);
				}
				settingDistrictDisplay();
				settingBuildingShadow();
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
				$("#standardFloorAreaRatio").val(180).trigger("change");
				$("#standardBuildingToLandRatio").val(50).trigger("change");
				$("#standardFloorCount").val(20).trigger("change");
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
				$("#standardFloorAreaRatio").val(200).trigger("change");
				$("#standardBuildingToLandRatio").val(40).trigger("change");
				$("#standardFloorCount").val(25).trigger("change");
				break;
			default:
				console.log("아무것도 선택되지 않았습니다.");
		}
	});

	$("#deleteDistrict").click(() => {
		let field = $("#selectPiece").val();
		if (field === "") {
			alert("필지를 먼저 선택해 주시기 바랍니다.");
			return;
		}
		switch (field) {
			case "sejong6_4":
				_viewer.scene.imageryLayers._layers.forEach((obj, idx) => {
					if (obj.imageryProvider.url.includes("mapgeoref.png")) {
						_viewer.scene.imageryLayers.remove(obj);
					}
				});
				break;
			case "ecoDelta":
				_viewer.scene.imageryLayers._layers.forEach((obj, idx) => {
					if (obj.imageryProvider.url.includes("ecoDelta.png")) {
						_viewer.scene.imageryLayers.remove(obj);
					}
				});
				break;
			default:
				console.log("일치하는 필지가 없습니다.");
		}

	});

	$("#delete3dModel").click(()=> {
		let val = $("#selectDistrict").val();
		if (allObject[val] === undefined) {
			alert("지역을 먼저 선택해 주시기 바랍니다.");
			return;
		}
		if (pickedName !== "sejong_apartmentComplex1" && pickedName !== "ecodelta_district") {
			alert("현재는 세종시, 부산시 아파트만 지원됩니다.");
			return;
		}

		if (allObject[pickedName].buildings.length === 0) {
			alert("3d 모형이 현재 존재하지 않습니다.");
		} else {
			allObject[pickedName].buildings.forEach((val, idx) => {
				val.show = false;
			});
			allObject[pickedName].buildings=[];
		}
	});

	$("#create3dModel").click(()=> {
		let val = $("#selectDistrict").val();
		if (allObject[val] === undefined) {
			alert("지역을 먼저 선택해 주시기 바랍니다.");
			return;
		}
		if (pickedName !== "sejong_apartmentComplex1" && pickedName !== "ecodelta_district") {
			alert("현재는 세종시, 부산시 아파트만 지원됩니다.");
			return;
		}

		if (allObject[pickedName].buildings.length !== 0) {
			alert("이 지역의 3D 모형이 이미 생성되어 있습니다.");
			return;
		}

		if (val === "sejong_apartmentComplex1") {
			const fileName = "6-4_buildings.geojson";
			const obj = {
				width : 5,
				leadTime : 0,
				trailTime : 100,
				resolution : 5,
				stroke: Cesium.Color.BLUEVIOLET,
				fill: Cesium.Color.BLUEVIOLET,
				clampToGround: true
			};
			let url = "/data/simulation-rest/drawGeojson?fileName=" + fileName;

			Cesium.GeoJsonDataSource.load(url, obj).then(function(dataSource) {
				let entitis = dataSource.entities._entities._array;
				let sumFloorArea = 0;

				for(let index in entitis) {
					let entitiyObj = entitis[index];
					let registeredEntity = _viewer.entities.add(entitiyObj);
					registeredEntity.name = "아파트_" + index;
					registeredEntity.polygon.heightReference = 1;
					// registeredEntity.polygon.extrudedHeightReference = 1;
					registeredEntity.polygon.extrudedHeight = parseInt(viewModel.buildingHeight) * 3;

					let buildingFloorArea = parseFloat(getArea(registeredEntity.polygon._hierarchy._value.positions));	// 건축면적
					let totalBuildingFloorArea = buildingFloorArea * registeredEntity.polygon.extrudedHeight / 6;  // 건축면적 * 층수 = 연면적
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
								let newVal = parseInt(newValue) * 3;
								let customizing = parseInt($("#inputCustomizing").val()) * 3;

								registeredEntity.polygon.extrudedHeight = newVal + customizing;

								// 변경된 연면적 계산
								registeredEntity.totalBuildingFloorArea = registeredEntity.buildingFloorArea * registeredEntity.polygon.extrudedHeight / 6;
								standardHeight = parseInt(newValue) * 3;
							}
						);
						Cesium.knockout.getObservable(viewModel, 'buildingAdjust').subscribe(
							function(newValue) {
								let newVal = parseInt(newValue) * 3;
								registeredEntity.polygon.extrudedHeight = standardHeight + newVal;

								// 변경된 연면적 계산
								registeredEntity.totalBuildingFloorArea = registeredEntity.buildingFloorArea * registeredEntity.polygon.extrudedHeight / 6;
							}
						);
					} else {
						Cesium.knockout.getObservable(viewModel, 'buildingHeight').subscribe(
							function(newValue) {
								// let curHeight = parseInt(registeredEntity.polygon.extrudedHeight.getValue());
								let newVal = parseInt(newValue) * 3;
								let customizing = parseInt($("#inputCustomizing").val()) * 3;

								registeredEntity.polygon.extrudedHeight = newVal - customizing;

								// 변경된 연면적 계산
								registeredEntity.totalBuildingFloorArea = registeredEntity.buildingFloorArea * registeredEntity.polygon.extrudedHeight / 6;
								standardHeight = parseInt(newValue) * 3;
							}
						);
						Cesium.knockout.getObservable(viewModel, 'buildingAdjust').subscribe(
							function(newValue) {
								let newVal = parseInt(newValue) * 3;
								registeredEntity.polygon.extrudedHeight = standardHeight - newVal;

								// 변경된 연면적 계산
								registeredEntity.totalBuildingFloorArea = registeredEntity.buildingFloorArea * registeredEntity.polygon.extrudedHeight / 6;
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
		}
		else if (val === "ecodelta_district") {
			const fileName = "eco_aparts.geojson";
			const obj = {
				width : 5,
				leadTime : 0,
				trailTime : 100,
				resolution : 5,
				stroke: Cesium.Color.BLUEVIOLET,
				fill: Cesium.Color.BLUEVIOLET,
				clampToGround: true
			};
			let url = "/data/simulation-rest/drawGeojson?fileName=" + fileName;

			Cesium.GeoJsonDataSource.load(url, obj).then(function(dataSource) {
				let entitis = dataSource.entities._entities._array;
				let sumFloorArea = 0;

				for(let index in entitis) {
					let entitiyObj = entitis[index];
					let registeredEntity = _viewer.entities.add(entitiyObj);
					registeredEntity.name = "아파트_" + index;
					registeredEntity.polygon.heightReference = 1;
					// registeredEntity.polygon.extrudedHeightReference = 1;
					registeredEntity.polygon.extrudedHeight = parseInt(viewModel.buildingHeight) * 3;

					let buildingFloorArea = parseFloat(getArea(registeredEntity.polygon._hierarchy._value.positions));	// 건축면적
					let totalBuildingFloorArea = buildingFloorArea * registeredEntity.polygon.extrudedHeight / 6;  // 건축면적 * 층수 = 연면적
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
								let newVal = parseInt(newValue) * 3;
								let customizing = parseInt($("#inputCustomizing").val()) * 3;

								registeredEntity.polygon.extrudedHeight = newVal + customizing;

								// 변경된 연면적 계산
								registeredEntity.totalBuildingFloorArea = registeredEntity.buildingFloorArea * registeredEntity.polygon.extrudedHeight / 6;
								standardHeight = parseInt(newValue) * 3;
							}
						);
						Cesium.knockout.getObservable(viewModel, 'buildingAdjust').subscribe(
							function(newValue) {
								let newVal = parseInt(newValue) * 3;
								registeredEntity.polygon.extrudedHeight = standardHeight + newVal;

								// 변경된 연면적 계산
								registeredEntity.totalBuildingFloorArea = registeredEntity.buildingFloorArea * registeredEntity.polygon.extrudedHeight / 6;
							}
						);
					} else {
						Cesium.knockout.getObservable(viewModel, 'buildingHeight').subscribe(
							function(newValue) {
								// let curHeight = parseInt(registeredEntity.polygon.extrudedHeight.getValue());
								let newVal = parseInt(newValue) * 3;
								let customizing = parseInt($("#inputCustomizing").val()) * 3;

								registeredEntity.polygon.extrudedHeight = newVal - customizing;

								// 변경된 연면적 계산
								registeredEntity.totalBuildingFloorArea = registeredEntity.buildingFloorArea * registeredEntity.polygon.extrudedHeight / 6;
								standardHeight = parseInt(newValue) * 3;
							}
						);
						Cesium.knockout.getObservable(viewModel, 'buildingAdjust').subscribe(
							function(newValue) {
								let newVal = parseInt(newValue) * 3;
								registeredEntity.polygon.extrudedHeight = standardHeight - newVal;

								// 변경된 연면적 계산
								registeredEntity.totalBuildingFloorArea = registeredEntity.buildingFloorArea * registeredEntity.polygon.extrudedHeight / 6;
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
		}

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
		if ($("#selectDistrict").val() === "ecodelta_district") {
			result /= 4;
		}
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
		if ($("#selectDistrict").val() === "ecodelta_district") {
			result /= 10;
		}
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
	function settingBuildingShadow() {
		if (allObject[pickedName].shadowView) {
			$("#buildingShadow").val("enable");
		} else {
			$("#buildingShadow").val("disable");
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
    
    $('#iotsiminterval').click(function(){
		const val = $('#iotList').val();
		if (val === "") {
			alert("종류를 먼저 선택해 주시기 바랍니다.");
			return;
		}
		if (iotEntities[val].isRunning) {
			alert(val+"는 이미 실행중입니다.");
			return;
		}
        
        let samplePosition = ""; //busSamplePosition;
		if (val === "bus") {
			samplePosition = busSamplePosition;
		} else if (val === "drone") {
			samplePosition = droneSamplePosition;
		} else {
			alert("아직 지원되지 않음.");
			return;
		}

        // 개수 만큼 시간을 나눈다.
        const day_start = moment(datepicker.getDate()); // 7 am
        // console.log(day_start);
        const day_end   = moment(datepicker.getDate()).add(30, 'minutes'); // 10 pm
        const durationTimeStep = parseInt((day_end.unix() - day_start.unix())/parseInt(samplePosition.length/3));
        let startUnidxTIme = day_start.unix();
        const arrInput = [];

        for(var i = 0; i < samplePosition.length; i+=3) {
            const time = moment(JSON.parse(JSON.stringify((startUnidxTIme += durationTimeStep))) * 1000);
            const lon = samplePosition[i];
            const lat = samplePosition[i+1];
            const alt = samplePosition[i+2];
            arrInput.push({
                dateTime: time,
                lon: lon,
                lat: lat,
                alt: alt
            })
        }
        
        let startTM = moment(JSON.parse(JSON.stringify(arrInput[0].dateTime)));
        let endTM = moment(JSON.parse(JSON.stringify(arrInput[arrInput.length-1].dateTime)));
        
        // init absStartTM for second object.
        if(absStartTM == null){
        	absStartTM = startTM;
        }
        
        let crinterval = setInterval(function() {
			let param_id = $('#iotList').val();
            if(startTM.isBefore(endTM)) {
				console.log("s", param_id);
				iotEntities[param_id].isRunning = true;
                startTM.add(2000, 'milliseconds');
                var jd = Cesium.JulianDate.fromDate(startTM.toDate());
                MAGO3D_INSTANCE.getViewer().clock.currentTime = jd;
                MAGO3D_INSTANCE.getMagoManager().sceneState.sunSystem.setDate(startTM.toDate());
            } else {
				console.log("e", param_id);
				iotEntities[param_id].isRunning = false;
                // startTM = moment(JSON.parse(JSON.stringify(arrInput[0].dateTime)));
                clearInterval(crinterval);
            }
        }, 30);
    });
    
    var isInterval = true;
    var interval = null;
    var absStartTM = null;
    
    var entityExistCheckObject = {};

	$('#iotSimReq').click(function() {
		const val = $('#iotList').val();
		if (val === "") {
			alert("종류를 먼저 선택해 주시기 바랍니다.");
			return;
		}
		
        let fileName = "";
        let preDir = "";
        let uri = "";
        let scale = "";
        let samplePosition = "";
        let id = "";

        if (iotEntities[val] !== undefined) {
			alert(val+"는 이미 등록된 객체 입니다.");
        	return;
		}
		
		if(val === 'bus') {
            fileName = 'Mat_1.gltf';
            preDir = 'buses';
            uri = '/data/simulation-rest/cityPlanModelSelect?FileName='+fileName+'&preDir='+preDir;
            scale = 0.01;
            samplePosition = busSamplePosition;
            id = "bus";

		} else if(val === 'drone') {
            fileName = 'drone.gltf';
            preDir = 'buses';
            uri = '/data/simulation-rest/cityPlanModelSelect?FileName='+fileName+'&preDir='+preDir;
            scale = 0.01;
            samplePosition = droneSamplePosition;
            id = "drone";
		}
		
        // 개수 만큼 시간을 나눈다.
        const day_start = moment(datepicker.getDate()); // 7 am
        const day_end   = moment(datepicker.getDate()).add(30, 'minutes'); // 10 pm
        
        const to_start = Cesium.JulianDate.fromDate(new Date());
        const to_end = Cesium.JulianDate.addMinutes(to_start, 30, new Cesium.JulianDate());
        
        const durationTimeStep = parseInt((day_end.unix() - day_start.unix())/parseInt(samplePosition.length/3));
        let startUnidxTIme = day_start.unix();
        const arrInput = [];

        for(var i = 0; i < samplePosition.length; i+=3) {
            const time = moment(JSON.parse(JSON.stringify((startUnidxTIme += durationTimeStep))) * 1000);
            const lon = samplePosition[i];
            const lat = samplePosition[i+1];
            const alt = samplePosition[i+2];
            arrInput.push({
                dateTime: time,
                lon: lon,
                lat: lat,
                alt: alt
            })
        }
        
        let startTM = moment(JSON.parse(JSON.stringify(arrInput[0].dateTime)));
        let endTM = moment(JSON.parse(JSON.stringify(arrInput[arrInput.length-1].dateTime)));
        
        if(absStartTM == null){
        	absStartTM = startTM;
        }
        
        // draw path and scatter.
//        MAGO3D_INSTANCE.getViewer().clock.stopTime = arrInput[arrInput.length - 1].dateTime;
        if(viewer.entities.getById(id) === undefined){
        	runIot(id, arrInput, uri, scale);
        }

		let iotInterval = setInterval(function(val){
			let param_id = $('#iotList').val();
			if(startTM.isBefore(endTM)){
				console.log("s", param_id);
				iotEntities[param_id].isRunning = true;
				startTM.add(2000, 'milliseconds');
				var jd = Cesium.JulianDate.fromDate(startTM.toDate());
				MAGO3D_INSTANCE.getViewer().clock.currentTime = jd;
				MAGO3D_INSTANCE.getMagoManager().sceneState.sunSystem.setDate(startTM.toDate());
			} else {
				console.log("e", param_id);
				iotEntities[param_id].isRunning = false;
				clearInterval(iotInterval);
			}
		}, 30);

        // if(isInterval){
        //     isInterval = false;
        // }
        // else{
        //     // endTM: IsAMomentObject
        //     // viewer.clock.currentTime: JulianDate
        //     clearInterval(interval);
        //
        //     startTM = absStartTM;
        //     endTM = endTM + moment(Cesium.JulianDate.toDate(viewer.clock.currentTime));
        //
        //     setInterval(function(){
        //         if(startTM.isBefore(endTM)){
        //             startTM.add(2000, 'milliseconds');
        //             var jd = Cesium.JulianDate.fromDate(startTM.toDate());
        //             MAGO3D_INSTANCE.getViewer().clock.currentTime = jd;
        //             MAGO3D_INSTANCE.getMagoManager().sceneState.sunSystem.setDate(startTM.toDate());
        //         } else{
        //             // console.log('test');
        //             clearInterval(this);
        //         }}, 30);
        // }
	});


	
	function sejeonjochiwonPoly() {
		Cesium.GeoJsonDataSource.load('/data/simulation-rest/select', {
			width : 5,
			leadTime : 0,
			trailTime : 100,
			resolution : 5,
			fill: Cesium.Color.PINK,
			clampToGround: true
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

		        });
			},4000);
		}, function(err) {
			stopLoading();
		});
	}
	
	function echdeltaLinString() {
		Cesium.GeoJsonDataSource.load('/data/simulation-rest/select', {
			width : 5,
			leadTime : 0,
			trailTime : 100,
			resolution : 5,
		  fill: Cesium.Color.PINK,
			clampToGround: true,
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
	$("#objectSelect").change(value => {
		runAllocBuildStat = value.target.value;

		if (multiPositions.length !== 0) {
			multiPositions.map((object, idx) => {
				multiGen(value.target.value, object);

				viewer.entities.remove(object.entity);
			});
			multiPositions = [];
		}
		// console.log(runAllocBuildStat);
	});

    $('#run_work_state').bind('afterClick', function () {
        console.log("맵컨트롤 : 면적");
        //clearMap();
        drawingMode = 'polygon';

        if ($('#run_work_state').hasClass('on')) {
            startDrawPolyLine();
        }
    });

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
		// $('#csRange, #constructionProcess .profileInfo').hide();
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
                var height = cartographic.height;

            	$('#monitorLon').text(longitudeString);
            	$('#monitorLat').text(latitudeString);
            	$("#monitorHeight").text(height);
            	var lonlat = {
            		lon: longitudeString,
					lat: latitudeString,
					height: height
				};
				arrIotLonlat.drone.push(lonlat);
        	}
			// console.log('1. 폴리곤 : ', longitudeString, latitudeString);

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
                }
                // else if (runAllocBuildStat === "autoBuild") {
                // 	genBuild(Cesium.Math.toDegrees(cartographic.longitude), Cesium.Math.toDegrees(cartographic.latitude), 0, 10, "7M6_871.gltf")
                // }
				else if (runAllocBuildStat === "multi_select_mode") {
					let pickPosition = _viewer.scene.pickPosition(event.position);

					let ellipsoid = _viewer.scene.globe.ellipsoid;
					let cartographic = ellipsoid.cartesianToCartographic(pickPosition);
					let longitudeString = Cesium.Math.toDegrees(cartographic.longitude);
					let latitudeString = Cesium.Math.toDegrees(cartographic.latitude);
					let height = cartographic.height;

					let entity = new Cesium.Entity({
						position : Cesium.Cartesian3.fromDegrees(longitudeString, latitudeString, height),
						point: new Cesium.PointGraphics({
							pixelSize: 12,
							color: Cesium.Color.WHITE
						})
					});

					let object = {
						lon: longitudeString,
						lat: latitudeString,
						alt: height,
						entity: entity
					};
					_viewer.entities.add(entity);

					multiPositions.push(object);
				}
				else if (runAllocBuildStat === "obj_select_mode") {
					var scene = viewer.scene;
					let pickedFeature = scene.pick(event.position);
					if (!Cesium.defined(pickedFeature)) {
						// nothing picked
						if (headPitchRollDialog.dialog("isOpen")) {
							headPitchRollDialog.dialog("close");
						}
						return;
					}

					if (selectedEntity !== pickedFeature.id) {
						selectedEntity = pickedFeature.id;

						if (selectedEntity.name.includes("gltf")){
							let cartographic = Cesium.Cartographic.fromCartesian(selectedEntity.position.getValue());
							let lon = Cesium.Math.toDegrees(cartographic.longitude);
							let lat = Cesium.Math.toDegrees(cartographic.latitude);
							document.getElementById("selected_obj_longitude").innerText = lon;
							document.getElementById("selected_obj_latitude").innerText = lat;
						} else {
							headPitchRollDialog.dialog("close");
							return;
						}

					} else if (!selectedEntity.name.includes("gltf")) {
						headPitchRollDialog.dialog("close");
						return;
					}
					headPitchRollDialog.dialog("open");

					//select Entity Drag 기능
					if (headPitchRollDialog.dialog("isOpen")) {
						var dragging = false;
						var handler = new Cesium.ScreenSpaceEventHandler(viewer.canvas);
						handler.setInputAction(
							function (click) {
								var pickedObject = scene.pick(click.position);
								if (Cesium.defined(pickedObject) && (pickedObject.id === selectedEntity)){
									dragging = true;
									scene.screenSpaceCameraController.enableRotate = false;
								};
							},
							Cesium.ScreenSpaceEventType.LEFT_DOWN
						);

						handler.setInputAction(
							function (movement) {
								if (dragging) {
									// var position = scene.camera.pickEllipsoid(movement.endPosition);

									let pickPosition = _viewer.scene.pickPosition(movement.endPosition);
									let ellipsoid = _viewer.scene.globe.ellipsoid;


									// selectedEntity.position = _viewer.scene.clampToHeight(position);
									// let cartographic = Cesium.Cartographic.fromCartesian(selectedEntity.position);
									selectedEntity.position = pickPosition;

									// let cartographic = Cesium.Cartographic.fromCartesian(position);
									let cartographic = ellipsoid.cartesianToCartographic(pickPosition);
									let lon = Cesium.Math.toDegrees(cartographic.longitude);
									let lat = Cesium.Math.toDegrees(cartographic.latitude);
									let height = cartographic.height;

									document.getElementById("selected_obj_longitude").innerText = lon;
									document.getElementById("selected_obj_latitude").innerText = lat;
									
								}
							},
							Cesium.ScreenSpaceEventType.MOUSE_MOVE
						);

						handler.setInputAction(
							function (click) {
								if (dragging) {
									dragging = false;
									scene.screenSpaceCameraController.enableRotate = true;

									let pickPosition = _viewer.scene.pickPosition(click.position);
									let ellipsoid = _viewer.scene.globe.ellipsoid;
									let cartographic = ellipsoid.cartesianToCartographic(pickPosition);
									// selectedEntity.position = scene.camera.pickEllipsoid(click.position);
									selectedEntity.position = pickPosition;
								}
							},
							Cesium.ScreenSpaceEventType.LEFT_UP
						);
					}
					
				}
                else if (runAllocBuildStat === "obj_lamp") {
					genBuild(Cesium.Math.toDegrees(cartographic.longitude), Cesium.Math.toDegrees(cartographic.latitude), cartographic.height, 0.4, "objLamp", "objLamp.gltf")
				}
                else if (runAllocBuildStat === "obj_tree") {
					genBuild(Cesium.Math.toDegrees(cartographic.longitude), Cesium.Math.toDegrees(cartographic.latitude), cartographic.height, 0.05, "tree", "tree.gltf")
				}
				else if (runAllocBuildStat === "obj_tree2") {
					genBuild(Cesium.Math.toDegrees(cartographic.longitude), Cesium.Math.toDegrees(cartographic.latitude), cartographic.height, 0.9, "Tree2", "Tree.gltf")
				}
				else if (runAllocBuildStat === "obj_cone") {
					genBuild(Cesium.Math.toDegrees(cartographic.longitude), Cesium.Math.toDegrees(cartographic.latitude), cartographic.height, 0.03, "TrafficCone", "TrafficCone.gltf")
				}
				else if (runAllocBuildStat === "obj_bench") {
					genBuild(Cesium.Math.toDegrees(cartographic.longitude), Cesium.Math.toDegrees(cartographic.latitude), cartographic.height, 0.1, "bench", "bank.gltf")
				}
				else if (runAllocBuildStat === "obj_bus1") {
					genBuild(Cesium.Math.toDegrees(cartographic.longitude), Cesium.Math.toDegrees(cartographic.latitude), cartographic.height+1, 0.05, "buses", "bus_1.gltf")
				}
				else if (runAllocBuildStat === "obj_bus2") {
					genBuild(Cesium.Math.toDegrees(cartographic.longitude), Cesium.Math.toDegrees(cartographic.latitude), cartographic.height, 0.03, "buses", "Mat_1.gltf")
				}
				else if (runAllocBuildStat === "obj_car1") {
					genBuild(Cesium.Math.toDegrees(cartographic.longitude), Cesium.Math.toDegrees(cartographic.latitude), cartographic.height+1, 0.05, "buses", "car_1.gltf")
				}
				else if (runAllocBuildStat === "obj_car2") {
					genBuild(Cesium.Math.toDegrees(cartographic.longitude), Cesium.Math.toDegrees(cartographic.latitude), cartographic.height+1, 0.05, "buses", "car2_2.gltf")
				}
				else if (runAllocBuildStat === "obj_truck1") {
					genBuild(Cesium.Math.toDegrees(cartographic.longitude), Cesium.Math.toDegrees(cartographic.latitude), cartographic.height+1, 0.05, "buses", "truck_1.gltf")
				}
				else if (runAllocBuildStat === "obj_truck2") {
					genBuild(Cesium.Math.toDegrees(cartographic.longitude), Cesium.Math.toDegrees(cartographic.latitude), cartographic.height+1, 0.05, "buses", "truck_2.gltf")
				}
				else if (runAllocBuildStat === "maple_green") {
					genBuild(Cesium.Math.toDegrees(cartographic.longitude), Cesium.Math.toDegrees(cartographic.latitude), cartographic.height, 1, "texture_maple", "maple_green.gltf")
				}
				else if (runAllocBuildStat === "maple_light_green") {
					genBuild(Cesium.Math.toDegrees(cartographic.longitude), Cesium.Math.toDegrees(cartographic.latitude), cartographic.height, 1, "texture_maple", "maple_light_green.gltf")
				}
				else if (runAllocBuildStat === "maple_orange") {
					genBuild(Cesium.Math.toDegrees(cartographic.longitude), Cesium.Math.toDegrees(cartographic.latitude), cartographic.height, 1, "texture_maple", "maple_orange.gltf")
				}
				else if (runAllocBuildStat === "maple_red") {
					genBuild(Cesium.Math.toDegrees(cartographic.longitude), Cesium.Math.toDegrees(cartographic.latitude), cartographic.height, 1, "texture_maple", "maple_red.gltf")
				}
				else if (runAllocBuildStat === "maple_yellow") {
					genBuild(Cesium.Math.toDegrees(cartographic.longitude), Cesium.Math.toDegrees(cartographic.latitude), cartographic.height, 1, "texture_maple", "maple_yellow.gltf")
				}

				else if(runAllocBuildStat === "imsiBuildSelect") {
                	// 새로운 모델 선택
                	
                    var pickedFeature = viewer.scene.pick(event.position);
                    if(pickedFeature) {
                		selectBuildDialog.dialog( "open" );
                		selectEntity = pickedFeature;
                    } else {
                    	selectEntity = undefined;
                    }
//                    _viewer._selectedEntity = pickedFeature.id.polygon;
                } else {
					var pickedFeature = viewer.scene.pick(event.position);

					if(pickedFeature) {
						if(pickedFeature.id.type === "delta") {

						} else {
							pickedName = pickedFeature.id.name;
							allObject[pickedName].terrain = pickedFeature.id;
							allObject[pickedName].plottage = getArea(allObject[pickedName].terrain.polygon._hierarchy._value.positions);
							$("#selectDistrict").val(allObject[pickedName].terrain.name).trigger("change");
							// $("#districtDisplay").val("enable").trigger("change");
						}
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
		console.log(store);

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

	function multiGen(selected_name, obj) {
		if (selected_name === "obj_lamp") {
			genBuild(obj.lon, obj.lat, obj.alt, 0.4, "objLamp", "objLamp.gltf")
		}
		else if (selected_name === "obj_tree") {
			genBuild(obj.lon, obj.lat, obj.alt, 0.05, "tree", "tree.gltf")
		}
		else if (selected_name === "obj_tree2") {
			genBuild(obj.lon, obj.lat, obj.alt, 0.9, "Tree2", "Tree.gltf")
		}
		else if (selected_name === "obj_cone") {
			genBuild(obj.lon, obj.lat, obj.alt, 0.03, "TrafficCone", "TrafficCone.gltf")
		}
		else if (selected_name === "obj_bench") {
			genBuild(obj.lon, obj.lat, obj.alt, 0.1, "bench", "bank.gltf")
		}
		else if (selected_name === "obj_bus1") {
			genBuild(obj.lon, obj.lat, obj.alt+1, 0.05, "buses", "bus_1.gltf")
		}
		else if (selected_name === "obj_bus2") {
			genBuild(obj.lon, obj.lat, obj.alt, 0.03, "buses", "Mat_1.gltf")
		}
		else if (selected_name === "obj_car1") {
			genBuild(obj.lon, obj.lat, obj.alt+1, 0.05, "buses", "car_1.gltf")
		}
		else if (selected_name === "obj_car2") {
			genBuild(obj.lon, obj.lat, obj.alt+1, 0.05, "buses", "car2_2.gltf")
		}
		else if (selected_name === "obj_truck1") {
			genBuild(obj.lon, obj.lat, obj.alt+1, 0.05, "buses", "truck_1.gltf")
		}
		else if (selected_name === "obj_truck2") {
			genBuild(obj.lon, obj.lat, obj.alt+1, 0.05, "buses", "truck_2.gltf")
		}
		else if (selected_name === "maple_green") {
			genBuild(obj.lon, obj.lat, obj.alt, 1, "texture_maple", "maple_green.gltf")
		}
		else if (selected_name === "maple_light_green") {
			genBuild(obj.lon, obj.lat, obj.alt, 1, "texture_maple", "maple_light_green.gltf")
		}
		else if (selected_name === "maple_orange") {
			genBuild(obj.lon, obj.lat, obj.alt, 1, "texture_maple", "maple_orange.gltf")
		}
		else if (selected_name === "maple_red") {
			genBuild(obj.lon, obj.lat, obj.alt, 1, "texture_maple", "maple_red.gltf")
		}
		else if (selected_name === "maple_yellow") {
			genBuild(obj.lon, obj.lat, obj.alt, 1, "texture_maple", "maple_yellow.gltf")
		}
	}
    
    function genBuild(lon, lat, alt, scale, preDir, fileName) {
    	const position = Cesium.Cartesian3.fromDegrees(lon, lat);
		const modelMatrix = Cesium.Transforms.eastNorthUpToFixedFrame(position);

		let heading = Cesium.Math.toRadians(0);
		let pitch = 0;
		let roll = 0;
		let hpr = new Cesium.HeadingPitchRoll(heading, pitch, roll);
		let orientation = Cesium.Transforms.headingPitchRollQuaternion(position, hpr);

		const entity = new Cesium.Entity({
			name: fileName,
			position: position,
			orientation: orientation,
			model: {
				uri: '/data/simulation-rest/cityPlanModelSelect?FileName='+fileName+'&preDir='+preDir,
				scale: scale,
				show: true,
				heightReference : Cesium.HeightReference.CLAMP_TO_GROUND,
			}
		});
		// entity.heading = 0;
		// entity.pitch = 0;
		// entity.roll = 0;

		_viewer.entities.add(entity);

	    // GLTF 모델 데이터 삽입
		/*const _model = Cesium.Model.fromGltf({
	        url : 'http://localhost/data/simulation-rest/cityPlanModelSelect?FileName='+fileName+'&preDir='+preDir,
	        modelMatrix : modelMatrix,
			scale : scale,
			debugWireframe: false,
	        show: true
	    });
	    _cityPlanModels.push(_model);
		const primiti_model = viewer.scene.primitives.add(_model);

	    Cesium.when(primiti_model.readyPromise).then(function(model) {
	    	  clacArea();
	    	  calcFloorCoverage();
	  		model._nodeCommands.forEach(function(data) {
	  			data.show = false;
	  		});
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
    	});*/
    }

    // 부산공정관리 빌딩 생성
    function genConsProcBuild(lon, lat, alt, scale, fileName, fairRate) {
    	var position = Cesium.Cartesian3.fromDegrees(lon, lat, alt);
//	    var modelMatrix = Cesium.Transforms.eastNorthUpToFixedFrame(position);
    	var defaultModel = null;
    	var pinBuilder = new Cesium.PinBuilder();
    	if(stdFairRate < fairRate) {
        	defaultModel = new Cesium.ModelGraphics({
                uri : '/data/simulation-rest/cityPlanModelSelect?FileName='+fileName,
                scale : scale,
                minimumPixelSize : 128,
                maximumScale : 20000
        	})
    	} else {
    		var color = Cesium.Color['RED'];
    		var colorAlpha = Cesium.Color.fromAlpha(color, parseFloat(0.3));
    		var blend = Cesium.ColorBlendMode['MIX'];
        	defaultModel = new Cesium.ModelGraphics({
                uri : '/data/simulation-rest/cityPlanModelSelect?FileName='+fileName,
                scale : scale,
                minimumPixelSize : 128,
                color : colorAlpha,
                colorBlendMode : blend,
                colorBlendAmount : parseFloat(0.7),
        	})
    	    
    	}

   	// var entitiyObj = new Cesium.Entity({
	   //  	position: position,
	   //      billboard : {
	   //          image : pinBuilder.fromText('?', Cesium.Color.BLACK, 48).toDataURL(),
	   //          verticalOrigin: Cesium.VerticalOrigin.BOTTOM,
	   //          eyeOffset: new Cesium.Cartesian3(0, 3.0504106, 0)
	   //      },
	   //      model : defaultModel,
	   //      show : false
	   //  });

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

	$("#sun_condition").click(() => {
		sunConditionDialog.dialog("open");
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

	//save CitPlanDlg
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
            url: "/data/simulation-rest/cityConstProcUpload",
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

	// function getCommentList(objectName) {
	// 	let commentData = {
	// 		objectName: objectName
	// 	};
	// 	$.ajax({
	// 		url: "/data/simulation-rest/commentList",
	// 		type: "POST",
	// 		headers: {"X-Requested-With": "XMLHttpRequest"},
	// 		data: commentData,
	// 		dataType: "json",
	// 		success: function(commentList){
	// 			const commentListViewer = document.getElementById("commentListViewer");
	// 			commentListViewer.setAttribute("objectName", commentData.objectName);
	// 			const abc = document.getElementById("commentViewDialog");
	// 			abc.setAttribute("title", "의견 교환창" + commentData.objectName);
	//
	// 			commentViewFunc(commentList);
	//
	// 			$("#commentContent").val("");
	// 			commentViewDialog.dialog("open");
	// 		},
	// 		error:function(request,status,error) {
	// 			console.log("err=", request, status, error);
	// 		}
	// 	});
	// }
	
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
		buildAcceptPermSeq = selectSeqBuild;
		if (selectSeqBuild !== "") {
			acceptMakeBuilding(selectSeqBuild);
		}
	});

	$("#acceptBuildList").change(value => {
		let val = value.target.value;
		buildAcceptPermSeq = val;
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
		let acbl = $('#acceptCompleteBuildList').val();
		if (acbl === undefined || acbl === "") {
			alert("완료 목록을 먼저 선택해 주시기 바랍니다.");
			return;
		}
		let data = {
			permSeq: acbl
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

				$("#permViewDialog #longitude").get(0).value = msg.longitude;
				$("#permViewDialog #latitude").get(0).value = msg.latitude;
				$("#permViewDialog #altitude").get(0).value = msg.altitude;

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
			success: function(permList) {
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
	$("#processStatusCheck").click(()=> {
		console.log("processStatusCheck");
		processStatusCheckDialog.dialog("open");
	});

	function getBuildingMetaData() {
		let data = {
			bottom: {
				type1: {
					material: "T30발포폴리스틸렌 / T0.08PE필름 / T90경량콘크리트(판넬히팅) / T27시멘트몰탈 / T6.0친환경 식물성수지바닥재(LG 지아소리잠)",
					width: "150",
					detailNo: "FL-01"
				},
				type2: {
					material: "T30발포폴리스틸렌 / T0.08PE필름 / T90경량콘크리트(판넬히팅) / T27시멘트몰탈 / T8온돌마루",
					width: "150",
					detailNo: "FL-02"
				},
				type3: {
					material: "액체방수1종 / 시멘트몰탈 / 석재타일",
					width: "100",
					detailNo: "FL-03"
				},
				type4: {
					material: "T27시멘트몰탈 / T8온돌마루",
					width: "35",
					detailNo: "FL-04"
				},
				type5: {
					material: "T30발포폴리스틸렌 / T0.08PE필름 / T90경량콘크리트(판넬히팅) / 액체방수1종 / T27~70시멘트몰탈 / T9.0자기질(논슬립)타일",
					width: "200",
					detailNo: "FL-05"
				},
				type6: {
					material: "액체방수1종 / T50시멘트몰탈(쇠흙손마감)",
					width: "50",
					detailNo: "FL-06"
				}
			},
			wall: {
				type1: {
					material: "시멘트 몰탈 위 친환경페인트 2회",
					detailNo: "WL-01"
				},
				type2: {
					material: "상부: 1.2m 이상 몰탈위 친환경페인트 2회 / 하부: 1.2m 이하 안전쿠션",
					detailNo: "WL-02"
				},
				type3: {
					material: "액체방수1종(반자높이까지) / 시멘트몰탈 / 도기질타일",
					detailNo: "WL-03"
				},
				type4: {
					material: "액체방수1종(H=1,200) / 시멘트몰탈 / 도기질타일",
					detailNo: "WL-04"
				},
				type5: {
					material: "액체방수1종(H=1,200) / 시멘트몰탈 / 친환경페인트 2회",
					detailNo: "WL-05"
				},
				type6: {
					material: "시멘트 몰탈 위 수성페인트 2회",
					detailNo: "WL-06"
				}
			},
			ceil: {
				type1: {
					material: "경량철골천장롤(M-BAR) / THK9.5석고보드 2겹 / 친환경페인트 2회",
					height: "1층 2,300 / 2층 2,900",
					detailNo: "CL-01"
				},
				type2: {
					material: "경량철골천장롤(CLIP-BAR) / 열경화성수지천정재",
					height: "2,300",
					detailNo: "CL-02"
				},
				type3: {
					material: "콘크리트면처리 위 수성페인트 2회",
					height: "-",
					detailNo: "CL-03"
				}
			}
		};
		return data;
	}

	const busSamplePosition = [
		127.268185563992,36.52498984302221,1,
		127.26787876098984,36.525301485567915,1,
		127.26767990481896,36.525558132376325,1,
		127.26747820504661,36.525791865414426,1,
		127.26741570210505,36.52610809448586,1,
		127.26747542763627,36.526420606537705,1,
		127.267532486665,36.526765806481635,1,
		127.26756957372169,36.527067279608964,1,
		127.26765516252534,36.527400971539514,1,
		127.26770651393856,36.52779450064776,1,
		127.2677893861096,36.52826761249312,1,
		127.26784664857215,36.528588630785634,1,
		127.26789818443586,36.5289835536422,1,
		127.26773178802088,36.52943476242508,1,
		127.26747924569432,36.52974956928284,1,
		127.26725253181495,36.5297796606732,1,
		127.26698851411592,36.52958521868429,1,
		127.26639733347912,36.52939077280283,1,
		127.2655830559292,36.529052964342206,1,
		127.26519035501734,36.528669153993995,1,
		127.26481792919128,36.52827626402508,1,
		127.26446894697484,36.52791862411967,1,
		127.26401412479109,36.52740407791329,1,
		127.26378889782335,36.527102690625604,1,
		127.26346957512136,36.52668642773908,1,
		127.26332417061622,36.52630006158854,1,
		127.26326714951544,36.5259504902189,1,
		127.26319047750127,36.525712238393396,1,
		127.26307119906448,36.52543733336696,1,
		127.26295192099887,36.52510639039557,1,
		127.26305984185795,36.52484981307907,1,
		127.2635710381883,36.52473985176785,1,
		127.2644400793169,36.524507239871056,1,
		127.26487120840146,36.52439972714907,1,
		127.26509227329731,36.52448203149675,1,
		127.2652368135746,36.52474722971511,1,
		127.26538985591549,36.52501928775557,1,
		127.26557691158472,36.525090159985346,1,
		127.2660473855522,36.524909550442935,1,
		127.26652919307674,36.52468550268405,1,
		127.2670450120734,36.5244660255848,1,
		127.26757217818313,36.52445458906652,1,
		127.26802882757312,36.52461226556226,1,
		127.26825591353428,36.5247130152673,1,
		127.268185563992,36.52498984302221,1,
		127.26787876098984,36.525301485567915,1];

	const droneSamplePosition =	[127.2856504212428,36.48066411326436,2+11,
			127.28578304702818,36.48080979054118,2+11,
			127.28592662916796,36.48103489505022,4+11,
			127.28617248357656,36.48125446340615,4+11,
			127.28638765775678,36.48152561777509,6+11,
			127.28641000252487,36.48164386125527,6+11,
			127.28628911618449,36.481981325955395,6+11,
			127.28580573784654,36.481965602851105,6+11,
			127.28532255462311,36.481885781823884,6+11,
			127.28513165322146,36.48166234771338,8+11,
			127.28554530433529,36.48127130963175,8+11,
			127.28605964844036,36.481483415184094,10+11,
			127.28591970469876,36.482110309041346,26+11,
			127.28481112026408,36.481724032641885,26+11,
			127.28431385979691,36.48194272150995,26+11,
			127.2837558833892,36.48202593951379,26+11,
			127.28368326049522,36.48179209922455,26+11,
			127.28412163666673,36.48143259180876,14+11,
			127.28454406753546,36.481254649097195,6+11,
			127.28489244391889,36.481060150041856,4+11,
			127.2852421125134,36.48083960258572,2+11,
			127.2856504212428,36.48066411326436,2+11,
			127.28578304702818,36.48080979054118,2+11];

	function runIot(id, pos, modelPath, scale) {
		console.log("runIot: ", id);
		var startTime = '';
		var endTime = '';
		function computeCirclularFlight() {
			var property = new Cesium.SampledPositionProperty();
			for (var i = 0; i < pos.length-1; i++) {
				var position = Cesium.Cartesian3.fromDegrees(pos[i].lon, pos[i].lat, pos[i].alt);
				const julDate = Cesium.JulianDate.fromDate(pos[i].dateTime.toDate());
				property.addSample(julDate, position);
				_viewer.entities.add({
					position : position,
				});
				if(i === 0)
					startTime = julDate;
				if(i === pos.length-2)
					endTime = julDate;
			}
			return property;
		}

		var position = computeCirclularFlight();

		_viewer.clock.startTime = startTime;
		_viewer.clock.stopTime = endTime;
		_viewer.clock.currentTime = startTime;
		_viewer.clock.clockRange = Cesium.ClockRange.LOOP_STOP; //Loop at the end
		_viewer.clock.multiplier = 10;
		
        let et_scale = 0;
        let clmp_ground = 0;
        if(id == 'bus'){
            et_scale = 0.05;
			clmp_ground = Cesium.HeightReference.CLAMP_TO_GROUND;
        } else if(id == 'drone'){
            et_scale = 10;
			clmp_ground = 0;
        }

		var entity = viewer.entities.add({
			id : id,
			availability : new Cesium.TimeIntervalCollection([new Cesium.TimeInterval({
				start : startTime,
				stop : endTime
			})]),
			position : position,
			orientation : new Cesium.VelocityOrientationProperty(position),
			model : {
				uri : modelPath,
				minimumPixelSize : 24,
				maximumPixelSize : 24,
				scale : et_scale,
				heightReference : clmp_ground,
			},
			path : {
				material : new Cesium.PolylineGlowMaterialProperty({
					glowPower : 0.1,
					rgba : [23, 184, 190, 255]
				}),
				width : 4
			},
		});
		iotEntities[id] = entity;
		entity.position.setInterpolationOptions({
			interpolationDegree : 5,
			interpolationAlgorithm : Cesium.LagrangePolynomialApproximation
		});
		// _viewer.zoomTo(_viewer.entities, new Cesium.HeadingPitchRange(0, Cesium.Math.toRadians(-90)));
	}

	$('#iotSimTrack').click(function() {
		const val = $('#iotList').val();
		if (val === "") {
			alert("종류를 먼저 선택해 주시기 바랍니다.");
			return;
		}
		if (iotEntities[val] === undefined) {
			alert("종류를 먼저 등록해 주시기 바랍니다.");
			return;
		}
		if (iotEntities[val].isTracking) {
			alert(val+"은 이미 트랙킹 중입니다.");
			return;
		}
		if (!iotEntities[val].isRunning) {
			alert(val+"을 먼저 실행시켜 주시기 바랍니다.");
			return;
		}

		sceneViewEntity(val);
	});

    var onTickListener = null;
	
	function sceneViewEntity(param_id){
		var first_flip = 0;

        onTickListener = viewer.clock.onTick.addEventListener(function(clock){
            // clock.currentTime, viewer.endTime하고 비교
            if(clock.currentTime < viewer.clock.stopTime){
				var flipAngle = -1;

				iotEntities[param_id].isTracking = true;
                var trackedEntity = viewer.entities.getById(iotEntities[param_id]._id);
                // console.log("trackedEntity=", iotEntities[param_id]._id);
                var direction = trackedEntity.orientation.getValue(clock.currentTime);
                
                if(first_flip === 400){
                	flipAngle *= -1;
                	first_flip += 1;
                } else if(first_flip === 960){
                	flipAngle *= -1;
                	first_flip += 1;
                } else{
                	first_flip += 1;
                }
                
                var angle = Cesium.Quaternion.computeAngle(direction) * flipAngle;
                var pitch = -Cesium.Math.toRadians(70.0);
                var range = Cesium.Cartesian3.magnitude(new Cesium.Cartesian3(80.0, 50.0, 60.0)) + 100;
                // debugger;
                var offset = new Cesium.HeadingPitchRange(angle, pitch, range);

                // console.log("angle=", angle, " pitch=", pitch, " range=", range, " offset=", offset);
                viewer.camera.lookAt(trackedEntity.position.getValue(clock.currentTime), offset);
            } else{
				iotEntities[param_id].isTracking = false;

                // viewer.entities.removeById(iotEntities[param_id]._id);
                viewer.clock.onTick.removeEventListener(onTickListener());
				viewer.camera.lookAtTransform(Cesium.Matrix4.IDENTITY);
            }
        });
	};
};

const f4dDataGenMaster = {
	avg_lon: 0,
	avg_lat: 0,
	rootObject: function(f4dObject, mappingType) {
		return  {
			"attributes": {
				"isPhysical": true,
				"nodeType": " root ",
				"projectType": "citygml",
				"specularLighting": true,
				"ratio": f4dObject.cons_ratio,
				"step": f4dObject.step,
				"consType": f4dObject.cons_type
			},
			"children": [],
			"parent": 0,
			"depth": 1,
			"view_order": 2,
			"data_key": f4dObject.data_key,
			"data_name": f4dObject.data_name,
			"mapping_type": mappingType
		};
	},
	initIfc: (f4dObject, lon, lat, alt, head, pich, roll) => {
		let mappingType = "origin";

		if(f4dObject.cons_type === 'CONSTPROCGEUMGANG') {
			mappingType = "boundingboxcenter";
		}
		const rootObj = f4dDataGenMaster.rootObject(f4dObject, mappingType);
		rootObj.children = f4dDataGenMaster.genIfcChild(f4dObject.f4dSubList, lon, lat, alt, head, pich, roll, mappingType);
		return rootObj;
	},
	initGml: (f4dObject) => {
		let mappingType = "origin";
		if(f4dObject.cons_type === 'CONSTPROCGEUMGANG') {
			mappingType = "boundingboxcenter";
		}
		const rootObj = f4dDataGenMaster.rootObject(f4dObject, mappingType);
		rootObj.children = f4dDataGenMaster.genGmlChild(f4dObject.f4dSubList, mappingType);
		return rootObj;
	},
	genIfcChild: function(f4dSubObject, lon, lat, alt, head, pich, roll, mappingType) {
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
				"mapping_type": mappingType,
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
	genGmlChild: function(f4dSubObject, mappingType) {
		arr = [];
		arr_lon = [];
		arr_lat = [];

		for(var i = 0; i < f4dSubObject.length; i++) {
			var obj = f4dSubObject[i];
			var imsiF4dSubObject = {
				"attributes": {
					"isPhysical": true,
					"nodeType": "daejeon",
					// "flipYTexCoords": false,
					"ratio": obj.ratio
				},
				"children": [],
				"data_key": obj.data_key,
				"data_name": obj.data_key,
				// origin, boundingboxcenter
				"mapping_type": mappingType,
				"longitude": obj.longitude,
				"latitude": obj.latitude,
				"height": obj.height,
				"heading": obj.heading,
				"pitch": obj.pitch,
				"roll": obj.roll
			};
			arr_lon.push(obj.longitude);
			arr_lat.push(obj.latitude);
			arr.push(imsiF4dSubObject);
		}
		// this.avg_lon = arr_lon.reduce((prev, curr) => prev + curr) / arr_lon.length;
		// this.avg_lat = arr_lat.reduce((prev, curr) => prev + curr) / arr_lat.length;
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
	},
};
