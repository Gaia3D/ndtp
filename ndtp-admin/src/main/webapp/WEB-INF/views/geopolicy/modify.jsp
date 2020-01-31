<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>운영정책 | NDTP</title>
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
	<link rel="stylesheet" href="/externlib/normalize/normalize.min.css" />
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css" />
	<link rel="stylesheet" href="/css/fontawesome-free-5.2.0-web/css/all.min.css">
    <link rel="stylesheet" href="/css/${lang}/admin-style.css" />
</head>
<body>
	<%@ include file="/WEB-INF/views/layouts/header.jsp" %>
	<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
	<div class="site-body">
		<div class="container">
			<div class="site-content">
				<%@ include file="/WEB-INF/views/layouts/sub_menu.jsp" %>
				<div class="page-area">
					<%@ include file="/WEB-INF/views/layouts/page_header.jsp" %>
					<div class="page-content">
						<div class="content-desc u-pull-right"><span class="icon-glyph glyph-emark-dot color-warning"></span><spring:message code='check'/></div>
						<div class="tabs">
							<ul>
								<li><a href="#geopolicyTab">공간정보</a></li>
								<li><a href="#geoserverTab">GeoServer</a></li>
							</ul>
							<spring:message var="notuse" code='not.use'/>
							<spring:message var="use" code='use'/>
							<%@ include file="/WEB-INF/views/geopolicy/modify-geopolicy.jsp" %>
							<%@ include file="/WEB-INF/views/geopolicy/modify-geoserver.jsp" %>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>

<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript" src="/js/navigation.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$( ".tabs" ).tabs();
	});

	var updatePolicyGeoInfoFlag = true;
	function updatePolicyGeoInfo() {
	    if(updatePolicyGeoInfoFlag) {
	        if( geoInfoCheck() === false ) return false;

	        updatePolicyGeoInfoFlag = false;
	        var formData = $('#geoPolicyGeoInfo').serialize();
	        $.ajax({
				url: "/geopolicy/modify-geopolicy",
				type: "POST",
				headers: {"X-Requested-With": "XMLHttpRequest"},
		        data: formData + "&geoPolicyId=${geoPolicy.geoPolicyId}",
				success: function(msg){
					if(msg.statusCode <= 200) {
						alert("공간정보 정책이 수정 되었습니다");
					} else {
						alert(JS_MESSAGE[msg.errorCode]);
						console.log("---- " + msg.message);
					}
					updatePolicyGeoInfoFlag = true;
				},
				error:function(request, status, error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updatePolicyGeoInfoFlag = true;
				}
			});
	    } else {
	        alert("진행 중입니다.");
	        return;
		}
	}

	var updatePolicyGeoServerFlag = true;
	function updatePolicyGeoServer() {
	    if(updatePolicyGeoServerFlag) {
	        if( geoserverCheck() === false ) return false;

	        updatePolicyGeoServerFlag = false;
	        var formData = $('#geoPolicyGeoServer').serialize();
	        $.ajax({
				url: "/geopolicy/modify-geoserver",
				type: "POST",
				headers: {"X-Requested-With": "XMLHttpRequest"},
		        data: formData + "&geoPolicyId=${geoPolicy.geoPolicyId}",
				success: function(msg){
					if(msg.statusCode <= 200) {
						alert("GeoServer 정책이 수정 되었습니다");
					} else {
						alert(JS_MESSAGE[msg.errorCode]);
						console.log("---- " + msg.message);
					}
					updatePolicyGeoServerFlag = true;
				},
				error:function(request, status, error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updatePolicyGeoServerFlag = true;
				}
			});
	    } else {
	        alert("진행 중입니다.");
	        return;
		}
	}

	function geoInfoCheck() {

	}
	function geoserverCheck() {

	}

</script>
</body>
</html>