<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>데이터 등록 | NDTP</title>
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
	<link rel="stylesheet" href="/externlib/normalize/normalize.min.css" />
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css" />
    <link rel="stylesheet" href="/externlib/dropzone/dropzone.min.css">
    <link rel="stylesheet" href="/css/${lang}/style.css" />
    <script type="text/javascript" src="/externlib/dropzone/dropzone.min.js"></script>

    <script src="/externlib/jquery/jquery.js"></script>
	<script src="/externlib/jquery-ui/jquery-ui.js"></script>
    <style type="text/css">
        .dropzone .dz-preview.lp-preview {
            width: 150px;
        }
        .dropzone.hzScroll {
            min-width: 700px;
            /*min-width: 1153px;*/
			max-width: 1920px;
            overflow: auto;
            white-space: nowrap;
            border: 1px solid #e5e5e5;
        }
    </style>
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
						<form:form id="uploadData" modelAttribute="uploadData" method="post" onsubmit="return false;">
						<table class="input-table scope-row">
							<colgroup>
			                    <col class="col-label l" style="width: 15%" >
			                    <col class="col-input" style="width: 35%" >
			                    <col class="col-label l" style="width: 15%" >
			                    <col class="col-input" style="width: 35%" >
			                </colgroup>
								<tr>
									<th class="col-label" scope="row">
										<form:label path="dataName">데이터명</form:label>
										<span class="icon-glyph glyph-emark-dot color-warning"></span>
									</th>
									<td class="col-input">
										<form:input path="dataName" class="l" />
				  						<form:errors path="dataName" cssClass="error" />
									</td>
									<th class="col-label" scope="row">
										<form:label path="dataKey">데이터 Key</form:label>
										<span class="icon-glyph glyph-emark-dot color-warning"></span>
									</th>
									<td class="col-type-select">
										<form:hidden path="duplication_value"/>
										<form:input path="dataKey" cssClass="l" />
				  						<input type="button" id="data_duplication_buttion" value="중복확인" />
				  						<form:errors path="dataKey" cssClass="error" />
									</td>
								</tr>
								<tr>
									<th class="col-label" scope="row">
										<form:label path="parentName">데이터 그룹</form:label>
										<span class="icon-glyph glyph-emark-dot color-warning"></span>
									</th>
									<td class="col-input">
										<form:hidden path="dataGroupId" />
			 							<form:input path="dataGroupName" cssClass="l" readonly="true" />
										<input type="button" id="dataGroupButtion" value="데이터 그룹 선택" />
									</td>
									<th class="col-label" scope="row">
				                        <form:label path="sharing">공유 유형</form:label>
				                        <span class="icon-glyph glyph-emark-dot color-warning"></span>
				                    </th>
				                    <td class="col-input">
				                        <select name="sharing">
											<option value="common">공통</option>
											<option value="public">공개</option>
											<option value="private">비공개</option>
											<option value="sharing">그룹 공개</option>
										</select>
				                    </td>
								</tr>
								<tr>




									<th class="col-label" scope="row">
										<form:label path="latitude"><spring:message code='latitude'/></form:label>
									</th>
									<td class="col-input">
										<form:input path="latitude" class="m" />
				  						<form:errors path="latitude" cssClass="error" />
									</td>
								</tr>
								<tr>
									<th class="col-label" scope="row">
										<form:label path="mappingType">매핑 유형</form:label>
									</th>
									<td class="col-input">
										<form:input path="mappingType" class="m" />
				  						<form:errors path="mappingType" cssClass="error" />
									</td>


									<th class="col-label" scope="row">
										<form:label path="longitude"><spring:message code='longitude'/></form:label>
									</th>
									<td class="col-input">
										<form:input path="longitude" class="m" />
				  						<form:errors path="longitude" cssClass="error" />
									</td>
								</tr>
								<tr>
									<th class="col-label" scope="row">
										<form:label path="height"><spring:message code='height'/></form:label>
									</th>
									<td class="col-input">
										<form:input path="height" class="m" />
				  						<form:errors path="height" cssClass="error" />
									</td>
								</tr>
								<tr>
									<th class="col-label" scope="row">
										<form:label path="heading">Heading</form:label>
									</th>
									<td class="col-input">
										<form:input path="heading" class="m" />
				  						<form:errors path="heading" cssClass="error" />
									</td>
								</tr>
								<tr>
									<th class="col-label" scope="row">
										<form:label path="pitch">Pitch</form:label>
									</th>
									<td class="col-input">
										<form:input path="pitch" class="m" />
				  						<form:errors path="pitch" cssClass="error" />
									</td>
								</tr>
								<tr>
									<th class="col-label" scope="row">
										<form:label path="roll">Roll</form:label>
									</th>
									<td class="col-input">
										<form:input path="roll" class="m" />
				  						<form:errors path="roll" cssClass="error" />
									</td>
								</tr>
								<tr>
									<th class="col-label" scope="row">
										<form:label path="attributes"><spring:message code='properties'/></form:label>
									</th>
									<td class="col-input">
										<form:input path="attributes" class="xl" value="{\"isPhysical\": true}" />
				  						<form:errors path="attributes" cssClass="error" />
									</td>
								</tr>
								<tr>
									<th class="col-label" scope="row">
										<form:label path="description"><spring:message code='description'/></form:label>
									</th>
									<td class="col-input">
										<form:input path="description" class="xl" />
				  						<form:errors path="description" cssClass="error" />
									</td>
								</tr>
							</table>
							</form:form>

							<h4 style="margin-top: 30px; margin-bottom: 5px;">파일 업로딩</h4>
				        <div class="fileSection" style="font-size: 17px;">
				            <form id="my-dropzone" action="" class="dropzone hzScroll"></form>
				        </div>
				        <div class="button-group">
							<div class="center-buttons">
								<input type="submit" id="allFileUpload" value="<spring:message code='save'/>" onclick="insertLayerGroup();" />
								<input type="submit" id="allFileClear" value="초기화" />
								<a href="/data/list" class="button">목록</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>

	<!-- Dialog -->
	<div id="dataDialog" class="dataDialog">
		<table class="list-table scope-col">
			<col class="col-number" />
			<col class="col-name" />
			<col class="col-id" />
			<col class="col-name" />
			<col class="col-toggle" />
			<col class="col-toggle" />
			<col class="col-toggle" />
			<col class="col-toggle" />
			<col class="col-toggle" />
			<thead>
				<tr>
					<th scope="col" class="col-number"><spring:message code='number'/></th>
					<th scope="col" class="col-number">Depth</th>
					<th scope="col" class="col-id"><spring:message code='key'/></th>
					<th scope="col" class="col-name"><spring:message code='name'/></th>
					<th scope="col" class="col-toggle"><spring:message code='latitude'/></th>
					<th scope="col" class="col-toggle"><spring:message code='longitude'/></th>
					<th scope="col" class="col-toggle"><spring:message code='height'/></th>
					<th scope="col" class="col-toggle"><spring:message code='properties'/></th>
					<th scope="col" class="col-toggle"><spring:message code='select'/></th>
				</tr>
			</thead>
			<tbody id="projectDataList">
			</tbody>
		</table>
		<div class="button-group">
			<input type="button" id="rootParentSelect" class="button" value="최상위(ROOT) 폴더로 저장"/>
		</div>
	</div>

