<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
<meta charset="utf-8">
<meta name="referrer" content="origin">
<meta name="viewport" content="width=device-width">
<meta name="robots" content="index,nofollow" />
<title>Mago3DJS API</title>
<link rel="shortcut icon" href="/images/favicon.ico">
<link rel="stylesheet" href="/externlib/cesium/Widgets/widgets.css" />
<link rel="stylesheet"
	href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css" />
<link rel="stylesheet" href="/externlib/geostats/geostats.css" />
<link rel="stylesheet" href="/externlib/kotSlider/range.css" />
<link rel="stylesheet" href="/css/ko/layout.css" />
<link rel="stylesheet" href="/css/ko/apihelp-style.css" />
<link rel="stylesheet" href="/externlib/highlightjs/styles/atelier-cave-dark.css">
<script src="/externlib/highlightjs/highlight.pack.js"></script>
<script>hljs.initHighlightingOnLoad();</script>

</head>
<body>
	<div id="popupWrap">
		<div class="popupSub">
			<h3><a onclick="changeToggleTab(api0)">mago3D.JS API</a></h3>
			<div class="searchWrap">
				<input id="searchApi" type="text" placeholder="검색어를 입력하세요">
				<button type="button">검색</button>
			</div>
			<ul></ul>
		</div>
		<!-- // MENU -->
		<div class="popupCon">
			<div class="popupMap">
				<!-- MAP -->
				<div id="magoContainer2" class="mapWrap"
					style="height: 100%; width: 100%;">

				</div>
				<canvas id="objectLabel"
					style="background-color: transparent; position: absolute; left: 0px; top: 0px; z-index: 10; pointer-events: none;"></canvas>

			</div>
			<div class="descript">

				<!-- RUN -->
				<div class="popupGroup">
					
 
 <div id="testtoggle">
