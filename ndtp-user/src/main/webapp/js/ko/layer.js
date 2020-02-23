
$(document).ready(function (){
	
	// 초기 레이어 트리 그리기  
	getLayerList();

    // 하위 영역 on/off
    $('#layerContent').on('click', '.mapLayer p', function(e) {
    	if(!initLayerCheck()) return;
    	e.stopPropagation();
    	var target = $(this).parent('li');
    	target.toggleClass('on');
    });
    
    // layer on/off
    $('#layerContent').on('click', '.nodepth p', function(e) {
    	layerOnOff($(this).parent("li"));
    });
});


function layerOnOff(obj) {
	var layerKey = $(obj).attr("data-layer-name");
	var flag = $(obj).hasClass("on");
	var serviceType = $(obj).attr("data-service-type");
	var cacheAvailable = $(obj).attr("data-tiling");
	if(serviceType === 'wms' && cacheAvailable ==='true') {
		if(flag) {
			NDTP.map.addTileLayer(layerKey);
		} else {
			NDTP.map.removeTileLayer(layerKey);
		}
	} else {
		if(serviceType === 'wms') {
			if(flag) {
				NDTP.map.addWMSLayer(layerKey);
			} else {
				NDTP.map.removeWMSLayer(layerKey);
			}
		} else if(serviceType ==='wfs') {
			if(flag) {
				NDTP.map.addWFSLayer(layerKey);
			} else {
				NDTP.map.removeWFSLayer(layerKey);
			}
		} else {
			alert(serviceType+" 타입은 지원하지 않는 서비스 타입입니다.");
		}
	}
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
            selector = $('#layerForm > ul');
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
	$('.nodepth').each(function(e){
		if($(this).hasClass("on")) {
			layerList.push($(this).attr("data-layer-name"));
		}
	});
	$("#baseLayers").val(layerList.join(","));
	
	$.ajax({
        url: '/user-policy/update-layers',
        type: 'POST',
        headers: {'X-Requested-With': 'XMLHttpRequest'},
        dataType: 'json',
        data : $("#layerForm").serialize(),
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
	if(!initLayerCheck()) return;
	$('.nodepth').addClass("on");
	NDTP.map.removeAllLayers();
	NDTP.map.initLayer(true);
}
//레이어 전체 끄기
function turnOffAllLayer() {
	if(!initLayerCheck()) return;
	$('.nodepth').removeClass("on");
	NDTP.map.removeAllLayers();
}

// 레이어 트리 전체 펼치기 
function openAllLayerTree() {
	if(!initLayerCheck()) return;
	$(".mapLayer").addClass("on");
}

// 레이어 트리 전체 접기
function closeAllLayerTree() {
	if(!initLayerCheck()) return;
	$(".mapLayer").removeClass("on");
}

function initLayerCheck() {
	if(!NDTP.map) {
		alert("로딩중입니다."); 
		return false;
	} else {
		return true;
	}
}