<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="referrer" content="origin">
<meta name="viewport" content="width=device-width">
<meta name="robots" content="index,nofollow" />
<title>Mago3DJS API</title>
<link rel="shortcut icon" href="/images/favicon.ico">
<link rel="stylesheet" href="/externlib/cesium/Widgets/widgets.css" />
<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css" />
<link rel="stylesheet" href="/externlib/highlightjs/styles/dark.css">
<link rel="stylesheet" href="/css/ko/apihelp-style.css" />
<script src="/externlib/highlightjs/highlight.pack.js"></script>
<script>hljs.initHighlightingOnLoad();</script>

</head>
<body>
	<div id="popupWrap">
		<div class="popupSub">
			<h3>
				<a onclick="changeToggleTab(api0)">mago3D.JS API</a>
			</h3>
			<div class="searchWrap">
			<label for="searchApi"></label>
				<input id="searchApi" type="text" placeholder="검색어를 입력하세요">
				<button type="button">검색</button>
			</div>
			<ul></ul>
		</div>
		<div class="popupCon">
			<div class="popupMap">
				<div id="magoContainer2" class="mapWrap" style="height: 100%; width: 100%;"></div>
				<canvas id="objectLabel" style="background-color: transparent; position: absolute; left: 0px; top: 0px; z-index: 10; pointer-events: none;"></canvas>
			</div>
			<div class="descript">
				<div class="popupGroup">
					<div id="testtoggle">
						<%@ include file="/WEB-INF/views/guide/main.jsp"%>
						<%@ include file="/WEB-INF/views/guide/changeMagoStateAPI.jsp"%>
						<%@ include file="/WEB-INF/views/guide/changeLabelAPI.jsp"%>
						<%@ include file="/WEB-INF/views/guide/changeOriginAPI.jsp"%>
						<%@ include file="/WEB-INF/views/guide/changeBoundingBoxAPI.jsp"%>
						<%@ include file="/WEB-INF/views/guide/changePropertyRenderingAPI.jsp"%>
						<%@ include file="/WEB-INF/views/guide/changeShadowAPI.jsp"%>
						<%@ include file="/WEB-INF/views/guide/changeColorAPI.jsp"%>
						<%@ include file="/WEB-INF/views/guide/changeLocationAndRotationAPI.jsp"%>
						<%@ include file="/WEB-INF/views/guide/changeObjectMoveAPI.jsp"%>
						<%@ include file="/WEB-INF/views/guide/saveObjectMoveAPI.jsp"%>
						<%@ include file="/WEB-INF/views/guide/deleteAllObjectMoveAPI.jsp"%>
						<%@ include file="/WEB-INF/views/guide/deleteAllChangeColorAPI.jsp"%>
						<%@ include file="/WEB-INF/views/guide/changeInsertIssueModeAPI.jsp"%>
						<%@ include file="/WEB-INF/views/guide/changeObjectInfoViewModeAPI.jsp"%>
						<%@ include file="/WEB-INF/views/guide/changeOcclusionCullingAPI.jsp"%>
						<%@ include file="/WEB-INF/views/guide/changeFPVModeAPI.jsp"%>
						<%@ include file="/WEB-INF/views/guide/changeNearGeoIssueListViewModeAPI.jsp"%>
						<%@ include file="/WEB-INF/views/guide/changeInsertIssueStateAPI.jsp"%>
						<%@ include file="/WEB-INF/views/guide/changeLodAPI.jsp"%>
						<%@ include file="/WEB-INF/views/guide/changeLightingAPI.jsp"%>
						<%@ include file="/WEB-INF/views/guide/changeSsaoRadiusAPI.jsp"%>
						<%@ include file="/WEB-INF/views/guide/clearAllDataAPI.jsp"%>
						<%@ include file="/WEB-INF/views/guide/drawInsertIssueImageAPI.jsp"%>
						<%@ include file="/WEB-INF/views/guide/gotoProjectAPI.jsp"%>
						<%@ include file="/WEB-INF/views/guide/gotoIssueAPI.jsp"%>
						<%@ include file="/WEB-INF/views/guide/searchDataAPI.jsp"%>
						<%@ include file="/WEB-INF/views/guide/isDataExistAPI.jsp"%>
						<%@ include file="/WEB-INF/views/guide/getDataAPI.jsp"%>
						<%@ include file="/WEB-INF/views/guide/getDataInfoByDataKeyAPI.jsp"%>
						<%@ include file="/WEB-INF/views/guide/drawAppendDataAPI.jsp"%>
						<%@ include file="/WEB-INF/views/guide/gotoFlyAPI.jsp"%>
						<%@ include file="/WEB-INF/views/guide/getCoordinateRelativeToBuildingAPI.jsp"%>
						<%@ include file="/WEB-INF/views/guide/getAbsoluteCoodinateOfBuildingPointAPI.jsp"%>
						<%@ include file="/WEB-INF/views/guide/getCameraCurrentPositionAPI.jsp"%>
						<%@ include file="/WEB-INF/views/guide/getCameraCurrentOrientaionAPI.jsp"%>
						<%@ include file="/WEB-INF/views/guide/changeCameraOrientationAPI.jsp"%>
						<%@ include file="/WEB-INF/views/guide/instantiateStaticModelAPI.jsp"%>
						<%@ include file="/WEB-INF/views/guide/addStaticModelAPI.jsp"%>
						<%@ include file="/WEB-INF/views/guide/setTrackNodeAPI.jsp"%>
						<%@ include file="/WEB-INF/views/guide/isExistStaticModelAPI.jsp"%>
						<%@ include file="/WEB-INF/views/guide/isExistDataAPI.jsp"%>
						<%@ include file="/WEB-INF/views/guide/isDataReadyToRenderAPI.jsp"%>
						<%@ include file="/WEB-INF/views/guide/setNodeAttributeAPI.jsp"%>
						<%@ include file="/WEB-INF/views/guide/togglePointCloudColorAPI.jsp"%>
					</div>
				</div>
			</div>
		</div>
	</div>



	<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
	<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>
	<script type="text/javascript" src="/externlib/cesium/Cesium.js"></script>
	<script type="text/javascript" src="/externlib/cesium-geoserver-terrain-provider/GeoserverTerrainProvider.js"></script>
	<script type="text/javascript" src="/externlib/decodeTextAlternative/encoding-indexes.js"></script>
	<script type="text/javascript" src="/externlib/decodeTextAlternative/encoding.js"></script>
	<script type="text/javascript" src="/externlib/moment-2.22.2/moment-with-locales.min.js"></script>
	<script type="text/javascript" src="/js/mago3d.js"></script>
	<script type="text/javascript" src="/js/mago3d_lx.js"></script>
	<script type="text/javascript" src="/js/ko/common.js"></script>


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
			
			if($('.paramContainer').get(i)){
				
				$(".popupSub").children('ul').append("<li class=\"item\"><a class=\"name\" href=\"#api1\" onclick=\"changeToggleTab(api"+i+"); return false;\">"+apiList[i]+"</a></li>");
				var parmScript = document.createTextNode(($('.paramContainer').get(i-1).innerHTML).replace(/\s{2,}/gi, ' '));
				var script = document.createTextNode($('.api-help-toggle').next()[i-1].text);
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
		}
		
		$( document ).ready(function() {
			
			for (var i =0; i< $("code").children('.hljs-tag').length; i++) {
				if($("code").children('.hljs-tag')[i].childNodes[0].nodeValue=="</"){
					$("code").children('.hljs-tag')[i].childNodes[2].nodeValue = $("code").children('.hljs-tag')[i].childNodes[2].nodeValue+"\n";
				}
			};
			
			cesiumCreditAlt();
		});
		
