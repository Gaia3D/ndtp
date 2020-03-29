<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="referrer" content="origin">
<meta name="viewport" content="width=device-width">
<meta name="robots" content="index,nofollow" />
<title>mago3DJS API | NDTP</title>
<link rel="shortcut icon" href="/images/favicon.ico?cacheVersion=${contentCacheVersion}">
<link rel="stylesheet" href="/externlib/cesium/Widgets/widgets.css?cacheVersion=${contentCacheVersion}" />
<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css?cacheVersion=${contentCacheVersion}" />
<link rel="stylesheet" href="/externlib/highlightjs/styles/dark.css?cacheVersion=${contentCacheVersion}">
<link rel="stylesheet" href="/css/ko/apihelp-style.css?cacheVersion=${contentCacheVersion}" />
<script src="/externlib/highlightjs/highlight.pack.js?cacheVersion=${contentCacheVersion}"></script>

</head>
<body>
	<div id="popupWrap">
		<div class="popupSub">
			<h3>
				<a onclick="changeToggleTab(0)">mago3D.JS API</a>
			</h3>
			<div class="searchWrap">
			<label for="searchApi"></label>
				<input type="text" id="searchApi" placeholder="검색어를 입력하세요">
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
							<img src="/images/ko/common/magologo.JPG" alt="메인">
								<h2>mago3D.JS V1.0.5</h2>
								<br>
								<img src="/images/ko/common/lisense.JPG" alt="라이센스">
								<br>
								<h3>3D 멀티 블록 시각화를 위한 오픈 소스 자바 스크립트 라이브러리</h3>
								<p>AEC(Architecture Engineering Construction) 영역과 전통적인 3D 공간 정보 (3D GIS)를 통합하고 시각화하는 차세대 3D GIS 플랫폼입니다. 실내 및 실외에서 구별 할 수 없는 웹 브라우저에 AEC 및 3D GIS를 통합하십시오.</p>
								<p>웹 브라우저에 프로그램을 설치하지 않고도 대규모 BIM(Building Information Modeling), JT(Jupiter Tessellation) 및 3D GIS 파일을 찾아보고 공동 작업 할 수 있습니다.</p>
								
								<h3>개발 환경</h3>
								<p>Java8, eclipse, neon, node, apache, jasmine, jsdoc, Gulp, eslint, Jquery</p>
								
								<h3>Getting Started</h3>
								<br>
								<ol class="mainlist">
									<li>소스 설치
										<ul class="mainlist">
											<li>github It accepts mago3DJS from.</li>
											<li>Installation path C://git/repository/mago3djs</li>
										</ul>
									</li>
									<li>Node 설치
										<ul class="mainlist">
											<li>npm install</li>
											<li>npm install -g gulp</li>
										</ul>
									</li>
									<li>Node Server 실행
										<ul class="mainlist">
											<li>Running a local server: C:\git\repository\mago3djs > node server.js</li>
											<li>Running a public server: C:\git\repository\mago3djs > node server.js --public true</li>
										</ul>
									</li>
									<li>Symbolic Link 생성
										<ul class="mainlist">
											<li>Create Data Folder: mklink /d "C:\git\repository\mago3djs\data" "C:\data"</li>
											<li>Delete data folder: C:\git\repository\mago3djs > rmdir data</li>
										</ul>
									</li>
								</ol>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js?cacheVersion=${contentCacheVersion}"></script>
	<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js?cacheVersion=${contentCacheVersion}"></script>
	<script type="text/javascript" src="/externlib/cesium/Cesium.js"></script>
	<script type="text/javascript" src="/externlib/cesium-geoserver-terrain-provider/GeoserverTerrainProvider.js?cacheVersion=${contentCacheVersion}"></script>
	<script type="text/javascript" src="/externlib/decodeTextAlternative/encoding-indexes.js?cacheVersion=${contentCacheVersion}"></script>
	<script type="text/javascript" src="/externlib/decodeTextAlternative/encoding.js?cacheVersion=${contentCacheVersion}"></script>
	<script type="text/javascript" src="/externlib/moment-2.22.2/moment-with-locales.min.js?cacheVersion=${contentCacheVersion}"></script>
	<script type="text/javascript" src="/js/mago3d.js?cacheVersion=${contentCacheVersion}"></script>
	<script type="text/javascript" src="/js/mago3d_lx.js?cacheVersion=${contentCacheVersion}"></script>
	<script type="text/javascript" src="/js/ko/common.js?cacheVersion=${contentCacheVersion}"></script>
	<script type="text/javascript" src="/js/ko/message.js?cacheVersion=${contentCacheVersion}"></script>
	

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
var geoPolicyJson;
initBasePolicy(function(policy){
	geoPolicyJson = policy; 
	magoInit2();
});

