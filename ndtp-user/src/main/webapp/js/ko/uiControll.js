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
        // 변환(upload-data)이 아닌 컨텐츠 클릭시 다시 지도 페이지로 돌아감 
        if(location.href.indexOf("upload") > 0) {
        	$(this).removeClass('on');
        	var classId = $(this).attr('class');
        	window.location="../data/list?activeContent="+classId;
        }
        
        // 변환 클릭 이벤트시 url 변경 
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
