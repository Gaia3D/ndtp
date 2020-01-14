<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>데이터 목록 | NDTP</title>
	
	<link rel="stylesheet" href="/externlib/cesium/Widgets/widgets.css" />
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css" />
	<link rel="stylesheet" href="/css/${lang}/user-style.css" />
	<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
	<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>
	<style type="text/css">
	    
    </style>
</head>
<body>

<%@ include file="/WEB-INF/views/layouts/header.jsp" %>

<div id="wrap">
	<!-- S: NAVWRAP -->
	<div class="navWrap">
	 	<%@ include file="/WEB-INF/views/layouts/menu.jsp" %> 
	</div>
	<!-- E: NAVWRAP -->
	
	<div style="float:right; width: calc(100% - 78px);">
		<div style="padding: 20px 20px 10px 10px; font-size: 18px;">업로딩 데이터 자동 변환</div>
		<div class="tabs" >
			<ul>
				<li><a href="#user_info_tab">업로딩 목록</a></li>
				<li><a href="#user_device_tab">업로딩</a></li>
				<li><a href="#user_device_tab2">데이터 변환</a></li>
				<li><a href="#user_device_tab3">데이터 그룹 등록</a></li>
			</ul>
			
			<%-- <%@ include file="/WEB-INF/views/upload-data/modify-policy-user.jsp" %> --%>
			
			<div id="user_info_tab">
				<form:form id="uploadData" modelAttribute="uploadData" method="post" onsubmit="return false;">
				<table class="input-table scope-row">
					<col class="col-label" />
					<col class="col-input" />
					<tr>
						<th class="col-label" scope="row">
							<form:label path="userId">아이디</form:label>
							<span class="icon-glyph glyph-emark-dot color-warning"></span>
						</th>
				</table>
				
				<div class="button-group">
					<div id="insertUserLink" class="center-buttons">
						<input type="submit" value="저장" onclick="insertUser();" />
						<a href="/user/list-user.do" class="button">목록</a>
					</div>
				</div>
				</form:form>
			</div>
			<div id="user_device_tab">
				<form:form id="converterJobForm" modelAttribute="converterJobForm" method="post" onsubmit="return false;">
				<table class="input-table scope-row">
					<col class="col-label" />
					<col class="col-input" />
					<tr>
						<th class="col-label" scope="row">
							<form:label path="userId">아이디</form:label>
							<span class="icon-glyph glyph-emark-dot color-warning"></span>
						</th>
				</table>
				
				<div class="button-group">
					<div id="insertUserLink" class="center-buttons">
						<input type="submit" value="저장" onclick="insertUser();" />
						<a href="/user/list-user.do" class="button">목록</a>
					</div>
				</div>
				
				<div class="button-group">
					<div id="insertUserLink" class="center-buttons">
						<input type="submit" value="저장" onclick="insertUser();" />
						<a href="/user/list-user.do" class="button">목록</a>
					</div>
				</div>
				</form:form>
			</div>
		</div>
	</div>
	
</div>
<!-- E: WRAP -->

<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript" src="/js/${lang}/MapControll.js"></script>
<script type="text/javascript" src="/js/${lang}/uiControll.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$( ".tabs" ).tabs();
		$('.convert').addClass('on');
	});
</script>
</body>
</html>
