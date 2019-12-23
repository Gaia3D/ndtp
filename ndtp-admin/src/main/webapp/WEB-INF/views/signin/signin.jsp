<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>Sign In</title>
	<link rel="shortcut icon" href="/images/favicon.ico">
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
	<link rel="stylesheet" href="/externlib/normalize/normalize.min.css" />
	<link rel="stylesheet" href="/css/${lang}/style.css" />
	<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
	<script type="text/javascript" src="/js/${lang}/common.js"></script>
	<script type="text/javascript" src="/js/${lang}/message.js"></script>
</head>
<body class="sign">
	<div class="site-body">
		<div class="row">
			<div class="container">
				<div class="row">
					<h1 style="padding-bottom:10px; font-size:38px; font-family:Lousianne; color:#573592;">NDTP</h1>
<c:if test="${signinForm.errorCode ne null && signinForm.errorCode ne ''}">
					<h6 style="padding-left: 10px; color: red;">* 
						<spring:message code="${signinForm.errorCode}" />
					</h6>
</c:if>
				</div>
				<div class="panel row">
					<h2 class="sign-title"><span class="text-sub">Administrator</span><br /><span class="text-main">SIGN IN</span></h2>
					<div class="sign-inputs">
						<div class="sign-desc">National Smart City Platform</div>
						
						<form:form id="signinForm" modelAttribute="signinForm" method="post" action="/signin/process-signin">
							<label for="userId"><span class="icon-glyph glyph-users"></span></label>
							<input type="text" id="userId" name="userId" maxlength="32" title="아이디" placeholder="아이디" required="required" autofocus="autofocus" />
							<label for="password"><span class="icon-glyph glyph-lock"></span></label>
							<input type="password" id="password" name="password" maxlength="32" title="비밀번호" placeholder="비밀번호" required="required" />
							<input type="submit" value="Sign In" class="sign-submit" />
						</form:form>					
						<div class="sign-links">
							Don't have an account? &nbsp;<a href="#">Sign up</a>
							<br />
							Forgot your password? &nbsp;<a href="<c:url value="/signin/find-password"/>" onclick="alert('준비중입니다.); return false;">Click</a>
						</div>
					</div>
				</div>
			</div>
			<div class="" style="text-align: center; margin-top: 50px;">
				NDTP ⓒ Gaia3d Corp. All Rights Reserved
			</div>
 		</div>
	</div>
	
<script type="text/javascript">
</script>
</body>
</html>