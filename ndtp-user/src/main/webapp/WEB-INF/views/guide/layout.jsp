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

</head>
<body>
	<div id="popupWrap">
		<div class="popupSub">
			<h3>
				<a onclick="changeToggleTab(0)">mago3D.JS API</a>
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
					<div id="api0" class="api-help-toggle">
						<img src="/images/ko/common/main.png" alt="메인">
					</div>
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
	var jspList = ["main","change-mago-state", "change-label", "change-origin",
		"change-bounding-box", "change-property-rendering", "change-shadow", 
		"change-color", "change-location-and-rotation", "change-object-move",
		"delete-all-object-move", "delete-all-change-color",
		"change-insert-issue-mode", "change-object-info-view-mode", "change-occlusion-culling",
		"change-FPV-mode", "change-lod", "change-lighting", "change-ssao-radius",
		"clear-all-data", "draw-insert-issue-image", "goto-project",
		"goto-issue", "search-data", "is-data-exist",
		"get-data", "get-data-info-by-data-key", "draw-append-data",
		"goto-fly", "get-coordinate-relative-to-building", "get-absolute-coodinate-of-building-point",
		"get-camera-current-position", "get-camera-current-orientaion", "change-camera-orientation",
		"instantiate-static-model", "add-static-model", "set-track-node", "stop-track",
		"is-exist-static-model", "is-exist-data", "is-data-ready-to-render",
		"set-node-attribute", "toggle-point-cloud-color"];
	var apiList = ["main","changeMagoStateAPI", "changeLabelAPI", "changeOriginAPI",
		"changeBoundingBoxAPI", "changePropertyRenderingAPI", "changeShadowAPI", 
		"changeColorAPI", "changeLocationAndRotationAPI", "changeObjectMoveAPI",
		"deleteAllObjectMoveAPI", "deleteAllChangeColorAPI",
		"changeInsertIssueModeAPI", "changeObjectInfoViewModeAPI", "changeOcclusionCullingAPI",
		"changeFPVModeAPI", "changeLodAPI", "changeLightingAPI", "changeSsaoRadiusAPI",
		"clearAllDataAPI", "drawInsertIssueImageAPI", "gotoProjectAPI",
		"gotoIssueAPI", "searchDataAPI", "isDataExistAPI",
		"getDataAPI", "getDataInfoByDataKeyAPI", "drawAppendDataAPI",
		"gotoFlyAPI", "getCoordinateRelativeToBuildingAPI", "getAbsoluteCoodinateOfBuildingPointAPI",
		"getCameraCurrentPositionAPI", "getCameraCurrentOrientaionAPI", "changeCameraOrientationAPI",
		"instantiateStaticModelAPI", "addStaticModelAPI", "setTrackNodeAPI", "stopTrackAPI",
		"isExistStaticModelAPI", "isExistDataAPI", "isDataReadyToRenderAPI",
		"setNodeAttributeAPI", "togglePointCloudColorAPI"];

		for(var i = 1; i<apiList.length; i++){
			
			 $(".popupSub").children('ul').append("<li class=\"item\"><a class=\"name\" href=\"\" onclick=\"changeToggleTab("+i+"); return false;\">"+apiList[i]+"</a></li>");
		}
		
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
				console.log(res);
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


$( document ).ready(function() {
	cesiumCreditAlt();

});
function changeToggleTab(apiIndex){

    // Contents 영역 삭제
    $('#testtoggle').children().remove();
	var index = new Number(apiIndex);
        // ajax option
        var ajaxOption = {
                url : "/guide/loadPage",
                async : true,
                type : "POST",
                data : {
                	api : jspList[index]
                },
                dataType : "html",
                cache : false
        };
        
        $.ajax(ajaxOption).done(function(data){
        	
            // Contents 영역 교체
            $('#testtoggle').scrollTop(0);
            $('#testtoggle').html(data);
            var codeTabContainer1 = document.createElement("div");
            codeTabContainer1.setAttribute("class", "codeTabContainer1");
            var codeTabContainer2 = document.createElement("div");
            codeTabContainer2.setAttribute("class", "codeTabContainer2");
            if(document.getElementsByClassName("paramContainer").length!=0){
   			 
   				var parmScript = document.createTextNode(($('.paramContainer')[0].innerHTML).replace(/\s{2,}/gi, ' '));
   				
   				var preTagBr = document.createElement("br");
   				var codeParmTag = document.createElement("code");
   				
   				codeParmTag.setAttribute("class","html");
   				codeParmTag.appendChild(parmScript);
   				var preTagParm = document.createElement("pre");
   				preTagParm.appendChild(codeParmTag);
   				codeTabContainer1.appendChild(preTagParm);
   				codeTabContainer1.appendChild(preTagBr);
   				
   				var codeTitle1 = document.createElement("h4");
   				var txt = document.createTextNode("HTML");
   				codeTitle1.appendChild(txt);
   				$('.menu_tab01')[0].appendChild(codeTitle1);
   	            $('.menu_tab01')[0].appendChild(codeTabContainer1);
   	            
   				// hilight
   				document.querySelector('.codeTabContainer1').querySelectorAll('pre code').forEach((block) => {
   				    hljs.highlightBlock(block);
   				  });
   			}
            if($('.api-help-toggle').next()[0]){
      			
   				var script = document.createTextNode($('.api-help-toggle').next()[0].text);
   				var preTagBr = document.createElement("br");
   				
   				var codeScriptTag = document.createElement("code");
   				codeScriptTag.setAttribute("class","javascript");
   				codeScriptTag.appendChild(script);		
   				var preTagScript = document.createElement("pre");
   				preTagScript.appendChild(codeScriptTag);
   				codeTabContainer2.appendChild(preTagBr);
   				codeTabContainer2.appendChild(preTagScript);
   				
   				var codeTitle2 = document.createElement("h4");
   				var txt = document.createTextNode("JAVASCRIPT");
   				codeTitle2.appendChild(txt);
   				$('.menu_tab01')[0].appendChild(codeTitle2);
   				$('.menu_tab01')[0].appendChild(codeTabContainer2);
   				
   				// hilight
   				document.querySelector('.codeTabContainer2').querySelectorAll('pre code').forEach((block) => {
   				    hljs.highlightBlock(block);
   				  });
   			}
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
						alert("적어도 1개 이상의 값을 입력해 주세요!");
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
						alert("적어도 1개 이상의 값을 입력해 주세요!");
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
						alert("적어도 1개 이상의 값을 입력해 주세요!");
						return;
					}
					window[id]();
				}else{
					for(var i = 0; i<inputTags.length; i++){
						if(inputTags[i].dataset.require === 'true' &&  (inputTags[i].value=="" || null || undefined) ){
							alert("필수값을 모두 입력해 주세요!");
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
