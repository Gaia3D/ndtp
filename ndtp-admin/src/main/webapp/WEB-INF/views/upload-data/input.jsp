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
    
    <script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
	<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>
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
								<%-- <th class="col-label" scope="row">
									<form:label path="dataKey">데이터 Key</form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-type-select">
									<form:hidden path="duplication_value"/>
									<form:input path="dataKey" cssClass="l" />
			  						<input type="button" id="data_duplication_buttion" value="중복확인" />
			  						<form:errors path="dataKey" cssClass="error" />
								</td> --%>
								<th class="col-label" scope="row">
									<form:label path="dataGroupName">데이터 그룹</form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input">
									<form:hidden path="dataGroupId" />
		 							<form:input path="dataGroupName" cssClass="ml" readonly="true" />
									<input type="button" id="dataGroupButtion" value="데이터 그룹 선택" />
								</td>
							</tr>
							<tr>
								<th class="col-label" scope="row">
			                        <form:label path="sharedType">공유 유형</form:label>
			                        <span class="icon-glyph glyph-emark-dot color-warning"></span>
			                    </th>
			                    <td class="col-input">
			                        <select name="sharedType">
										<option value="common">공통</option>
										<option value="public">공개</option>
										<option value="private">비공개</option>
										<option value="sharing">그룹 공개</option>
									</select>
			                    </td>
			                    <th class="col-label m" scope="row">
									<form:label path="dataType">데이터 타입</form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input">
									<select id="dataType" name="dataType" class="select" style="height: 30px;">
										<option value="citygml" selected="selected"> CITYGML </option>
										<option value="3ds"> 3DS </option>
										<option value="obj"> OBJ </option>
						          		<option value="dae"> DAE(COLLADA) </option>
						          		<option value="ifc"> IFC </option>
						          		<option value="las"> LAS </option>
						          		<option value="indoorgml"> INDOORGML </option>
									</select>
								</td>
							</tr>
							<tr>
								<th class="col-label" scope="row">
								<form:label path="latitude">위도 / 경도</form:label>
								</th>
								<td class="col-input">
									<form:input path="latitude" cssClass="m" />
									<form:input path="longitude" cssClass="m" /> 
									<input type="button" id="mapButtion" value="지도에서 찾기" />
									<form:errors path="latitude" cssClass="error" />
									<form:errors path="longitude" cssClass="error" />
								</td>
								<th class="col-label" scope="row">
									<form:label path="altitude">높이</form:label>
								</th>
								<td class="col-input">
									<form:input path="altitude" cssClass="s" />
									<form:errors path="altitude" cssClass="error" />
								</td>
							</tr>
							<tr>
								<th class="col-label" scope="row">
									<form:label path="description"><spring:message code='description'/></form:label>
								</th>
								<td colspan="3" class="col-input">
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
								<a href="/layer/list" class="button">목록</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
	
		<!-- Dialog -->
	<div id="dataGroupDialog" class="dialog">
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
					<th scope="col" class="col-toggle">공유 유형</th>
					<th scope="col" class="col-toggle">설명</th>
					<th scope="col" class="col-date">등록일</th>
					<th scope="col" class="col-date">선택</th>
				</tr>
			</thead>
			<tbody>
<c:if test="${empty dataGroupList }">
			<tr>
				<td colspan="6" class="col-none">데이터 그룹이 존재하지 않습니다.</td>
			</tr>
