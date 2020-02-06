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
    <link rel="stylesheet" href="/css/${lang}/user-style.css" />
	<style type="text/css">
		/* MAP / CTRLBTNS */
		.mapToollWrap {
			position: absolute;
			top: 3px;
			right: 3px;
		}
		.mapToollWrap div {
			display: inline-block;
			color: #fff;
			border-radius: 25px;
			background-color: #252535;
		}
		.mapToollWrap div > button {
			border: none;
			border-radius: 25px;
			background-color: transparent;
			background-image: url(/images/ko/ico.png);
			background-repeat: no-repeat;
		}
		.mapToollWrap div button:hover {
			background-color: #333446;
		}
		.mapToollWrap div.zoom button {
			width: 50px;
			height: 50px;
			text-indent: -999em;
		}
		.mapToollWrap div.rotate button {
			width: 50px;
			height: 50px;
			text-indent: -999em;
		}
		.mapToollWrap div > button.reset {
			background-position: 15px 0;
		}
		.mapToollWrap div > button.zoomall {
			background-position: -35px 0;
		}
		.mapToollWrap div > button.zoomin {
			background-position: -85px 0;
		}
		.mapToollWrap div > button.zoomout {
			background-position: -135px 0;
		}
		.mapToollWrap div > button.distance {
			background-position: -185px 0;
		}
		.mapToollWrap div > button.distance.on {
			background-position: -185px -50px;
			background-color: #fff600;
		}
		.mapToollWrap div > button.area {
			background-position: -242px 0;
		}
		.mapToollWrap div > button.area.on {
			background-position: -242px -50px;
			background-color: #fff600;
		}
		.mapToollWrap div > button.rotateReset {
			background-position: -285px 0;
		}
		.mapToollWrap div > button.rotateReset.on {
			background-color: #fff600;
			background-position: -285px -50px;
		}
		.mapToollWrap div > button.rotateLeft {
			background-position: -340px 0;
		}
		.mapToollWrap div > button.rotateRight {
			background-position: -390px 0;
		}
		.mapToollWrap div > button.magoSet {
			background-position: -85px -52px;
		}
		.mapToollWrap div > button.magoSet.on {
			background-position: -85px -102px;
		}
		.mapToollWrap div > input {
			width: 30px;
			margin-top: 3px;
			padding: 8px;
			font-size: 17px;
			color: #fff;
			text-align: center;
			border: none;
			border-bottom: 2px solid #fff;
			background-color: transparent;
		}
		
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
		
		#magoTool {
			width: 110px;
			height: 50px;
			padding-left: 25px;
			color: #fff;
			background-color:#ff8d00;
			font-size: 16px;
			font-weight: bold;
			letter-spacing: -1px;
			border-radius: 25px;
			/* background-position: -451px -588px; */
		}
		#magoTool.on {
			color: #000;
			background-color: #fff600;
			border: 1px solid #333446;
		}
		
		.labelLayer {
			position: absolute;
			top:60px;
			right: 5px;
			
			min-height: 333px;
			min-width: 200px;
			border-radius: 5px;
			box-shadow: 1px 1px 2px 0 #333;
			background-color: #fff;
			z-index:1;
		}
		.labelLayer > .layerHeader {
			height: 35px;
			padding: 5px 5px 0px 15px;
			cursor: pointer;
			border-radius: 5px 5px 0 0;
			border-bottom: 1px solid #e0e0e0;
			background-color: #f1f1f1;
		}
		.labelLayer > .layerContents {
			margin: 15px 20px;
		}
		.layerHeader > h3 {
			margin-top:5px;	
		}
		.layerClose {
			position: absolute;
			top: 3px;
			right: 5px;
			width: 30px;
			height: 30px;
			border: none;
			text-indent: -999em;
			background-image: url(/images/ko/ico.png);
			background-position: -10px 792px;
		}
		.labelLayer div.layerContents > ul.category {
			list-style: circle;
			margin-bottom: 10px;
			margin-left: 10px;
			margin-top: 10px;
		}
		
		/* 레이어 스타일 추가 */
		.geometryControl {
			margin-bottom: 20px;
		}
		.geometryControl li {
			margin-bottom: 2px;
		}
		.geometryControl li * {
			vertical-align: middle;
		}
		.geometryControl label {
			display: inline-block;
			width: 70px;
		}
		.geometryControl input  {
			padding: 3px;
		}
		.geometryControl li > button:not(.btnTextF):not(.btnText) {
			width: 30px;
			height: 30px;
			text-indent: -999em;
			border: 1px solid #ccc;
			background-image: url(/images/ko/ico.png);
			background-repeat: no-repeat;
			background-color: #fff;
		}
		
		button.up {
			background-position: -112px -195px;
		}
		button.down {
			background-position: -162px -195px;
		}
		button.rangePrev {
			background-position: -212px -193px;
		}
		button.rangeNext {
			background-position: -262px -193px;
		}
		.geometryControl li > button:active {
			border: 1px solid #287be4;
			background-color: #ccc;
		}
		button.up:active {
			background-position: -112px -245px;
		}
		button.down:active {
			background-position: -162px -245px;
		}
		button.rangePrev:active {
			background-position: -212px -243px;
		}
		button.rangeNext:active {
			background-position: -262px -243px;
		}
		.geometryControl li > button:hover {
			border: 1px solid #287be4;
			background-color: #eee;
		}
		button.up:hover {
			background-position: -112px -245px;
		}
		button.down:hover {
			background-position: -162px -245px;
		}
		button.rangePrev:hover {
			background-position: -212px -243px;
		}
		button.rangeNext:hover {
			background-position: -262px -243px;
		}
		.ellipsis {
			overflow:hidden;
			white-space: nowrap;
			text-overflow: ellipsis; 
		}
    </style>
 </head>
