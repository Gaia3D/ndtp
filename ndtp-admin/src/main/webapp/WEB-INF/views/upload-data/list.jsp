<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>업로딩 파일 목록 | NDTP</title>
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
							<form:form id="searchForm" modelAttribute="uploadData" method="post" action="/upload-data/list-upload-data" onsubmit="return searchCheck();">
							<div class="input-group row">
								<div class="input-set">
									<label for="searchWord"><spring:message code='search.word'/></label>
									<select id="searchWord" name="searchWord" class="select" style="height: 30px;">
										<option value=""><spring:message code='select'/></option>
					          			<option value="data_name">파일명</option>
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
										<option value="data_name">파일명</option>
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
							<form:form id="listForm" modelAttribute="uploadData" method="post">
								<input type="hidden" id="checkIds" name="checkIds" value="" />
							<div class="list-header">
								<div class="list-desc u-pull-left">
									<spring:message code='all.d'/> <em><fmt:formatNumber value="${pagination.totalCount}" type="number"/></em><spring:message code='search.what.count'/> 
									<fmt:formatNumber value="${pagination.pageNo}" type="number"/> / <fmt:formatNumber value="${pagination.lastPage }" type="number"/> <spring:message code='search.page'/>
								</div>
								<div class="list-functions u-pull-right">
									<div style="padding-bottom: 3px;" class="button-group">
										<a href="#" onclick="converterFiles(); return false;" class="button">F4D 일괄 변환</a>	
									</div>
								</div>
							</div>
							<table class="list-table scope-col">
									<col class="col-checkbox" />
									<col class="col-number" />
									<col class="col-name" />
									<col class="col-name" />
									<col class="col-name" />
									<col class="col-number" />
									<col class="col-number" />
									<col class="col-number" />
									<col class="col-functions" />
									<col class="col-functions" />
									<col class="col-functions" />
									<thead>
										<tr>
											<th scope="col" class="col-checkbox"><input type="checkbox" id="chkAll" name="chkAll" /></th>
											<th scope="col" class="col-number"><spring:message code='number'/></th>
											<th scope="col" class="col-name">공유 유형</th>
											<th scope="col" class="col-name">데이터 타입</th>
											<th scope="col" class="col-name">그룹명</th>
											<th scope="col" class="col-name">데이터명</th>
											<th scope="col" class="col-name">파일 개수</th>
											<th scope="col" class="col-name">Converter 횟수</th>
											<th scope="col" class="col-functions">Converter</th>
											<th scope="col" class="col-functions">삭제</th>
											<th scope="col" class="col-date">등록일</th>
										</tr>
									</thead>
									<tbody>
		<c:if test="${empty uploadDataList }">
										<tr>
											<td colspan="11" class="col-none">파일 업로딩 이력이 존재하지 않습니다.</td>
										</tr>
		</c:if>
		<c:if test="${!empty uploadDataList }">
			<c:forEach var="uploadData" items="${uploadDataList}" varStatus="status">
				
										<tr>
											<td class="col-checkbox">
												<input type="checkbox" id="uploadDataId_${uploadData.uploadDataId}" name="uploadDataId" value="${uploadData.uploadDataId}" />
											</td>
											<td class="col-number">${pagination.rowNumber - status.index }</td>
						
											<td class="col-type">
				<c:if test="${uploadData.sharing eq 'common' }">
												공통
				</c:if>
				<c:if test="${uploadData.sharing eq 'public' }">
												공개
				</c:if>
				<c:if test="${uploadData.sharing eq '2' }">
												개인
				</c:if>
				<c:if test="${uploadData.sharing eq '3' }">
												공유
				</c:if>
											</td>
											<td class="col-type">${uploadData.dataType }</td>
											<td class="col-name">${uploadData.dataGroupName }</td>
											<td class="col-name">
												<a href="/upload-data/modify?uploadDataId=${uploadData.uploadDataId }">
												${uploadData.dataName }
												</a>
											</td>
											<td class="col-count"><fmt:formatNumber value="${uploadData.fileCount}" type="number"/> 개</td>
											<td class="col-count">${uploadData.converterCount} 건</td>
											<td class="col-functions">
												<span class="button-group">
													<a href="#" onclick="converterFile('${uploadData.uploadDataId}', '${uploadData.dataName}'); return false;" 
														class="button" style="text-decoration: none;">
														F4D 변환
													</a>
												</span>
											</td>
											<td class="col-functions">
												<span class="button-group">
													<a href="#" onclick="deleteUploadData(${uploadData.uploadDataId }); return false;" 
														class="image-button button-delete"><spring:message code='delete'/></a>
												</span>
											</td>
											<td class="col-type">
												<fmt:parseDate value="${uploadData.insertDate}" var="viewInsertDate" pattern="yyyy-MM-dd HH:mm:ss"/>
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

	<%-- F4D Converter Job 등록 --%>
	<div class=dialogConverterJob title="F4D Converter Job 등록">
		<form id="converterJobForm" name="converterJobForm" action="" method="post">
			<input type="hidden" id="converterCheckIds" name="converterCheckIds" value="" />
			<table class="inner-table scope-row">
				<col class="col-sub-label xl" />
				<col class="col-data" />
				<tbody>
					<tr>
						<th class="col-sub-label x">변환 템플릿</th>
						<td class="col-input">
							<select id="converterTemplate" name="converterTemplate" class="select" style="height: 30px;">
		                		<option value="basic"> 기본 </option>
			                	<option value="building"> 빌딩 </option>
								<option value="extra-big-building"> 초대형 빌딩 </option>
								<option value="single-realistic-mesh"> 단일 Point Cloud </option>
								<option value="splitted-realistic-mesh"> 분할 Point Cloud </option>
							</select>
						</td>
					</tr>
					<tr>
						<th class="col-sub-label x">제목</th>
						<td>
							<div class="inner-data">
								<input type="text" id="title" name="title" class="l" />
							</div>
						</td>
					</tr>
				</tbody>
			</table>
			<div class="button-group">
				<a href="#" onclick="saveConverterJob(); return false;" class="button" style="color: white">저장</a>
			</div>
		</form>
	</div>