<%@ include file="/WEB-INF/views/api-help/main.jsp"%>
			<%@ include file="/WEB-INF/views/api-help/changeMagoStateAPI.jsp"%>
			<%@ include file="/WEB-INF/views/api-help/changeLabelAPI.jsp"%>
			<%@ include file="/WEB-INF/views/api-help/changeOriginAPI.jsp"%>
			<%@ include file="/WEB-INF/views/api-help/changeBoundingBoxAPI.jsp"%>
			<%@ include
				file="/WEB-INF/views/api-help/changePropertyRenderingAPI.jsp"%>

			<%@ include file="/WEB-INF/views/api-help/changeShadowAPI.jsp"%>
			<%@ include file="/WEB-INF/views/api-help/changeColorAPI.jsp"%>
			<%@ include
				file="/WEB-INF/views/api-help/changeLocationAndRotationAPI.jsp"%>
			<%@ include file="/WEB-INF/views/api-help/changeObjectMoveAPI.jsp"%>
			<%@ include file="/WEB-INF/views/api-help/saveObjectMoveAPI.jsp"%>

			<%@ include file="/WEB-INF/views/api-help/deleteAllObjectMoveAPI.jsp"%>
			<%@ include
				file="/WEB-INF/views/api-help/deleteAllChangeColorAPI.jsp"%>
			<%@ include
				file="/WEB-INF/views/api-help/changeInsertIssueModeAPI.jsp"%>
			<%@ include
				file="/WEB-INF/views/api-help/changeObjectInfoViewModeAPI.jsp"%>
			<%@ include
				file="/WEB-INF/views/api-help/changeOcclusionCullingAPI.jsp"%>

			<%@ include file="/WEB-INF/views/api-help/changeFPVModeAPI.jsp"%>
			<%@ include
				file="/WEB-INF/views/api-help/changeNearGeoIssueListViewModeAPI.jsp"%>
			<%@ include
				file="/WEB-INF/views/api-help/changeInsertIssueStateAPI.jsp"%>
			<%@ include file="/WEB-INF/views/api-help/changeLodAPI.jsp"%>
			<%@ include file="/WEB-INF/views/api-help/changeLightingAPI.jsp"%>

			<%@ include file="/WEB-INF/views/api-help/changeSsaoRadiusAPI.jsp"%>
			<%@ include file="/WEB-INF/views/api-help/clearAllDataAPI.jsp"%>
			<%@ include
				file="/WEB-INF/views/api-help/drawInsertIssueImageAPI.jsp"%>
			<%@ include file="/WEB-INF/views/api-help/gotoProjectAPI.jsp"%>
			<%@ include file="/WEB-INF/views/api-help/gotoIssueAPI.jsp"%>

			<%@ include file="/WEB-INF/views/api-help/searchDataAPI.jsp"%>
			<%@ include file="/WEB-INF/views/api-help/isDataExistAPI.jsp"%>
			<%@ include file="/WEB-INF/views/api-help/getDataAPI.jsp"%>
			<%@ include
				file="/WEB-INF/views/api-help/getDataInfoByDataKeyAPI.jsp"%>
			<%@ include file="/WEB-INF/views/api-help/drawAppendDataAPI.jsp"%>

			<%@ include file="/WEB-INF/views/api-help/gotoFlyAPI.jsp"%>
			<%@ include
				file="/WEB-INF/views/api-help/getCoordinateRelativeToBuildingAPI.jsp"%>
			<%@ include
				file="/WEB-INF/views/api-help/getAbsoluteCoodinateOfBuildingPointAPI.jsp"%>
			<%@ include
				file="/WEB-INF/views/api-help/getCameraCurrentPositionAPI.jsp"%>
			<%@ include
				file="/WEB-INF/views/api-help/getCameraCurrentOrientaionAPI.jsp"%>

			<%@ include
				file="/WEB-INF/views/api-help/changeCameraOrientationAPI.jsp"%>
			<%@ include
				file="/WEB-INF/views/api-help/instantiateStaticModelAPI.jsp"%>
			<%@ include file="/WEB-INF/views/api-help/addStaticModelAPI.jsp"%>
			<%@ include file="/WEB-INF/views/api-help/setTrackNodeAPI.jsp"%>
			<%@ include file="/WEB-INF/views/api-help/isExistStaticModelAPI.jsp"%>

			<%@ include file="/WEB-INF/views/api-help/isExistDataAPI.jsp"%>
			<%@ include file="/WEB-INF/views/api-help/isDataReadyToRenderAPI.jsp"%>
			<%@ include file="/WEB-INF/views/api-help/setNodeAttributeAPI.jsp"%>
			<%@ include
				file="/WEB-INF/views/api-help/togglePointCloudColorAPI.jsp"%>
		</div>
				</div>
			</div>
		</div>
	</div>



	<script type="text/javascript"
		src="/externlib/jquery-3.3.1/jquery.min.js"></script>
	<script type="text/javascript"
		src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>
	<script type="text/javascript"
		src="/externlib/handlebars-4.1.2/handlebars.js"></script>
	<script type="text/javascript" src="/externlib/cesium/Cesium.js"></script>
	<script type="text/javascript" src="/externlib/geostats/geostats.js"></script>
	<script type="text/javascript" src="/externlib/chartjs/Chart.min.js"></script>
	<script type="text/javascript" src="/externlib/kotSlider/range.js"></script>
	<script type="text/javascript"
		src="/externlib/decodeTextAlternative/encoding-indexes.js"></script>
	<script type="text/javascript"
		src="/externlib/decodeTextAlternative/encoding.js"></script>
	<script type="text/javascript"
		src="/externlib/moment-2.22.2/moment-with-locales.min.js"></script>
	<script type="text/javascript" src="/js/mago3d.js"></script>
	<script type="text/javascript" src="/js/mago3d_lx.js"></script>
	

	<script type="text/javascript">
	var apiList = ["main","changeMagoStateAPI", "changeLabelAPI", "changeOriginAPI",
		"changeBoundingBoxAPI", "changePropertyRenderingAPI", "changeShadowAPI", 
		"changeColorAPI", "changeLocationAndRotationAPI", "changeObjectMoveAPI",
		"saveObjectMoveAPI", "deleteAllObjectMoveAPI", "deleteAllChangeColorAPI",
		"changeInsertIssueModeAPI", "changeObjectInfoViewModeAPI", "changeOcclusionCullingAPI",
		"changeFPVModeAPI", "changeNearGeoIssueListViewModeAPI", "changeInsertIssueStateAPI",
		"changeLodAPI", "changeLightingAPI", "changeSsaoRadiusAPI",
		"clearAllDataAPI", "drawInsertIssueImageAPI", "gotoProjectAPI",
		"gotoIssueAPI", "searchDataAPI", "isDataExistAPI",
		"getDataAPI", "getDataInfoByDataKeyAPI", "drawAppendDataAPI",
		"gotoFlyAPI", "getCoordinateRelativeToBuildingAPI", "getAbsoluteCoodinateOfBuildingPointAPI",
		"getCameraCurrentPositionAPI", "getCameraCurrentOrientaionAPI", "changeCameraOrientationAPI",
		"instantiateStaticModelAPI", "addStaticModelAPI", "setTrackNodeAPI",
		"isExistStaticModelAPI", "isExistDataAPI", "isDataReadyToRenderAPI",
		"setNodeAttributeAPI", "togglePointCloudColorAPI"];

		for(var i = 1; i<apiList.length+1; i++){
			console.log(i);
			$(".popupSub").children('ul').append("<li class=\"item\"><a class=\"name\" href=\"#\" onclick=\"changeToggleTab(api"+i+");\">"+apiList[i]+"</a></li>");
			var parmScript = document.createTextNode(($('.paramContainer').get(i-1).innerHTML).replace(/\s{2,}/gi, ' '));
			var script = document.createTextNode($('.apihelptoggle').next()[i-1].text);
			var preTagBr = document.createElement("br");
			
			var codeParmTag = document.createElement("code");
			codeParmTag.setAttribute("class","html");
			codeParmTag.appendChild(parmScript);
			
			var preTagParm = document.createElement("pre");
			preTagParm.appendChild(codeParmTag);
			
			var codeScriptTag = document.createElement("code");
			codeScriptTag.setAttribute("class","javascript");
			codeScriptTag.appendChild(script);
			
			var preTagScript = document.createElement("pre");
			preTagScript.appendChild(codeScriptTag);
			
			
			$('.menu_tab01')[i-1].appendChild(preTagParm);
			$('.menu_tab01')[i-1].appendChild(preTagBr);
			$('.menu_tab01')[i-1].appendChild(preTagBr);
			$('.menu_tab01')[i-1].appendChild(preTagBr);
			$('.menu_tab01')[i-1].appendChild(preTagScript);
			
			
		}
		
		$( document ).ready(function() {
			for (var i =0; i< $("code").children('.hljs-tag').length; i++) {
				
				if($("code").children('.hljs-tag')[i].childNodes[0].nodeValue=="</"){
					$("code").children('.hljs-tag')[i].childNodes[2].nodeValue = $("code").children('.hljs-tag')[i].childNodes[2].nodeValue+"\n";
				}
				
				
			};
		    
		});
		
