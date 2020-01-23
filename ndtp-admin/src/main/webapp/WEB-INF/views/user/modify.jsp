<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>사용자 수정 | NDTP</title>
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
	<link rel="stylesheet" href="/externlib/normalize/normalize.min.css" />
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css" />
	<link rel="stylesheet" href="/externlib/dropzone/dropzone.min.css">
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
						<div class="input-header row">
							<div class="content-desc u-pull-right"><span class="icon-glyph glyph-emark-dot color-warning"></span><spring:message code='check'/></div>
						</div>
						<form:form id="userInfo" modelAttribute="userInfo" method="post" onsubmit="return false;">
						<table class="input-table scope-row">
							<col class="col-label" />
							<col class="col-input" />
			                <tr>
								<th class="col-label" scope="row">
									<form:label path="userId"><spring:message code='user.id'/></form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input">
									<form:input path="userId" cssClass="m" readonly="true" />
								</td>
							</tr>
			                <tr>
								<th class="col-label" scope="row">
									<form:label path="userGroupName"><spring:message code='user.group.usergroup'/></form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input">
									<form:hidden path="userGroupId" />
									<form:input path="userGroupName" cssClass="m" readonly="true" />
									<input type="button" id="userGroupButton" value="사용자 그룹 선택" />
								</td>
							</tr>
							<tr>
								<th class="col-label" scope="row">
			                        <form:label path="userName"><spring:message code='name'/></form:label>
			                        <span class="icon-glyph glyph-emark-dot color-warning"></span>
			                    </th>
			                    <td class="col-input">
									<form:input path="userName" cssClass="m"/>
								</td>
			                    <%-- <td class="col-input radio-set">
			                        <form:radiobutton id="sharingPublic"  path="sharing" value="public" label="공개" />
									<form:radiobutton id="sharingPrivate" path="sharing" value="private" label="비공개" />
									<form:radiobutton id="sharingGroup" path="sharing" value="group" label="그룹" />
			                    </td> --%>
							</tr>
							<tr>
								<th class="col-label" scope="row">
									<form:label path="password"><spring:message code='password'/></form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input">
									<form:input path="password" class="m" />
									<span class="table-desc"><spring:message code='user.input.upper.case'/> ${policy.passwordEngUpperCount}, <spring:message code='user.input.lower.case'/> ${policy.passwordEngLowerCount},
										 <spring:message code='user.input.number'/> ${policy.passwordNumberCount}, <spring:message code='user.input.special.characters'/> ${policy.passwordSpecialCharCount} <spring:message code='user.input.special.characters.need'/>
										 ${policy.passwordMinLength} ~ ${policy.passwordMaxLength}<spring:message code='user.input.do'/></span>
									<form:errors path="password" cssClass="error" />
								</td>
							</tr>
							<tr>
								<th class="col-label" scope="row">
									<form:label path="passwordConfirm"><spring:message code='password.check'/></form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input">
									<form:input path="password" class="m" />
									<form:errors path="passwordConfirm" cssClass="error" />
								</td>
							</tr>
							<%-- <tr>
			                    <th class="col-label" scope="row">
			                        <form:label path="layerName">Layer 명</form:label>
			                        <span class="icon-glyph glyph-emark-dot color-warning"></span>
			                    </th>
			                    <td class="col-input">
			                        <form:input path="layerName" cssClass="ml" />
			                        <form:errors path="layerName" cssClass="error" />
			                    </td>
			                    <th class="col-label" scope="row">
			                        <form:label path="layerKey">Layer Key</form:label>
			                        <span class="icon-glyph glyph-emark-dot color-warning"></span>
			                    </th>
			                    <td class="col-input">
			                        <form:input path="layerKey" cssClass="ml" />
			                        <form:errors path="layerKey" cssClass="error" />
			                    </td>
			                </tr>
			                <tr>
			                    <th class="col-label" scope="row">
			                        <form:label path="serviceType">서비스 타입</form:label>
			                        <span class="icon-glyph glyph-emark-dot color-warning"></span>
			                    </th>
			                    <td class="col-input">
			                        <select name="serviceType">
										<option value="">선택</option>
										<option value="wms">WMS</option>
										<option value="wfs">WFS</option>
										<option value="wcs">WCS</option>
										<option value="wps">WPS</option>
									</select>
			                    </td>
			                    <th class="col-label" scope="row">
			                        <form:label path="layerType">Layer 타입</form:label>
			                        <span class="icon-glyph glyph-emark-dot color-warning"></span>
			                    </th>
			                    <td class="col-input">
			                        <select name="layerType">
										<option value="">선택</option>
										<option value="Vector">Vector</option>
										<option value="Raster">Raster</option>
									</select>
			                    </td>
			                </tr>
			                <tr>
			                    <th class="col-label" scope="row">
			                        <form:label path="geometryType">도형 타입</form:label>
			                        <span class="icon-glyph glyph-emark-dot color-warning"></span>
			                    </th>
								<td class="col-input">
									<select name="geometryType" class="forRaster">
										<option value="">선택</option>
										<option value="Point">Point</option>
										<option value="Line">Line</option>
										<option value="Polygon">Polygon</option>
									</select>
								</td>
			                    <th class="col-label" scope="row">
			                        <form:label path="geometryType">외곽선 색상</form:label>
			                        <span class="icon-glyph glyph-emark-dot color-warning"></span>
			                    </th>
								<td class="col-input">
									<input id="lineColorValue" placeholder="RGB" class="forRaster forLineColor" />
									<input type="color" id="layerLineColor" name="layerLineColor" class="picker forLineColor" alt="외곽선 색상" />
								</td>
							</tr>
							<tr>
								<th class="col-label" scope="row">
			                        <form:label path="layerLineStyle">외곽선 두께</form:label>
			                    </th>
								<td class="col-input">
									<input type="number" id="layerLineStyle"  name="layerLineStyle" class="forRaster" alt="외곽선 두께" min="0.1" max="5.0" size="3" step="0.1">
								</td>
								<th class="col-label" scope="row">
			                        <form:label path="layerFillColor">채우기 색상</form:label>
			                        <span class="icon-glyph glyph-emark-dot color-warning"></span>
			                    </th>
								<td class="col-input">
									<input id="fillColorValue" placeholder="RGB" class="forRaster forPolygon">
									<input type="color" id="layerFillColor" name="layerFillColor" class="picker forPolygon" alt="채우기 색상">
								</td>
							</tr>

			                <tr>
			                	<th class="col-label" scope="row">
			                        <form:label path="layerAlphaStyle">투명도</form:label>
			                        <span class="icon-glyph glyph-emark-dot color-warning"></span>
			                    </th>
								<td class="col-input">
									<input type="text" id="sliderValue" name="layerAlphaStyle" class="slider" alt="투명도">
									<input type="range" id="sliderRange" min="0" max="100" value="100" alt="투명도">
								</td>
			                    <th class="col-label" scope="row">
			                        <label for="zIndex">표시 순서(Z-Index)</label>
			                    </th>
			                    <td class="col-input">
			                        <form:input path="zIndex" cssClass="s" />
			                        <form:errors path="zIndex" cssClass="error" />
			                    </td>
			                </tr>
			                <tr>
			                    <th class="col-label" scope="row">
			                        <label for="defaultDisplayTrue">기본 표시</label>
			                        <span class="icon-glyph glyph-emark-dot color-warning"></span>
			                    </th>
			                    <td class="col-input radio-set">
			                        <form:radiobutton id="defaultDisplayTrue"  path="defaultDisplay" value="true" label="사용" />
									<form:radiobutton id="defaultDisplayFlase" path="defaultDisplay" value="false" label="미사용" />
			                    </td>
			                    <th class="col-label" scope="row">
			                        <label for="useY">사용유무</label>
			                        <span class="icon-glyph glyph-emark-dot color-warning"></span>
			                    </th>
			                    <td class="col-input radio-set">
			                        <form:radiobutton id="availableTrue"  path="available" value="true" label="사용" />
									<form:radiobutton id="availableFalse" path="available" value="false" label="미사용" />
			                    </td>
			                </tr>
			                <tr>
			                    <th class="col-label" scope="row">
			                        <label for="labelDisplayTrue">Label 표시 유무</label>
			                    </th>
			                    <td class="col-input radio-set">
			                        <form:radiobutton id="labelDisplayTrue"  path="labelDisplay" value="true" label="표시" />
									<form:radiobutton id="labelDisplayFalse" path="labelDisplay" value="false" label="비표시" />
			                    </td>
			                    <th class="col-label" scope="row">
			                        <form:label path="coordinate">좌표계</form:label>
			                    </th>
			                    <td class="col-input">
			                        <form:input path="coordinate" cssClass="m" />
			                        <form:errors path="coordinate" cssClass="error" />
			                    </td>
			                </tr>
			                <tr>
			                    <th class="col-label" scope="row">
			                        <form:label path="description">설명</form:label>
			                    </th>
			                    <td class="col-input">
			                        <form:input path="description" cssClass="l" />
			                        <form:errors path="description" cssClass="error" />
			                    </td>
			                    <th class="col-label" scope="row">
			                        <form:label path="shapeEncoding">SHP 파일 인코딩</form:label>
			                    </th>
			                    <td class="col-input">
			                    	<select id="shapeEncoding" name="shapeEncoding" style="width:100px; height: 30px;">
				                    	<option value="CP949">CP949</option>
				                        <option value="UTF-8">UTF-8</option>
				                    </select>
			                    </td>
			                </tr> --%>
						</table>
						<div class="button-group">
							<div class="center-buttons">
								<input type="submit" value="<spring:message code='save'/>" onclick="update();"/>
								<%-- <a href="/user/detail?userId=${userInfo.userId}" class="button">목록</a> --%>
								<a href="/user/list" class="button">목록</a>
							</div>
						</div>
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
	<%@ include file="/WEB-INF/views/user/group-dialog.jsp" %>

