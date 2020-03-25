<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<%@ include file="/WEB-INF/views/perm-request/application-register.jsp" %>
<%@ include file="/WEB-INF/views/perm-request/application-view.jsp" %>

<%@ include file="/WEB-INF/views/perm-request/test-fly.jsp" %>
<%@ include file="/WEB-INF/views/perm-request/test-picking.jsp" %>
<%@ include file="/WEB-INF/views/perm-request/comment-view.jsp" %>
<%@ include file="/WEB-INF/views/perm-request/comment-view2.jsp" %>
<%@ include file="/WEB-INF/views/perm-request/agenda-view.jsp" %>
<%--<%@ include file="/WEB-INF/views/perm-request/comment-register.jsp" %>--%>

<%@ include file="/WEB-INF/views/modals/sun-analysis.jsp" %>
<%@ include file="/WEB-INF/views/modals/head-pitch-roll.jsp" %>
<%@ include file="/WEB-INF/views/modals/show-blueprint.jsp" %>
<%@ include file="/WEB-INF/views/modals/show-metadata.jsp" %>
<%@ include file="/WEB-INF/views/modals/show-addrsearch.jsp" %>

<%@ include file="/WEB-INF/views/construction-process/process-status-check.jsp" %>


<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="utf-8">
    <meta name="referrer" content="origin">
    <meta name="viewport" content="width=device-width">
    <meta name="robots" content="index,nofollow"/>
	<title>데이터 목록 | NDTP</title>
	<link rel="shortcut icon" href="/images/favicon.ico?cacheVersion=${contentCacheVersion}">
	<link rel="stylesheet" href="/externlib/cesium/Widgets/widgets.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/externlib/geostats/geostats.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/externlib/kotSlider/range.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/externlib/tuidatepicker-4.0.3/tui-date-picker.min.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/css/${lang}/user-style.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/externlib/json-viewer/json-viewer.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/externlib/css-toggle-switch/toggle-switch.css?cacheVersion=${contentCacheVersion}" />
	<style type="text/css">
	    .mapWrap {
	    	float:right;
	    	width: calc(100% - 60px);
	    	height: 100%;
			background-color: #eee;
		}
		.ctrlWrap {
			z-index:100;
		}
		#objectLabel {
		    background-color: transparent;
		    position: absolute;
		    left: 0px;
		    top: 0px;
		    /* z-index: 10; */
		    pointer-events: none;
	   	}
		/*
		.ctrlWrap div.zoom button, .ctrlWrap div.rotate button  {
			width:47px;
			height:47px;
		}
		*/
    </style>
</head>
<body>

<%@ include file="/WEB-INF/views/layouts/header.jsp" %>
<div id="loadingWrap">
	<div class="loading">
		<span class="spinner"></span>
	</div>
</div>
<div id="wrap" style="min-height: 560px;"> <!-- 왼쪽 메뉴 높이에 맞춰서 설정해 줘야함 -->
	<!-- S: NAVWRAP -->
	<div class="navWrap">
	 	<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>

		<!-- E: NAVWRAP -->

		<div id="contentsWrap" class="contentsWrap" style="display: none;">
			<div id="searchContent" class="contents fullHeight" style="display:none;">
				<%@ include file="/WEB-INF/views/search/district.jsp" %>
			</div>
			<div id="dataContent" class="contents-margin-default fullHeight">
				<div class="tabs">
					<ul id="dataInfoTab" class="tab tab-divide">
						<li id="dataGroupTab" data-nav="dataGroupInfoContent">데이터 그룹</li>
						<li id="dataListTab" data-nav="dataInfoContent" class="on">데이터 목록</li>
					</ul>
				</div>
				<%@ include file="/WEB-INF/views/data/map-data.jsp" %>
				<%@ include file="/WEB-INF/views/data/map-data-group.jsp" %>
			</div>
			<!-- E: 데이터 -->

			<div id="spatialContent" class="contents yScroll fullHeight" style="display:none;">
				<%@ include file="/WEB-INF/views/spatial/spatial.jsp" %>
			</div>
			<div id="simulationContent" class="contents yScroll fullHeight" style="display:none;">
				<%@ include file="/WEB-INF/views/simulation/simulation.jsp" %>
			</div>
			<div id="civilVoiceContent" class="contents yScroll fullHeight" style="display:none;">
				<%@ include file="/WEB-INF/views/civil-voice/list.jsp" %>
			</div>

			<div id="layerContent" class="contents yScroll fullHeight" style="display:none;">
				<%@ include file="/WEB-INF/views/layer/list.jsp" %>
			</div>

			<div id="userPolicyContent" class="contents yScroll fullHeight" style="display:none;">
				<%@ include file="/WEB-INF/views/user-policy/modify.jsp" %>
			</div>
			<!-- E: CONTENTS -->
			<!-- E: CONTENTS -->


			<!-- E: CONTENTSBTN -->
		</div>
		<div class="contentsBtn">
			<button type="button" id="closeLeftBtn" title="닫기" style="display:none;">Close</button>
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
		<div class="sliderWrap" id="csRange">
			<label for="rangeInput" class="hiddenTag">caRange</label>
			<input id="rangeInput"/>
		</div>
		<div class="sliderWrap" id="saRange">
			<label for="timeInput" class="hiddenTag">saRange</label>
			<input id="timeInput"/>
		</div>
	</div>
	<canvas id="objectLabel"></canvas>
	<!-- E: MAP -->
