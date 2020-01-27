
$(document).ready(function (){
	
	// 초기 레이어 트리 그리기  
	getLayerList();

    // 하위 영역 on/off
    $('#layerContent').on('click', '.mapLayer p', function(e) {
    	e.stopPropagation();
    	var $target = $(this).parent('li');
    	$target.toggleClass('on');
    });
    
    $('#layerContent').on('click', '.wmsLayer p', function(e) {
    	initLayer(MAGO3D_INSTANCE);
    });

});

// 관리자 레이어에서 기본표시가  사용인 항목들을 랜더링 
function initLayer(magoInstance, baseLayers) {
	var viewer = magoInstance.getViewer();
	var layerList = [];
	if(baseLayers) {
		layerList = baseLayers.split(",");
	} else {
		$("ul.layerList li ul li.wmsLayer.on").each(function(){
			var layerKey = $(this).attr("data-layer-name");
			layerList.push(NDTP.policy.geoserverDataStore+':'+layerKey);
		});
	}
	
	createWmsProvider(viewer, layerList);
}

// wmsProvider 생성 
function createWmsProvider(viewer, layerList) {
	if(NDTP.wmsProvider){
		viewer.imageryLayers.remove(NDTP.wmsProvider);
	}
	if(layerList.length === 0) return;
	var policy = NDTP.policy;
	var queryString = "enable_yn='Y'";
    var queryStrings = layerList.map(function(){ return queryString; }).join(';');	// map: ie9부터 지원
	var provider = new Cesium.WebMapServiceImageryProvider({
        url : policy.geoserverDataUrl + "/wms",
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
    
	NDTP.wmsProvider = viewer.imageryLayers.addImageryProvider(provider);
}

//레이어 메뉴 목록 조회
function getLayerList() {
    $.ajax({
        url: '/layer/list',
        type: 'GET',
        headers: {'X-Requested-With': 'XMLHttpRequest'},
        contentType: "application/json; charset=utf-8",
        dataType: 'json',
        success: function(res){
        	if(res.statusCode <= 200) {
            	// html 생성
                createLayerHtml(res.layerGroupList);
                var baseLayers = NDTP.baseLayers;
                if(baseLayers) {
            		layerList = baseLayers.split(",");
            		layerList.forEach(function(layer) {
            			var layer = layer.split(":")[1];
                		var target = $('#layerContent [data-layer-name="'+layer+'"]');
                		target.addClass("on");
                	});
                } 
			} else {
				alert(JS_MESSAGE[res.errorCode]);
				console.log("---- " + res.message);
			}
        },
        error: function(request, status, error) {
        	alert(JS_MESSAGE["ajax.error.message"]);
        }
    });
}

// 레이어 트리 html 랜더링 
function createLayerHtml(res) {
	var source = $("#templateLayerList").html();
    var template = Handlebars.compile(source);

    for(var i=0, len=res.length; i<len; i++) {
        var h = '';
        var selector = '';

        h += template(res[i]);

        if(res[i].depth === 1) {
            selector = $('#layerContent > ul');
            selector.append(h);
        } else {
        	selector = $('[data-depth=' + res[i].parent + '] > ul');
            selector.append(h);
        }
    }
}

// 사용자 레이어 설정 저장 
function saveUserLayers() {
	var layerList = [];
	var dataInfo = {};
	$("ul.layerList li ul li.wmsLayer.on").each(function(){
	    var layerKey = $(this).attr("data-layer-name");
	    layerList.push(NDTP.policy.geoserverDataStore+':'+layerKey);
	});
	dataInfo.baseLayers = layerList.join(",");
	
	$.ajax({
        url: '/user-policy/update-layers?baseLayers=' + layerList.join(","),
        type: 'POST',
        headers: {'X-Requested-With': 'XMLHttpRequest'},
        contentType: "application/json; charset=utf-8",
        dataType: 'json',
        success: function(res){
        	if(res.statusCode <= 200) {
        		alert(JS_MESSAGE["update"]);
			} else {
				alert(JS_MESSAGE[res.errorCode]);
				console.log("---- " + res.message);
			}
        },
        error: function(request, status, error) {
        	alert(JS_MESSAGE["ajax.error.message"]);
        }
    });
}
// 레이어 전체 켜기 
function turnOnAllLayer() {
	turnOffAllLayer();
	var layerList = [];
	$('.nodepth').addClass("on");
	$('.nodepth').each(function(){
		var layerKey = $(this).attr("data-layer-name");
	    layerList.push(NDTP.policy.geoserverDataStore+':'+layerKey);
	});
	
	createWmsProvider(MAGO3D_INSTANCE.getViewer(), layerList);
}
//레이어 전체 끄기
function turnOffAllLayer() {
	$('.nodepth').removeClass("on");
	MAGO3D_INSTANCE.getViewer().imageryLayers.remove(NDTP.wmsProvider);
}

// 레이어 트리 전체 펼치기 
function openAllLayerTree() {
	$(".mapLayer").addClass("on");
}

// 레이어 트리 전체 접기
function closeAllLayerTree() {
	$(".mapLayer").removeClass("on");
}