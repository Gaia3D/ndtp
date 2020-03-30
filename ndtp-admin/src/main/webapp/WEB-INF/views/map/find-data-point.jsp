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
	<link rel="stylesheet" href="/externlib/kotSlider/range.css?cacheVersion=${contentCacheVersion}" />
    <link rel="stylesheet" href="/css/${lang}/map-style.css?cacheVersion=${contentCacheVersion}" />
    <link rel="stylesheet" href="/externlib/css-toggle-switch/toggle-switch.css?cacheVersion=${contentCacheVersion}" />
    <style type="text/css">
    .ctrlWrap {
	    z-index: 10000;
	}
    </style>
 </head>
<body>
	<div class="ctrlWrap">
		<div class="zoom">
			<button type="button" id="mapCtrlReset" class="reset" title="초기화">초기화</button>
			<button type="button" id="mapCtrlAll" class="zoomall" title="전체보기">전체보기</button>
			<button type="button" id="mapCtrlZoomIn" class="zoomin" title="확대">확대</button>
			<button type="button" id="mapCtrlZoomOut" class="zoomout" title="축소">축소</button>
			<button type="button" id="mapCtrlDistance" class="measures distance" data-type="LineString" title="거리">거리</button>
			<button type="button" id="mapCtrlArea" class="measures area" data-type="Polygon" title="면적">면적</button>
			<button type="button" id="mapCapture" class="save" data-type="" title="저장">저장</button>
		</div>
		<div class="rotate">
			<button type="button" class="rotateReset on" id="rotateReset" title="방향초기화"></button>
			<!-- <input type="text" placeholder="0" id="rotateInput"/>&deg; -->
			<input type="text" id="rotateInput" placeholder="0" readonly>&deg;
	        <input type="text" id="pitchInput" placeholder="-90" readonly>&deg;
			<button type="button" class="rotateLeft" id="rotateLeft" title="왼쪽으로 회전">왼쪽으로 회전</button>
			<button type="button" class="rotateRight" id="rotateRight" title="오른쪽으로 회전">오른쪽으로 회전</button>
	<!-- 		<button type="button" class="mapPolicy" id="mapPolicy" title="지도 설정">지도 설정</button> -->
		</div>
		<div class="index">
			<button type="button" class="magoSet" id="mapPolicy" title="Mago3D 설정">Mago3D</button>
		</div>
	</div>
	<div id="mago3DSettingLabelLayer" class="labelLayer" style="display:none;">
	    <div class="layerHeader">
	        <h3 class="ellipsis" style="max-width:260px;">Mago3D 설정</h3>
	        <button type="button" class="layerClose" title="닫기">닫기</button>
	    </div>
	    <div class="layerContents">

			<div class="inline-toggle">
				<h4 class="category">Origin</h4>
				<div id="datainfoDisplay" class="switch-toggle switch-ios">
					<input type="radio" id="originDisplayY" name="originDisplay" value="true">
		            <label for="originDisplayY">표시</label>
		            <input type="radio" id="originDisplayN" name="originDisplay" value="false" checked>
		            <label for="originDisplayN">비표시</label>
					<a></a>
				</div>
			</div>

			<div class="inline-toggle">
				<h4 class="category">Bounding Box</h4>
				<div id="datainfoDisplay" class="switch-toggle switch-ios">
					<input type="radio" id="bboxDisplayY" name="bboxDisplay" value="true">
					<label for="bboxDisplayY">표시</label>
					<input type="radio" id="bboxDisplayN" name="bboxDisplay" value="false" checked>
					<label for="bboxDisplayN">비표시</label>
					<a></a>
				</div>
			</div>

			<div class="inline-toggle marB20">
				<h4 class="category">선택 및 이동</h4>
				<div class="switch-toggle switch-ios" style="width: 60%;">
					<input type="radio" id="objectNoneMove" name="objectMoveMode" value="2" checked>
					<label for="objectNoneMove">None</label>
					<input type="radio" id="objectAllMove" name="objectMoveMode" value="0">
					<label for="objectAllMove">All</label>
					<input type="radio" id="objectMove" name="objectMoveMode" value="1">
					<label for="objectMove">Object</label>
					<a></a>
				</div>
			</div>


			<div id="dataControllWrap" style="display:none;">
				<p class="layerDivTit"><span>test / 오전반1조_행복관_s</span></p>
				<div class="layerDiv">
					<h4 class="category">색상 변경</h4>
					<ul>
						<li>
							<label for="dcColorPicker">색상</label>
							<input type="color" id="dcColorPicker">
							<input type="text" id="dcColorInput" value="#000000" size="6" readonly style="color: rgb(0, 0, 0);">
							<button type="button" id="dcColorApply" class="btnTextF">적용</button>
							<button type="button" id="dcColorCancle" class="btnText">되돌리기</button>
						</li>
					</ul>
				</div>
				<form:form id="dcRotLocForm" class="layerDiv marB0">
					<input type="hidden" name="dataId" value="${dataInfo.dataId}" />
					<h4 class="category">위치 변경</h4>
					<ul class="layerDiv">
						<li>
							<label for="dcLongitude">경도</label>
							<input type="text" id="dcLongitude" name="longitude" readonly>
						</li>
						<li>
							<label for="dcLatitude">위도</label>
							<input type="text" id="dcLatitude" name="latitude" readonly>
						</li>
						<li>
							<label for="dcAltitude">높이</label>
							<input type="text" id="dcAltitude" name="altitude" size="10" readonly>
							<button id="dcAltUp" data-type="up" type="button" class="up"></button>
							<button id="dcAltDown" data-type="down" type="button" class="down"></button>
							<label for="dcAltitudeOffset" style="width: 40px;">offset</label>
							<input type="text" id="dcAltitudeOffset" value="1" size="1">
						</li>
					</ul>

					<h4 class="category">회전 변경</h4>
					<ul class="layerDiv">
						<li>
							<label for="dcPitch">x(pitch)</label>
							<input type="text" id="dcPitch" name="pitch" size="2" readonly>
							<button type="button" class="dcRangeBtn rangePrev" data-type="prev" id="rcPitchPrev"></button>
							<input id="dcPitchRange" data-type="Pitch" style="width: 140px;" type="range" min="-360" max="360" step="1" value="1">
							<button type="button" class="dcRangeBtn rangeNext" data-type="next" id="rcPitchNext"></button>
						</li>

						<li>
							<label for="dcRoll">y(roll)</label>
							<input type="text" id="dcRoll" name="roll" size="2" readonly>
							<button type="button" class="dcRangeBtn rangePrev" data-type="prev" id="rcRollPrev"></button>
							<input id="dcRollRange" data-type="Roll" style="width: 140px;" type="range" min="-360" max="360" step="1" value="1">
							<button type="button" class="dcRangeBtn rangeNext" data-type="next" id="rcRollNext"></button>
						</li>

						<li>
							<label for="dcHeading">z(heading)</label>
							<input type="text" id="dcHeading" name="heading" size="2" readonly>
							<button type="button" class="dcRangeBtn rangePrev" data-type="prev" id="rcHeadingPrev"></button>
							<input id="dcHeadingRange" data-type="Heading" style="width: 140px;" type="range" min="-360" max="360" step="1" value="1">
							<button type="button" class="dcRangeBtn rangeNext" data-type="next" id="rcHeadingNext"></button>
						</li>
					</ul>

					<div>
						<button type="button" id="dcSavePosRotPop" class="btnTextF"
								title="<spring:message code='data.transform.save'/>">
							<spring:message code='data.transform.save'/>
						</button>
					</div>
				</form:form>
			</div>
		</div>
	</div>
    <div id="magoContainer" style="height: 100%;"></div>
    <canvas id="objectLabel"></canvas>
    <button class="mapSelectButton" onclick="window.close();">닫기</button>
