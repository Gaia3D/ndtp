<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>권한 | NDTP</title>
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
	<link rel="stylesheet" href="/externlib/normalize/normalize.min.css" />
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css" />
	<link rel="stylesheet" href="/css/fontawesome-free-5.2.0-web/css/all.min.css">
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
						<form:form id="searchForm" modelAttribute="role" method="get" action="/role/list" onsubmit="return searchCheck();">
						<div class="input-group row">
							<div class="input-set">
								<label for="searchWord">검색어</label>
								<select id="searchWord" name="searchWord">
									<option value="">선택</option>
									<option value="role_name">Role명</option>
								</select>
								<select id="searchOption" name="searchOption">
									<option value="0">일치</option>
									<option value="1">포함</option>
								</select>
								<form:input path="searchValue"/>
							</div>
							<div class="input-set">
								<label for="startDate">기간</label>
								<input type="text" id="startDate" name="startDate" class="date"/>
								<span class="delimeter tilde">~</span>
								<input type="text" id="endDate" name="endDate" class="date"/>
							</div>
			
							<div class="input-set">
								<label for="orderWord">표시순서</label>
								<select id="orderWord" name="orderWord">
									<option value="">기본</option>
									<option value="role_name">Role명</option>
									<option value="insert_date">등록일</option>
								</select>
								<select id="orderValue" name="orderValue">
									<option value="">기본</option>
									<option value="ASC">오름차순</option>
									<option value="DESC">내림차순</option>
								</select>
							</div>
							<div class="input-set">
								<input type="submit" value="검색" class="searchBtn"/>
							</div>
						</div>
						</form:form>
						</div>
						
						<div class="list">
					    	<div class="list-header row">
								<div class="list-desc u-pull-left">
									전체: <em><fmt:formatNumber value="${pagination.totalCount}" type="number"/></em> 건, 
									<fmt:formatNumber value="${pagination.pageNo}" type="number"/> / <fmt:formatNumber value="${pagination.lastPage }" type="number"/> 페이지
								</div>
								<div class="list-functions u-pull-right">
									<div class="button-group">
										<a href="/role/input" class="image-button button-area button-new" title="Role 등록">Role 등록</a>
									</div>
								</div>
							</div>
							<table class="list-table scope-col">
								<thead>
								<tr>
									<th scope="col">번호</th>
									<th scope="col">Role명</th>
									<th scope="col">Role Key</th>
									<th scope="col">Role Target</th>
									<th scope="col">Role 타입</th>
									<th scope="col">사용유무</th>
									<th scope="col">등록일</th>
									<th scope="col">수정</th>
									<th scope="col">삭제</th>
								</tr>
								</thead>
				<c:if test="${empty roleList }">
								<tr>
									<td colspan="9" class="col-none">Role 이 존재하지 않습니다.</td>
								</tr>
				</c:if>
				<c:if test="${!empty roleList }">
					<c:forEach var="role" items="${roleList}" varStatus="status">
								<tr>
									<td class="col-number">${ pagination.totalCount - ((pagination.pageNo - 1) * 10) - status.index }</td>
									<td class="col-name" style="text-align: left;">${role.roleName }</td>
									<td class="col-key" style="text-align: left;">${role.roleKey }</td>
									<td class="col-type">
						<c:if test="${role.roleTarget eq '0' }">
										사용자 사이트
						</c:if>
						<c:if test="${role.roleTarget eq '1' }">
										관리자 사이트
						</c:if>
						<c:if test="${role.roleTarget eq '2' }">
										서버
						</c:if>
									</td>
									<td class="col-type">
						<c:if test="${role.roleType eq '0' }">
										사용자
						</c:if>
						<c:if test="${role.roleType eq '1' }">
										서버
						</c:if>
						<c:if test="${role.roleType eq '2' }">
										api
						</c:if>
									</td>
									<td class="col-toggle">
						<c:if test="${role.useYn eq 'Y' }">
										사용
						</c:if>
						<c:if test="${role.useYn eq 'N' }">
										미사용
						</c:if>
									</td>
									<td class="col-date-time">${role.insertDate }</td>
									<td class="col-functions">
										<a href="/role/modify/${role.roleId }" class="linkButton">수정</a>
									</td>
									<td class="col-functions">
										<a href="#" onclick="deleteRole('${role.roleId}'); return false;" class="linkButton">삭제</a>
									</td>
								</tr>
					</c:forEach>
				</c:if>
							</table>
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
	initJqueryCalendar();

	$("#searchWord").val("${role.searchWord}");
	$("#searchValue").val("${role.searchValue}");
	$("#orderWord").val("${role.orderWord}");
	$("#orderValue").val("${role.orderValue}");

	initCalendar(new Array("startDate", "endDate"), new Array("${role.startDate}", "${role.endDate}"));
});

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

var deleteRoleFlag = true;
function deleteRole(roleId) {
	if(deleteRoleFlag) {
		if(confirm(JS_MESSAGE["delete.confirm"])) {
			deleteRoleFlag = false;
			$.ajax({
				url: "/role/delete/" + roleId,
				type: "DELETE",
				headers: {"X-Requested-With": "XMLHttpRequest"},
				dataType: "json",
				success: function(msg) {
					alert(JS_MESSAGE["delete"]);
					location.reload();
				},
		        error: function(request, status, error) {
		        	// alert message, 세션이 없는 경우 로그인 페이지로 이동 - common.js
		        	ajaxErrorHandler(request);
					deleteRoleFlag = true;
		        }
			});
		} else {
			deleteRoleFlag = true;
		}
	} else {
		alert(JS_MESSAGE["button.dobule.click"]);
		return;
	}
}
</script>
</body>
</html>