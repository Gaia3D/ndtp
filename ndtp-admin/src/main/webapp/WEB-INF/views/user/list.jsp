<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>사용자 목록 | NDTP</title>
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
						<div class="filters">
							<form:form id="searchForm" modelAttribute="userInfo" method="post" action="/user/list" onsubmit="return searchCheck();">
								<div class="input-group row">
									<div class="input-set">
									<label for="searchWord"><spring:message code='search.word'/></label>
									<select id="searchWord" name="searchWord" class="select" style="height: 30px;">
										<option value=""><spring:message code='select'/></option>
					          			<option value="user_id">아이디</option>
					          			<option value="user_name">사용자명</option>
					          			<option value="status">상태</option>
									</select>
									<select id="searchOption" name="searchOption" class="select" style="height: 30px;">
										<option value="0"><spring:message code='search.same'/></option>
										<option value="1"><spring:message code='search.include'/></option>
									</select>
									<form:input path="searchValue" type="search" cssClass="m" cssStyle="float: right;" />
								</div>
								<div class="input-set">
									<label for="startDate"><spring:message code='search.date'/></label>
									<input type="text" class="s date" id="startDate" name="startDate" />
									<span class="delimeter tilde">~</span>
									<input type="text" class="s date" id="endDate" name="endDate" />
								</div>
								<div class="input-set">
									<label for="orderWord"><spring:message code='search.order'/></label>
									<select id="orderWord" name="orderWord" class="select" style="height: 30px;">
										<option value=""> <spring:message code='search.basic'/> </option>
					          			<option value="user_id">아이디</option>
										<option value="user_name">사용자명</option>
					          			<option value="status">상태</option>
					          			<option value="last_signin_date">마지막 로그인</option>
										<option value="insertDate"> <spring:message code='search.insert.date'/> </option>
									</select>
									<select id="orderValue" name="orderValue" class="select" style="height: 30px;">
				                		<option value=""> <spring:message code='search.basic'/> </option>
					                	<option value="ASC"> <spring:message code='search.ascending'/> </option>
										<option value="DESC"> <spring:message code='search.descending.order'/> </option>
									</select>
									<select id="listCounter" name="listCounter" class="select" style="height: 30px;">
				                		<option value="10"> <spring:message code='search.ten.count'/> </option>
					                	<option value="50"> <spring:message code='search.fifty.count'/> </option>
										<option value="100"> <spring:message code='search.hundred.count'/> </option>
									</select>
								</div>
								<div class="input-set">
									<input type="submit" value="<spring:message code='search'/>" />
								</div>
							</div>
							</form:form>
						</div>
						<div class="list">
							<form:form id="listForm" modelAttribute="userInfo" method="post">
								<input type="hidden" id="checkIds" name="checkIds" value="" />
							<div class="list-header row">
								<div class="list-desc u-pull-left">
									<spring:message code='all.d'/> <em><fmt:formatNumber value="${pagination.totalCount}" type="number"/></em><spring:message code='search.what.count'/>
									<fmt:formatNumber value="${pagination.pageNo}" type="number"/> / <fmt:formatNumber value="${pagination.lastPage }" type="number"/> <spring:message code='search.page'/>
								</div>
								<div class="list-functions u-pull-right">
									<!-- <div style="padding-bottom: 3px;" class="button-group">
										<a href="#" onclick="return false;" class="button">비밀번호 초기화</a>
										<a href="#" onclick="return false;" class="button">사용자 잠금</a>
										<a href="#" onclick="return false;" class="button">사용자 잠금 해제</a>
										<a href="#" onclick="return false;" class="button">일괄삭제</a>
										<a href="#" onclick="return false;" class="button">일괄등록(EXCEL)</a>
										<a href="#" onclick="return false;" class="button">다운로드(EXCEL)</a>
									</div> -->
								</div>
							</div>
							<table class="list-table scope-col">
								<col class="col-checkbox" />
								<col class="col-number" />
								<col class="col-name" />
								<col class="col-name" />
								<col class="col-name" />
								<col class="col-type" />
								<col class="col-type" />
								<col class="col-functions" />
								<col class="col-functions" />
								<col class="col-functions" />
								<thead>
									<tr>
										<th scope="col" class="col-checkbox"><input type="checkbox" id="chkAll" name="chkAll" /></th>
										<th scope="col" class="col-number"><spring:message code='number'/></th>
										<th scope="col">그룹명</th>
					                    <th scope="col">아이디</th>
					                    <th scope="col">이름</th>
					                    <th scope="col">상태</th>
					                    <th scope="col">등록유형</th>
					                    <th scope="col">마지막 로그인</th>
					                    <th scope="col">등록일</th>
					                    <th scope="col">수정/삭제</th>
									</tr>
								</thead>
								<tbody>
<c:if test="${empty userList}">
									<tr>
										<td colspan="10" class="col-none">사용자 목록이 존재하지 않습니다.</td>
									</tr>