<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$(".tabs").tabs();
		$(".select").selectmenu();
	});

	var dataDialog = $( ".dataDialog" ).dialog({
		autoOpen: false,
		height: 600,
		width: 1200,
		modal: true,
		overflow : "auto",
		resizable: false
	});

	// 부모 찾기
	$( "#parentFind" ).on( "click", function() {
		dataDialog.dialog( "open" );
		dataDialog.dialog( "option", "title", $("#project_id option:selected").prop("label"));
		drawDataList($("#project_id").val());
	});

	function drawDataList(projectId) {
		if(projectId === "") {
			alert(JS_MESSAGE["project.project_id.empty"]);
			return false;
		}
		var info = "project_id=" + projectId;
		$.ajax({
			url: "/data/ajax-list-data-by-project-id.do",
			type: "POST",
			data: info,
			headers: {"X-Requested-With": "XMLHttpRequest"},
			dataType: "json",
			success: function(msg){
				if(msg.result == "success") {
					var content = "";
					var dataList = msg.dataList;
					var projectDataNone = "<spring:message code='data.does.not.exist'/>";
					if(dataList == null || dataList.length == 0) {
						content = content
							+ 	"<tr>"
							+ 	"	<td colspan=\"9\" class=\"col-none\">" + projectDataNone + "</td>"
							+ 	"</tr>";
					} else {
						dataListCount = dataList.length;
						var preViewDepth = "";
						var preDataId = 0;
						var preDepth = 0;
						var select = "<spring:message code='select'/>";
						for(i=0; i<dataListCount; i++ ) {
							var dataInfo = dataList[i];
							var viewAttributes = dataInfo.attributes;
							var viewDepth = getViewDepth(preViewDepth, dataInfo.data_id, preDepth, dataInfo.depth);
							if(viewAttributes !== null && viewAttributes !== "" && viewAttributes.length > 20) viewAttributes = viewAttributes.substring(0, 20) + "...";
							content = content
								+ 	"<tr>"
								+ 	"	<td class=\"col-number\">" + (i + 1) + " </td>"
								+ 	"	<td class=\"col-id\">" + viewDepth + "</td>"
								+ 	"	<td class=\"col-id\">" + dataInfo.data_key + "</td>"
								+ 	"	<td class=\"col-name\">" + dataInfo.data_name + "</td>"
								+ 	"	<td class=\"col-toggle\">" + dataInfo.latitude + "</td>"
								+ 	"	<td class=\"col-toggle\">" + dataInfo.longitude + "</td>"
								+ 	"	<td class=\"col-toggle\">" + dataInfo.height + "</td>"
								+ 	"	<td class=\"col-toggle\">" + viewAttributes + "</td>"
								+ 	"	<td class=\"col-toggle\"><a href=\"#\" onclick=\"confirmParent('"
								+ 									dataInfo.data_id + "', '" + dataInfo.data_name + "', '" + dataInfo.depth + "'); return false;\">" + select + "</a></td>"
								+ 	"</tr>";

							preDataId = dataInfo.data_id;
							preDepth = dataInfo.depth;
							preViewDepth = viewDepth;
						}
					}

					$("#projectDataList").empty();
					$("#projectDataList").html(content);
				} else {
					alert(JS_MESSAGE[msg.result]);
				}
			},
			error:function(request, status, error) {
				//alert(JS_MESSAGE["ajax.error.message"]);
				alert(" code : " + request.status + "\n" + ", message : " + request.responseText + "\n" + ", error : " + error);
    		}
		});
	}

	function getViewDepth(preViewDepth, dataId, preDepth, depth) {
		var result = "";
		if(depth === 1) return result + dataId;

		if(preDepth === depth) {
			// 형제
			if(preViewDepth.indexOf(".") >= 0) {
				result =  preViewDepth.substring(0, preViewDepth.lastIndexOf(".") + 1) + dataId;
			} else {
				result = dataId;
			}
		} else if(preDepth < depth) {
			// 자식
			result = preViewDepth + "." + dataId;
		} else {
			result =  preViewDepth.substring(0, preViewDepth.lastIndexOf("."));
			result =  result.substring(0, result.lastIndexOf(".") + 1) + dataId;
		}
		return result;
	}

	// 상위 Node
	function confirmParent(dataId, dataName, depth) {
		$("#parent").val(dataId);
		$("#parent_name").val(dataName);
		$("#parent_depth").val(depth);
		dataDialog.dialog( "close" );
	}

	$( "#rootParentSelect" ).on( "click", function() {
		$("#parent").val(0);
		$("#parent_name").val("최상위 Node");
		$("#parent_depth").val(1);
		dataDialog.dialog( "close" );
	});

	// 아이디 중복 확인
	$( "#data_duplication_buttion" ).on( "click", function() {
		var dataKey = $("#data_key").val();
		if (dataKey == "") {
			alert(JS_MESSAGE["data.key.empty"]);
			$("#data_id").focus();
			return false;
		}
		var info = "project_id=" + $("#project_id").val() + "&data_key=" + dataKey;
		$.ajax({
			url: "/data/ajax-data-key-duplication-check.do",
			type: "POST",
			data: info,
			headers: {"X-Requested-With": "XMLHttpRequest"},
			dataType: "json",
			success: function(msg){
				if(msg.result == "success") {
					if(msg.duplication_value != "0") {
						alert(JS_MESSAGE["data.key.duplication"]);
						$("#data_key").focus();
						return false;
					} else {
						alert(JS_MESSAGE["data.key.enable"]);
						$("#duplication_value").val(msg.duplication_value);
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

	// Data 정보 저장
	var insertDataFlag = true;
	function insertData() {
		if (checkData() == false) {
			return false;
		}
		if(insertDataFlag) {
			insertDataFlag = false;
			var info = $("#dataInfo").serialize();
			$.ajax({
				url: "/data/ajax-insert-data-info.do",
				type: "POST",
				data: info,
				headers: {"X-Requested-With": "XMLHttpRequest"},
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["data.insert"]);
						$("#parent").val("");
						$("#duplication_value").val("");
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
			$("#parent_name").focus();
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