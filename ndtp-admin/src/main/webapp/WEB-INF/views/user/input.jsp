<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>사용자 등록 | NDTP</title>
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
	<link rel="stylesheet" href="/externlib/normalize/normalize.min.css" />
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css" />
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
										<form:label path="userId"><spring:message code='id'/></form:label>
										<span class="icon-glyph glyph-emark-dot color-warning"></span>
									</th>
									<td class="col-input">
										<form:hidden path="duplicationValue"/>
										<form:input path="userId" cssClass="m" />
				  						<input type="button" id="userDuplicationButton" value="<spring:message code='overlap.check'/>" />
				  						<span class="table-desc" style="padding-left: 5px;"><spring:message code='minimum.length'/> ${policy.userIdMinLength}</span>
										<form:errors path="userId" cssClass="error" />
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
										<input type="button" id="userGroupButton" value="<spring:message code='user.group.usergroup'/> 선택" />
									</td>
								</tr>
								<tr>
									<th class="col-label" scope="row">
										<form:label path="userName"><spring:message code='name'/></form:label>
										<span class="icon-glyph glyph-emark-dot color-warning"></span>
									</th>
									<td class="col-input">
										<form:input path="userName" class="m" />
				  						<form:errors path="userName" cssClass="error" />
									</td>
								</tr>
								<tr>
									<th class="col-label" scope="row">
										<form:label path="password"><spring:message code='password'/></form:label>
										<span class="icon-glyph glyph-emark-dot color-warning"></span>
									</th>
									<td class="col-input">
										<form:password path="password" class="m" />
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
										<form:password path="passwordConfirm" class="m" />
										<form:errors path="passwordConfirm" cssClass="error" />
									</td>
								</tr>
								<%-- <tr>
									<th class="col-label" scope="row">
										<form:label path="telephone1"><spring:message code='phone.number'/></form:label>
									</th>
									<td class="col-input">
										<form:input path="telephone1" class="xs" maxlength="3" />
										<span class="delimeter dash">-</span>
										<form:input path="telephone2" class="xs" maxlength="4" />
										<span class="delimeter dash">-</span>
										<form:input path="telephone3" class="xs" maxlength="4" />
										<form:errors path="telephone1" cssClass="error" />
										<form:errors path="telephone2" cssClass="error" />
										<form:errors path="telephone3" cssClass="error" />
									</td>
								</tr>
								<tr>
									<th class="col-label" scope="row">
										<form:label path="mobile_phone1"><spring:message code='mobile'/></form:label>
									</th>
									<td class="col-input">
										<form:input path="mobile_phone1" class="xs" maxlength="3" />
										<span class="delimeter dash">-</span>
										<form:input path="mobile_phone2" class="xs" maxlength="4" />
										<span class="delimeter dash">-</span>
										<form:input path="mobile_phone3" class="xs" maxlength="4" />
										<form:errors path="mobile_phone1" cssClass="error" />
										<form:errors path="mobile_phone2" cssClass="error" />
										<form:errors path="mobile_phone3" cssClass="error" />
									</td>
								</tr>
								<tr>
									<th class="col-label" scope="row">
										<form:label path="email1"><spring:message code='email'/></form:label>
									</th>
									<td class="col-input">
										<form:input path="email1" class="s" />
										<span class="delimeter at">@</span>
										<form:input path="email2" class="s" />
										<select id="email3" name="email3" class="select">
			               		 			<option value="0"><spring:message code='direct.input'/></option>
<c:if test="${!empty emailCommonCodeList }">
	<c:forEach var="commonCode" items="${emailCommonCodeList}" varStatus="status">
			               		 			<option value="${commonCode.code_value }">${commonCode.code_value }</option>
	</c:forEach>
