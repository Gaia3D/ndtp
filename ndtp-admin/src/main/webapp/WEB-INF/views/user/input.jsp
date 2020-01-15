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
				  						<input type="button" id="userDuplicationButtion" value="<spring:message code='overlap.check'/>" />
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
										<input type="button" id="userGroupButtion" value="<spring:message code='user.group.usergroup'/>" />
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
									<input type="submit" id="allFileClear" value="초기화" />
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

	<!-- Dialog -->
	<div id="userGroupDialog" class="dialog">
		<table class="list-table scope-col">
			<col class="col-name" />
			<col class="col-toggle" />
			<col class="col-id" />
			<col class="col-function" />
			<col class="col-date" />
			<col class="col-toggle" />
			<thead>
				<tr>
					<th scope="col" class="col-name">데이터 그룹명</th>
					<th scope="col" class="col-toggle">사용 여부</th>
					<th scope="col" class="col-toggle">설명</th>
					<th scope="col" class="col-date">등록일</th>
					<th scope="col" class="col-date">선택</th>
				</tr>
			</thead>
			<tbody>
<c:if test="${empty userGroupList }">
			<tr>
				<td colspan="6" class="col-none">사용자 그룹이 존재하지 않습니다.</td>
			</tr>
</c:if>
<c:if test="${!empty userGroupList }">
	<c:set var="paddingLeftValue" value="0" />
	<c:forEach var="userGroup" items="${userGroupList}" varStatus="status">
		<c:if test="${userGroup.depth eq '1' }">
            <c:set var="depthClass" value="oneDepthClass" />
            <c:set var="paddingLeftValue" value="0px" />
        </c:if>
        <c:if test="${userGroup.depth eq '2' }">
            <c:set var="depthClass" value="twoDepthClass" />
            <c:set var="paddingLeftValue" value="40px" />
        </c:if>
        <c:if test="${userGroup.depth eq '3' }">
            <c:set var="depthClass" value="threeDepthClass" />
            <c:set var="paddingLeftValue" value="80px" />
        </c:if>

			<tr class="${depthClass } ${depthParentClass} ${ancestorClass }" style="${depthStyleDisplay}">
				<td class="col-name" style="text-align: left;" nowrap="nowrap">
					<span style="padding-left: ${paddingLeftValue}; font-size: 1.6em;"></span>
					${userGroup.userGroupName }
				</td>
				<td class="col-type">
        <c:if test="${userGroup.available eq 'true' }">
                	사용
        </c:if>
        <c:if test="${userGroup.available eq 'false' }">
        			미사용
        </c:if>
			    </td>
			    <td class="col-key">${userGroup.description }</td>
			    <td class="col-date">
			    	<fmt:parseDate value="${userGroup.insertDate}" var="viewInsertDate" pattern="yyyy-MM-dd HH:mm:ss"/>
					<fmt:formatDate value="${viewInsertDate}" pattern="yyyy-MM-dd HH:mm"/>
			    </td>
			    <td class="col-toggle">
			    	<a href="#" onclick="confirmParent('${userGroup.userGroupId}', '${userGroup.userGroupName}'); return false;">확인</a></td>
			</tr>
	</c:forEach>
</c:if>
			</tbody>
		</table>
		<div class="button-group">
			<input type="button" id="rootParentSelect" class="button" value="최상위(ROOT) 그룹으로 저장"/>
		</div>
	</div>

<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript" src="/js/navigation.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
	});

	var userDialog = $( ".userDialog" ).dialog({
		autoOpen: false,
		height: 600,
		width: 1200,
		modal: true,
		overflow : "auto",
		resizable: false
	});

	// 부모 찾기
	$( "#userGroupButtion" ).on( "click", function() {
		userDialog.dialog( "open" );
		userDialog.dialog( "option", "title", "사용자 그룹 선택");
	});

	// 상위 Node
	function confirmParent(parent, parentName) {
		$("#parent").val(parent);
		$("#parentName").val(parentName);
		userDialog.dialog( "close" );
	}

	$( "#rootParentSelect" ).on( "click", function() {
		$("#parent").val(0);
		$("#parentName").val("${userGroup.parentName}");
		userDialog.dialog( "close" );
	});

	// 아이디 중복 확인
 	$( "#userDuplicationButtion" ).on( "click", function() {
		var userId = $("#userId").val();
		if (userId == "") {
			alert(JS_MESSAGE["user.id.empty"]);
			$("#userId").focus();
			return false;
		}
		$.ajax({
			url: "/user/duplication-check",
			type: "POST",
			data: {"userId": userId},
			headers: {"X-Requested-With": "XMLHttpRequest"},
			dataType: "json",
			success: function(msg){
				if(msg.result == "success") {
					if(msg.duplicationValue != "0") {
						alert(JS_MESSAGE["user.id.duplication"]);
						$("#userId").focus();
						return false;
					} else {
						alert(JS_MESSAGE["user.id.enable"]);
						$("#duplicationValue").val(msg.duplicationValue);
					}
				} else {
					alert(JS_MESSAGE[msg.result]);
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
				url: "/user/insert",
				type: "POST",
				data: info,
				headers: {"X-Requested-With": "XMLHttpRequest"},
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["user.insert"]);
						$("#parent").val("");
						$("#duplicationValue").val("");
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					insertDataFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        alert(" code : " + request.status + "\n" + ", message : " + request.responseText + "\n" + ", error : " + error);
			        insertDataFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}

	function checkData() {
		if ($("#parent").val() == "") {
			alert(JS_MESSAGE["data.parent.empty"]);
			$("#parentName").focus();
			return false;
		}
		if ($("#data_key").val() == "") {
			alert(JS_MESSAGE["data.key.empty"]);
			$("#data_key").focus();
			return false;
		}
		if($("#duplication_value").val() == null || $("#duplication_value").val() == "") {
			alert(JS_MESSAGE["data.key.duplication_value.check"]);
			return false;
		} else if($("#duplication_value").val() == "1") {
			alert(JS_MESSAGE["data.key.duplication_value.already"]);
			return false;
		}
		if ($("#data_name").val() == "") {
			alert(JS_MESSAGE["data.name.empty"]);
			$("#data_name").focus();
			return false;
		}
	}
</script>
</body>
</html>