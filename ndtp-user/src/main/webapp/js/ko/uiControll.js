$(function() {
	// 상세 메뉴 닫기
	$('button#closeLeftBtn').click(function() {
		//$('ul.nav li[data-nav]').removeClass('on');
		
		$('#contentsWrap').hide();
		$('ul.nav li.on').removeClass('on');
		//$('#closeLeftBtn').toggle();
	});

/***** NAV WRAP: 메뉴 *****/
    // 상세 메뉴 클릭 시 기본 동작
    $("ul.nav li[data-nav]:not(:empty)").click(function() {
        var active = $(this).attr('data-nav');
        var display = $(this).toggleClass('on').hasClass('on');
        if(active === "convertContent") {
        	window.location="../upload-data/list";
        }
        
        $("ul.nav li[data-nav]:not(:empty)").not($(this)).each(function() {
            $(this).removeClass('on');
            $('#' + $(this).attr('data-nav')).hide();
        });

        $('#'+ active).toggle(display);
        $('#contentsWrap').toggle(display);
    });

    
/***** Contents Wrap: 공간분석 *****/	
	// 공간분석 그룹 클릭 시	
	$('#spatialContent ul.listDrop li > p').click(function(e) {
		var parentObj = $(this).parent();
		var index = parentObj.index();
		$('#spatialContent ul.listDrop > li').eq(index).toggleClass('on');
	});
	
/***** Contents Wrap: 공간분석 *****/	
	// 시뮬레이션 그룹 클릭 시	
	$('#simulationContent ul.listDrop li > p').click(function() {
		var parentObj = $(this).parent();
		var index = parentObj.index();
		$('#simulationContent ul.listDrop > li').eq(index).toggleClass('on');
	});
});
