
$(document).ready(function (){
	
	// 초기 레이어 트리 그리기  
	getLayerList();

    // 하위 영역 on/off
    $('#layerContent').on('click', '.mapLayer p', function(e) {
    	e.stopPropagation();
    	var target = $(this).parent('li');
    	target.toggleClass('on');
//    	var parent = target.attr("data-depth");
//    	$('.nodepth').each(function(e){
//    	    if($(this).attr("data-parent") === parent) {
//    	    	var serviceType = $(this).attr("data-service-type");
//    	    	var layerKey = $(this).attr("data-layer-name");
//    	    	var cacheAvailable = $(this).attr("data-tiling");
//    	    	var layerList = [];
//    	    	if(target.hasClass("on")) {
//    	    		if(serviceType ==='wms' && cacheAvailable ==='true') {
//						this.addTileLayer(layerKey);
//					} else if (serviceType ==='wms' && cacheAvailable ==='false') {
//						layerList.push(layerKey);
//					} else if(serviceType ==='wfs') {
//						this.addWFSLayer(layerKey);
//					} else {
//						alert(serviceType+" 타입은  지원하지 않습니다.");
//					}
//    	    	} else {
//    	    		if(serviceType ==='wms' && cacheAvailable ==='true') {
//						this.addTileLayer(layerKey);
//					} else if (serviceType ==='wms' && cacheAvailable ==='false') {
//						wmsLayerList.push(layerKey);
//					} else if(serviceType ==='wfs') {
//						this.addWFSLayer(layerKey);
//					} else {
//						alert(serviceType+" 타입은  지원하지 않습니다.");
//					}
//    	    	}
//    	    }
//    	})
    });
    
    // wms layer on/off
    $('#layerContent').on('click', '.wmsLayer p', function(e) {
    	var target = $(this).parent('li');
    	var layerKey = target.attr("data-layer-name");
    	// 캐시  사용할 경우  
    	if(target.attr("data-tiling") === 'true') {
    		if(target.hasClass("on")) {
    			NDTP.map.addTileLayer(layerKey);
    		} else {
    			NDTP.map.removeTileLayer(layerKey);
    		}
    	} else {
    		var layerList = [];
    		$("ul.layerList li ul li.wmsLayer.on").each(function() {
    			var layerKey = $(this).attr("data-layer-name");
    			var tiling = $(this).attr("data-tiling");
    			if(tiling === 'false') {
    				layerList.push(layerKey);
    			}
    		});
    		NDTP.map.initWMSLayer(layerList);
    	}
    });
    
    // wfs layer on/off
    $('#layerContent').on('click', '.wfsLayer p', function(e) {
    });
});

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

// 사용자 레이어 설정 저장 
function saveUserLayers() {
	var layerList = [];
	var dataInfo = {};
	$("ul.layerList li ul li.wmsLayer.on").each(function(){
	    var layerKey = $(this).attr("data-layer-name");
	    layerList.push(layerKey);
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
	$('.nodepth').addClass("on");
	NDTP.map.removeAllLayer();
	NDTP.map.initLayer(true);
}
//레이어 전체 끄기
function turnOffAllLayer() {
	$('.nodepth').removeClass("on");
	NDTP.map.removeAllLayer();
}

// 레이어 트리 전체 펼치기 
function openAllLayerTree() {
	$(".mapLayer").addClass("on");
}

// 레이어 트리 전체 접기
function closeAllLayerTree() {
	$(".mapLayer").removeClass("on");
}