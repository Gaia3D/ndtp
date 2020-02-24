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
						<%@ include file="/WEB-INF/views/guide/change-mago-state.jsp"%>
						<%@ include file="/WEB-INF/views/guide/change-label.jsp"%>
						<%@ include file="/WEB-INF/views/guide/change-origin.jsp"%>
						<%@ include file="/WEB-INF/views/guide/change-bounding-box.jsp"%>
						<%@ include file="/WEB-INF/views/guide/change-property-rendering.jsp"%>
						<%@ include file="/WEB-INF/views/guide/change-shadow.jsp"%>
						<%@ include file="/WEB-INF/views/guide/change-color.jsp"%>
						<%@ include file="/WEB-INF/views/guide/change-location-and-rotation.jsp"%>
						<%@ include file="/WEB-INF/views/guide/change-object-move.jsp"%>
						<%@ include file="/WEB-INF/views/guide/save-object-move.jsp"%>
						<%@ include file="/WEB-INF/views/guide/delete-all-object-move.jsp"%>
						<%@ include file="/WEB-INF/views/guide/delete-all-change-color.jsp"%>
						<%@ include file="/WEB-INF/views/guide/change-insert-issue-mode.jsp"%>
						<%@ include file="/WEB-INF/views/guide/change-object-info-view-mode.jsp"%>
						<%@ include file="/WEB-INF/views/guide/change-occlusion-culling.jsp"%>
						<%@ include file="/WEB-INF/views/guide/change-FPV-mode.jsp"%>
						<%@ include file="/WEB-INF/views/guide/change-near-geo-issue-list-view-mode.jsp"%>
						<%@ include file="/WEB-INF/views/guide/change-insert-issue-state.jsp"%>						
						<%@ include file="/WEB-INF/views/guide/change-lod.jsp"%>
						<%@ include file="/WEB-INF/views/guide/change-lighting.jsp"%>
						<%@ include file="/WEB-INF/views/guide/change-ssao-radius.jsp"%>
						<%@ include file="/WEB-INF/views/guide/clear-all-data.jsp"%>
						<%@ include file="/WEB-INF/views/guide/draw-insert-issue-image.jsp"%>
						<%@ include file="/WEB-INF/views/guide/goto-project.jsp"%>
						<%@ include file="/WEB-INF/views/guide/goto-issue.jsp"%>
						<%@ include file="/WEB-INF/views/guide/search-data.jsp"%>
						<%@ include file="/WEB-INF/views/guide/is-data-exist.jsp"%>
						<%@ include file="/WEB-INF/views/guide/get-data.jsp"%>
						<%@ include file="/WEB-INF/views/guide/get-data-info-by-data-key.jsp"%>
						<%@ include file="/WEB-INF/views/guide/draw-append-data.jsp"%>
						<%@ include file="/WEB-INF/views/guide/goto-fly.jsp"%>
						<%@ include file="/WEB-INF/views/guide/get-coordinate-relative-to-building.jsp"%>
						<%@ include file="/WEB-INF/views/guide/get-absolute-coodinate-of-building-point.jsp"%>
						<%@ include file="/WEB-INF/views/guide/get-camera-current-position.jsp"%>
						<%@ include file="/WEB-INF/views/guide/get-camera-current-orientaion.jsp"%>
						<%@ include file="/WEB-INF/views/guide/change-camera-orientation.jsp"%>
						<%@ include file="/WEB-INF/views/guide/instantiate-static-model.jsp"%>
						<%@ include file="/WEB-INF/views/guide/add-static-model.jsp"%>
						<%@ include file="/WEB-INF/views/guide/set-track-node.jsp"%>
						<%@ include file="/WEB-INF/views/guide/stop-track.jsp"%>
						<%@ include file="/WEB-INF/views/guide/is-exist-static-model.jsp"%>
						<%@ include file="/WEB-INF/views/guide/is-exist-data.jsp"%>
						<%@ include file="/WEB-INF/views/guide/is-data-ready-to-render.jsp"%>
						<%@ include file="/WEB-INF/views/guide/set-node-attribute.jsp"%>
						<%@ include file="/WEB-INF/views/guide/toggle-point-cloud-color.jsp"%>


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
	
	var apiNum;
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
		"instantiateStaticModelAPI", "addStaticModelAPI", "setTrackNodeAPI", "stopTrackAPI",
		"isExistStaticModelAPI", "isExistDataAPI", "isDataReadyToRenderAPI",
		"setNodeAttributeAPI", "togglePointCloudColorAPI"];

		for(var i = 1; i<apiList.length+1; i++){
			
			if($('.paramContainer').get(i)){
				
				$(".popupSub").children('ul').append("<li class=\"item\"><a class=\"name\" href=\"#api"+i+"\" onclick=\"changeToggleTab(api"+i+"); return false;\">"+apiList[i]+"</a></li>");
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
				var codeTabContainer = document.createElement("div");
				codeTabContainer.appendChild(preTagParm);
				codeTabContainer.appendChild(preTagBr);
				codeTabContainer.appendChild(preTagBr);
				codeTabContainer.appendChild(preTagBr);
				codeTabContainer.appendChild(preTagScript);
					
				$('.menu_tab01')[i-1].appendChild(codeTabContainer);
				
			
			}
		}
		
		$( document ).ready(function() {
			
			// code toggle align
			for (var i =0; i< $("code").children('.hljs-tag').length; i++) {
				if($("code").children('.hljs-tag')[i].childNodes[0].nodeValue=="</"){
					$("code").children('.hljs-tag')[i].childNodes[2].nodeValue = $("code").children('.hljs-tag')[i].childNodes[2].nodeValue+"\n";
				}
				if($("code").children('.hljs-tag')[i].childNodes[1].childNodes[0]=="br"){
					$("code").children('.hljs-tag')[i].childNodes[2].nodeValue = $("code").children('.hljs-tag')[i].childNodes[2].nodeValue+"\n";
				}
			};
			
			// cesium credit img alt
			cesiumCreditAlt();
			
			// blank check 
			$('.paramContainer').children('input[type=text]').focusout(function (){
				if($(this)[0].nextSibling.nodeValue){
					$(this)[0].nextSibling.nodeValue="";
				}
				if($(this).val()=="" && $(this).attr('data-require') === 'true'){
					var txt = document.createTextNode("필수로 입력해 주세요.");
					$(this).after(txt);
				}/* else{
					var txt = document.createTextNode("만족!");
					$(this).after(txt);
				}  */
			})
			
			// null check and start function
			$('.popupBtn').on("click", function(){
				var id = $(this).attr('id');/* 
				$('.menu_tab00').scrollTop($('.menu_tab00')[0].scrollHeight); */
				var inputTags = $("#"+id).siblings('.paramContainer').children('input[type=text]');
				var count=0;
				if(id=="changeLod"){
					for(var i = 0; i<inputTags.length; i++){
						if(inputTags[i].dataset.require === 'false' &&  (inputTags[i].value!="") ){
							count=count+1;
						}
					}
					if(count==0){
						alert("필수!");
						return;
					}
					window[id]();
				}else if(id=="changeLighting"){
					for(var i = 0; i<inputTags.length; i++){
						if(inputTags[i].dataset.require === 'false' &&  (inputTags[i].value!="") ){
							count=count+1;
						}
					}
					if(count==0){
						alert("필수!");
						return;
					}
					window[id]();
				}else if(id=="changeCameraOrientation"){
					for(var i = 0; i<inputTags.length; i++){
						if(inputTags[i].dataset.require === 'false' &&  (inputTags[i].value!="") ){
							if(inputTags[i].id!="api36-p4"){
								count=count+1;
							}
						}
					}
					if(count==0){
						alert("필수!");
						return;
					}
					window[id]();
				}else{
					for(var i = 0; i<inputTags.length; i++){
						if(inputTags[i].dataset.require === 'true' &&  (inputTags[i].value=="" || null || undefined) ){
							alert("필수!");
							return;
						}
					}
					window[id]();
				}
			})
			
			//color picker
			$('#api7-p5').on("change", function(){
				if($(this)[0].nextSibling.nodeValue){
					$(this)[0].nextSibling.nodeValue="";
				}
				var txt = document.createTextNode(convertColor($(this).val()));
				$(this).after(txt);
			})
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
	
	magoManager.magoPolicy.imagePath = '/sample/images';
	
	magoManager.init(viewer.scene._context._gl);
	magoManager.objMarkerManager.loadDefaultImages(magoManager);

	Mago3D.MagoConfig.serverPolicy.geo_callback_enable = 'true';
    Mago3D.MagoConfig.serverPolicy.geo_callback_selectedobject = 'selectedObjectCallBack';
    Mago3D.MagoConfig.serverPolicy.geo_callback_insertissue = 'insertIssueCallBack';
    
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
	$(apiId).scrollTop(0);
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

// rgb to hex
function convertColor(color) {
  if(color.substring(0,1) == '#') {
     color = color.substring(1);
   }
  var rgbColor = [parseInt(color.substring(0,2),16),parseInt(color.substring(2,4),16),parseInt(color.substring(4),16)];

  return rgbColor;
 }

function validateCheckGuide() {
	/* for(var i = 0; i = ){
		if ($("#issueTitle").val() === "") {
			alert("제목을 입력하여 주십시오.");
			$("#issueTitle").focus();
			return false;
		}
	} */
}
</script>
</body>
</html>