<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript" src="/js/navigation.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
	});

	var userGroupDialog = $("#userGroupListDialog").dialog({
		autoOpen: false,
		height: 600,
		width: 1200,
		modal: true,
		overflow : "auto",
		resizable: false
	});

	// 사용자 그룹 선택
	$("#userGroupButton").on("click", function() {
		userGroupDialog.dialog("open");
		userGroupDialog.dialog("option", "title", "사용자 그룹 선택");
	});

	// 상위 Node
	function confirmParent(parent, parentName) {
		$("#userGroupId").val(parent);
		$("#userGroupName").val(parentName);
		userGroupDialog.dialog( "close" );
	}

	function check() {
		var number = /^[0-9]+$/;

		if(!$("#userGroupId").val() || !number.test($("#userGroupId").val())) {
			alert("사용자 그룹을 선택해 주세요.");
			$("#layerGroupName").focus();
			return false;
		}
		if (!$("#userName").val()) {
			alert("사용자 명을 입력하여 주십시오.");
			$("#layerName").focus();
			return false;
		}
	}

	// 저장
	var updateUserFlag = true;
	function update() {
		if (check() == false) {
			return false;
		}
		if(updateUserFlag) {
			updateUserFlag = false;
			var formData = $("#userInfo").serialize();
			$.ajax({
				url: "/user/update",
				type: "POST",
				headers: {"X-Requested-With": "XMLHttpRequest"},
		        data: formData,
				success: function(msg){
					if(msg.statusCode <= 200) {
						alert(JS_MESSAGE["update"]);
						window.location.reload();
					} else {
						alert(JS_MESSAGE[msg.errorCode]);
						console.log("---- " + msg.message);
					}
					updateUserFlag = true;
				},
				error:function(request, status, error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updateUserFlag = true;
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