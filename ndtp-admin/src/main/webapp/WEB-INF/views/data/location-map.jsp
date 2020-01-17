<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
    <meta charset="utf-8">
    <meta name="referrer" content="origin">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <meta name="robots" content="index,nofollow"/>
    <title>지도에서 찾기 | NDTP</title>
    <link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
	<link rel="stylesheet" href="/externlib/normalize/normalize.min.css" />
	<link rel="stylesheet" href="/externlib/cesium/Widgets/widgets.css" />
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css" />
    <link rel="stylesheet" href="/css/${lang}/style.css" />
    <style type="text/css">
	    .mapWrap {
			height: 100%;
			background-color: #eee;
		}
    </style>
 </head>
<body>
    <div id="magoContainer" style="height: 699px;">
	</div>
</body>
<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script type="text/javascript" src="/externlib/cesium/Cesium.js"></script>
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript" src="/js/navigation.js"></script>
<script type="text/javascript" src="/js/mago3d.js"></script>

<script type="text/javascript">
	var managerFactory = null;
	var policyJson = ${policyJson};
	var FPVModeFlag = false;
	
	var imagePath = "/images/${lang}/mago3d";
	magoStart();
	var intervalCount = 0;
	var timerId = setInterval("startMogoUI()", 1000);
	
	function startMogoUI() {
		intervalCount++;
		if(managerFactory != null && managerFactory.getMagoManagerState() === Mago3D.CODE.magoManagerState.READY) {
			gotoFlyAPI(managerFactory, 127.5820, 36.5100, 170000, 2);
			
			// Label 표시
			//changeLabel(false);
			// object 정보 표시
			//changeObjectInfoViewMode(true);
            // Origin 표시
            //changeOrigin(false);
			// BoundingBox
			//changeBoundingBox(false);
			// Selecting And Moving
			//changeObjectMove("2");
			// slider, color-picker
			//initRendering();
			
			// Test. ****************
			//changeMagoStateAPI(managerFactory, false);
			
			// 3PView Mode
			//changeViewMode(false);
			
			clearInterval(timerId);
			console.log(" managerFactory != null, managerFactory.getMagoManagerState() = " + managerFactory.getMagoManagerState() + ", intervalCount = " + intervalCount);
			return;
		}
		console.log("--------- intervalCount = " + intervalCount);
	}
	
	// mago3d 시작, 정책 데이터 파일을 로딩
	function magoStart() {
		managerFactory = new Mago3D.ManagerFactory(null, "magoContainer", policyJson, null, null, null, imagePath);
	}

	function showClickPosition(position) {
		$(opener.document).find("#latitude").val(position.lat);
		$(opener.document).find("#longitude").val(position.lon);
		$(opener.document).find("#altitude").val(position.alt);
	}
	
</script>
</html>