</div>
<!-- E: WRAP -->
<%@ include file="/WEB-INF/views/data/data-dialog.jsp" %>
<%@ include file="/WEB-INF/views/data/data-group-dialog.jsp" %>
<%@ include file="/WEB-INF/views/data/map-data-template.jsp" %>
<%@ include file="/WEB-INF/views/data/map-data-group-template.jsp" %>
<%@ include file="/WEB-INF/views/data/data-attribute-dialog.jsp" %>
<%@ include file="/WEB-INF/views/data/data-object-attribute-dialog.jsp" %>
<%@ include file="/WEB-INF/views/issue/issue-dialog.jsp" %>
<%@ include file="/WEB-INF/views/simulation/simul-solar-dialog.jsp" %>

<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/externlib/json-viewer/json-viewer.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/externlib/handlebars-4.1.2/handlebars.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/handlebarsHelper.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/externlib/cesium/Cesium.js"></script>
<script type="text/javascript" src="/externlib/cesium-geoserver-terrain-provider/GeoserverTerrainProvider.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/externlib/geostats/geostats.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/externlib/chartjs/Chart.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/externlib/kotSlider/range.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/externlib/decodeTextAlternative/encoding-indexes.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/externlib/decodeTextAlternative/encoding.js?cacheVersion=${contentCacheVersion}"></script>

<script type="text/javascript" src="/externlib/moment-2.22.2/moment-with-locales.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/externlib/moment-range/moment-range.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/externlib/tuidatepicker-4.0.3/tui-date-picker.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/mago3d.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/mago3d_lx.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/externlib/cesium/HtmlBillboard.js"></script>
<script type="text/javascript" src="/externlib/cesium/HtmlBillboardCollection.js"></script>
<script type="text/javascript" src="/js/${lang}/common.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/message.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/map-controll.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/ui-controll.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/spatial-analysis.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/district-controll.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/wps-request.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/search.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/data-info.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/user-policy.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/simulation.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/layer.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/map-data-controll.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/civil-voice.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/map-init.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/issue-controller.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/map-data.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/map-data-group.js?cacheVersion=${contentCacheVersion}"></script>