<body>
	<div class="mapToollWrap" style="z-index: 9999">
		<div class="zoom">
			<button type="button" id="mapCtrlReset" class="reset" title="초기화">초기화</button>
			<button type="button" class="zoomall" title="전체보기">전체보기</button>
			<button type="button" id="mapCtrlZoomIn" class="zoomin" title="확대">확대</button>
			<button type="button" id="mapCtrlZoomOut" class="zoomout" title="축소">축소</button>
			<button type="button" id="mapCtrlDistance" class="measures distance" data-type="LineString" title="거리">거리</button>
			<button type="button" id="mapCtrlArea" class="measures area" data-type="Polygon" title="면적">면적</button>
			<button type="button" id="mapCapture" class="" data-type="" title="화면캡처">캡처</button>
		</div>
		<div class="rotate"> 
			<button type="button" id="rotateReset" class="rotateReset on" title="방향초기화">방향 초기화</button>
			<!-- <input type="text" placeholder="0" id="rotateInput"/>&deg; --> 
			<input type="text" id="rotateInput" placeholder="0" readonly>&deg;
	        <input type="text" id="pitchInput" placeholder="-90" readonly>&deg;
			<button type="button" id="rotateLeft" class="rotateLeft" title="왼쪽으로 회전">왼쪽으로 회전</button>
			<button type="button" id="rotateRight" class="rotateRight" title="오른쪽으로 회전">오른쪽으로 회전</button>
	<!-- 		<button type="button" class="mapPolicy" id="mapPolicy" title="지도 설정">지도 설정</button> -->
		</div>
		<div>
			<button type="button" id="magoTool" class="magoSet" title="Mago3D 설정">Mago3D</button>
		</div>
	</div>
	<div class="labelLayer" style="display:none;">
	    <div class="layerHeader">
	        <h3>Mago3D 설정</h3>
	        <button type="button" class="layerClose" title="닫기">닫기</button>
	    </div>
	    <div class="layerContents">
	    	<!-- <ul class="category">
	    		<li>객체정보</li>
	    	</ul>
				<input type="radio" id="datainfoDisplayY" name="datainfoDisplay" value="true"/>
				<label for="datainfoDisplayY">표시</label>
				<input type="radio" id="datainfoDisplayN" name="datainfoDisplay" value="false" checked/>
				<label for="datainfoDisplayN">비표시</label> -->
			<ul class="category">
	    		<li>Origin
	    			<ul>
	    				<li style="margin-top: 4px;">
							<input type="radio" id="originDisplayY" name="originDisplay" value="true"/>
							<label for="originDisplayY">표시</label>&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="radio" id="originDisplayN" name="originDisplay" value="false" checked/>
							<label for="originDisplayN">비표시</label>
						</li>    			
	    			</ul>
	    		</li>
	    	</ul>
			<ul class="category">
	    		<li>Bounding Box
	    			<ul>
	    				<li style="margin-top: 4px;">
	    					<input type="radio" id="bboxDisplayY" name="bboxDisplay" value="true"/>
							<label for="bboxDisplayY">표시</label>&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="radio" id="bboxDisplayN" name="bboxDisplay" value="false" checked/>
							<label for="bboxDisplayN">비표시</label>
	    				</li>
	    			</ul>
	    		</li>
	    	</ul>
			<ul class="category">
	    		<li>선택 및 이동
	    			<ul>
	    				<li style="margin-top: 4px;">
	    					<input type="radio" id="objectNoneMove" name="objectMoveMode" value="2"/>
							<label for="objectNoneMove">None</label>&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="radio" id="objectAllMove" name="objectMoveMode" value="0" checked />
							<label for="objectAllMove">All</label>&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="radio" id="objectMove" name="objectMoveMode" value="1"/>
							<label for="objectMove">Object</label>
	    				</li>
	    			</ul>
	    		</li>
	    	</ul>
	    	<ul class="category">
	    		<li>색상 변경
	    			<ul>
	    				<li style="margin-top: 4px;">
	    					<label for="dcColorPicker">색상</label>
							<input type="color" id="dcColorPicker">
							<input type="text" id="dcColorInput" value="#000000" size="6" readonly style="color: rgb(0, 0, 0);">
							<button type="button" id="dcColorApply" class="btnTextF">적용</button>
							<button type="button" id="dcColorCancle" class="btnText">되돌리기</button>
	    				</li>
	    			</ul>
	    		</li>
	    	</ul>
	    	<ul class="category">
	    		<li>위치 변경
	    			<ul class="geometryControl">
	    				<li style="margin-top: 4px;">
			    			<label for="longitude">경도</label>
			    			<input type="text" id="longitude" name="longitutde" value="${dataInfo.longitude }">
			    		</li>
			    		<li>
			    			<label for="latitude">위도</label>
			    			<input type="text" id="latitude" name="latitude" value="${dataInfo.latitude }">
			    		</li>
			    		<li>
			    			<label for="altitude">높이</label>
			    			<input type="text" id="altitude" name="altitude" value="${dataInfo.altitude }" size="15">
			    			<button id="dcAltUp" data-type="up" type="button" class="up"></button>
							<button id="dcAltDown" data-type="down" type="button" class="down"></button>
							<label for="dcAltitude" style="width: 37px;">offset</label>
							<input type="text" id="dcAltitudeOffset" value="1" size="1">
			    		</li>
	    			</ul>
	    		</li>
	    	</ul>				
			<ul class="category">
	    		<li>회전 변경
	    			<ul class="geometryControl">
	    				<li style="margin-top: 4px;">
			    			<label for="dcPitch">x(pitch)</label>
							<input type="text" id="dcPitch" name="pitch" size="2" readonly>
							<button type="button" class="dcRangeBtn rangePrev" data-type="prev" id="rcPitchPrev"></button>
							<input id="dcPitchRange" data-type="Pitch" style="margin-left: 5px; width: 150px;" type="range" min="-360" max="360" step="1" value="1">
							<button type="button" class="dcRangeBtn rangeNext" data-type="next" id="rcPitchNext"></button>
			    		</li>
			    		<li>
			    			<label for="dcRoll">y(roll)</label>
							<input type="text" id="dcRoll" name="roll" size="2" readonly>
							<button type="button" class="dcRangeBtn rangePrev" data-type="prev" id="rcRollPrev"></button>
							<input id="dcRollRange" data-type="Roll" style="margin-left: 5px; width: 150px;" type="range" min="-360" max="360" step="1" value="1">
							<button type="button" class="dcRangeBtn rangeNext" data-type="next" id="rcRollNext"></button>
			    		</li>
			    		<li>
			    			<label for="dcHeading">z(heading)</label>
							<input type="text" id="dcHeading" name="heading" size="2" readonly>
							<button type="button" class="dcRangeBtn rangePrev" data-type="prev" id="rcHeadingPrev"></button>
							<input id="dcHeadingRange" data-type="Heading" style="margin-left: 5px; width: 150px;" type="range" min="-360" max="360" step="1" value="1">
							<button type="button" class="dcRangeBtn rangeNext" data-type="next" id="rcHeadingNext"></button>
			    		</li>
	    			</ul>
	    		</li>
	    	</ul>				
		
	<c:if test="${referrer eq 'MODIFY' }">	
			<ul>
				<li style="text-align: center;">
					<button id="applyLocationButton" style="height: 30px; width: 120px;">위치 정보 적용</button>
				</li>
			</ul>
	</c:if>
	    </div>
	</div>
	
    <div id="magoContainer" style="height: 100%;"></div>
    
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
<%-- <script type="text/javascript" src="/js/${lang}/layer.js"></script> --%>
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
     	
		//선택된 데이터 이동 시 결과 리턴
	    magoManager.on(Mago3D.MagoManager.EVENT_TYPE.SELECTEDF4DMOVED, function(result) {
	    	//console.info(result);
	    	var longitude = result.result.longitude;
			var latitude = result.result.latitude;
			var altitude = result.result.altitude;
			
			$("#longitude").val(longitude);
			$("#latitude").val(latitude);
			$("#altitude").val(altitude);
	    });
	
	    // 기본 레이어 랜더링
		setTimeout(function(){
        	initLayer('${baseLayers}');
        }, geoPolicyJson.initDuration * 1000);
		
		/* setTimeout(function(){
			changeObjectMove();
        }, 5000); */
        
		//지도상에 데이터 다루는거
		MapDataControll(magoInstance);
		
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
		dataInfoList.push(dataInfoJson);
		
		//var dataInfoList = msg.dataInfoList;
		var dataInfoFirst = dataInfoJson;
		var dataInfoGroupId = dataInfoFirst.dataGroupId;
			
		dataGroup.datas = dataInfoList;
		f4dController.addF4dGroup(dataGroup);

		magoInstance.getMagoManager().on(Mago3D.MagoManager.EVENT_TYPE.F4DLOADEND,function(e){
			flyTo(magoInstance);
		});
		
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
	
	$("#magoTool").click(function(){
		$("#magoTool").addClass("on");
		$(".labelLayer").show();
	});
	$(".layerClose").click(function(){
		$("#magoTool").removeClass("on");
		$(".labelLayer").hide();
	});
	
	// 위치 정보 적용 버튼 클릭
	$("#applyLocationButton").click(function(){
		$(opener.document).find("#longitude").val($("#longitude").val());
		$(opener.document).find("#latitude").val($("#latitude").val());
		$(opener.document).find("#altitude").val($("#altitude").val());
		window.close();
	});
</script>
</html>