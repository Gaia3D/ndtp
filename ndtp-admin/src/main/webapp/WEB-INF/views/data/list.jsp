<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>데이터 목록 | NDTP</title>
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
					<div class="filters">
						<form:form id="searchForm" modelAttribute="dataInfo" method="post" action="/data/list" onsubmit="return searchCheck();">
						<div class="input-group row">
							<div class="input-set">
								<label for="searchWord"><spring:message code='search.word'/></label>
								<select id="searchWord" name="searchWord" class="select" style="height: 30px;">
									<option value=""><spring:message code='select'/></option>
				          			<option value="data_name">데이터명</option>
				          			<option value="data_group_name">데이터그룹명</option>
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
									<option value="data_name">데이터 명</option>
				          			<option value="data_group_name">데이터 그룹명</option>
									<option value="insert_date"> <spring:message code='search.insert.date'/> </option>
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
						<form:form id="listForm" modelAttribute="dataInfo" method="post">
							<input type="hidden" id="checkIds" name="checkIds" value="" />
						<div class="list-header row">
							<div class="list-desc u-pull-left">
								<spring:message code='all.d'/> <em><fmt:formatNumber value="${pagination.totalCount}" type="number"/></em><spring:message code='search.what.count'/>
								<fmt:formatNumber value="${pagination.pageNo}" type="number"/> / <fmt:formatNumber value="${pagination.lastPage }" type="number"/> <spring:message code='search.page'/>
							</div>
							<div class="list-functions u-pull-right">
								<div class="button-group">
									<a href="#" onclick="updateDataStatus('DATA', 'USE'); return false;" class="button">사용</a>
									<a href="#" onclick="updateDataStatus('DATA', 'UNUSED'); return false;" class="button">사용중지</a>
									<a href="#" onclick="deleteDatas(); return false;" class="button"><spring:message code='data.all.delete'/></a>
									<a href="#" onclick="uploadDataGroupDataAttribute(); return false;" class="button"><spring:message code='data.attribute.insert'/></a>
									<a href="#" onclick="uploadDataGroupDataObjectAttribute(); return false;" class="button"><spring:message code='data.object.attribute.insert'/></a>
								</div>
							</div>
						</div>
						<table class="list-table scope-col">
							<col class="col-checkbox" />
							<col class="col-number" />
							<col class="col-name" />
							<col class="col-name" />
							<col class="col-number" />
							<col class="col-number" />
							<col class="col-number" />
							<col class="col-functions" />
							<col class="col-functions" />
							<col class="col-functions" />
							<col class="col-functions" />
							<thead>
								<tr>
									<th scope="col" class="col-checkbox"><input type="checkbox" id="chkAll" name="chkAll" /></th>
									<th scope="col" class="col-number"><spring:message code='number'/></th>
									<th scope="col" class="col-name">그룹명</th>
									<th scope="col" class="col-name">데이터명</th>
									<th scope="col" class="col-name">상태</th>
									<th scope="col" class="col-name">지도</th>
									<th scope="col" class="col-name">메타정보</th>
									<th scope="col" class="col-name">속성</th>
									<th scope="col" class="col-name">오브젝트 속성</th>
									<th scope="col" class="col-name">편집</th>
									<th scope="col" class="col-date">등록일</th>
								</tr>
							</thead>
							<tbody>
<c:if test="${empty dataList }">
								<tr>
									<td colspan="11" class="col-none"><spring:message code='data.does.not.exist'/></td>
								</tr>
