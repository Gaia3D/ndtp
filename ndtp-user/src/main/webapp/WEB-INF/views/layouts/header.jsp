<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="ndtp.domain.Key"%>
<%@page import="ndtp.domain.UserSession"%>
<%@page import="ndtp.domain.CacheManager"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>

<header>
	<h1>
		국가 디지털트윈 플랫폼 시범 서비스
	</h1>
	<div class="signArea">
<%
	UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
	if(userSession != null && userSession.getUserId() != null && !"".equals(userSession.getUserId())) {
%>
		<span><%=userSession.getUserName() %> 님</span>
		<a href="/sign/signout" class="signButton">Sign out</a>
<%
	} else {
%>		
		<a href="/sign/signin" class="signButton">Sign in</a>
<%
	}
%>		
	</div>
</header>