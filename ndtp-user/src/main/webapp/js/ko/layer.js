
$(document).ready(function (){
	// 트리 안그렸을때만 ajax 요청해서 랜더링 
	if($("ul.layerList li").length === 0){
		//레이어 목록 가져오기
		getLayerList();
	}
	
//    $('#layerMenu').on('click', function() {
//    	
//    });

    // 하위 영역 on/off
    $('#layerContent').on('click', '.mapLayer p', function(e) {
    	e.stopPropagation();
    	var $target = $(this).parent('li');
    	$target.toggleClass('on');
    });
    
    $('#layerContent').on('click', '.wmsLayer p', function(e) {
    	initLayer(MAGO3D_INSTANCE, NDTP.policy);
    });

});

// 관리자 레이어에서 기본표시가  사용인 항목들을 랜더링 
function initLayer(magoInstance) {
	var viewer = magoInstance.getViewer();
	if(NDTP.wmsProvider){
		viewer.imageryLayers.remove(NDTP.wmsProvider);
	}
	var layerList = [];
	var policy = NDTP.policy;
	$("ul.layerList li ul li.wmsLayer.on").each(function(){
	    var layerKey = $(this).attr("data-layer-name");
	    layerList.push(policy.geoserverDataStore+':'+layerKey);
	});
	
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

//레이어 전체 끄기
function turnOffAllLayer() {
	$('#layerContent .nodepth.on').each(function() {
		$(this).find('p').trigger('click');
	});
}