</c:if>
<c:if test="${!empty dataList }">
	<c:forEach var="dataInfo" items="${dataList}" varStatus="status">

								<tr>
									<td class="col-checkbox">
										<input type="checkbox" id="dataId_${dataInfo.dataId}" name="dataId" value="${dataInfo.dataId}" />
									</td>
									<td class="col-number">${pagination.rowNumber - status.index }</td>
									<td class="col-name">
										<a href="#" class="view-group-detail" onclick="detailDataGroup('${dataInfo.dataGroupId }'); return false;">${dataInfo.dataGroupName }</a></td>
									<td class="col-name"><a href="/data/detail?dataId=${dataInfo.dataId }&amp;pageNo=${pagination.pageNo }${pagination.searchParameters}">
										${dataInfo.dataName }</a></td>
									<td class="col-type">
		<c:if test="${dataInfo.status eq 'use'}">
										<span class="icon-glyph glyph-on on"></span>
										<span class="icon-text">사용중</span>
		</c:if>
		<c:if test="${dataInfo.status eq 'unused'}">
										<span class="icon-glyph glyph-off off"></span>
										<span class="icon-text">사용중지</span>
		</c:if>
		<c:if test="${dataInfo.status eq 'delete'}">
										<span class="icon-glyph glyph-off off"></span>
										<span class="icon-text">삭제(비표시)</span>
		</c:if>
									</td>
									<td class="col-type">
										<a href="#" onclick="viewMapData('${dataInfo.dataId }'); return false;">보기</a></td>
									<td class="col-type">
										<a href="#" onclick="detailMetainfo('${dataInfo.dataId }'); return false;">보기</a>
									</td>
									<td class="col-functions">
										<span class="button-group">
											<a href="#" onclick="detailDataAttribute('${dataInfo.dataId }', '${dataInfo.dataName }'); return false;">보기</a>
											<a href="#" class="image-button button-edit"
												onclick="uploadDataAttribute('${dataInfo.dataId }', '${dataInfo.dataName }'); return false;">
												<spring:message code='modified'/></a>
										</span>
									</td>
									<td class="col-functions">
										<span class="button-group">
											<a href="#" class="image-button button-edit"
												onclick="uploadDataObjectAttribute('${dataInfo.dataId }', '${dataInfo.dataName }'); return false;">
												<spring:message code='modified'/></a>
										</span>
									</td>
									<td class="col-functions">
										<span class="button-group">
											<a href="/data/modify?dataId=${dataInfo.dataId }&amp;pageNo=${pagination.pageNo }${pagination.searchParameters}" >
												<spring:message code='modified'/></a>&nbsp;&nbsp;
											<a href="/data/delete?dataId=${dataInfo.dataId }" onclick="return deleteWarning();" >
												<spring:message code='delete'/></a>
										</span>
									</td>
									<td class="col-type">
										<fmt:parseDate value="${dataInfo.insertDate}" var="viewInsertDate" pattern="yyyy-MM-dd HH:mm:ss"/>
										<fmt:formatDate value="${viewInsertDate}" pattern="yyyy-MM-dd HH:mm"/>
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

<%@ include file="/WEB-INF/views/data/group-dialog.jsp" %>
<%@ include file="/WEB-INF/views/data/data-metainfo-dialog.jsp" %>
<%@ include file="/WEB-INF/views/data/data-attribute-dialog.jsp" %>
<%@ include file="/WEB-INF/views/data/data-attribute-file-dialog.jsp" %>
<%@ include file="/WEB-INF/views/data/data-object-attribute-file-dialog.jsp" %>
<%--
<%@ include file="/WEB-INF/views/data/group-data-attribute-file-dialog.jsp" %>
<%@ include file="/WEB-INF/views/data/group-data-object-attribute-file-dialog.jsp" %> --%>