<script type="text/javascript">
	var a=1;
	var b=2;
	var buildAcceptPermSeq;
	var selectedObjectName;

	var selectedEntity;
	var rotationModel;

	var multiPositions = [];

	var buildingMetaData = {};
	var iotEntities = {};
	// window['moment-range'].extendMoment(moment);
	// 임시로...
	$(document).ready(function() {
		$(".ui-slider-handle").slider({});

 		$("#simulationMenu").click(()=> {
			getUserInfo();
		});
		getUserInfo();

		// metadataDialog.dialog("open");
		// blueprintDialog.dialog("open");
		// headPitchRollDialog.on("dialogopen", function(event, ui) {
		//
		// });
		// headPitchRollDialog.dialog('option', 'position', [1000,1500]);

	});

	var addrSearchDialog = $("#addrSearchDialog").dialog({
		autoOpen: false,
		width: 500,
		height: 350,
		modal: false,
		overflow : "auto",
		resizable: true,
		position: {
			my: "right top",
			at: "right-5 top+105",
			of: "body"
		},
		open: function( event, ui ) {
			let val = document.getElementById("addrSearch").value;
			document.getElementById("addressLoc").innerText = val;
		},
		close: function( event, ui ) {

		},
		buttons: [
			{
				text: "확인",
				click: function() {
					$( this ).dialog( "close" );
				}
			}
		],
	});

	var metadataDialog = $("#metadataDialog").dialog({
		autoOpen: false,
		width: 364,
		height: 370,
		modal: false,
		overflow : "auto",
		resizable: false,
		position: {
			my: "right top",
			at: "right-5 top+105",
			of: "body"
		},
		open: function( event, ui ) {
			MAGO3D_INSTANCE.getMagoManager().isShowingMetadata = true;
		},
		close: function( event, ui ) {
			MAGO3D_INSTANCE.getMagoManager().isShowingMetadata = false;
		},
		buttons: [
			{
				text: "확인",
				click: function() {
					$( this ).dialog( "close" );
				}
			}, {
				text: "최소화",
				icon: "ui-icon-about",
				click: function() {
					$( '#metadataDialog' ).toggle('fold');
				}
			},
		],
	});
	var blueprintDialog = $("#blueprintDialog").dialog({
		autoOpen: false,
		width: 364,
		height: 375,
		modal: false,
		overflow : "auto",
		resizable: true,
		position: {
			my: "right top",
			at: "right-5 top+475",
			of: "body"
		},
		open: function( event, ui ) {
			MAGO3D_INSTANCE.getMagoManager().isShowingBlueprint = true;
		},
		close: function( event, ui ) {
			MAGO3D_INSTANCE.getMagoManager().isShowingBlueprint = false;
		},
		buttons: [
			{
				text: "확인",
				click: function() {
					$( this ).dialog( "close" );
				}
			}, {
				text: "최소화",
				icon: "ui-icon-about",
				click: function() {
					$( '#blueprintDialog' ).toggle('fold');
				}
			},
		],
	});

	var sunConditionDialog = $("#sunConditionDialog").dialog({
		autoOpen: false,
		width: 600,
		height: 340,
		modal: false,
		overflow : "auto",
		resizable: true
	});
	var headPitchRollDialog = $("#headPitchRollDialog").dialog({
		autoOpen: false,
		width: 290,
		height: 240,
		modal: false,
		overflow : "auto",
		resizable: true,
		position: {
			my: "right-290 bottom-180",
		}
		// position: "top"
		// position: [1000,500]
	});

	var permRequestDialog = $( "#permRequestDialog" ).dialog({
		autoOpen: false,
		width: 1100,
		height: 720,
		modal: true,
		overflow : "auto",
		resizable: false
	});
	var permViewDialog = $( "#permViewDialog" ).dialog({
		autoOpen: false,
		width: 1100,
		height: 660,
		modal: true,
		overflow : "auto",
		resizable: false
	});
	var agendaConsultationDialog = $( "#agendaConsultationDialog" ).dialog({
		autoOpen: false,
		width: 1100,
		height: 820,
		modal: true,
		overflow : "auto",
		resizable: true,
		buttons: [{
				text: "저장",
				click: function() {
					let batchCheckedIdx = [];
					let batchCheckedEl = $("#agenda_tbody input:checked");
					batchCheckedEl.map((idx, val) => {
						let rawId = val.getAttribute("id");
						let id = rawId.substring(rawId.lastIndexOf("_")+1);
						batchCheckedIdx.push(parseInt(id));
					});
					console.log("batchCheckedIdx=", batchCheckedIdx);

					let agendaCheckedIdx = [];
					let agendaCheckedEl = $("#agenda_tbody2 input:checked");
					agendaCheckedEl.map((idx, val) => {
						let rawId = val.getAttribute("id");
						let id = rawId.substring(rawId.lastIndexOf("_")+1);
						agendaCheckedIdx.push(parseInt(id));
					});
					console.log("agendaCheckedIdx=", agendaCheckedIdx);

					const data = {
						permSeq: buildAcceptPermSeq,
						batchChecked: batchCheckedIdx.join(),
						agendaChecked: agendaCheckedIdx.join(),
					};

					$.ajax({
						url: "/data/simulation-rest/saveBatchAgendaChecked",
						type: "POST",
						headers: {"X-Requested-With": "XMLHttpRequest"},
						data: data,
						// dataType: "json",
						success: function(msg){
							console.log("msg=", msg);
						},
						error:function(request,status,error) {
							console.log("err=", request, status, error);
						}
					});

					$( this ).dialog( "close" );
				}
			},{
				text: "취소",
				click: function() {
					$( this ).dialog( "close" );
				}
			},
		],
	});

	var commentRegisterDialog = $( "#commentRegisterDialog" ).dialog({
		autoOpen: false,
		width: 380,
		height: 470,
		modal: true,
		overflow : "auto",
		resizable: false
	});

	var processStatusCheckDialog = $( "#processStatusCheckDialog" ).dialog({
		autoOpen: false,
		width: 400,
		height: 500,
		overflow : "auto",
		position: {
			my: "right top",
			at:"right-5 top+105",
			of:"body"
		},
		buttons: [
			{
				text: "확인",
				click: function() {
					$( this ).dialog( "close" );
				}
			},
			{
				text: "최소화",
				icon: "ui-icon-about",
				click: function() {
					$( '#processStatusCheckDialog' ).toggle('fold');
				}
			},
		],
		resizable: false
	});

	var viewDialogInterval="";
	var commentViewDialog = $( "#commentViewDialog" ).dialog({
		autoOpen: false,
		width: 380,
		height: 600,
		modal: true,
		overflow : "auto",
		resizable: false,
		open: function( event, ui ) {
			console.log("commentViewDialog opended");
			viewDialogInterval = setInterval(refreshCommentDialog, 500);
		},
		close: function( event, ui ) {
			console.log("commentViewDialog closed");
			clearInterval(viewDialogInterval);
		}
	});

	var viewDialogInterval2="";
	var commentViewDialog2 = $( "#commentViewDialog2" ).dialog({
		autoOpen: false,
		width: 380,
		height: 600,
		modal: true,
		overflow : "auto",
		resizable: false,
		open: function( event, ui ) {
			console.log("commentViewDialog2 opended");
			viewDialogInterval2 = setInterval(refreshCommentDialog2, 500);
		},
		close: function( event, ui ) {
			console.log("commentViewDialog2 closed");
			clearInterval(viewDialogInterval2);
		}
	});

	function refreshCommentDialog() {
		let commentData = {
			permSeq: buildAcceptPermSeq
		};
		$.ajax({
			url: "/data/simulation-rest/commentList",
			type: "POST",
			headers: {"X-Requested-With": "XMLHttpRequest"},
			data: commentData,
			dataType: "json",
			success: function(commentList){
				commentViewFunc(commentList);
			},
			error:function(request,status,error) {
				console.log("err=", request, status, error);
			}
		});
		console.log("refreshed");
	}
	function refreshCommentDialog2() {
		let commentData = {
			objectName: selectedObjectName
		};
		$.ajax({
			url: "/data/simulation-rest/commentListConstructProcess",
			type: "POST",
			headers: {"X-Requested-With": "XMLHttpRequest"},
			data: commentData,
			dataType: "json",
			success: function(commentList){
				commentViewFunc2(commentList);
			},
			error:function(request,status,error) {
				console.log("err=", request, status, error);
			}
		});
		console.log("refreshed");
	}
	//Cesium.Ion.defaultAccessToken = '';
	//var viewer = new Cesium.Viewer('magoContainer');
	var MAGO3D_INSTANCE;
	var NDTP = NDTP || {
		policy : {},
		dataGroup : {},
		baseLayers : {}
	};

	initPolicy(function(policy, baseLayers){
		NDTP.policy = policy;
		NDTP.baseLayers = baseLayers;
		magoInit();
	});

	function magoInit() {
		var geoPolicyJson = NDTP.policy;

		var cesiumViewerOption = {};
		cesiumViewerOption.infoBox = false;
		cesiumViewerOption.navigationHelpButton = false;
		cesiumViewerOption.selectionIndicator = true;
		cesiumViewerOption.homeButton = false;
		cesiumViewerOption.fullscreenButton = false;
		cesiumViewerOption.geocoder = false;
		cesiumViewerOption.baseLayerPicker = false;
		cesiumViewerOption.sceneModePicker = false;
		/*cesiumViewerOption.timeline = true;
		cesiumViewerOption.shouldAnimate = true;
		cesiumViewerOption.animation = true;*/
		// cesiumViewerOption.automaticallyTrackDataSourceClocks = true;

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
		var geoPolicyJson = NDTP.policy;
		var viewer = magoInstance.getViewer();
		var magoManager = magoInstance.getMagoManager();
		var f4dController = magoInstance.getF4dController();

		// TODO : 세슘 MAP 선택 UI 제거,엔진에서 처리로 변경 예정.
		viewer.baseLayerPicker.destroy();
		viewer.scene.globe.depthTestAgainstTerrain = true;
		viewer.scene.screenSpaceCameraController.minimumZoomDistance = 10;

		magoManager.on(Mago3D.MagoManager.EVENT_TYPE.MOUSEMOVE, function(result) {
			//console.info(result);
		});

		// mago3d logo 추가

		// Mago3D.tempCredit(viewer);

		//우측 상단 지도 컨트롤러
		MapControll(viewer);
		//공간분석 기능 수행
		SpatialAnalysis(magoInstance);
		// 행정 구역 이동
        DistrictControll(magoInstance);

        dataGroupList();
        mapDataGroupList(1, null);
        mapDataInfoList(1, null, null, null);

        var cesiumInit = Cesium;
        Simulation(magoInstance, viewer, $);
        // 환경 설정.
        UserPolicy(magoInstance);
        // 시민참여
        CivilVoice(magoInstance);
        // 기본 레이어 랜더링
        setTimeout(function(){
        	NDTP.map = new mapInit(magoInstance, NDTP.baseLayers, geoPolicyJson);
        	NDTP.map.initLayer();
        	cesiumCreditAlt(); //웹접근성
        }, geoPolicyJson.initDuration * 1000);

		//지도상에 데이터 다루는거
		MapDataControll(magoInstance);

		NDTP.issueController = new IssueController(magoInstance);


		/* // hard code : load f4d of echo delta city for simulation
		$.ajax({
			url: '/js/temp/echo.json',
			type: 'GET',
			dataType: "json",
			success: function(json){
				if(json) {
					f4dController.addF4dGroup(json);
				}
			}
		}); */
	}

	// smart tiling data flyTo
	function gotoFly(longitude, latitude, altitude) {
		if(longitude === null || longitude === '' || latitude === null || latitude === '' || altitude === null || altitude === '') {
			alert("위치 정보가 올바르지 않습니다. 확인하여 주십시오.");
			return;
		}

		gotoFlyAPI(MAGO3D_INSTANCE, longitude, latitude, 500, 3);
		hereIamMarker(longitude, latitude, altitude);
	}

	function flyTo(dataGroupId, dataKey) {
		if(dataGroupId === null || dataGroupId === '' || dataKey === null || dataKey === '') {
			alert("위치 정보가 올바르지 않습니다. 확인하여 주십시오.");
			return;
		}

		//  searchDataAPI
		 searchDataAPI(MAGO3D_INSTANCE, dataGroupId, dataKey);

		 var node = MAGO3D_INSTANCE.getMagoManager().hierarchyManager.getNodeByDataKey(dataGroupId, dataKey);
		 var geographic = node.data.bbox.geographicCoord;
		 hereIamMarker(geographic.longitude, geographic.latitude, geographic.altitude);
	}

	var hereIamTimeOut;
	function hereIamMarker(longitude, latitude, altitude) {
		var magoManager = MAGO3D_INSTANCE.getMagoManager();
		if(!magoManager.speechBubble) {
			magoManager.speechBubble = new Mago3D.SpeechBubble();
		}
		var sb = magoManager.speechBubble;
		removeHearIam();
		if(hereIamTimeOut) {
			clearTimeout(hereIamTimeOut);
		}
		var commentTextOption = {
			pixel:12,
			color:'black',
			borderColor:'white',
			text:'여기요 여기!'
		}

		var img = sb.getPng([80,32],'#94D8F6', commentTextOption);

		var options = {
			positionWC    : Mago3D.ManagerUtils.geographicCoordToWorldPoint(longitude, latitude, parseFloat(altitude)+5),
			imageFilePath : img
		};

		var omId = new Date().getTime();
		var om = magoManager.objMarkerManager.newObjectMarker(options, magoManager);
		om.id = omId;
		om.hereIam = true;

		var effectOption = {
			effectType : "zMovement",
			durationSeconds : 9.9,
			zVelocity : 100,
			zMax : 30,
			zMin : 0
		};
		var effect = new Mago3D.Effect(effectOption);
		magoManager.effectsManager.addEffect(omId, effect);

		hereIamTimeOut = setTimeout(function() {
			removeHearIam();
		},10000);

		function removeHearIam() {
			magoManager.objMarkerManager.setMarkerByCondition(function(om){
				return !om.hereIam;
			});
		}
	}

	function flyToGroup(longitude, latitude, altitude, duration) {
		if(longitude === null || longitude === '' || latitude === null || latitude === '' || altitude === null || altitude === '') {
			alert("위치 정보가 올바르지 않습니다. 확인하여 주십시오.");
			return;
		}
		gotoFlyAPI(MAGO3D_INSTANCE, parseFloat(longitude), parseFloat(latitude), parseFloat(altitude), parseFloat(duration));
	}

	// 데이터 정보 다이얼 로그
	var dataInfoDialog = $( "#dataInfoDialog" ).dialog({
		autoOpen: false,
		width: 500,
		height: 720,
		modal: true,
		overflow : "auto",
		resizable: false
	});

	//데이터 상세 정보 조회
	function detailDataInfo(url) {
		dataInfoDialog.dialog( "open" );
		$.ajax({
			url: url,
			type: "GET",
			headers: {"X-Requested-With": "XMLHttpRequest"},
			dataType: "json",
			success: function(msg){
				if(msg.statusCode <= 200) {
					dataInfoDialog.dialog( "option", "title", msg.dataInfo.dataName + " 상세 정보");

					var source = $("#templateDataInfo").html();
				    var template = Handlebars.compile(source);
				    var dataInfoHtml = template(msg.dataInfo);

				    $("#dataInfoDialog").html("");
	                $("#dataInfoDialog").append(dataInfoHtml);
				} else {
					alert(JS_MESSAGE[msg.errorCode]);
				}
			},
			error:function(request,status,error){
				alert(JS_MESSAGE["ajax.error.message"]);
			}
		});
	}

	// 데이터 속성 다이얼 로그
	var dataAttributeDialog = $( "#dataAttributeDialog" ).dialog({
		autoOpen: false,
		width: 600,
		height: 350,
		modal: true,
		resizable: false
	});

	// 데이터 속성
	function detailDataAttribute(dataId, dataName) {
		//jQuery('#id').css("display", "block");
		dataAttributeDialog.dialog( "open" );
		$("#dataNameForAttribute").html(dataName);

		$.ajax({
			url: "/datas/attributes/" + dataId,
			type: "GET",
			headers: {"X-Requested-With": "XMLHttpRequest"},
			dataType: "json",
			success: function(msg){
				if(msg.statusCode <= 200) {
					if(msg.dataAttribute !== null) {
						//$("#dataAttributeForOrigin").html(msg.dataAttribute.attributes);
						$("#dataAttributeViewer").html("");
						var jsonViewer = new JSONViewer();
						document.querySelector("#dataAttributeViewer").appendChild(jsonViewer.getContainer());
						jsonViewer.showJSON(JSON.parse(msg.dataAttribute.attributes), -1, -1);
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

	// 데이터 Object 속성 다이얼 로그
	var dataObjectAttributeDialog = $( "#dataObjectAttributeDialog" ).dialog({
		autoOpen: false,
		width: 800,
		height: 550,
		modal: true,
		resizable: false
	});

	// 데이터 Object 속성
	function detailDataObjectAttribute(dataId, dataName) {
		dataObjectAttributeDialog.dialog( "open" );
		$("#dataNameForObjectAttribute").html(dataName);

		$.ajax({
			url: "/datas/object/attributes/" + dataId,
			type: "GET",
			headers: {"X-Requested-With": "XMLHttpRequest"},
			dataType: "json",
			success: function(msg){
				if(msg.statusCode <= 200) {
					if(msg.dataObjectAttribute !== null) {
						//$("#dataObjectAttributeForOrigin").html(msg.dataObjectAttribute.attributes);
						$("#dataObjectAttributeViewer").html("");
						var jsonViewer = new JSONViewer();
						document.querySelector("#dataObjectAttributeViewer").appendChild(jsonViewer.getContainer());
						jsonViewer.showJSON(JSON.parse(msg.dataObjectAttribute.attributes), -1, -1);
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

	// 데이터 그룹 다이얼로그
	var dataGroupDialog = $( "#dataGroupDialog" ).dialog({
		autoOpen: false,
		width: 500,
		height: 620,
		modal: true,
		overflow : "auto",
		resizable: false
	});

	// 데이터 그룹 상세 정보 조회
	function detailDataGroup(url) {
		dataGroupDialog.dialog( "open" );
		$.ajax({
			url: url,
			type: "GET",
			headers: {"X-Requested-With": "XMLHttpRequest"},
			dataType: "json",
			success: function(msg){
				if(msg.statusCode <= 200) {
					dataGroupDialog.dialog( "option", "title", msg.dataGroup.dataGroupName + " 상세 정보");

					var source = $("#templateDataGroup").html();
				    var template = Handlebars.compile(source);
				    var dataGroupHtml = template(msg.dataGroup);

				    $("#dataGroupDialog").html("");
	                $("#dataGroupDialog").append(dataGroupHtml);
				} else {
					alert(JS_MESSAGE[msg.errorCode]);
				}
			},
			error:function(request,status,error){
				alert(JS_MESSAGE["ajax.error.message"]);
			}
		});
	}

	// 이슈 등록 버튼 클릭
	$("#issueButton").click(function() {
		$('#issueTitle,#issueContents').prop('readonly',false);
		$('#issueSaveButton').parent('.btns').show();
		issueDialog.dialog( "open" );
		issueDialog.dialog( "option", "title", "이슈 등록");
	});
	// 이슈 다이얼 로그
	var issueDialog = $( "#issueDialog" ).dialog({
		autoOpen: false,
		width: 500,
		height: 500,
		modal: true,
		overflow : "auto",
		resizable: false
	});

	// 이슈 상세 정보 조회
	function detailIssueInfo(issueId) {

		$.ajax({
			url: "/issues/" + issueId,
			type: "GET",
			headers: {"X-Requested-With": "XMLHttpRequest"},
			dataType: "json",
			success: function(msg){
				if(msg.statusCode <= 200) {
					issueDialog.dialog( "open" );
					issueDialog.dialog( "option", "title", "이슈 상세 정보");
					$('#issueSaveButton').parent('.btns').hide();

					$('#issueTitle,#issueContents').prop('readonly',true);

					var issue = msg.issue;
					$('#issueDataGroupName').text(issue.dataGroupName);
					$('#issueDataName').text(issue.dataKey);
					$('#issueLongitude').val(issue.longitude);
					$('#issueLatitude').val(issue.latitude);
					$('#issueAltitude').val(issue.altitude);
					$('#issueTitle').val(issue.title);
					$('#issueContents').val(issue.contents);
				} else {
					alert(JS_MESSAGE[msg.errorCode]);
				}
			},
			error:function(request,status,error){
				alert(JS_MESSAGE["ajax.error.message"]);
			}
		});
	}

	// 이슈 등록
	var insertIssueFlag = true;
	function insertIssue() {
		if (validate() == false) {
			return false;
		}
		if(insertIssueFlag) {
			insertIssueFlag = false;
			var lon = $("#issueLongitude").val();
			var lat = $("#issueLatitude").val();
			var alt = $("#issueAltitude").val();
			$.ajax({
				url: "/issues",
				type: "POST",
				headers: {"X-Requested-With": "XMLHttpRequest"},
				data: { "dataId" : $("#issueDataId").val(), "dataGroupId" : $("#issueDataGroupId").val(),
					"dataKey" : $("#issueDataKey").val(), "dataGroupName" : $("#issueDataGroupName").val(), "objectKey" : $("#issueObjectKey").val(),
					"longitude" : lon, "latitude" : lat, "altitude" : alt,
					"title" : $("#issueTitle").val(), "contents" : $("#issueContents").val()
				},
				success: function(msg){
					if(msg.statusCode <= 200) {
						alert(JS_MESSAGE["insert"]);
						insertIssueFlag = true;
						issueDialog.dialog('close');

						NDTP.issueController.addIssue({
							longitude : parseFloat(lon),
							latitude : parseFloat(lat),
							altitude : parseFloat(alt),
							issueId : msg.issueId
						});
						/* var magoManager = this.magoInstance.getMagoManager();
						if(Array.isArray(issue)) {
							for(var i in issue) {
								this.addIssue(issue[i]);
							}
						} else {
							var point = Mago3D.ManagerUtils.geographicCoordToWorldPoint(issue.longitude,issue.latitude,issue.altitude);
							option.positionWC = point;

							var objMarker = magoManager.objMarkerManager.newObjectMarker(option, magoManager);
							objMarker.issueId = issue.issueId;
						} */
					} else {
						alert(JS_MESSAGE[msg.errorCode]);
						console.log("---- " + msg.message);
					}
					insertIssueFlag = true;
				},
				error:function(request, status, error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        insertIssueFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}

	function validate() {
		if ($("#issueTitle").val() === "") {
			alert("제목을 입력하여 주십시오.");
			$("#issueTitle").focus();
			return false;
		}
		if ($("#issueContents").val() === "") {
			alert("내용을 입력하여 주십시오.");
			$("#issueContents").focus();
			return false;
		}
	}
	Date.prototype.format = function (f) {
		if (!this.valueOf()) return " ";

		var weekKorName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
		var weekKorShortName = ["일", "월", "화", "수", "목", "금", "토"];
		var weekEngName = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
		var weekEngShortName = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
		var d = this;

		return f.replace(/(yyyy|yy|MM|dd|KS|KL|ES|EL|HH|hh|mm|ss|a\/p)/gi, function ($1) {
			switch ($1) {
				case "yyyy": return d.getFullYear(); // 년 (4자리)
				case "yy": return (d.getFullYear() % 1000).zf(2); // 년 (2자리)
				case "MM": return (d.getMonth() + 1).zf(2); // 월 (2자리)
				case "dd": return d.getDate().zf(2); // 일 (2자리)
				case "KS": return weekKorShortName[d.getDay()]; // 요일 (짧은 한글)
				case "KL": return weekKorName[d.getDay()]; // 요일 (긴 한글)
				case "ES": return weekEngShortName[d.getDay()]; // 요일 (짧은 영어)
				case "EL": return weekEngName[d.getDay()]; // 요일 (긴 영어)
				case "HH": return d.getHours().zf(2); // 시간 (24시간 기준, 2자리)
				case "hh": return ((h = d.getHours() % 12) ? h : 12).zf(2); // 시간 (12시간 기준, 2자리)
				case "mm": return d.getMinutes().zf(2); // 분 (2자리)
				case "ss": return d.getSeconds().zf(2); // 초 (2자리)
				case "a/p": return d.getHours() < 12 ? "오전" : "오후"; // 오전/오후 구분
				default: return $1;
			}
		});
	};

	String.prototype.string = function (len) { var s = '', i = 0; while (i++ < len) { s += this; } return s; };
	String.prototype.zf = function (len) { return "0".string(len - this.length) + this; };
	Number.prototype.zf = function (len) { return this.toString().zf(len); };
</script>
<%@ include file="/WEB-INF/views/notification/notification.jsp" %>
</body>
</html>