</c:if>								
<c:if test="${!empty dataGroupList }">
	<c:set var="paddingLeftValue" value="0" />
	<c:forEach var="dataGroup" items="${dataGroupList}" varStatus="status">
		<c:if test="${dataGroup.depth eq '1' }">
            <c:set var="depthClass" value="oneDepthClass" />
            <c:set var="paddingLeftValue" value="0px" />
        </c:if>
        <c:if test="${dataGroup.depth eq '2' }">
            <c:set var="depthClass" value="twoDepthClass" />
            <c:set var="paddingLeftValue" value="40px" />
        </c:if>
        <c:if test="${dataGroup.depth eq '3' }">
            <c:set var="depthClass" value="threeDepthClass" />
            <c:set var="paddingLeftValue" value="80px" />
        </c:if>
			
			<tr class="${depthClass } ${depthParentClass} ${ancestorClass }" style="${depthStyleDisplay}">
				<td class="col-name" style="text-align: left;" nowrap="nowrap">
					<span style="padding-left: ${paddingLeftValue}; font-size: 1.6em;"></span> 
					${dataGroup.dataGroupName }
				</td>
				<td class="col-type">
        <c:if test="${dataGroup.available eq 'true' }">
                	사용
        </c:if>
        <c:if test="${dataGroup.available eq 'false' }">
        			미사용
        </c:if>
			    </td>
			    <td class="col-key">${dataGroup.sharedType }</td>
			    <td class="col-key">${dataGroup.description }</td>
			    <td class="col-date">
			    	<fmt:parseDate value="${dataGroup.insertDate}" var="viewInsertDate" pattern="yyyy-MM-dd HH:mm:ss"/>
					<fmt:formatDate value="${viewInsertDate}" pattern="yyyy-MM-dd HH:mm"/>
			    </td>
			    <td class="col-toggle">
			    	<a href="#" onclick="confirmDataGroup('${dataGroup.dataGroupId}', '${dataGroup.dataGroupName}'); return false;">확인</a></td>
			</tr>	
	</c:forEach>