var MAGO3D_INSTANCE2;
var NDTP2 = {
	policy : ${geoPolicyJson},
	baseLayers : "ndtp:land_block",
	wmsProvider : {},	
	districtProvider : {}
};

magoInit2();

function magoInit2() {
	var geoPolicyJson = ${geoPolicyJson};
	geoPolicyJson.initAltitude = 250.0;
	var cesiumViewerOption = {};
	cesiumViewerOption.infoBox = false;
	cesiumViewerOption.navigationHelpButton = false;
	cesiumViewerOption.selectionIndicator = false;
	cesiumViewerOption.homeButton = false;
	cesiumViewerOption.fullscreenButton = false;
	cesiumViewerOption.geocoder = false;
	cesiumViewerOption.baseLayerPicker = false;
	cesiumViewerOption.sceneModePicker = false;

	MAGO3D_INSTANCE2 = new Mago3D.Mago3d('magoContainer2', geoPolicyJson, {loadend : magoLoadEnd2}, cesiumViewerOption);
}

function magoLoadEnd2(e) {
	var magoInstance = e;
	var geoPolicyJson = ${geoPolicyJson};
	var viewer = magoInstance.getViewer();
	var magoManager = magoInstance.getMagoManager();
	var f4dController = magoInstance.getF4dController();
	viewer.baseLayerPicker.destroy();
	viewer.scene.globe.depthTestAgainstTerrain = true;
	
	$.ajax({
		url: "/sample/json/sample_f4d.json",
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
			//alert(JS_MESSAGE["ajax.error.message"]);
		}
	});
}

$('.item').on("click", function(){
	$('.item').removeClass('on');
	$(this).addClass('on');
})

function changeToggleTab(apiId){
	$('.api-help-toggle').css('display','none');
	$(apiId).show();
}

function tabMenu(num){
 
 var f = $('.api-help-toggle');
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
