<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>데이터 그룹 수정 | NDTP</title>
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
						<form:form id="dataGroup" modelAttribute="dataGroup" method="post" onsubmit="return false;">
							<form:hidden path="dataGroupId"/>
							<table class="input-table scope-row">
								<col class="col-label" />
								<col class="col-input" />
								<tr>
									<th class="col-label" scope="row">
										<form:label path="dataGroupName">데이터 그룹명</form:label>
										<span class="icon-glyph glyph-emark-dot color-warning"></span>
									</th>
									<td class="col-input">
										<form:input path="dataGroupName" cssClass="l" />
										<form:errors path="dataGroupName" cssClass="error" />
									</td>
								</tr>
								<tr>
									<th class="col-label" scope="row">
										<form:label path="dataGroupName">데이터 그룹 Key</form:label>
										<span class="icon-glyph glyph-emark-dot color-warning"></span>
									</th>
									<td class="col-input">
										<form:input path="dataGroupKey" cssClass="l" readonly="true" />
										<form:errors path="dataGroupKey" cssClass="error" />
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
										<input type="button" id="dataGroupButtion" value="상위 그룹 선택" />
									</td>
								</tr>
								<%-- <tr>
									<th class="col-label" scope="row">
										<form:label path="dataGroupPath">데이터 그룹 경로</form:label>
									</th>
									<td class="col-input">
										<form:input path="dataGroupPath" cssClass="l" />
										<form:errors path="dataGroupPath" cssClass="error" />
									</td>
								</tr> --%>
								<tr>
				                    <th class="col-label" scope="row">
				                        <form:label path="sharing">공유 타입</form:label>
				                        <span class="icon-glyph glyph-emark-dot color-warning"></span>
				                    </th>
				                    <td class="col-input">
				                        <select name="sharing">
											<option value="common">공통</option>
											<option value="public" selected="selected">공개</option>
											<option value="private">개인</option>
											<option value="group">그룹</option>
										</select>
				                    </td>
				                </tr>
				                <tr>
									<th class="col-label l" scope="row">
										기본 여부
										<span class="icon-glyph glyph-emark-dot color-warning"></span>
									</th>
									<td class="col-input radio-set">
										<form:radiobutton label="기본" path="basic" value="true" />
										<form:radiobutton label="선택" path="basic" value="false" />
										<form:errors path="basic" cssClass="error" />
									</td>
								</tr>
								<tr>
									<th class="col-label l" scope="row">
										사용 여부
										<span class="icon-glyph glyph-emark-dot color-warning"></span>
									</th>
									<td class="col-input radio-set">
										<form:radiobutton label="사용" path="available" value="true" />
										<form:radiobutton label="미사용" path="available" value="false" />
										<form:errors path="available" cssClass="error" />
									</td>
								</tr>
								<tr>
									<th class="col-label" scope="row">
										<form:label path="latitude">위도</form:label>
									</th>
									<td class="col-input">
										<form:input path="latitude" cssClass="m" />
										<input type="button" id="mapButtion" value="지도에서 찾기" />
										<form:errors path="latitude" cssClass="error" />
									</td>
								</tr>
								<tr>
									<th class="col-label" scope="row">
										<form:label path="longitude">경도</form:label>
									</th>
									<td class="col-input">
										<form:input path="longitude" cssClass="m" />
										<form:errors path="longitude" cssClass="error" />
									</td>
								</tr>
								<tr>
									<th class="col-label" scope="row">
										<form:label path="altitude">높이</form:label>
									</th>
									<td class="col-input">
										<form:input path="altitude" cssClass="m" />
										<form:errors path="altitude" cssClass="error" />
									</td>
								</tr>
								<tr>
									<th class="col-label" scope="row">
										<form:label path="duration">이동시간</form:label>
									</th>
									<td class="col-input">
										<form:input path="duration" cssClass="s" />&nbsp;&nbsp;ms
										<form:errors path="duration" cssClass="error" />
									</td>
								</tr>
								<tr>
									<th class="col-label" scope="row">
										<form:label path="metainfo">메타정보</form:label>
										<span class="icon-glyph glyph-emark-dot color-warning"></span>
									</th>
									<td class="col-input">
										<form:input path="metainfo" class="xl" value="{\"isPhysical\": false}" />
				  						<form:errors path="metainfo" cssClass="error" />
									</td>
								</tr>
								<tr>
									<th class="col-label m" scope="row"><form:label path="description"><spring:message code='description'/></form:label></th>
									<td class="col-input">
										<form:input path="description" cssClass="xl" />
										<form:errors path="description" cssClass="error" />
									</td>
								</tr>
							</table>
							<div class="button-group">
								<div class="center-buttons">
									<input type="submit" value="<spring:message code='save'/>" onclick="updateDataGroup();"/>
									<a href="/data-group/list" class="button">목록</a>
								</div>
							</div>
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
	<%@ include file="/WEB-INF/views/data/group-dialog.jsp" %>

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
		if ($("#dataGroupName").val() === null || $("#dataGroupName").val() === "") {
			alert("데이터 그룹명을 입력해 주세요.");
			$("#dataGroupName").focus();
			return false;
		}
		if($("#parent").val() === null || $("#parent").val() === "" || !number.test($("#parent").val())) {
			alert("상위 레이어 그룹을 선택해 주세요.");
			$("#parent").focus();
			return false;
		}
	}

	var dataGroupDialog = $("#dataGroupListDialog").dialog({
		autoOpen: false,
		height: 600,
		width: 1200,
		modal: true,
		overflow : "auto",
		resizable: false
	});

	// 상위 데이터 그룹 찾기
	$( "#dataGroupButton" ).on( "click", function() {
		dataGroupDialog.dialog("open" );
		dataGroupDialog.dialog("option", "title", "데이터 그룹 선택");
	});

	// 상위 Node
	function confirmParent(parent, parentName) {
		$("#parent").val(parent);
		$("#parentName").val(parentName);
		dataGroupDialog.dialog( "close" );
	}

	$( "#rootParentSelect" ).on( "click", function() {
		$("#parent").val(0);
		$("#parentName").val("${dataGroup.parentName}");
		dataGroupDialog.dialog("close");
	});

	// 지도에서 찾기
	$( "#mapButtion" ).on( "click", function() {
		var url = "/data/location-map";
		var width = 800;
		var height = 700;

        var popWin = window.open(url, "","toolbar=no ,width=" + width + " ,height=" + height
                + ", directories=no,status=yes,scrollbars=no,menubar=no,location=no");
        //popWin.document.title = layerName;
	});

	// 저장
	var updateDataGroupFlag = true;
	function updateDataGroup() {
		if (validate() == false) {
			return false;
		}
		if(updateDataGroupFlag) {
			updateDataGroupFlag = false;
			var formData = $("#dataGroup").serialize();
			$.ajax({
				url: "/data-group/update",
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
					updateDataGroupFlag = true;
				},
				error:function(request, status, error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updateDataGroupFlag = true;
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