<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="ndtp.domain.Key"%>
<%@page import="ndtp.domain.UserSession"%>
<%@page import="ndtp.domain.CacheManager"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<header class="site-header">
	<div class="row">
		<div class="container">
			<h2 class="site-title u-pull-left" style="font-size:28px; font-family:Lousianne; color:#573592"><a href="/main/index">NDTP</a></h2>
			<aside class="site-aside-menu u-pull-right">
				<ul>
					<li>
						<a href="#">
							<span class="icon-glyph glyph-qmark-circle"></span>
							<a href="#" title="API도움말" onclick="goMagoAPIGuide();return false;">API도움말</a>
							
						</a>
					</li>
					<li>
<%
	UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
	if(userSession != null && userSession.getUserId() != null && !"".equals(userSession.getUserId())) {
%>
						<a href="/sign/signout">
							<span class="icon-glyph glyph-out"></span>
							<span class="icon-text"><spring:message code='signout'/></span>
						</a>
<%
	} else {
%>
						<a href="/sign/signin">
							<span class="icon-glyph glyph-on"></span>
							<span class="icon-text"><spring:message code='signin'/></span>
						</a>
<%
	}
%>					
					</li>
				</ul>
			</aside>
		</div>
	</div>
</header>
<script>
function goMagoAPIGuide() {
	var url = "/guide/help";
	//console.log("test");
	var width = 1200;
	var height = 800;

	// 만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음
	var popupX = (window.screen.width / 2) - (width / 2);
	var popupY = (window.screen.height / 2) - (height / 2);

	var popWin = window.open(url, "", "toolbar=no, width=" + width + " ,height=" + height + ", top=" + popupY + ", left=" + popupX +
			", directories=no,status=yes,scrollbars=no,menubar=no,location=no");
	return false;
}
</script>