<%-- F4D Converter Job 등록 --%>
<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript">
	
	//전체 선택 
	$("#chkAll").click(function() {
		$(":checkbox[name=uploadDataId]").prop("checked", this.checked);
	});
	
	var dialogConverterJob = $( ".dialogConverterJob" ).dialog({
		autoOpen: false,
		height: 280,
		width: 600,
		modal: true,
		resizable: false,
		close: function() {
			$("#converterCheckIds").val("");
			$("#title").val("");
			//location.reload(); 
		}
	});
	
	// F4D Converter Button Click
	function converterFile(uploadDataId, dataName) {
		$("#converterCheckIds").val(uploadDataId + ",");
		$("#title").val(dataName);
		
		dialogConverterJob.dialog( "open" );
	}
	
	// All F4D Converter Button Click
	function converterFiles() {
		var checkedValue = "";
		$("input:checkbox[name=uploadDataId]:checked").each(function(index) {
			checkedValue += $(this).val() + ",";
		});
		if(checkedValue === "") {
			alert("파일을 선택해 주십시오.");
			return;
		}
		$("#converterCheckIds").val(checkedValue);
		
		dialogConverterJob.dialog( "open" );
	}
	
	// F4D Converter 일괄 변환
	var saveConverterJobFlag = true;
	function saveConverterJob() {
		if($("#title").val() === null || $("#title").val() === "") {
			alert("제목을 입력하여 주십시오.");
			$("#title").focus();
			return false;
		}
		
		if(saveConverterJobFlag) {
			saveConverterJobFlag = false;
			var formData =$("#converterJobForm").serialize();
			$.ajax({
				url: "/converter/insert",
				type: "POST",
				data: formData,
				dataType: "json",
				success: function(msg){
					if(msg.statusCode <= 200) {
						alert(JS_MESSAGE["insert"]);	
					} else {
						alert(JS_MESSAGE[msg.errorCode]);
					}
					
					$("#converterCheckIds").val("");
					$("#title").val("");
					$(":checkbox[name=uploadDataId]").prop("checked", false);
					dialogConverterJob.dialog( "close" );
					saveConverterJobFlag = true;
				},
				error:function(request,status,error){
					alert(JS_MESSAGE["ajax.error.message"]);
					dialogConverterJob.dialog( "close" );
					saveConverterJobFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
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
</script>
</body>
</html>
