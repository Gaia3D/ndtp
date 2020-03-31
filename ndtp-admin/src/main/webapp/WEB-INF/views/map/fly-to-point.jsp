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
    <link rel="stylesheet" href="/externlib/cesium/Widgets/widgets.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css?cacheVersion=${contentCacheVersion}" />
    <%-- <link rel="stylesheet" href="/css/${lang}/admin-style.css" /> --%>
	<link rel="stylesheet" href="/css/${lang}/map-style.css?cacheVersion=${contentCacheVersion}" />
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
	<button class="mapSelectButton" onclick="flyToPointClose();">닫기</button>
    <div id="magoContainer" style="height: 699px;">
	</div>
	<canvas id="objectLabel"></canvas>
</body>
<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/externlib/cesium/Cesium.js"></script>
<script type="text/javascript" src="/externlib/cesium-geoserver-terrain-provider/GeoserverTerrainProvider.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/externlib/decodeTextAlternative/encoding-indexes.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/externlib/decodeTextAlternative/encoding.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/common.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/message.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/mago3d.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/mago3d_lx.js?cacheVersion=${contentCacheVersion}"></script>

<script type="text/javascript">
	//Cesium.Ion.defaultAccessToken = '';
	//var viewer = new Cesium.Viewer('magoContainer');
	var MAGO3D_INSTANCE;
	var viewer = null;
	var entities = null;
	var geoPolicyJson = ${geoPolicyJson};

	magoInit();

	function magoInit() {

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
		if(viewer.baseLayerPicker) viewer.baseLayerPicker.destroy();

		// mago3d logo 추가
		Mago3D.tempCredit(viewer);

		if(!${readOnly}) {
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
		}

		setTimeout(function(){
        	initLayer('${baseLayers}');
        	drawMarker(geoPolicyJson);
        }, geoPolicyJson.initDuration * 1000);
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

	function drawMarker(geoPolicyJson) {
		var x = Number(geoPolicyJson.initLongitude);
   		var y = Number(geoPolicyJson.initLatitude);

   		viewer.entities.add({
   		    name : 'Location',
   		    position : Cesium.Cartesian3.fromDegrees(x, y),
   		    billboard : {
   	        	disableDepthTestDistance : Number.POSITIVE_INFINITY,
   				heightReference: Cesium.HeightReference.CLAMP_TO_GROUND,
   		        image: '/images/ko/marker.png',
   	            horizontalOrigin : Cesium.HorizontalOrigin.CENTER, // default
   	            verticalOrigin : Cesium.VerticalOrigin.BOTTOM, // default: CENTER
   	            scale: 0.2
   		    }
   		});
	}

	function flyToPointClose() {
		if(beforePointId && !${readOnly}) {
			alert("위치가 변경되었습니다.");
		}
		window.close();
	}
</script>
</html>