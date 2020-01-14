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
		.ctrlWrap div.zoom button, .ctrlWrap div.rotate button  {
			width:47px;
			height:47px;
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
		
		<div id="contentsWrap" class="contentsWrap" style="display: none;">
			<div id="dataContent" class="contents fullHeight">
				<!-- 데이터 그룹 -->
				<h3>데이터 그룹</h3>
				<ul class="dataGroupSum">
					<li class="total">
						<label>전체</label>
						<span>112</span>
					</li>
					<li>
						<label>공공</label>
						<span>51</span>
					</li>
					<li>
						<label>공개</label>
						<span>235</span>
					</li>
					<li>
						<label>개인</label>
						<span>32</span>
					</li>
					<li>
						<label>그룹</label>
						<span>1</span>
					</li>
				</ul>
				
				<!-- 데이터 검색 -->
				<div class="listSearch">
					<input type="text" placeholder="그룹명을 입력하세요">
					<button type="button" title="검색">검색</button>
				</div>
				
				<!-- 데이터 목록 -->
				<!-- 
				<h3>데이터 목록</h3>
				-->
				<h3><span>세종</span> 검색결과</h3>
				<div class="bothSide">
					<div>
						전체
						<span>55</span>
						/ <span>23</span>건
					</div>
					<div class="dataBtns">
						<button type="button" title="초기화">초기화</button>
						<button type="button" title="그룹" class="on">그룹</button>
						<button type="button" title="데이터">데이터</button>
					</div>
				</div>
				<div class="tableList">
					<table>
						<thead>
							<tr>
								<th>그룹명</th>
								<th>공유타입</th>
								<th>데이터건수</th>
								<th>바로가기</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>세종</td>
								<td>공용</td>
								<td><a href="">200</a></td>
								<td><button type="button" title="바로가기" class="goto">바로가기</button></td>
							</tr>
							<tr>
								<td>세종</td>
								<td>공용</td>
								<td><a href="">200</a></td>
								<td><button type="button" title="바로가기" class="goto">바로가기</button></td>
							</tr>
							<tr>
								<td>세종</td>
								<td>공용</td>
								<td><a href="">200</a></td>
								<td><button type="button" title="바로가기" class="goto">바로가기</button></td>
							</tr>
						</tbody>
					</table>
				</div>
				
				<ul class="pagination">
					<li class="ico first" title="맨앞으로">처음</li>
					<li class="ico forward" title="앞으로">앞으로</li>
					<li>1</li>
					<li>2</li>
					<li>3</li>
					<li class="on">4</li>
					<li>5</li>
					<li>6</li>
					<li class="ico back" title="뒤로">뒤로</li>
					<li class="ico end" title="맨뒤로">마지막</li>
				</ul>
			</div>
			<!-- E: 데이터 -->
			
			<div id="spatialContent" class="contentsList yScroll" style="display:none;height: 798px;background-color: #fff;">
				<%@ include file="/WEB-INF/views/spatial/spatial.jsp" %> 
			</div>
			<div id="simulationContent" class="contentsList yScroll" style="display:none;">
				<%@ include file="/WEB-INF/views/simulation/simulation.jsp" %>
			</div>
			<div id="joininContent" class="contents" style="display:none;">
				<%@ include file="/WEB-INF/views/joinin/joinin.jsp" %>
			</div>
			<div id="setupContent" class="contents" style="display:none;">
				<%@ include file="/WEB-INF/views/setup/setup.jsp" %>
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
	</div>
	<!-- E: MAP -->
</div>
<!-- E: WRAP -->

<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script type="text/javascript" src="/externlib/cesium/Cesium.js"></script>
<script type="text/javascript" src="/js/mago3d.js"></script>
<script type="text/javascript" src="/js/mago3d_lx.js"></script>
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript" src="/js/${lang}/MapControll.js"></script>
<script type="text/javascript" src="/js/${lang}/uiControll.js"></script>
<script type="text/javascript" src="/js/${lang}/SpatialAnalysis.js"></script>
<script type="text/javascript">
	// 임시로...
	$(document).ready(function() {
		$(".ui-slider-handle").slider({});
		var activeContent = "${activeContent}";
		if(activeContent !== undefined && activeContent !== null && activeContent !== "") {
			$(".${activeContent}").click();			
		}
	});
	
	//Cesium.Ion.defaultAccessToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiIyNmNjOWZkOC03NjdlLTRiZTktYWQ3NS1hNmQ0YjA1ZjIzYWEiLCJpZCI6Mzk5Miwic2NvcGVzIjpbImFzciIsImdjIl0sImlhdCI6MTU0NDYwNDQ3M30.AwvoVAuMRwjcMMJ9lEG2v4CPUp8gfltJqZARHgxGv_k';
	//var viewer = new Cesium.Viewer('magoContainer');
	var MAGO3D_INSTANCE;
	magoInit();
	
	dataGroupList();

	
	function magoInit() {
		var geoPolicyJson = ${geoPolicyJson};
		
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
		MAGO3D_INSTANCE = new Mago3D.Mago3d('magoContainer', geoPolicyJson, {loadend : magoLoadEnd}, cesiumViewerOption);

	}

	function magoLoadEnd(e) {
		var magoInstance = e;
		
		var viewer = magoInstance.getViewer(); 
		var magoManager = magoInstance.getMagoManager();
		var f4dController = magoInstance.getF4dController();

		// TODO : 세슘 MAP 선택 UI 제거,엔진에서 처리로 변경 예정.
		viewer.baseLayerPicker.destroy();
		
		/* magoManager.on(Mago3D.MagoManager.EVENT_TYPE.CLICK, function(result) {
			console.info(result);
		}); */

		//우측 상단 지도 컨트롤러
		MapControll(viewer);
		//공간분석 기능 수행
		SpatialAnalysis(magoInstance);
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
		for(var i=0; i<dataGroupArray.length; i++) {
			var dataGroup = dataGroupArray[i];
			$.ajax({
				url: "/datas",
				data: { "dataGroupId" : dataGroup.dataGroupId },
				type: "GET",
				headers: {"X-Requested-With": "XMLHttpRequest"},
				dataType: "json",
				success: function(msg){
					if(msg.statusCode <= 200) {
						var dataInfoList = msg.dataInfoList;
						
						dataGroup.datas = dataInfoList;
						dataArray.push(dataGroup);
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
</script>
</body>
</html>