</c:if>
<c:if test="${!empty userList}">
	<c:forEach var="user" items="${userList}" varStatus="status">

									<tr>
										<td class="col-checkbox">
											<input type="checkbox" id="userId_${user.userId}" name="userId" value="${user.userId}" />
										</td>
										<td class="col-number">${pagination.rowNumber - status.index}</td>
										<td class="col-name">
											<a href="#" class="view-group-detail" onclick="detailUserGroup('${user.userGroupId}'); return false;">${user.userGroupName }</a>
										</td>
										<td class="col-name">${user.userId}</td>
										<td class="col-name">
											<a href="/user/detail?userId=${user.userId}&amp;pageNo=${pagination.pageNo }${pagination.searchParameters}" class="linkButton">${user.userName}</a>
										</td>
										<td class="col-type">
											<c:if test="${user.status eq '0' }">사용중</c:if>
											<c:if test="${user.status eq '1' }">사용중지</c:if>
											<c:if test="${user.status eq '2' }">잠금</c:if>
											<c:if test="${user.status eq '3' }">휴면</c:if>
											<c:if test="${user.status eq '4' }">만료</c:if>
											<c:if test="${user.status eq '5' }">삭제</c:if>
											<c:if test="${user.status eq '6' }">임시비밀번호</c:if>
										</td>
										<td class="col-type">${user.status}</td>
										<td class="col-type">
											<fmt:parseDate value="${user.lastSigninDate}" var="viewLastSigninDate" pattern="yyyy-MM-dd HH:mm:ss"/>
											<fmt:formatDate value="${viewLastSigninDate}" pattern="yyyy-MM-dd HH:mm"/>
										</td>
										<td class="col-type">
											<fmt:parseDate value="${user.insertDate}" var="viewInsertDate" pattern="yyyy-MM-dd HH:mm:ss"/>
											<fmt:formatDate value="${viewInsertDate}" pattern="yyyy-MM-dd HH:mm"/>
										</td>
										<td class="col-functions">
											<span class="button-group">
												<a href="/user/modify?userId=${user.userId}" class="image-button button-modify"><spring:message code='modified'/></a>
											</span>
											<span class="button-group">
												<a href="/user/delete?userId=${user.userId}" class="image-button button-delete"><spring:message code='delete'/></a>
											</span>
										</td>
									</tr>
	</c:forEach>
</c:if>
								</tbody>
							</table>
							</form:form>

						</div>
						<%@ include file="/WEB-INF/views/common/pagination.jsp" %>
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
<script type="text/javascript">

	//전체 선택
	$("#chkAll").click(function() {
		$(":checkbox[name=uploadDataId]").prop("checked", this.checked);
	});

	// 사용자 그룹 정보
	var userGroupDialog = $("#userGroupInfoDialog").dialog({
		autoOpen: false,
		width: 400,
		height: 300,
		modal: true,
		resizable: false
	});

	// 사용자 그룹 정보
	function detailUserGroup(userGroupId) {
		userGroupDialog.dialog("open");

		$.ajax({
			url: "/user/detail-group",
			data: {"userGroupId": userGroupId},
			type: "GET",
			headers: {"X-Requested-With": "XMLHttpRequest"},
			dataType: "json",
			success: function(msg){
				if(msg.statusCode <= 200) {
					$("#userGroupNameInfo").html(msg.userGroup.userGroupName);
					$("#userGroupKeyInfo").html(msg.userGroup.userGroupKey);
					$("#basicInfo").html(msg.userGroup.basic?'기본':'선택');
					$("#availableInfo").html(msg.userGroup.available?'사용':'미사용');
					$("#descriptionInfo").html(msg.userGroup.description);
				} else {
					alert(JS_MESSAGE[msg.errorCode]);
				}
			},
			error: function(request, status, error){
				alert(JS_MESSAGE["ajax.error.message"]);
			}
		});
	}

	function deleteUploadData(uploadDataId) {
		deleteAllUploadData(uploadDataId);
	}

	// 삭제
	var deleteUploadDataFlag = true;
	function deleteAllUploadData(uploadDataId) {
		var formData = null;
		if(uploadDataId === undefined) {
			if($("input:checkbox[name=uploadDataId]:checked").length == 0) {
				alert(JS_MESSAGE["check.value.required"]);
				return false;
			} else {
				var checkedValue = "";
				$("input:checkbox[name=uploadDataId]:checked").each(function(index){
					checkedValue += $(this).val() + ",";
				});
				$("#checkIds").val(checkedValue);
			}
			formData = "checkIds=" + $("#checkIds").val();
		} else {
			formData = "checkIds=" + uploadDataId;
		}

		if(confirm(JS_MESSAGE["delete.confirm"])) {
			if(deleteUploadDataFlag) {
				deleteUploadDataFlag = false;
				$.ajax({
					url: "/upload-data/delete",
					type: "POST",
					data: formData,
					dataType: "json",
					headers: {"X-Requested-With": "XMLHttpRequest"},
					success: function(msg){
						if(msg.statusCode <= 200) {
							alert(JS_MESSAGE["delete"]);
							location.reload();
						} else {
							alert(JS_MESSAGE[msg.errorCode]);
						}
						deleteDatasFlag = true;
					},
					error:function(request,status,error){
				        alert(JS_MESSAGE["ajax.error.message"]);
				        deleteDatasFlag = true;
					}
				});
			} else {
				alert(JS_MESSAGE["button.dobule.click"]);
				return;
			}
		}
	}

	function searchCheck() {
		if($("#searchOption").val() == "1") {
			if(confirm(JS_MESSAGE["search.option.warning"])) {
				// go
			} else {
				return false;
			}
		}

		var startDate = $("#startDate").val();
		var endDate = $("#endDate").val();
		if(startDate != null && startDate != "" && endDate != null && endDate != "") {
			if(parseInt(startDate) > parseInt(endDate)) {
				alert(JS_MESSAGE["search.date.warning"]);
				$("#startDate").focus();
				return false;
			}
		}
		return true;
	}
</script>
</body>
</html>