<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript">

	// 전체 선택
	$("#chkAll").click(function() {
		$(":checkbox[name=dataGroupid]").prop("checked", this.checked);
	});

	// 데이터 그룹 정보
	function detailDataGroup(dataGroupId) {
		dataGroupDialog.dialog( "open" );

		$.ajax({
			url: "/data-group/detail",
			data: { "dataGroupId" : dataGroupId },
			type: "GET",
			headers: {"X-Requested-With": "XMLHttpRequest"},
			dataType: "json",
			success: function(msg){
				if(msg.statusCode <= 200) {
					$("#dataGroupNameInfo").html(msg.dataGroup.dataGroupName);
					$("#sharingInfo").html(msg.dataGroup.sharing);
					$("#availableInfo").html(msg.dataGroup.available);
					$("#descriptionInfo").html(msg.dataGroup.description);
				} else {
					alert(JS_MESSAGE[msg.errorCode]);
				}
			},
			error:function(request,status,error){
				alert(JS_MESSAGE["ajax.error.message"]);
			}
		});
	}

		// 제어 속성
	function detailMetainfo(dataId) {
		dataMetainfoDialog.dialog( "open" );

		$.ajax({
			url: "/data/detail-data-info",
			data: { dataId : dataId },
			type: "GET",
			headers: {"X-Requested-With": "XMLHttpRequest"},
			dataType: "json",
			success: function(msg){
				if(msg.statusCode <= 200) {
					$("#dataMetainfo").html(msg.dataInfo.metainfo);
				} else {
					alert(JS_MESSAGE[msg.errorCode]);
				}
			},
			error:function(request,status,error){
				alert(JS_MESSAGE["ajax.error.message"]);
			}
		});
	}

	// 데이터 속성
	function detailDataAttribute(dataId, dataName) {
		dataAttributeDialog.dialog( "open" );
		$("#data_name_for_origin").html(dataName);

		$.ajax({
			url: "/data/detail-data-attribute",
			data: { data_id : dataId },
			type: "GET",
			headers: {"X-Requested-With": "XMLHttpRequest"},
			dataType: "json",
			success: function(msg){
				if(msg.statusCode <= 200) {
					if(msg.dataInfoAttribute !== null) {
						$("#dataAttributeForOrigin").html(msg.dataInfoAttribute.attributes);
					}
				} else {
					alert(JS_MESSAGE[msg.errorCode]);
				}
			},
			error:function(request,status,error){
				alert(JS_MESSAGE["ajax.error.message"]);
			}
		});
	}

	// origin 속성 수정
	function uploadDataAttribute(dataId, dataName) {
		uploadDataAttributeDialog.dialog( "open" );
		$("#attributeFileName").val("");
		$("#dataAttributeUploadLog > tbody:last").html("");
		$("#attributeFileDataId").val(dataId);
		$("#attributeDataName").html(dataName);
	}

	// origin 속성 파일 upload
	var dataAttributeFileUploadFlag = true;
	function dataAttributeFileUpload() {
		alert("준비 중입니다.");
		return;

		var fileName = $("#attributeFileName").val();
		if(fileName === "") {
			alert(JS_MESSAGE["file.name.empty"]);
			$("#attributeFileName").focus();
			return false;
		}
		if( fileName.lastIndexOf("json") <=0 && fileName.lastIndexOf("txt") <=0 ) {
			alert(JS_MESSAGE["file.ext.invalid"]);
			$("#fileName").focus();
			return false;
		}

		if(dataAttributeFileUploadFlag) {
			dataAttributeFileUploadFlag = false;
			var totalNumber = "총건수";
			var successParsing = "성공 건수";
			var failedParsing = "실패 건수";
			var insertSuccessCount = "DB 등록 건수'/>";
			var updateSuccessCount = "DB 수정 건수'/>";
			var failCount = "DB 실패 건수'/>";
			$("#dataAttributeInfo").ajaxSubmit({
				type: "POST",
				headers: {"X-Requested-With": "XMLHttpRequest"},
				dataType: "json",
				success: function(msg){
					if(msg.statusCode <= 200) {
						if(msg.parseErrorCount != 0 || msg.insertErrorCount != 0) {
							$("#dataFileName").val("");
							alert(JS_MESSAGE["error.exist.in.processing"]);
						} else {
							alert(JS_MESSAGE["update"]);
						}
						var content = ""
							+ "<tr>"
							+ 	"<td colspan=\"2\" style=\"text-align: center;\">Result of parsing</td>"
							+ "</tr>"
							+ "<tr>"
							+ 	"<td> " + totalNumber + "</td>"
							+ 	"<td> " + msg.totalCount + "</td>"
							+ "</tr>"
							+ "<tr>"
							+ 	"<td> " + successParsing + "</td>"
							+ 	"<td> " + msg.parseSuccessCount + "</td>"
							+ "</tr>"
							+ "<tr>"
							+ 	"<td> " + failedParsing + "</td>"
							+ 	"<td> " + msg.parseErrorCount + "</td>"
							+ "</tr>"
							+ "<tr>"
							+ 	"<td> " + insertSuccessCount + "</td>"
							+ 	"<td> " + msg.insertSuccessCount + "</td>"
							+ "</tr>"
							/* + "<tr>"
							+ 	"<td> " + updateSuccessCount + "</td>"
							+ 	"<td> " + msg.update_success_count + "</td>"
							+ "</tr>" */
							+ "<tr>"
							+ 	"<td> " + failCount + "</td>"
							+ 	"<td> " + msg.insertErrorCount + "</td>"
							+ "</tr>";
							$("#dataAttributeUploadLog > tbody:last").html("");
							$("#dataAttributeUploadLog > tbody:last").append(content);
					} else {
						alert(JS_MESSAGE[msg.errorCode]);
	    			}
					dataAttributeFileUploadFlag = true;
				},
				error:function(request,status,error){
					alert(JS_MESSAGE["ajax.error.message"]);
					dataAttributeFileUploadFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}

	// Data Object Attribute 파일 수정
	function uploadDataObjectAttribute(dataId, dataName) {
		uploadDataObjectAttributeDialog.dialog( "open" );
		$("#objectAttributeFileName").val("");
			$("#dataObjectAttributeUploadLog > tbody:last").html("");
		$("#objectAttributeFileDataId").val(dataId);
		$("#objectAttributeDataName").html(dataName);
	}

	// Data Object 속성 파일 upload
	var dataObjectAttributeFileUploadFlag = true;
	function dataObjectAttributeFileUpload() {
		alert("준비 중입니다.");
		return;

		var fileName = $("#object_attribute_file_name").val();
		if(fileName === "") {
			alert(JS_MESSAGE["file.name.empty"]);
			$("#object_attribute_file_name").focus();
			return false;
		}

		if( fileName.lastIndexOf("json") <=0 && fileName.lastIndexOf("txt") <=0 ) {
			alert(JS_MESSAGE["file.ext.invalid"]);
			$("#file_name").focus();
			return false;
		}

		if(dataObjectAttributeFileUploadFlag) {
			dataObjectAttributeFileUploadFlag = false;

			var totalNumber = "총건수";
			var successParsing = "성공 건수";
			var failedParsing = "실패 건수";
			var insertSuccessCount = "DB 등록 건수'/>";
			var updateSuccessCount = "DB 수정 건수'/>";
			var failCount = "DB 실패 건수'/>";
			$("#dataObjectAttributeInfo").ajaxSubmit({
				type: "POST",
				headers: {"X-Requested-With": "XMLHttpRequest"},
				dataType: "json",
				success: function(msg){
					if(msg.statusCode <= 200) {
						if(msg.parse_error_count != 0 || msg.insert_error_count != 0) {
							$("#data_file_name").val("");
							alert(JS_MESSAGE["error.exist.in.processing"]);
						} else {
							alert(JS_MESSAGE["update"]);
						}
						var content = ""
							+ "<tr>"
							+ 	"<td colspan=\"2\" style=\"text-align: center;\">Result of parsing</td>"
							+ "</tr>"
							+ "<tr>"
							+ 	"<td> " + totalNumber + "</td>"
							+ 	"<td> " + msg.total_count + "</td>"
							+ "</tr>"
							+ "<tr>"
							+ 	"<td> " + successParsing + "</td>"
							+ 	"<td> " + msg.parse_success_count + "</td>"
							+ "</tr>"
							+ "<tr>"
							+ 	"<td> " + failedParsing + "</td>"
							+ 	"<td> " + msg.parse_error_count + "</td>"
							+ "</tr>"
							+ "<tr>"
							+ 	"<td> " + insertSuccessCount + "</td>"
							+ 	"<td> " + msg.insert_success_count + "</td>"
							+ "</tr>"
							/* + "<tr>"
							+ 	"<td> " + updateSuccessCount + "</td>"
							+ 	"<td> " + msg.update_success_count + "</td>"
							+ "</tr>" */
							+ "<tr>"
							+ 	"<td> " + failCount + "</td>"
							+ 	"<td> " + msg.insert_error_count + "</td>"
							+ "</tr>";
							$("#dataObjectAttributeUploadLog > tbody:last").html("");
							$("#dataObjectAttributeUploadLog > tbody:last").append(content);
					} else {
						alert(JS_MESSAGE[msg.errorCode]);
	    			}
					dataObjectAttributeFileUploadFlag = true;
				},
				error:function(request,status,error){
					alert(JS_MESSAGE["ajax.error.message"]);
					dataObjectAttributeFileUploadFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}

	// Data 일괄 삭제
	var deleteDatasFlag = true;
	function deleteDatas() {
		if($("input:checkbox[name=data_id]:checked").length == 0) {
			alert(JS_MESSAGE["check.value.required"]);
			return false;
		} else {
			var checkedValue = "";
			$("input:checkbox[name=data_id]:checked").each(function(index){
				checkedValue += $(this).val() + ",";
			});
			$("#check_ids").val(checkedValue);
		}

		if(confirm(JS_MESSAGE["delete.confirm"])) {
			if(deleteDatasFlag) {
				deleteDatasFlag = false;
				var info = $("#listForm").serialize();
				$.ajax({
					url: "/data/ajax-delete-datas.do",
					type: "POST",
					data: info,
					headers: {"X-Requested-With": "XMLHttpRequest"},
					dataType: "json",
					success: function(msg){
						if(msg.statusCode <= 200) {
							alert(JS_MESSAGE["delete"]);
							location.reload();
							$(":checkbox[name=data_id]").prop("checked", false);
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

	// 일괄등록(파일)
	var dataFileUploadFlag = true;
	function dataFileUpload() {
		var fileName = $("#data_file_name").val();
		if(fileName === "") {
			alert(JS_MESSAGE["file.name.empty"]);
			$("#data_file_name").focus();
			return false;
		}

		if( fileName.lastIndexOf("xlsx") <=0
				&& fileName.lastIndexOf("xls") <=0
				&& fileName.lastIndexOf("json") <=0
				&& fileName.lastIndexOf("txt") <=0 ) {
			alert(JS_MESSAGE["file.ext.invalid"]);
			$("#data_file_name").focus();
			return false;
		}

		if(dataFileUploadFlag) {
			dataFileUploadFlag = false;
			var totalNumber = "총건수";
			var successParsing = "성공 건수";
			var failedParsing = "실패 건수";
			var insertSuccessCount = "DB 등록 건수'/>";
			var updateSuccessCount = "DB 수정 건수'/>";
			var failCount = "DB 실패 건수'/>";
			$("#dataFileInfo").ajaxSubmit({
				type: "POST",
				headers: {"X-Requested-With": "XMLHttpRequest"},
				dataType: "json",
				success: function(msg){
					if(msg.statusCode <= 200) {
						if(msg.parse_error_count != 0 || msg.insert_error_count != 0) {
							$("#data_file_name").val("");
							alert(JS_MESSAGE["error.exist.in.processing"]);
						} else {
							alert(JS_MESSAGE["update"]);
						}
						var content = ""
						+ "<tr>"
						+ 	"<td colspan=\"2\" style=\"text-align: center;\">Result of parsing</td>"
						+ "</tr>"
						+ "<tr>"
						+ 	"<td> " + totalNumber + "</td>"
						+ 	"<td> " + msg.total_count + "</td>"
						+ "</tr>"
						+ "<tr>"
						+ 	"<td> " + successParsing + "</td>"
						+ 	"<td> " + msg.parse_success_count + "</td>"
						+ "</tr>"
						+ "<tr>"
						+ 	"<td> " + failedParsing + "</td>"
						+ 	"<td> " + msg.parse_error_count + "</td>"
						+ "</tr>"
						+ "<tr>"
						+ 	"<td> " + insertSuccessCount + "</td>"
						+ 	"<td> " + msg.insert_success_count + "</td>"
						+ "</tr>"
						+ "<tr>"
						+ 	"<td> " + updateSuccessCount + "</td>"
						+ 	"<td> " + msg.update_success_count + "</td>"
						+ "</tr>"
						+ "<tr>"
						+ 	"<td> " + failCount + "</td>"
						+ 	"<td> " + msg.insert_error_count + "</td>"
						+ "</tr>";
						$("#dataFileUploadLog > tbody:last").html("");
						$("#dataFileUploadLog > tbody:last").append(content);
					} else {
						alert(JS_MESSAGE[msg.errorCode]);
	    			}
					dataFileUploadFlag = true;
				},
				error:function(request,status,error){
					alert(JS_MESSAGE["ajax.error.message"]);
					dataFileUploadFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}

	// Data Attribute 일괄 등록
	function uploadProjectDataAttribute() {
		uploadProjectDataAttributeDialog.dialog( "open" );
		$("#project_data_attribute_path").val("");
			$("#projectDataAttributeUploadLog > tbody:last").html("");
	}

	// data attribute 일괄 등록
	var projectDataAttributeFileUploadFlag = true;
	function projectDataAttributeFileUpload() {
		if(projectDataAttributeFileUploadFlag) {
			projectDataAttributeFileUploadFlag = false;
			var totalNumber = "총건수";
			var successParsing = "성공 건수";
			var failedParsing = "실패 건수";
			var insertSuccessCount = "DB 등록 건수'/>";
			var updateSuccessCount = "DB 수정 건수'/>";
			var failCount = "DB 실패 건수'/>";
			var info = $("#projectDataAttributeInfo").serialize();
			$.ajax({
				url: "/data/ajax-insert-project-data-attribute.do",
				type: "POST",
				data: info,
				headers: {"X-Requested-With": "XMLHttpRequest"},
				dataType: "json",
				success: function(msg){
					//if(msg.statusCode <= 200) {
					//} alert(JS_MESSAGE[msg.errorCode]);

					if(msg.insert_error_count != 0) {
						$("#project_data_attribute_path").val("");
						alert(JS_MESSAGE["error.exist.in.processing"]);
					} else {
						alert(JS_MESSAGE["update"]);
					}
					var content = ""
					+ "<tr>"
					+ 	"<td colspan=\"2\" style=\"text-align: center;\">Result of parsing</td>"
					+ "</tr>"
					+ "<tr>"
					+ 	"<td> " + totalNumber + "</td>"
					+ 	"<td> " + msg.total_count + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ 	"<td> " + insertSuccessCount + "</td>"
					+ 	"<td> " + msg.insert_success_count + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ 	"<td> " + updateSuccessCount + "</td>"
					+ 	"<td> " + msg.update_success_count + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ 	"<td> " + failCount + "</td>"
					+ 	"<td> " + msg.insert_error_count + "</td>"
					+ "</tr>";
					$("#projectDataAttributeUploadLog > tbody:last").html("");
					$("#projectDataAttributeUploadLog > tbody:last").append(content);
					projectDataAttributeFileUploadFlag = true;
				},
				error:function(request,status,error){
					alert(JS_MESSAGE["ajax.error.message"]);
					projectDataAttributeFileUploadFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}

	// Data Object Attribute 일괄 등록
	function uploadProjectDataObjectAttribute() {
		uploadProjectDataObjectAttributeDialog.dialog( "open" );
		$("#project_data_object_attribute_path").val("");
			$("#projectDataObjectAttributeUploadLog > tbody:last").html("");
	}

	// data object attribute 일괄 등록
	var projectDataObjectAttributeFileUploadFlag = true;
	function projectDataObjectAttributeFileUpload() {
		if(projectDataObjectAttributeFileUploadFlag) {
			projectDataObjectAttributeFileUploadFlag = false;
			var totalNumber = "총건수";
			var successParsing = "성공 건수";
			var failedParsing = "실패 건수";
			var insertSuccessCount = "DB 등록 건수'/>";
			var updateSuccessCount = "DB 수정 건수'/>";
			var failCount = "DB 실패 건수'/>";
			var info = $("#projectDataObjectAttributeInfo").serialize();
			$.ajax({
				url: "/data/ajax-insert-project-data-object-attribute.do",
				type: "POST",
				data: info,
				dataType: "json",
				success: function(msg){
					// if(msg.statusCode <= 200) {
					// alert(JS_MESSAGE[msg.errorCode]);

					if(msg.insert_error_count != 0) {
						$("#project_data_object_attribute_path").val("");
						alert(JS_MESSAGE["error.exist.in.processing"]);
					} else {
						alert(JS_MESSAGE["update"]);
					}
					var content = ""
					+ "<tr>"
					+ 	"<td colspan=\"2\" style=\"text-align: center;\">Result of parsing</td>"
					+ "</tr>"
					+ "<tr>"
					+ 	"<td> " + totalNumber + "</td>"
					+ 	"<td> " + msg.total_count + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ 	"<td> " + insertSuccessCount + "</td>"
					+ 	"<td> " + msg.insert_success_count + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ 	"<td> " + updateSuccessCount + "</td>"
					+ 	"<td> " + msg.update_success_count + "</td>"
					+ "</tr>"
					+ "<tr>"
					+ 	"<td> " + failCount + "</td>"
					+ 	"<td> " + msg.insert_error_count + "</td>"
					+ "</tr>";
					$("#projectDataObjectAttributeUploadLog > tbody:last").html("");
					$("#projectDataObjectAttributeUploadLog > tbody:last").append(content);
					projectDataObjectAttributeFileUploadFlag = true;
				},
				error:function(request,status,error){
					alert(JS_MESSAGE["ajax.error.message"]);
					projectDataObjectAttributeFileUploadFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}

	// 데이터 그룹 정보
	var dataGroupDialog = $( ".dataGroupDialog" ).dialog({
		autoOpen: false,
		width: 400,
		height: 300,
		modal: true,
		resizable: false
	});
	// 데이터 제어 속성 다이얼 로그
	var dataMetainfoDialog = $( ".dataMetainfoDialog" ).dialog({
		autoOpen: false,
		width: 500,
		height: 255,
		modal: true,
		resizable: false
	});
	// 데이터 속성 다이얼 로그
	var dataAttributeDialog = $( ".dataAttributeDialog" ).dialog({
		autoOpen: false,
		width: 600,
		height: 350,
		modal: true,
		resizable: false
	});
	// 데이터 속성 하나 등록 다이얼 로그
	var uploadDataAttributeDialog = $( ".uploadDataAttributeDialog" ).dialog({
		autoOpen: false,
		width: 600,
		height: 445,
		modal: true,
		resizable: false
	});
	// 데이터 Object 속성 하나 등록
	var uploadDataObjectAttributeDialog = $( ".uploadDataObjectAttributeDialog" ).dialog({
		autoOpen: false,
		width: 600,
		height: 445,
		modal: true,
		resizable: false
	});
	// 데이터 속성 프로젝트 전체 등록 다이얼 로그
	var uploadDataGroupDataAttributeDialog = $( ".uploadDataGroupDataAttributeDialog" ).dialog({
		autoOpen: false,
		width: 600,
		height: 445,
		modal: true,
		resizable: false
	});
	// 프로젝트 데이터 Object 속성 하나 등록
	var uploadDataGroupDataObjectAttributeDialog = $( ".uploadDataGrouptDataObjectAttributeDialog" ).dialog({
		autoOpen: false,
		width: 600,
		height: 445,
		modal: true,
		resizable: false
	});

	// Map 에 데이터 표시
	function viewMapData(dataId) {
		var url = "/data/map-data?dataId=" + dataId;
		var width = 800;
		var height = 700;

        var popWin = window.open(url, "","toolbar=no ,width=" + width + " ,height=" + height
                + ", directories=no,status=yes,scrollbars=no,menubar=no,location=no");
        //popWin.document.title = layerName;
	}
</script>
</body>
</html>
