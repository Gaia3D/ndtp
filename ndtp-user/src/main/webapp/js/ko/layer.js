$(document).ready(function (){
	// 트리 안그렸을때만 ajax 요청해서 랜더링 
	if($("ul.layerList li").length === 0){
		//레이어 목록 가져오기
		getLayerList();
//		initImageryLayer();
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

});

// 관리자 레이어에서 기본표시가  사용인 항목들을 랜더링 
function initDefaultLayer(viewer, policy) {
	var layerList = [];
	$("ul.layerList li ul li.wmsLayer.on").each(function(){
	    var layerKey = $(this).attr("data-layer-name");
	    layerList.push(policy.geoserverDataStore+':'+layerKey);
	});
	
	var queryString = "enable_yn='Y'";
    var queryStrings = layerList.map(function(){ return queryString; }).join(';');	// map: ie9부터 지원
//	var now = new Date();
//	var rand = ( now - now % 5000) / 5000;
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
//            ,rand:rand
            ,maxZoom : 25
            ,maxNativeZoom : 23
            ,CQL_FILTER: queryStrings
        },
        enablePickFeatures : false
    });
    
    LAYER_PROVIDER = viewer.imageryLayers.addImageryProvider(provider);
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