var MAGO3D_INSTANCE2;
// ndtp 전역 네임스페이스
var NDTP2 = {
	policy : ${geoPolicyJson},
	baseLayers : "ndtp:land_block",
	wmsProvider : {},	
	districtProvider : {}
};
magoInit2();

function magoInit2() {
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
	MAGO3D_INSTANCE2 = new Mago3D.Mago3d('magoContainer2', geoPolicyJson, {loadend : magoLoadEnd2}, cesiumViewerOption);
}

function magoLoadEnd2(e) {
	var magoInstance = e;
	var geoPolicyJson = ${geoPolicyJson};
	var viewer = magoInstance.getViewer();
	var magoManager = magoInstance.getMagoManager();
	var f4dController = magoInstance.getF4dController();

	// TODO : 세슘 MAP 선택 UI 제거,엔진에서 처리로 변경 예정.
	viewer.baseLayerPicker.destroy();
	viewer.scene.globe.depthTestAgainstTerrain = true;
	
	$.ajax({
		url: "/js/temp/sample_f4d.json",
		type: "GET",
		headers: {"X-Requested-With": "XMLHttpRequest"},
		dataType: "json",
		success: function(res){
			if(res) {
				var policy = Mago3D.MagoConfig.getPolicy();
				var initLat = parseFloat(policy.initLatitude);
				var initLon = parseFloat(policy.initLongitude);
				var childs = res.children;
				var offset = 0.00001;
				for(var i=0,len=childs.length;i<len;i++) {
					var child = childs[i];
					child.latitude = initLat + i*offset; 
					child.longitude = initLon + i*offset; 
				}
				
				f4dController.addF4dGroup(res);
			}
		},
		error:function(request,status,error){
			alert(JS_MESSAGE["ajax.error.message"]);
		}
	});
}


function changeToggleTab(apiId){
	$('.apihelptoggle').css('display','none');
	$(apiId).show();
}



function tab_menu(num){
 var f = $('.apihelptoggle');
 for ( var i = 0; i < f.length; i++ ) {
  if ( num == 0) {
   f.eq(i).children('.menu_tab').children('ul').children('li').eq(0).addClass('active');
   f.eq(i).children('.menu_tab').children('ul').children('li').eq(1).removeClass('active');
   f.eq(i).children('.menu_tab00').show();
   f.eq(i).children('.menu_tab01').hide();
  } else {
	  f.eq(i).children('.menu_tab').children('ul').children('li').eq(1).addClass('active');
   f.eq(i).children('.menu_tab').children('ul').children('li').eq(0).removeClass('active');
   f.eq(i).children('.menu_tab01').show();
   f.eq(i).children('.menu_tab00').hide();	
  }
 }
}

$("#searchApi").on("propertychange change keyup paste input",function(){
	var value, name, item, i;

    value = document.getElementById("searchApi").value.toUpperCase();
    item = document.getElementsByClassName("item");

    for(i=0;i<item.length;i++){
      name = item[i].getElementsByClassName("name");
      if(name[0].innerHTML.toUpperCase().indexOf(value) > -1){
        item[i].style.display = "flex";
      }else{
        item[i].style.display = "none";
      }
    }
})


</script>
</body>
</html>
