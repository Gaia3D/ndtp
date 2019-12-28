<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>Layer 그룹 등록 | NDTP</title>
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
	<link rel="stylesheet" href="/externlib/normalize/normalize.min.css" />
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css" />
    <link rel="stylesheet" href="/css/${lang}/style.css" />
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
						<div class="input-header row">
							<div class="content-desc u-pull-right"><span class="icon-glyph glyph-emark-dot color-warning"></span><spring:message code='check'/></div>
						</div>
						<form:form id="layerGroup" modelAttribute="layerGroup" method="post" onsubmit="return false;">
						<table class="input-table scope-row">
							<col class="col-label l" />
							<col class="col-input" />
							<tr>
								<th class="col-label" scope="row">
									<form:label path="layerGroupName">Layer 그룹명</form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input">
									<form:input path="layerGroupName" cssClass="l" readonly="true" />
								</td>
							</tr>
							<tr>
								<th class="col-label" scope="row">
									<form:label path="parentName">상위 그룹</form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input">
									<form:hidden path="parent" />
		 							<form:input path="parentName" cssClass="l" readonly="true" />
									<input type="button" id="layerGroupButtion" value="상위 그룹 선택" />
								</td>
							</tr>
							<tr>
								<th class="col-label l" scope="row">
									<span>사용여부</span>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input radio-set">
									<input type="radio" id="availableTrue" name="available" value="true" checked>
									<label for="availableTrue">사용</label>
									<input type="radio" id="availableFalse" name="available" value="false">
									<label for="availableFalse">미사용</label>
								</td>
							</tr>
							<tr>
								<th class="col-label l" scope="row"><form:label path="description"><spring:message code='description'/></form:label></th>
								<td class="col-input"><form:input path="description" cssClass="xl" /></td>
							</tr>
						</table>
						<div class="button-group">
							<div class="center-buttons">
								<input type="submit" value="<spring:message code='save'/>" onclick="insertLayerGroup();"/>
								<a href="/role/list-role.do?pageNo=${pagination.pageNo }" class="button">목록</a>
							</div>
						</div>
						</form:form>
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
	});
	
	function check() {
		if ($("#role_name").val() == "") {
			alert(JS_MESSAGE["role.insert.name"]);
			$("#role_name").focus();
			return false;
		}
		if ($("#role_key").val() == "") {
			alert(JS_MESSAGE["role.insert.key"]);
			$("#role_key").focus();
			return false;
		}
		if ($("#role_type").val() == "") {
			alert(JS_MESSAGE["role.insert.type"]);
			$("#role_type").focus();
			return false;
		}
	}
	
	// 저장
	var insertRoleFlag = true;
	function insertRole() {
		if (check() == false) {
			return false;
		}
		if(insertRoleFlag) {
			insertRoleFlag = false;
			var info = $("#role").serialize();		
			$.ajax({
				url: "/role/ajax-insert-role.do",
				type: "POST",
				data: info,
				cache: false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["insert"]);
						$("#insertRoleLink").empty();
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					insertRoleFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        insertRoleFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
</script>
</body>
</html>