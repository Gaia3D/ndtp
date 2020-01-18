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
								<li><a href="#userTab">사용자</a></li>
								<li><a href="#passwordTab">비밀번호</a></li>
								<li><a href="#noticeTab">알림</a></li>
								<li><a href="#securityTab">보안</a></li>
								<li><a href="#contentTab">컨텐트</a></li>
								<li><a href="#uploadTab">사용자 업로딩 파일</a></li>
							</ul>
							
							<div id="userTab">
							<form:form id="policyUser" modelAttribute="policy" method="post" onsubmit="return false;">
								<form:hidden path="policyId" />
							<table class="input-table scope-row">
								<col class="col-label l" />
								<col class="col-input" />
								<tr>
									<th class="col-label l" scope="row">
										<form:label path="userIdMinLength">사용자 아이디 최소길이</form:label>
										<span class="icon-glyph glyph-emark-dot color-warning"></span>
									</th>
									<td class="col-input">
										<form:input path="userIdMinLength" maxlength="2" cssClass="s" />
										<span class="table-desc">5이상</span>
										<form:errors path="userIdMinLength" cssClass="error" />
									</td>
								</tr>
								<tr>
									<th class="col-label l" scope="row">
										<form:label path="userFailSigninCount">로그인 실패 횟수</form:label>
										<span class="icon-glyph glyph-emark-dot color-warning"></span>
									</th>
									<td class="col-input">
										<form:input path="userFailSigninCount" maxlength="2" cssClass="s" />
										<form:errors path="userFailSigninCount" cssClass="error" />
									</td>
								</tr>
								<tr>
									<th class="col-label l" scope="row">
										<form:label path="userFailLockRelease">로그인 실패 잠금 해제 기간</form:label>
										<span class="icon-glyph glyph-emark-dot color-warning"></span>
									</th>
									<td class="col-input">
										<form:input path="userFailLockRelease" maxlength="2" cssClass="s" />
										<form:errors path="userFailLockRelease" cssClass="error" />
									</td>
								</tr>
							</table>
							<div class="button-group">
								<div class="center-buttons">
											<a href="#" onclick="updatePolicyUser();" class="button"><spring:message code='save'/></a>
								</div>
							</div>
							</form:form>
						</div>
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
</script>
</body>
</html>