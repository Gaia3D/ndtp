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
	<title>데이터 목록 | NDTP</title>
	<link rel="shortcut icon" href="/images/favicon.ico">
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
			z-index:100;
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
			<div id="searchContent" class="contents yScroll fullHeight" style="display:none;">
				<%@ include file="/WEB-INF/views/search/district.jsp" %>
			</div>
			<div id="dataContent" class="contents-margin-default fullHeight">
				<div class="tabs">
					<ul id="dataInfoTab" class="tab tab-divide">
						<li data-nav="dataGroupInfoContent">데이터 그룹</li>
						<li data-nav="dataInfoContent" class="on">데이터 목록</li>
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
			<div id="civilVoiceContent" class="yScroll" style="display:none;">
				<%@ include file="/WEB-INF/views/civil-voice/list.jsp" %>
			</div>

			<div id="layerContent" class="contents fullHeight" style="display:none;">
				<%@ include file="/WEB-INF/views/layer/list.jsp" %>
			</div>

			<div id="userPolicyContent" class="contents" style="display:none;">
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
		<div class="sliderWrap">
			<input id="rangeInput"/>
		</div>
	</div>
	<!-- E: MAP -->
</div>
<!-- E: WRAP -->

<%@ include file="/WEB-INF/views/data/data-dialog.jsp" %>
<%@ include file="/WEB-INF/views/data/map-data-template.jsp" %>
<%@ include file="/WEB-INF/views/data/map-data-group-template.jsp" %>

