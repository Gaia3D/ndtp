$(document).ready(function (){
    // 레이어 목록 가져오기
    $('#layerMenu').on('click', function() {
        getLayerList();
    });

    // 하위 영역 on/off
    $('#layerContent').on('click', '.mapLayer p', function(e) {
    	e.stopPropagation();
    	var $target = $(this).parent('li');
    	$target.toggleClass('on');
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