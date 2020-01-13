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
    </style>
</head>
<body>

<%@ include file="/WEB-INF/views/layouts/header.jsp" %>

<div id="wrap">
	<!-- S: NAVWRAP -->
	<div class="navWrap">
	 	<%@ include file="/WEB-INF/views/layouts/menu.jsp" %> 
		
		<!-- E: NAVWRAP -->	
		
		<div id="contentsWrap" class="contentsWrap" style="display: block;">
			
			<div id="dataContent" class="contents">
				dataContent
			</div>
			<div id="convertContent" class="contents" style="display:none;">
				convertContent
			</div>
			<div id="spatialContent" class="contents" style="display:none;">
				spatialContent
			</div>
			<div id="simulationContent" class="contents" style="display:none;">
				simulationContent
			</div>
			<div id="joininContent" class="contents" style="display:none;">
				joininContent
			</div>
			<div id="setupContent" class="contents" style="display:none;">
				setupContent
			</div>
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
	</div>
	<!-- E: MAP -->
</div>
<!-- E: WRAP -->

<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script type="text/javascript" src="/externlib/cesium/Cesium.js"></script>
<script type="text/javascript" src="/js/mago3d.js"></script>
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript" src="/js/${lang}/MapControll.js"></script>
<script type="text/javascript" src="/js/${lang}/uiControll.js"></script>
<script type="text/javascript">
	//Cesium.Ion.defaultAccessToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiIyNmNjOWZkOC03NjdlLTRiZTktYWQ3NS1hNmQ0YjA1ZjIzYWEiLCJpZCI6Mzk5Miwic2NvcGVzIjpbImFzciIsImdjIl0sImlhdCI6MTU0NDYwNDQ3M30.AwvoVAuMRwjcMMJ9lEG2v4CPUp8gfltJqZARHgxGv_k';
	//var viewer = new Cesium.Viewer('magoContainer');
	var MAGO3D_INSTANCE;
	magoInit();

	
	function magoInit() {
		$.ajax({
			url: "/js/temp/geopolicy.json",
			type: "GET",
			dataType: "json",
			success: function(serverPolicy){
				//cesium Ion token 할당.
				serverPolicy.cesiumIonToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiIyNmNjOWZkOC03NjdlLTRiZTktYWQ3NS1hNmQ0YjA1ZjIzYWEiLCJpZCI6Mzk5Miwic2NvcGVzIjpbImFzciIsImdjIl0sImlhdCI6MTU0NDYwNDQ3M30.AwvoVAuMRwjcMMJ9lEG2v4CPUp8gfltJqZARHgxGv_k';

				var cesiumViewerOption = {};
 				cesiumViewerOption.infoBox = false;
 				cesiumViewerOption.navigationHelpButton = false;
 				cesiumViewerOption.scene3DOnly = true;
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
				MAGO3D_INSTANCE = new Mago3D.Mago3d('magoContainer', serverPolicy, {loadend : magoLoadEnd}, cesiumViewerOption);
			},
			error: function(e){
				alert(e.responseText);
			}
		});
	}

	function magoLoadEnd(e) {
		var magoInstance = e;

		// TODO : 세슘 MAP 선택 UI 제거,엔진에서 처리로 변경 예정.
		
		var viewer = magoInstance.getViewer(); 
		var magoManager = magoInstance.getMagoManager();
		var f4dController = magoInstance.getF4dController();

		viewer.baseLayerPicker.destroy();
		
		magoManager.on(Mago3D.MagoManager.EVENT_TYPE.CLICK, function(result) {
			console.info(result);
		});

		//우측 상단 지도 컨트롤러
		MapControll(viewer);
	}
	
	// 상세 메뉴 닫기
	$('button#closeLeftBtn').click(function() {
		//$('ul.nav li[data-nav]').removeClass('on');
		
		$('#contentsWrap').hide();
		//$('#closeLeftBtn').toggle();
	});
</script>
</body>
</html>