</c:if>
			</tbody>
		</table>
	</div>
	
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		
	});
	
	var dataGroupDialog = $( ".dialog" ).dialog({
		autoOpen: false,
		height: 600,
		width: 1200,
		modal: true,
		overflow : "auto",
		resizable: false
	});
	
	// 상위 Layer Group 찾기
	$( "#dataGroupButtion" ).on( "click", function() {
		dataGroupDialog.dialog( "open" );
		dataGroupDialog.dialog( "option", "title", "데이터 그룹 선택");
	});
	
	// 데이터 그룹 선택
	function confirmDataGroup(dataGroupId, dataGroupName) {
		$("#dataGroupId").val(dataGroupId);
		$("#dataGroupName").val(dataGroupName);
		dataGroupDialog.dialog( "close" );
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
	
	// 지도에서 찾기
	$( "#mapButtion" ).on( "click", function() {
		var url = "/data/location-map";
		var width = 800;
		var height = 700;

        var popWin = window.open(url, "","toolbar=no ,width=" + width + " ,height=" + height
                + ", directories=no,status=yes,scrollbars=no,menubar=no,location=no");
        //popWin.document.title = layerName;
	});
	
	// 업로딩 파일 개수
    var uploadFileCount = 0;
    // dropzone 업로딩 결과(n개 파일을 올리면 n개 리턴이 옴)
    var uploadFileResultCount = 0;
    Dropzone.options.myDropzone = {
		url: "/upload-data/insert",	
		//paramName: "file",
		// Prevents Dropzone from uploading dropped files immediately
		timeout: 3600000,
        autoProcessQueue: false,
        // 여러개의 파일 허용
		uploadMultiple: true,
		method: "post",
		// 병렬 처리
		parallelUploads: 100,
		// 최대 파일 업로드 갯수
		maxFiles: 100,
		// 최대 업로드 용량 Mb단위
		maxFilesize: 2000,
		dictDefaultMessage: "업로딩 하려면 파일을 올리거나 클릭 하십시오.",
		/* headers: {
			"x-csrf-token": document.querySelectorAll("meta[name=csrf-token]")[0].getAttributeNode("content").value,
		}, */
		// 허용 확장자
		acceptedFiles: ".3ds, .obj, .dae, .collada, .ifc, .citygml, .indoorgml, .jpg, .jpeg, .gif, .png, .bmp, .zip",
		// 업로드 취소 및 추가 삭제 미리 보기 그림 링크 를 기본 추가 하지 않음
		// 기본 true false 로 주면 아무 동작 못함
		//clickable: true,
		fallback: function() {
	    	// 지원하지 않는 브라우저인 경우
	    	alert("죄송합니다. 최신의 브라우저로 Update 후 사용해 주십시오.");
	    	return;
	    },
		init: function() {
			var magoDropzone = this; // closure
			var uploadTask = document.querySelector("#allFileUpload");
			var clearTask = document.querySelector("#allFileClear");
			
			uploadTask.addEventListener("click", function(e) {
				if (checkData() === false) {
					return;
				}
				
				uploadFileCount = 0;
                uploadFileResultCount = 0;
                e.preventDefault();
                e.stopPropagation();
				
                if (myDropzone.getQueuedFiles().length > 0) {
                    uploadFileCount = myDropzone.getQueuedFiles().length;
                    myDropzone.processQueue();
                    //startSpinner("fileUploadSpinner");
                    fileUploadDialog.dialog( "open" );
                } else {
                    alert("업로딩 할 파일이 존재하지 않습니다.");
                    return;
                }
			});

			clearTask.addEventListener("click", function () {
                // Using "_this" here, because "this" doesn't point to the dropzone anymore
                if (confirm("정말 전체 항목을 삭제하겠습니까?")) {
                	// true 주면 업로드 중인 파일도 다 같이 삭제
                	magoDropzone.removeAllFiles(true);
                }
            });
			
			this.on("sending", function(file, xhr, formData) {
				formData.append("sharing_type", $("#sharing_type").val());
				formData.append("data_type", $("#data_type").val());
				formData.append("project_id", $("#project_id").val());
				formData.append("data_name", $("#data_name").val());
				formData.append("latitude", $("#latitude").val());
				formData.append("longitude", $("#longitude").val());
				formData.append("height", $("#height").val());
				formData.append("description", $("#description").val());
				
				formData.append("layerName", $("#layerName").val());
                formData.append("viewType", $("#viewType").val());
                formData.append("coordinate", $("#coordinate").val());
                formData.append("geometryType", $("#geometryType").val());
                formData.append("managementDept", $("#managementDept").val());
                formData.append("managementUserId", $("#managementUserId").val());
                formData.append("managementSubUserId", $("#managementSubUserId").val());
                formData.append("description", $("#description").val());
                formData.append("shapeEncoding", $("#shapeEncoding").val());
                formData.append("useYn", $(':radio[name="useYn"]:checked').val());
                formData.append("blockDefaultYn", $(':radio[name="blockDefaultYn"]:checked').val());
                formData.append("facilityDefaultYn", $(':radio[name="facilityDefaultYn"]:checked').val());
                formData.append("mobileDefaultYn", $(':radio[name="mobileDefaultYn"]:checked').val());
                formData.append("labelDisplayYn", $(':radio[name="labelDisplayYn"]:checked').val());
                var zIndex = 0;
                if($("#zIndex").val() !== null && $("#zIndex").val() !== "") zIndex = $("#zIndex").val();
                formData.append("zIndex", zIndex);
                formData.append("comment", $("#comment").val());
			});
			
			// maxFiles 카운터를 초과하면 경고창
			this.on("maxfilesexceeded", function (data) {
				alert("최대 업로드 파일 수는 100개 입니다.");
				return;
			});
			
			this.on("success", function(file, response) {
                if(file !== undefined && file.name !== undefined) {
                    console.log("file name = " + file.name);
                    $("#fileUploadSpinner").empty();
                    fileUploadDialog.dialog( "close" );

                    if(response.error === undefined) {
                        if(uploadFileCount === 0) {
                            alert("수정 하였습니다.");
                        } else {
                            uploadFileResultCount ++;
                            if(uploadFileCount === uploadFileResultCount) {
                                alert("업로딩을 완료 하였습니다.");
                                reloadLayerFileInfoList();
                            }
                        }
                    } else {
                        alertMessage(response);
                    }
                } else {
                    console.log("------- success response = " + response);
                    if(response === 200) {
                        alert("수정하였습니다.");
                    } else {
                        alert("수정에 실패 하였습니다. \n" + response);
                    }
                }
            });
		}
	};
</script>
</body>
</html>