function magoInit2() {
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
	var viewer = magoInstance.getViewer();
	var magoManager = magoInstance.getMagoManager();
	var f4dController = magoInstance.getF4dController();
	if(viewer.baseLayerPicker) viewer.baseLayerPicker.destroy();
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
				cesiumCreditAlt();
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
// 	cesiumCreditAlt();
});
function changeToggleTab(apiIndex){
	$('.item').removeClass('on');

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
            	var test = ($('.paramContainer')[0].innerHTML).split("\n");
            	var testString = "";
            	var offsetLength = ($('.paramContainer')[0].innerHTML).replace(/\t/gi,"    ").indexOf( "<" )-1;
            	for(var i = 0; i < test.length; i++){
            		test[i] = test[i].replace(/\t/gi,"    ");
            		if(test[i].length >(($('.paramContainer')[0].innerHTML).replace(/\t/gi,"    ").indexOf( "<" )-1)){
            			if(offsetLength>test[i].indexOf( "<" )){
            				offsetLength = test[i].indexOf( "<" );
            			}
            			
            		}
            	}
            	for(var i = 0; i < test.length; i++){
            		test[i] = test[i].replace(/\t/gi,"    ");
            		if(test[i].length >(($('.paramContainer')[0].innerHTML).replace(/\t/gi,"    ").indexOf( "<" )-1)){
            			testString += test[i].substr(offsetLength, test[i].length);
                		testString += "\n";
            		}
            	}
            	var testString;
   				var parmScript = document.createTextNode(testString);
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
			/* for (var i =0; i< $("code").children('.hljs-tag').length; i++) {
				if($("code").children('.hljs-tag')[i].childNodes[0].nodeValue=="</"){
					$("code").children('.hljs-tag')[i].childNodes[2].nodeValue = $("code").children('.hljs-tag')[i].childNodes[2].nodeValue+"\n";
				}
				if($("code").children('.hljs-tag')[i].childNodes[1].childNodes[0].wholeText=="br"){
					console.log($("code").children('.hljs-tag')[i].childNodes[2].nodeValue);
					$("code").children('.hljs-tag')[i].childNodes[2].nodeValue = $("code").children('.hljs-tag')[i].childNodes[2].nodeValue+"\n";
				}
			}; */
			
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
				var id = $(this).attr('id');
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
				 if($('#resultContainer').length!=0){
					 $('.popupGroup').stop().animate({scrollTop:$('.menu_tab00').height()},800);
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

function initBasePolicy(callback) {
	$.ajax({
		url: "/geopolicies",
		type: "GET",
		headers: {"X-Requested-With": "XMLHttpRequest"},
		dataType: "json",
		success: function(msg){
			if(msg.statusCode <= 200) {
				callback(msg.geoPolicy);
			} else {
				alert(JS_MESSAGE[msg.errorCode]);
			}
		},
		error:function(request,status,error){
			alert(JS_MESSAGE["ajax.error.message"]);
		}
	});
}
</script>
</body>
</html>
