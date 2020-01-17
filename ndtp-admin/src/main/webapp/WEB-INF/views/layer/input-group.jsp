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
									<form:input path="layerGroupName" cssClass="l" />
									<form:errors path="layerGroupName" cssClass="error" />
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
								<td class="col-input">
									<form:input path="description" cssClass="xl" />
									<form:errors path="description" cssClass="error" />
								</td>
							</tr>
						</table>
						<div class="button-group">
							<div class="center-buttons">
								<input type="submit" value="<spring:message code='save'/>" onclick="insertLayerGroup();"/>
								<a href="/layer-group/list" class="button">목록</a>
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
	<div id="layerGroupDialog" class="dialog">
		<table class="list-table scope-col">
			<col class="col-number" />
			<col class="col-name" />
			<col class="col-toggle" />
			<col class="col-id" />
			<col class="col-function" />
			<col class="col-date" />
			<col class="col-toggle" />
			<thead>
				<tr>
					<th scope="col" class="col-number">Depth</th>
					<th scope="col" class="col-name">Layer 그룹명</th>
					<th scope="col" class="col-toggle">사용 여부</th>
					<th scope="col" class="col-toggle">사용자 아이디</th>
					<th scope="col" class="col-toggle">설명</th>
					<th scope="col" class="col-date">등록일</th>
					<th scope="col" class="col-date">선택</th>
				</tr>
			</thead>
			<tbody>
<c:if test="${empty layerGroupList }">
			<tr>
				<td colspan="7" class="col-none">Layer 그룹이 존재하지 않습니다.</td>
			</tr>
</c:if>
<c:if test="${!empty layerGroupList }">
	<c:set var="paddingLeftValue" value="0" />
	<c:forEach var="layerGroup" items="${layerGroupList}" varStatus="status">
		<c:if test="${layerGroup.depth eq '1' }">
            <c:set var="depthClass" value="oneDepthClass" />
            <c:set var="paddingLeftValue" value="0px" />
        </c:if>
        <c:if test="${layerGroup.depth eq '2' }">
            <c:set var="depthClass" value="twoDepthClass" />
            <c:set var="paddingLeftValue" value="40px" />
        </c:if>
        <c:if test="${layerGroup.depth eq '3' }">
            <c:set var="depthClass" value="threeDepthClass" />
            <c:set var="paddingLeftValue" value="80px" />
        </c:if>

			<tr class="${depthClass } ${depthParentClass} ${ancestorClass }" style="${depthStyleDisplay}">
				<td class="col-key" style="text-align: left;" nowrap="nowrap">
					<span style="padding-left: ${paddingLeftValue}; font-size: 1.6em;"></span>
					${layerGroup.depth }
				</td>
				<td class="col-name">
					${layerGroup.layerGroupName }
				</td>
				<td class="col-type">
        <c:if test="${layerGroup.available eq 'true' }">
                	사용
        </c:if>
        <c:if test="${layerGroup.available eq 'false' }">
        			미사용
        </c:if>
			    </td>
			    <td class="col-key">${layerGroup.userId }</td>
			    <td class="col-key">${layerGroup.description }</td>
			    <td class="col-date">
			    	<fmt:parseDate value="${layerGroup.insertDate}" var="viewInsertDate" pattern="yyyy-MM-dd HH:mm:ss"/>
					<fmt:formatDate value="${viewInsertDate}" pattern="yyyy-MM-dd HH:mm"/>
			    </td>
			    <td class="col-toggle">
			    	<a href="#" onclick="confirmParent('${layerGroup.layerGroupId}', '${layerGroup.layerGroupName}'); return false;">확인</a></td>
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

	function validate() {
		var number = /^[0-9]+$/;
		if ($("#layerGroupName").val() === null || $("#layerGroupName").val() === "") {
			alert("레이어 그룹명을 입력해 주세요.");
			$("#layerGroupName").focus();
			return false;
		}
		if($("#parent").val() === null || $("#parent").val() === "" || !number.test($("#parent").val())) {
			alert("상위 레이어 그룹을 선택해 주세요.");
			$("#parent").focus();
			return false;
		}
	}

	// 저장
	var insertLayerGroupFlag = true;
	function insertLayerGroup() {
		if (validate() == false) {
			return false;
		}
		if(insertLayerGroupFlag) {
			insertLayerGroupFlag = false;
			var formData = $("#layerGroup").serialize();
			$.ajax({
				url: "/layer-group/insert",
				type: "POST",
				headers: {"X-Requested-With": "XMLHttpRequest"},
		        data: formData,
				success: function(msg){
					if(msg.statusCode <= 200) {
						alert(JS_MESSAGE["insert"]);
						window.location.reload();
					} else {
						alert(JS_MESSAGE[msg.errorCode]);
						console.log("---- " + msg.message);
					}
					insertLayerGroupFlag = true;
				},
				error:function(request, status, error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        insertLayerGroupFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}

	var layerGroupDialog = $( ".dialog" ).dialog({
		autoOpen: false,
		height: 600,
		width: 1200,
		modal: true,
		overflow : "auto",
		resizable: false
	});

	// 상위 Layer Group 찾기
	$( "#layerGroupButtion" ).on( "click", function() {
		layerGroupDialog.dialog( "open" );
		layerGroupDialog.dialog( "option", "title", "Layer 그룹 선택");
	});

	// 상위 Node
	function confirmParent(parent, parentName) {
		$("#parent").val(parent);
		$("#parentName").val(parentName);
		layerGroupDialog.dialog( "close" );
	}

	$( "#rootParentSelect" ).on( "click", function() {
		$("#parent").val(0);
		$("#parentName").val("${layerGroup.parentName}");
		layerGroupDialog.dialog( "close" );
	});
</script>
</body>
</html>