</body>
<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/externlib/handlebars-4.1.2/handlebars.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/externlib/cesium/Cesium.js"></script>
<script type="text/javascript" src="/externlib/cesium-geoserver-terrain-provider/GeoserverTerrainProvider.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/externlib/decodeTextAlternative/encoding-indexes.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/externlib/decodeTextAlternative/encoding.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/externlib/moment-2.22.2/moment-with-locales.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/mago3d.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/mago3d_lx.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/common.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/message.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/map-controll.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/ui-controll.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/wps-request.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/data-info.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/user-policy.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/map-data-controll.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/map-init.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#magoTool").addClass("on");
		$(".labelLayer").show();
	});

	//Cesium.Ion.defaultAccessToken = '';
	//var viewer = new Cesium.Viewer('magoContainer');
	var MAGO3D_INSTANCE;
	// ndtp 전역 네임스페이스
	let dataGroupMap = new Map();
	dataGroupMap.set(parseInt('${dataInfo.dataGroupId}'), '${dataInfo.dataGroupName}');
	var NDTP = NDTP ||{
		policy : {},
		dataGroup : dataGroupMap,
		baseLayers : {}
	};
	var viewer = null;
	var entities = null;
	
	initPolicy(function(policy, baseLayers){
		NDTP.policy = policy;
		NDTP.baseLayers = baseLayers;
		magoInit();
	},'${dataInfo.dataId}');

	function magoInit() {

		var geoPolicyJson = NDTP.policy;

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
		var geoPolicyJson = NDTP.policy;
		viewer = magoInstance.getViewer();
		entities = viewer.entities;
		var magoManager = magoInstance.getMagoManager();
		var f4dController = magoInstance.getF4dController();

		// TODO : 세슘 MAP 선택 UI 제거,엔진에서 처리로 변경 예정.
		if(viewer.baseLayerPicker) viewer.baseLayerPicker.destroy();
		viewer.scene.globe.depthTestAgainstTerrain = true;
		/* magoManager.on(Mago3D.MagoManager.EVENT_TYPE.CLICK, function(result) {
			console.info(result);
		}); */

		// mago3d logo 추가
		Mago3D.tempCredit(viewer);

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
// 		setTimeout(function(){
// 			var ndtpMap = new mapInit(magoInstance, NDTP.baseLayers, geoPolicyJson);
// 			ndtpMap.initLayer();
//         }, geoPolicyJson.initDuration * 1000);

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

			// 로드되는 시점
			magoInstance.getMagoManager().on(Mago3D.MagoManager.EVENT_TYPE.F4DLOADEND,function(e){
				var tiling = "${dataInfo.tiling}";
				if(tiling === "true") {
					gotoFly(magoInstance);
				} else {
					flyTo(magoInstance);
				}
			});

			// 화면에 표출할 준비가 된 시점
			magoInstance.getMagoManager().on(Mago3D.MagoManager.EVENT_TYPE.F4DRENDERREADY, function(e){
				var data = e.f4d.data;
				if (data.dataGroupId === parseInt("${dataInfo.dataGroupId}") && data.nodeId === "${dataInfo.dataKey}") {
					selectF4dAPI(magoInstance, data.dataGroupId, data.nodeId);
				}
			});

		}
		/* setTimeout(function() {
			flyTo(magoInstance);
		}, 500); */
	}

	// smart tiling data flyTo
	function gotoFly(magoInstance) {
		gotoFlyAPI(magoInstance, "${dataInfo.longitude}", "${dataInfo.latitude}", "${dataInfo.altitude}", 3);
	}

	function flyTo(magoInstance) {
		//  searchDataAPI
		searchDataAPI(magoInstance, "${dataInfo.dataGroupId}", "${dataInfo.dataKey}");
	}

	function remove(entityStored) {
		entities.removeById(entityStored);
	}

	function initData(dataInfo) {

		//clearDataControl();
		//$('#dcColor').hide();

		var $dataControlWrap = $('#dataControllWrap');
		//$dataControlWrap.find('.layerDivTit').hide();
		//var $header = $('#mago3DSettingLabelLayer .layerHeader h3');
		var $header = $dataControlWrap.find('.layerDivTit span');

		var groupId = dataInfo.dataGroupId;
		if (groupId) {
			var title = dataInfo.dataGroupName + ' / ' + (dataInfo.dataName || dataInfo.dataKey);
			$header.text(title);
			$header.attr('title', title);
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

	function validate() {
		if ($("#dcLongitude").val() === "") {
			alert("경도를 입력하여 주십시오.");
			$("#dcLongitude").focus();
			return false;
		}
		if ($("#dcLatitude").val() === "") {
			alert("위도를 입력하여 주십시오.");
			$("#dcLatitude").focus();
			return false;
		}
		if ($("#dcAltitude").val() === "") {
			alert("높이를 입력하여 주십시오.");
			$("#dcAltitude").focus();
			return false;
		}
	}

	// 위치/회전 저장 버튼 클릭
	$("#dcSavePosRotPop").click(function(){
		if (validate() == false) {
			return false;
		}
		var dataId = parseInt("${dataInfo.dataId}");
		if(confirm(JS_MESSAGE["data.update.check"])) {
			if(!dataId) {
				alert('선택된 데이터가 없습니다.');
				return false;
			}
			//startLoading();
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

					var $opnerHeading = $(opener.document).find("#heading");
					var $opnerPitch = $(opener.document).find("#pitch");
					var $opnerRoll = $(opener.document).find("#roll");

					if ($opnerHeading && $opnerPitch && $opnerRoll) {
						$opnerHeading.val($("#dcHeading").val());
						$opnerPitch.val($("#dcPitch").val());
						$opnerRoll.val($("#dcRoll").val());
					}
					window.close();

					updateDataInfoFlag = true;
				},
				error:function(request, status, error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updateDataInfoFlag = true;
				}
			}).always(/* stopLoading */);
		} else {
			//alert('no');
		}
	});

</script>
</html>