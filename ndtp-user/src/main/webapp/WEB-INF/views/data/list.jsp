<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>데이터 목록 | NDTP</title>
	
	<link rel="stylesheet" href="/externlib/cesium/Widgets/widgets.css" />
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css" />
	<link rel="stylesheet" href="/externlib/geostats/geostats.css" />
	<link rel="stylesheet" href="/externlib/kotSlider/range.css" />
	<link rel="stylesheet" href="/css/${lang}/user-style.css" />
	<style type="text/css">
	    .mapWrap {
	    	float:right;
	    	width: calc(100% - 60px);
	    	height: 100%;
			background-color: #eee;
		}
		.ctrlWrap {
			z-index:10000;
		}
		.ctrlWrap div.zoom button, .ctrlWrap div.rotate button  {
			width:47px;
			height:47px;
		}
    </style>
</head>
<body>

<%@ include file="/WEB-INF/views/layouts/header.jsp" %>
<div id="loadingWrap">
	<div class="loading">
		<span class="spinner"></span>
	</div>
</div>
<div id="wrap">
	<!-- S: NAVWRAP -->
	<div class="navWrap">
	 	<%@ include file="/WEB-INF/views/layouts/menu.jsp" %> 
		
		<!-- E: NAVWRAP -->	
		
		<div id="contentsWrap" class="contentsWrap" style="display: none;">
			<div id="searchContent" class="contents yScroll" style="display:none;">
				<%@ include file="/WEB-INF/views/search/district.jsp" %>
			</div>
			<div id="dataContent" class="contents fullHeight">
				<div class="tabs" >
					<ul id="dataInfoTab" class="tab">
						<li data-nav="dataGroupInfoContent">데이터 그룹</li>
						<li class="on" data-nav="dataInfoContent">데이터 목록</li>
					</ul>
				</div>
				<%@ include file="/WEB-INF/views/data/list-data.jsp" %>
				<%@ include file="/WEB-INF/views/data/list-data-group.jsp" %>
			</div>
			<!-- E: 데이터 -->
			
			<div id="spatialContent" class="contentsList yScroll" style="display:none;height: 798px;background-color: #fff;">
				<%@ include file="/WEB-INF/views/spatial/spatial.jsp" %> 
			</div>
			<div id="simulationContent" class="contentsList yScroll" style="display:none;">
				<%@ include file="/WEB-INF/views/simulation/simulation.jsp" %>
			</div>
			<div id="civilVoiceContent" class="contents" style="display:none;">
				<%@ include file="/WEB-INF/views/civil-voice/input.jsp" %>
			</div>
			
			<div id="layerContent" class="contents" style="display:none;">
				<%@ include file="/WEB-INF/views/layer/list.jsp" %>
			</div>
			
			<div id="userPolicyContent" class="contents" style="display:none;">
				<%@ include file="/WEB-INF/views/user-policy/modify.jsp" %>
			</div>
			<!-- E: CONTENTS -->
			<!-- E: CONTENTS -->
			
			<div class="contentsBtn">
				<button type="button" id="closeLeftBtn" title="닫기">Close</button>
			</div>
			<!-- E: CONTENTSBTN -->
		</div>
		<!-- E: CONTENTSWRAP -->

	</div>
	<!-- E: NAVWRAP -->
	
	<!-- S: GNB WRAP -->	
	<%@ include file="/WEB-INF/views/layouts/global-search.jsp" %>
	<!-- E: GNB WRAP -->

	<!-- CTRLWRAP -->
	<%@ include file="/WEB-INF/views/layouts/toolbar.jsp" %>
	<!-- E: CTRLWRAP -->

	<!-- MAP -->
	<div id="magoContainer" class="mapWrap">
		<div class="analysisGraphic">
			<canvas id="analysisGraphic"></canvas>
			<div class="closeGraphic">X</div>
		</div>
		<div class="sliderWrap">
			<input id="rangeInput"/>
		</div>
	</div>
	<!-- E: MAP -->
</div>
<!-- E: WRAP -->

<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script type="text/javascript" src="/externlib/handlebars-4.1.2/handlebars.js"></script>
<script type="text/javascript" src="/js/${lang}/handlebarsHelper.js"></script>
<script type="text/javascript" src="/externlib/cesium/Cesium.js"></script>
<script type="text/javascript" src="/externlib/geostats/geostats.js"></script>
<script type="text/javascript" src="/externlib/chartjs/Chart.min.js"></script>
<script type="text/javascript" src="/externlib/kotSlider/range.js"></script>
<script type="text/javascript" src="/js/mago3d.js"></script>
<script type="text/javascript" src="/js/mago3d_lx.js"></script>
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript" src="/js/${lang}/map-controll.js"></script>
<script type="text/javascript" src="/js/${lang}/ui-controll.js"></script>
<script type="text/javascript" src="/js/${lang}/spatial-analysis.js"></script>
<script type="text/javascript" src="/js/${lang}/district-controll.js"></script>
<script type="text/javascript" src="/js/${lang}/wps-request.js"></script>
<script type="text/javascript" src="/js/${lang}/search.js"></script>
<script type="text/javascript" src="/js/${lang}/data-info.js"></script>
<script type="text/javascript" src="/js/${lang}/user-policy.js"></script>
<script type="text/javascript" src="/js/${lang}/simulation.js"></script>
<script type="text/javascript" src="/js/${lang}/layer.js"></script>
<script type="text/javascript">
	// 임시로...
	$(document).ready(function() {
		$(".ui-slider-handle").slider({});
	});
	
	//Cesium.Ion.defaultAccessToken = '';
	//var viewer = new Cesium.Viewer('magoContainer');
	var MAGO3D_INSTANCE;
	magoInit();
	
	function magoInit() {
		var geoPolicyJson = ${geoPolicyJson};
		
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

	function magoLoadEnd(e) {
		var magoInstance = e;
		
		var viewer = magoInstance.getViewer(); 
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
		//공간분석 기능 수행
		SpatialAnalysis(magoInstance);
		// 행정 구역 이동 
        DistrictControll(viewer);

        dataGroupList();

        Simulation(magoInstance);
        // 환경 설정.
        UserPolicy(magoInstance);
	}
	
	// 데이터 그룹 목록
	function dataGroupList() {
		$.ajax({
			url: "/data-groups",
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
				url: "/datas",
				data: { "dataGroupId" : dataGroup.dataGroupId },
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
	
	function flyToData(longitude, latitude, altitude, duration) {
		gotoFlyAPI(MAGO3D_INSTANCE, parseFloat(longitude), parseFloat(latitude), parseFloat(altitude), parseFloat(duration));
	}
</script>
</body>
</html>