</c:if>
										</select>
										<form:errors path="email1" cssClass="error" />
										<form:errors path="email2" cssClass="error" />
										<form:errors path="email" cssClass="error" />
									</td>
								</tr>
								<tr>
									<th class="col-label" scope="row">
										<form:label path="messanger"><spring:message code='messenger'/></form:label>
									</th>
									<td class="col-input">
										<form:input path="messanger" class="m" />
										<form:errors path="messanger" cssClass="error" />
									</td>
								</tr> --%>
							</table>

							<div class="button-group">
								<div id="insertUserLink" class="center-buttons">
									<input type="submit" value="<spring:message code='save'/>" onclick="insertUser();" />
									<input type="submit" onClick="formClear(); return false;" value="초기화" />
									<a href="/user/list" class="button"><spring:message code='list'/></a>
								</div>
							</div>
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
	<%@ include file="/WEB-INF/views/user-group/dialog.jsp" %>

<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript" src="/js/navigation.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
	});

	var userDialog = $("#userGroupListDialog").dialog({
		autoOpen: false,
		height: 600,
		width: 1200,
		modal: true,
		overflow : "auto",
		resizable: false
	});

	// 부모 찾기
	$("#userGroupButton").on("click", function() {
		userDialog.dialog("open");
		userDialog.dialog("option", "title", "사용자 그룹 선택");
		$('#rootParentSelect').hide();
	});

	// 상위 Node
	function confirmParent(parent, parentName) {
		$("#userGroupId").val(parent);
		$("#userGroupName").val(parentName);
		userDialog.dialog("close");
	}

	// 입력값이 변경되면 중복체크 필요
	$("#userId").on("keyup", function() {
		$("#duplicationValue").val(null);
	});

	// 아이디 중복 확인
 	$("#userDuplicationButton").on("click", function() {
		var userId = $("#userId").val();
		if (userId == "") {
			alert(JS_MESSAGE["user.id.empty"]);
			$("#userId").focus();
			return false;
		}
		$.ajax({
			url: "/users/duplication",
			type: "POST",
			data: {"userId": userId},
			headers: {"X-Requested-With": "XMLHttpRequest"},
			dataType: "json",
			success: function(msg){
				if(msg.statusCode <= 200) {
					if(msg.duplication == true) {
						alert(JS_MESSAGE["user.id.duplication"]);
						$("#userId").focus();
						return false;
					} else {
						alert(JS_MESSAGE["user.id.enable"]);
						$("#duplicationValue").val(msg.duplication);
					}
				} else {
					alert(JS_MESSAGE[msg.errorCode]);
					console.log("---- " + msg.message);
				}
			},
			error:function(request, status, error) {
				//alert(JS_MESSAGE["ajax.error.message"]);
				alert(" code : " + request.status + "\n" + ", message : " + request.responseText + "\n" + ", error : " + error);
    		}
		});
	});

	// 사용자 등록
	var insertUserFlag = true;
	function insertUser() {
		if (checkData() == false) {
			return false;
		}
		if(insertUserFlag) {
			insertUserFlag = false;
			var info = $("#userInfo").serialize();
			$.ajax({
				url: "/users/insert",
				type: "POST",
				data: info,
				headers: {"X-Requested-With": "XMLHttpRequest"},
				dataType: "json",
				success: function(msg){
					if(msg.statusCode <= 200) {
						alert(JS_MESSAGE["user.insert"]);
						window.location.reload();
					} else {
						alert(JS_MESSAGE[msg.errorCode]);
						console.log("---- " + msg.message);
					}
					insertUserFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        alert(" code : " + request.status + "\n" + ", message : " + request.responseText + "\n" + ", error : " + error);
			        insertUserFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}

	function checkData() {
		if($("#duplicationValue").val() == null || $("#duplicationValue").val() == "") {
			alert(JS_MESSAGE["check.id.duplication"]);
			return false;
		} else if($("#duplicationValue").val() == "1") {
			alert(JS_MESSAGE["user.id.duplication"]);
			return false;
		}
		if ($("#userGroupId").val() == "") {
			alert(JS_MESSAGE["user.group.select"]);
			$("#userGroupId").focus();
			return false;
		}
		if ($("#userName").val() == "") {
			alert(JS_MESSAGE["user.name.empty"]);
			$("#userName").focus();
			return false;
		}
	}
	// 초기화
	function formClear() {
		$("#userId").val("");
		$("#userGroupId").val("");
		$("#userGroupName").val("");
		$("#userName").val("");
		$("#password").val("");
		$("#passwordConfirm").val("");
	}

</script>
</body>
</html>