<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script type="text/javascript" src="/externlib/handlebars-4.1.2/handlebars.js"></script>
<script type="text/javascript" src="/js/${lang}/handlebarsHelper.js"></script>
<script type="text/javascript" src="/externlib/cesium/Cesium.js"></script>
<script type="text/javascript" src="/externlib/geostats/geostats.js"></script>
<script type="text/javascript" src="/externlib/chartjs/Chart.min.js"></script>
<script type="text/javascript" src="/externlib/kotSlider/range.js"></script>
<script type="text/javascript" src="/externlib/decodeTextAlternative/encoding-indexes.js"></script>
<script type="text/javascript" src="/externlib/decodeTextAlternative/encoding.js"></script>
<script type="text/javascript" src="/externlib/moment-2.22.2/moment-with-locales.min.js"></script>
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
<script type="text/javascript" src="/js/${lang}/map-data-controll.js"></script>
<script type="text/javascript" src="/js/${lang}/civil-voice.js"></script>
<script type="text/javascript">
	// 임시로...
	$(document).ready(function() {
		$(".ui-slider-handle").slider({});
 		initDataGroupList();
	});

	//Cesium.Ion.defaultAccessToken = '';
	//var viewer = new Cesium.Viewer('magoContainer');
	var MAGO3D_INSTANCE;
	// ndtp 전역 네임스페이스
	var NDTP = NDTP ||{
		policy : ${geoPolicyJson},
		baseLayers : "${baseLayers}",
		wmsProvider : {},
		districtProvider : {}
	};
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

	function magoLoadEnd(e) {
		var magoInstance = e;
		var geoPolicyJson = ${geoPolicyJson};
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
        DistrictControll(magoInstance);

        dataGroupList();

        Simulation(magoInstance);
        // 환경 설정.
        UserPolicy(magoInstance);
        // 기본 레이어 랜더링
        setTimeout(function(){
        	initLayer(magoInstance, NDTP.baseLayers);
        }, geoPolicyJson.initDuration * 1000);

		//지도상에 데이터 다루는거
		MapDataControll(magoInstance);
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
		for(var i=0; i<dataGroupArrayLength; i++) {
			var dataGroup = dataGroupArray[i];
			var f4dController = MAGO3D_INSTANCE.getF4dController();
			$.ajax({
				url: "/datas/" + dataGroup.dataGroupId + "/list",
				type: "GET",
				headers: {"X-Requested-With": "XMLHttpRequest"},
				dataType: "json",
				success: function(msg){
					if(msg.statusCode <= 200) {
						var dataInfoList = msg.dataInfoList;
						if(dataInfoList != null && dataInfoList.length > 0) {
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

	function flyTo(dataGroupId, dataKey) {
		if(dataGroupId === null || dataGroupId === '' || dataKey === null || dataKey === '') {
			alert("위치 정보가 올바르지 않습니다. 확인하여 주십시오.");
			return;
		}

		//  searchDataAPI
		 searchDataAPI(MAGO3D_INSTANCE, dataGroupId, dataKey);
	}

	function flyToGroup(longitude, latitude, altitude, duration) {
		if(longitude === null || longitude === '' || latitude === null || latitude === '' || altitude === null || altitude === '') {
			alert("위치 정보가 올바르지 않습니다. 확인하여 주십시오.");
			return;
		}
		gotoFlyAPI(MAGO3D_INSTANCE, parseFloat(longitude), parseFloat(latitude), parseFloat(altitude), parseFloat(duration));
	}

	var dataInfoDialog = $( "#dataInfoDialog" ).dialog({
		autoOpen: false,
		width: 500,
		height: 700,
		modal: true,
		overflow : "auto",
		resizable: false
	});

	// 데이터 상세 정보 조회
	function detailDataInfo(dataId) {
		dataInfoDialog.dialog( "open" );
		$.ajax({
			url: "/datas/" + dataId,
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

	// 데이터 검색 버튼 클릭
	$("#mapDataSearch").click(function() {
		mapDataInfoList(1, $("#searchDataName").val(), $("#searchDataStatus").val(), $("#searchDataType").val());
	});

	// 데이터 검색 페이징에서 호출됨
	function pagingDataInfoList(pageNo, searchParameters) {
		// searchParameters=&searchWord=dataName&searchOption=&searchValue=%ED%95%9C%EA%B8%80&startDate=&endDate=&orderWord=&orderValue=&status=&dataType=
		var dataName = null;
		var status = null;
		var dataType = null;
		var parameters = searchParameters.split("&");
		for(var i=0; i<parameters.length; i++) {
			if(i == 3) {
				var tempDataName = parameters[3].split("=");
				dataName = tempDataName[1];
			} else if(i == 8) {
				var tempDataStatus = parameters[8].split("=");
				status = tempDataStatus[1];
			} else if(i == 9) {
				var tempDataType = parameters[9].split("=");
				dataType = tempDataType[1];
			}
		}

		mapDataInfoList(pageNo, dataName, status, dataType);
	}

	// 데이터 검색
	var dataSearchFlag = true;
	function mapDataInfoList(pageNo, searchDataName, searchStatus, searchDataType) {
		// searchOption : 1 like

		//searchDataName
		if(dataSearchFlag) {
			dataSearchFlag = false;
			//var formData =$("#searchDataForm").serialize();

			$.ajax({
				url: "/datas",
				type: "GET",
				data: { pageNo : pageNo, searchWord : "data_name", searchValue : searchDataName, searchOption : "1", status : searchStatus, dataType : searchDataType},
				dataType: "json",
				headers: {"X-Requested-With": "XMLHttpRequest"},
				success: function(msg){
					if(msg.statusCode <= 200) {
						$("#dataInfoListArea").html("");

						var source = $("#templateDataList").html();
		                //핸들바 템플릿 컴파일
		                var template = Handlebars.compile(source);

		               	//핸들바 템플릿에 데이터를 바인딩해서 HTML 생성
		                var dataInfoListHtml = template(msg);
		                $("#dataInfoListArea").html("");
		                $("#dataInfoListArea").append(dataInfoListHtml);
					} else {
						alert(JS_MESSAGE[msg.errorCode]);
					}
					dataSearchFlag = true;
				},
				error:function(request,status,error){
					alert(JS_MESSAGE["ajax.error.message"]);
					dataSearchFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}

	// 데이터 그룹 목록 초기화
	function initDataGroupList() {
		mapDataGroupList(1, null);
	}

	// 데이터 그룹 검색 버튼 클릭
	$("#mapDataGroupSearch").click(function() {
		mapDataGroupList(1, $("#searchDataGroupName").val());
	});

	$("#searchDataGroupName").keyup(function(e) {
		if(e.keyCode == 13) mapDataGroupList(1, $("#searchDataGroupName").val());
	});

	// 데이터 그룹 검색 페이징에서 호출됨
	function pagingDataGroupList(pageNo, searchParameters) {
		// searchParameters=&searchWord=dataName&searchOption=&searchValue=%ED%95%9C%EA%B8%80&startDate=&endDate=&orderWord=&orderValue=&status=&dataType=
		var dataGroupName = null;
		var parameters = searchParameters.split("&");
		for(var i=0; i<parameters.length; i++) {
			if(i == 3) {
				var tempDataName = parameters[3].split("=");
				dataGroupName = tempDataName[1];
			}
		}

		mapDataGroupList(pageNo, dataGroupName);
	}

	// 데이터 그룹 검색
	var dataGroupSearchFlag = true;
	function mapDataGroupList(pageNo, searchDataGroupName) {
		// searchOption : 1 like

		//searchDataName
		if(dataGroupSearchFlag) {
			dataGroupSearchFlag = false;
			//var formData =$("#searchDataForm").serialize();

			$.ajax({
				url: "/data-groups",
				type: "GET",
				data: { pageNo : pageNo, searchWord : "data_group_name", searchValue : searchDataGroupName, searchOption : "1"},
				dataType: "json",
				headers: {"X-Requested-With": "XMLHttpRequest"},
				success: function(msg){
					if(msg.statusCode <= 200) {
						$("#dataGroupListArea").html("");

						var source = $("#templateDataGroupList").html();
		                //핸들바 템플릿 컴파일
		                var template = Handlebars.compile(source);

		                //핸들바 템플릿에 데이터를 바인딩해서 HTML 생성
		                var dataGroupListHtml = template(msg);
		                $("#dataGroupListArea").html("");
		                $("#dataGroupListArea").append(dataGroupListHtml);
					} else {
						alert(JS_MESSAGE[msg.errorCode]);
					}
					dataGroupSearchFlag = true;
				},
				error:function(request,status,error){
					alert(JS_MESSAGE["ajax.error.message"]);
					dataGroupSearchFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
</script>
</body>
</html>
