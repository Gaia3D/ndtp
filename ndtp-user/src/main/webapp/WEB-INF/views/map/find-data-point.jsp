<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
    <meta charset="utf-8">
    <meta name="referrer" content="origin">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <meta name="robots" content="index,nofollow"/>
    <title>지도에서 찾기 | NDPT</title>
    <link rel="stylesheet" href="/externlib/cesium/Widgets/widgets.css" />
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css" />
    <link rel="stylesheet" href="/css/${lang}/user-style.css" />
	<link rel="stylesheet" href="/css/${lang}/style.css" />
	<style type="text/css">
    	.mapSelectButton {
			position : absolute;
			bottom : 17px;
			right : 20px;
			z-index : 1;
			width: 90px;
			height: 40px;
			padding: 7px;
			font-size: 17px;
			border-radius: 3px;
			color: #414e80;
			border: 1px solid #414e80;
			background-color: #fff;
		}
		.mapSelectButton:hover {
			color: #fff;
			border: 1px solid #414e80;
			background-color: #414e80;
		}
	    .mapWrap {
			height: 100%;
			background-color: #eee;
		}
    </style>
 </head>
<body>
	<button class="mapSelectButton" onclick="window.close();">닫기</button>
    <div id="magoContainer" style="height: 699px;">
	</div>
</body>
<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script type="text/javascript" src="/externlib/handlebars-4.1.2/handlebars.js"></script>
<script type="text/javascript" src="/externlib/cesium/Cesium.js"></script>
<script type="text/javascript" src="/js/mago3d.js"></script>
<script type="text/javascript" src="/js/mago3d_lx.js"></script>
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript" src="/js/${lang}/map-controll.js"></script>
<script type="text/javascript" src="/js/${lang}/ui-controll.js"></script>
<script type="text/javascript" src="/js/${lang}/wps-request.js"></script>
<script type="text/javascript" src="/js/${lang}/data-info.js"></script>
<script type="text/javascript" src="/js/${lang}/user-policy.js"></script>
<%-- <script type="text/javascript" src="/js/${lang}/layer.js"></script> --%>

<script type="text/javascript">
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
		
        dataGroupList();

        // 환경 설정.
        UserPolicy(magoInstance);
		
		magoManager.on(Mago3D.MagoManager.EVENT_TYPE.CLICK, function(result) {
			if(beforePointId !== undefined && beforePointId !== null) {
				remove(beforePointId);
			}
			
			var longitude = result.clickCoordinate.geographicCoordinate.longitude;
			var latitude = result.clickCoordinate.geographicCoordinate.latitude;
			var altitude = result.clickCoordinate.geographicCoordinate.altitude;
			
			var x = result.clickCoordinate.worldCoordinate.x;
			var y = result.clickCoordinate.worldCoordinate.y;
			var z = result.clickCoordinate.worldCoordinate.z;
			
			var pointGraphic = new Cesium.PointGraphics({
				pixelSize : 10,
				heightReference : Cesium.HeightReference.CLAMP_TO_GROUND,
				color : Cesium.Color.AQUAMARINE,
				outlineColor : Cesium.Color.WHITE,
				outlineWidth : 2
			});
			
			var addedEntity = viewer.entities.add({
				position : new Cesium.Cartesian3(x, y, z),
				point : pointGraphic
			});
			
			$(opener.document).find("#longitude").val(longitude);
			$(opener.document).find("#latitude").val(latitude);
			$(opener.document).find("#altitude").val(altitude);
			
			beforePointId = addedEntity.id;
		});
		
		// 기본 레이어 랜더링
		setTimeout(function(){
        	initLayer('${baseLayers}');
        }, geoPolicyJson.initDuration * 1000);
	}
	
	// 데이터 그룹 목록
	function dataGroupList() {
		$.ajax({
			url: "/data-groups/all",
			type: "GET",
			headers: {"X-Requested-With": "XMLHttpRequest"},
			dataType: "json",
			success: function(msg){
				if(msg.statusCode <= 200) {
					var dataGroupList = msg.dataGroupList;
					if(dataGroupList !== null && dataGroupList !== undefined) {
						dataList(dataGroupList);
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
	function dataList(dataGroupArray) {
		var dataArray = new Array();
		var dataGroupArrayLength = dataGroupArray.length;
		var cnt = 0;
		for(var i=0; i<dataGroupArrayLength; i++) {
			var dataGroup = dataGroupArray[i];
			if(dataGroup.dataCount === 0) delete dataGroupArray[i];
			var f4dController = MAGO3D_INSTANCE.getF4dController();
			$.ajax({
				url: "/datas/" + dataGroup.dataGroupId + "/list",
				type: "GET",
				headers: {"X-Requested-With": "XMLHttpRequest"},
				dataType: "json",
				success: function(msg){
					if(msg.statusCode <= 200) {
						var dataInfoList = msg.dataInfoList;

						if(dataInfoList.length > 0) {
							var dataInfoFirst = dataInfoList[0];
							var dataInfoGroupId = dataInfoFirst.dataGroupId;
							var group;
							for(var j in dataGroupArray) {
								if(dataGroupArray[j].dataGroupId === dataInfoGroupId) {
									group = dataGroupArray[j];
									break;
								}
							}

							group.datas = dataInfoList;
							f4dController.addF4dGroup(group);
						}
						cnt++;
					} else {
						alert(JS_MESSAGE[msg.errorCode]);
					}
				},
				error:function(request,status,error){
					alert(JS_MESSAGE["ajax.error.message"]);
				}
			});			
		}
		
	}
	
	function flyTo(longitude, latitude, altitude, duration) {
		if(longitude === null || longitude === '' || latitude === null || latitude === '' || altitude === null || altitude === '') {
			alert("위치 정보가 올바르지 않습니다. 확인하여 주십시오.");
			return;
		}
		gotoFlyAPI(MAGO3D_INSTANCE, parseFloat(longitude), parseFloat(latitude), parseFloat(altitude), parseFloat(duration));
	}
	
	function remove(entityStored) {
		entities.removeById(entityStored);
	}
	
	function initLayer(baseLayers) {
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
</script>
</html>