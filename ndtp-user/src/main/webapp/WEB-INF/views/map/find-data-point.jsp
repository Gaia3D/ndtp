<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>
<!DOCTYPE html>
<html lang="${accessibility}">
<head>
    <meta charset="utf-8">
    <meta name="referrer" content="origin">
    <meta name="viewport" content="width=device-width">
    <meta name="robots" content="index,nofollow"/>
    <title>지도에서 찾기 | NDPT</title>
    <link rel="stylesheet" href="/externlib/cesium/Widgets/widgets.css" />
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css" />
	<link rel="stylesheet" href="/externlib/kotSlider/range.css" />
    <link rel="stylesheet" href="/css/${lang}/user-style.css" />
    <style type="text/css">
    .ctrlWrap {
	    z-index: 10000;
	}
    </style>
</head>
<body>
	<%@ include file="/WEB-INF/views/map/find-data-toolbar.jsp" %>
    <div id="magoContainer" style="height: 100%;"></div>
    <button class="mapSelectButton" onclick="window.close();">닫기</button>
</body>
<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script type="text/javascript" src="/externlib/handlebars-4.1.2/handlebars.js"></script>
<script type="text/javascript" src="/externlib/cesium/Cesium.js"></script>
<script type="text/javascript" src="/externlib/decodeTextAlternative/encoding-indexes.js"></script>
<script type="text/javascript" src="/externlib/decodeTextAlternative/encoding.js"></script>
<script type="text/javascript" src="/externlib/moment-2.22.2/moment-with-locales.min.js"></script>
<script type="text/javascript" src="/js/mago3d.js"></script>
<script type="text/javascript" src="/js/mago3d_lx.js"></script>
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript" src="/js/${lang}/map-controll.js"></script>
<script type="text/javascript" src="/js/${lang}/ui-controll.js"></script>
<script type="text/javascript" src="/js/${lang}/wps-request.js"></script>
<script type="text/javascript" src="/js/${lang}/data-info.js"></script>
<script type="text/javascript" src="/js/${lang}/user-policy.js"></script>
<script type="text/javascript" src="/js/${lang}/map-data-controll.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#magoTool").addClass("on");
		$(".labelLayer").show();
	});

	//Cesium.Ion.defaultAccessToken = '';
	//var viewer = new Cesium.Viewer('magoContainer');
	var MAGO3D_INSTANCE;
	// ndtp 전역 네임스페이스
	/* var NDTP = NDTP ||{
		policy : ${geoPolicyJson},
		baseLayers : "${baseLayers}",
		wmsProvider : {},
		districtProvider : {}
	}; */

	var geoPolicyJson = null;
	var viewer = null;
	var entities = null;

	magoInit();

	function magoInit() {

		geoPolicyJson = ${geoPolicyJson};

		var cesiumViewerOption = {};
		cesiumViewerOption.infoBox = false;
		cesiumViewerOption.navigationHelpButton = false;
		cesiumViewerOption.selectionIndicator = false;
		cesiumViewerOption.homeButton = false;
		cesiumViewerOption.fullscreenButton = false;
		cesiumViewerOption.geocoder = false;
		cesiumViewerOption.baseLayerPicker = false;
		cesiumViewerOption.sceneModePicker = false;

		/**
		 * @param {Stirng} containerId container div id. required.
		 * @param {object} serverPolicy mage3d geopolicy. required.
		 * @param {object} callback loadstart callback, loadend callback. option.
		 * @param {object} options Cesium viewer parameter. option.
		 * @param {Cesium.Viewer} legacyViewer 타 시스템과의 연동의 경우 view 객체가 생성되어서 넘어 오는 경우가 있음. option.
		*/
		MAGO3D_INSTANCE = new Mago3D.Mago3d('magoContainer', geoPolicyJson, {loadend : magoLoadEnd}, cesiumViewerOption);
	}

	var beforePointId = null;
	function magoLoadEnd(e) {
		var magoInstance = e;
		viewer = magoInstance.getViewer();
		entities = viewer.entities;
		var magoManager = magoInstance.getMagoManager();
		var f4dController = magoInstance.getF4dController();

		// TODO : 세슘 MAP 선택 UI 제거,엔진에서 처리로 변경 예정.
		viewer.baseLayerPicker.destroy();
		viewer.scene.globe.depthTestAgainstTerrain = true;
		/* magoManager.on(Mago3D.MagoManager.EVENT_TYPE.CLICK, function(result) {
			console.info(result);
		}); */

		//우측 상단 지도 컨트롤러
		MapControll(viewer);
		dataGroupList(magoInstance);
        // 환경 설정.
        UserPolicy(magoInstance);

     	// 선택 및 이동 all 로 선택
		changeObjectMoveAPI(magoInstance, "0");
		$('#objectAllMove').prop("checked", true);

		//지도상에 데이터 다루는거
		MapDataControll(magoInstance);

		//선택된 데이터 이동 시 결과 리턴
	    magoManager.on(Mago3D.MagoManager.EVENT_TYPE.SELECTEDF4DMOVED, function(result) {
	    	var dataInfo = result.result;
	    	initData(dataInfo);
	    });

	    // 기본 레이어 랜더링
		setTimeout(function(){
        	initLayer('${baseLayers}');
        }, geoPolicyJson.initDuration * 1000);

		/* setTimeout(function(){
			changeObjectMove();
        }, 5000); */

	}
	/*
	function changeObjectMove() {
		// 선택 및 이동 all 로 선택
		changeObjectMoveAPI(MAGO3D_INSTANCE, "0");
	} */

	// 데이터 그룹 목록
	function dataGroupList(magoInstance) {
		$.ajax({
			url: "/data-groups/${dataInfo.dataGroupId}",
			type: "GET",
			headers: {"X-Requested-With": "XMLHttpRequest"},
			dataType: "json",
			success: function(msg){
				if(msg.statusCode <= 200) {
					var dataGroup = msg.dataGroup;
					if(dataGroup !== null && dataGroup !== undefined) {
						dataList(magoInstance, dataGroup);
					}
				} else {
					alert(JS_MESSAGE[msg.errorCode]);
				}
			},
			error:function(request,status,error){
				alert(JS_MESSAGE["ajax.error.message"]);
			}
		});
	}

	// 데이터 정보 목록
	function dataList(magoInstance, dataGroup) {
		var dataInfoJson = ${dataInfoJson};

		var f4dController = MAGO3D_INSTANCE.getF4dController();

		var dataInfoList = new Array();

		if (dataInfoJson && f4dController) {

			dataInfoList.push(dataInfoJson);

			initData(dataInfoJson);

			//var dataInfoList = msg.dataInfoList;
			var dataInfoFirst = dataInfoJson;
			var dataInfoGroupId = dataInfoFirst.dataGroupId;

			dataGroup.datas = dataInfoList;
			f4dController.addF4dGroup(dataGroup);

			magoInstance.getMagoManager().on(Mago3D.MagoManager.EVENT_TYPE.F4DLOADEND,function(e){
				flyTo(magoInstance);
				//selectF4dAPI(magoInstance, "${dataInfo.dataGroupId}", "${dataInfo.dataKey}");
			});

		}
		/* setTimeout(function() {
			flyTo(magoInstance);
		}, 500); */
	}

	function flyTo(magoInstance) {
		//  searchDataAPI
		searchDataAPI(magoInstance, "${dataInfo.dataGroupId}", "${dataInfo.dataKey}");
	}

	function remove(entityStored) {
		entities.removeById(entityStored);
	}

	function initLayer(baseLayers) {
		if(!baseLayers) return;
		var layerList = baseLayers.split(",");
		var queryString = "enable_yn='Y'";
	    var queryStrings = layerList.map(function(){ return queryString; }).join(';');	// map: ie9부터 지원
		var provider = new Cesium.WebMapServiceImageryProvider({
	        url : geoPolicyJson.geoserverDataUrl + "/wms",
	        layers : layerList.join(","),
	        parameters : {
	            service : 'WMS'
	            ,version : '1.1.1'
	            ,request : 'GetMap'
	            ,transparent : 'true'
	            ,format : 'image/png'
	            ,time : 'P2Y/PRESENT'
	            ,maxZoom : 25
	            ,maxNativeZoom : 23
	            ,CQL_FILTER: queryStrings
	        },
	        enablePickFeatures : false
	    });

		viewer.imageryLayers.addImageryProvider(provider);
	}

	function initData(dataInfo) {

		//clearDataControl();
		//$('#dcColor').hide();

		$('#datainfoDisplay').hide();
		if (!$('.layerContents > div:visible').first().hasClass('marT0')) {
			$('.layerContents > div:visible').first().addClass('marT0');
			$('#mago3DSettingLabelLayer').css('min-height', '260px');
		}

		var $dataControlWrap = $('#dataControllWrap');
		$dataControlWrap.find('.layerDivTit').hide();
		var $header = $('#mago3DSettingLabelLayer .layerHeader h3');

		var groupId = dataInfo.dataGroupId;
		if (groupId) {
			var title = groupId + ' / ' + (dataInfo.dataName || dataInfo.dataKey);
			$header.text(title);
		}

		$('#dcLongitude').val(dataInfo.longitude);
		$('#dcLatitude').val(dataInfo.latitude);
		$('#dcAltitude').val(dataInfo.altitude);

		$('#dcPitch,#dcPitchRange').val(dataInfo.pitch);
		$('#dcHeading,#dcHeadingRange').val(dataInfo.heading);
		$('#dcRoll,#dcRollRange').val(dataInfo.roll);

		if(!$('#mapPolicy').hasClass('on')) {
			$('#mapPolicy').trigger('click');
		}

		$dataControlWrap.show();

	}

	$("#magoTool").click(function(){
		$("#magoTool").addClass("on");
		$(".labelLayer").show();
	});
	$(".layerClose").click(function(){
		$("#magoTool").removeClass("on");
		$(".labelLayer").hide();
	});

	// 위치 정보 적용 버튼 클릭
	$("#dcSavePosRotPop").click(function(){
		var dataId = parseInt("${dataInfo.dataId}");
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

					/* 만일 부모창에 항목이 있으면 항목 업데이트 */
					var $opnerLon = $(opener.document).find("#longitude");
					var $opnerLat = $(opener.document).find("#latitude");
					var $opnerAlt = $(opener.document).find("#altitude");

					if ($opnerLat && $opnerLat && $opnerAlt) {
						$opnerLat.val($("#dcLongitude").val());
						$opnerLat.val($("#dcLatitude").val());
						$opnerAlt.val($("#dcAltitude").val());
					}

					$('#dcPitch,#dcPitchRange').val(dataInfo.pitch);
					$('#dcHeading,#dcHeadingRange').val(dataInfo.heading);
					$('#dcRoll,#dcRollRange').val(dataInfo.roll);


					window.close();

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

</script>
</html>