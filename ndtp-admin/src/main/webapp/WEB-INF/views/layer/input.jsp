<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>Layer 등록 | NDTP</title>
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
	<link rel="stylesheet" href="/externlib/normalize/normalize.min.css" />
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css" />
	<link rel="stylesheet" href="/externlib/dropzone/dropzone.min.css">
    <link rel="stylesheet" href="/css/${lang}/style.css" />
    <script type="text/javascript" src="/externlib/dropzone/dropzone.min.js"></script>
    <style type="text/css">
        .dropzone .dz-preview.lp-preview {
            width: 150px;
        }
        .dropzone.hzScroll {
            min-width: 700px;
            overflow: auto;
            white-space: nowrap;
            border: 1px solid #e5e5e5;
        }
        
        .loader-txt p {
            font-size: 13px;
            color: #666;
        }
    
        .loader-txt p small {
            font-size: 11.5px;
            color: #999;
        }
        
        .loader {
            position: relative;
            text-align: center;
            margin: 15px auto 35px auto;
            z-index: 9999;
            display: block;
            width: 80px;
            height: 80px;
            border: 10px solid rgba(0, 0, 0, 0.3);
            border-radius: 50%;
            border-top-color: #000;
            animation: spin 1s ease-in-out infinite;
            -webkit-animation: spin 1s ease-in-out infinite;
        }
    
        @keyframes spin {
            to {
                -webkit-transform: rotate(360deg);
            }
        }
    
        @-webkit-keyframes spin {
            to {
                -webkit-transform: rotate(360deg);
            }
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
						<form:form id="layer" modelAttribute="layer" method="post" onsubmit="return false;">
						<table class="input-table scope-row">
							<colgroup>
			                    <col class="col-label l" style="width: 15%" >
			                    <col class="col-input" style="width: 35%" >
			                    <col class="col-label l" style="width: 15%" >
			                    <col class="col-input" style="width: 35%" >
			                </colgroup>
			                <tr>
								<th class="col-label" scope="row">
									<form:label path="layerGroupName">Layer 그룹명</form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input">
									<form:hidden path="layerGroupId" />
									<form:input path="parentName" cssClass="ml" readonly="true" />
									<input type="button" id="layerGroupButtion" value="Layer 그룹 찾기" />
								</td>
								<th class="col-label" scope="row">
			                        <label for="sharing">공유 유형</label>
			                    </th>
			                    <td class="col-input radio-set">
			                        <form:radiobutton id="sharingPublic"  path="sharing" value="public" label="공개" />
									<form:radiobutton id="sharingPrivate" path="sharing" value="private" label="비공개" />
									<form:radiobutton id="sharingGroup" path="sharing" value="group" label="그룹" />
			                    </td>
							</tr>
							<tr>
			                    <th class="col-label" scope="row">
			                        <form:label path="layerName">Layer 명</form:label>
			                        <span class="icon-glyph glyph-emark-dot color-warning"></span>
			                    </th>
			                    <td class="col-input">
			                        <form:input path="layerName" cssClass="ml" />
			                        <form:errors path="layerName" cssClass="error" />
			                    </td>
			                    <th class="col-label" scope="row">
			                        <form:label path="layerKey">Layer Key</form:label>
			                        <span class="icon-glyph glyph-emark-dot color-warning"></span>
			                    </th>
			                    <td class="col-input">
			                        <form:input path="layerKey" cssClass="ml" />
			                        <form:errors path="layerKey" cssClass="error" />
			                    </td>
			                </tr>
			                <tr>
			                    <th class="col-label" scope="row">
			                        <form:label path="serviceType">서비스 타입</form:label>
			                        <span class="icon-glyph glyph-emark-dot color-warning"></span>
			                    </th>
			                    <td class="col-input">
			                        <select name="serviceType">
										<option value="">선택</option>
										<option value="wms">WMS</option>
										<option value="wfs">WFS</option>
										<option value="wcs">WCS</option>
										<option value="wps">WPS</option>
									</select>
			                    </td>
			                    <th class="col-label" scope="row">
			                        <form:label path="layerType">Layer 타입</form:label>
			                        <span class="icon-glyph glyph-emark-dot color-warning"></span>
			                    </th>
			                    <td class="col-input">
			                        <select name="layerType">
										<option value="">선택</option>
										<option value="Vector">Vector</option>
										<option value="Raster">Raster</option>
									</select>
			                    </td>
			                </tr>
			                <tr>
			                    <th class="col-label" scope="row">
			                        <form:label path="geometryType">도형 타입</form:label>
			                        <span class="icon-glyph glyph-emark-dot color-warning"></span>
			                    </th>
								<td class="col-input">
									<select name="geometryType" class="forRaster">
										<option value="">선택</option>
										<option value="Point">Point</option>
										<option value="Line">Line</option>
										<option value="Polygon">Polygon</option>
									</select>
								</td>
			                    <th class="col-label" scope="row">
			                        <form:label path="geometryType">외곽선 색상</form:label>
			                        <span class="icon-glyph glyph-emark-dot color-warning"></span>
			                    </th>
								<td class="col-input">
									<input id="lineColorValue" placeholder="RGB" class="forRaster" />
									<input type="color" id="layerLineColor" name="layerLineColor" class="picker" alt="외곽선 색상" />
								</td>
							</tr>
							<tr>	
								<th class="col-label" scope="row">
			                        <form:label path="layerLineStyle">외곽선 두께</form:label>
			                    </th>
								<td class="col-input">
									<input type="number" id="layerLineStyle"  name="layerLineStyle" class="forRaster" alt="외곽선 두께" min="0.1" max="5.0" size="3" step="0.1">
								</td>
								<th class="col-label" scope="row">
			                        <form:label path="layerFillColor">채우기 색상</form:label>
			                        <span class="icon-glyph glyph-emark-dot color-warning"></span>
			                    </th>
								<td class="col-input">
									<input id="fillColorValue" placeholder="RGB" class="forRaster forPolygon">
									<input type="color" id="layerFillColor" name="layerFillColor" class="picker forPolygon" alt="채우기 색상">
								</td>
							</tr>
			                
			                <tr>
			                	<th class="col-label" scope="row">
			                        <form:label path="layerAlphaStyle">투명도</form:label>
			                        <span class="icon-glyph glyph-emark-dot color-warning"></span>
			                    </th>
								<td class="col-input">
									<input type="text" id="sliderValue" name="layerAlphaStyle" class="slider" alt="투명도">
									<input type="range" id="sliderRange" min="0" max="100" value="100" alt="투명도">
								</td>
			                    <th class="col-label" scope="row">
			                        <label for="zIndex">표시 순서(Z-Index)</label>
			                    </th>
			                    <td class="col-input">
			                        <form:input path="zIndex" cssClass="s" />
			                        <form:errors path="zIndex" cssClass="error" />
			                    </td>
			                </tr>
			                <tr>
			                    <th class="col-label" scope="row">
			                        <label for="defaultDisplayTrue">기본 표시</label>
			                        <span class="icon-glyph glyph-emark-dot color-warning"></span>
			                    </th>
			                    <td class="col-input radio-set">
			                        <form:radiobutton id="defaultDisplayTrue"  path="defaultDisplay" value="true" label="사용" />
									<form:radiobutton id="defaultDisplayFlase" path="defaultDisplay" value="false" label="미사용" />
			                    </td>
			                    <th class="col-label" scope="row">
			                        <label for="useY">사용유무</label>
			                        <span class="icon-glyph glyph-emark-dot color-warning"></span>
			                    </th>
			                    <td class="col-input radio-set">
			                        <form:radiobutton id="availableTrue"  path="available" value="true" label="사용" />
									<form:radiobutton id="availableFalse" path="available" value="false" label="미사용" />
			                    </td>
			                </tr>
			                <tr>
			                    <th class="col-label" scope="row">
			                        <label for="labelDisplayTrue">Label 표시 유무</label>
			                    </th>
			                    <td class="col-input radio-set">
			                        <form:radiobutton id="labelDisplayTrue"  path="labelDisplay" value="true" label="표시" />
									<form:radiobutton id="labelDisplayFalse" path="labelDisplay" value="false" label="비표시" />
			                    </td>
			                    <th class="col-label" scope="row">
			                        <form:label path="coordinate">좌표계</form:label>
			                    </th>
			                    <td class="col-input">
			                        <form:input path="coordinate" cssClass="m" />
			                        <form:errors path="coordinate" cssClass="error" />
			                    </td>
			                </tr>
			                <tr>
			                    <th class="col-label" scope="row">
			                        <form:label path="description">설명</form:label>
			                    </th>
			                    <td class="col-input">
			                        <form:input path="description" cssClass="l" />
			                        <form:errors path="description" cssClass="error" />
			                    </td>
			                    <th class="col-label" scope="row">
			                        <form:label path="shapeEncoding">SHP 파일 인코딩</form:label>
			                    </th>
			                    <td class="col-input">
			                    	<select id="shapeEncoding" name="shapeEncoding" style="width:100px; height: 30px;">
				                    	<option value="CP949">CP949</option>
				                        <option value="UTF-8">UTF-8</option>
				                    </select>
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
								<input type="submit" id="allFileUpload" value="<spring:message code='save'/>"/>
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
	<%@ include file="/WEB-INF/views/layer/spinner-dialog.jsp" %>
	
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
		showRange(100);
		changeLayerType(null);
		changeGeometryType(null);
		
		$("input[name='sharing']").filter("[value='public']").prop("checked", true);
		$("input[name='defaultDisplay']").filter("[value='true']").prop("checked", true);
		$("input[name='available']").filter("[value='true']").prop("checked", true);
        $("input[name='labelDisplay']").filter("[value='true']").prop("checked", true);
	});
	
	$('[name=layerType]').on('change', function() {
		changeLayerType($("[name=layerType]").val());
	});
	
	$('[name=geometryType]').on('change', function() {
		changeGeometryType($("[name=geometryType]").val());
	});
	
	// 레이어 타입 Raster 선택 시 입력폼 변경
	function changeLayerType(layerType) {
		if(layerType == 'Vector') {
			$('.forRaster').attr('disabled', false);
			$('.forRaster').removeClass('disabled');
			$('.picker').attr('disabled', false);
			changeGeometryType(null);
			$('#layerLineStyle').val(Number(1.0));
		} else {
			$('.forRaster').attr('disabled', true);
			$('.forRaster').addClass('disabled');
			$('.picker').attr('disabled', true);
			$('.forRaster').val('');
			$('.picker').val(null);
		}
	}

	// 도형 타입 Polygon 선택시 선택폼 변경
	function changeGeometryType(geometryType) {
		if(geometryType == 'Polygon') {
			$('.forPolygon').attr('disabled', false);
			$('.forPolygon').removeClass("disabled");
			$('.picker.forPolygon').attr('disabled', false);
		} else {
			$('.forPolygon').attr('disabled', true);
			$('.forPolygon').addClass("disabled");
			$('.picker.forPolygon').attr('disabled', true);
			$('.forPolygon').val(null);
		}
	}
	
	// 슬라이더
	function showRange(valus) {
		$('#sliderValue').val(valus + "%");
	}

	var rangeSlider = function(){
		var range = $('#sliderRange');
		
		range.on('change', function(){		
			showRange(this.value);
		});
	};
	rangeSlider();

	// color picker
	function pickerColor() {
		var layerFillColor = $('#layerFillColor');
		var layerLineColor = $('#layerLineColor');
		var fillColorValue = $('#fillColorValue');
		var lineColorValue = $('#lineColorValue');
		
		layerFillColor.on('change', function(){		
			$('#fillColorValue').val($(this).val().toUpperCase());
		});

		layerLineColor.on('change', function(){		
			$('#lineColorValue').val($(this).val().toUpperCase());
		});

		fillColorValue.on('change', function(){		
			$('#layerFillColor').val($(this).val().toUpperCase());
		});

		lineColorValue.on('change', function(){		
			$('#layerLineColor').val($(this).val().toUpperCase());
		});
	}
	pickerColor();
	
	var layerGroupDialog = $( ".dialog" ).dialog({
		autoOpen: false,
		height: 600,
		width: 1200,
		modal: true,
		overflow : "auto",
		resizable: false
	});
	
	// Layer Group 찾기
	$( "#layerGroupButtion" ).on( "click", function() {
		layerGroupDialog.dialog( "open" );
		layerGroupDialog.dialog( "option", "title", "Layer 그룹 선택");
	});
	
	// 상위 Node
	function confirmParent(parent, parentName) {
		$("#layerGroupId").val(parent);
		$("#parentName").val(parentName);
		layerGroupDialog.dialog( "close" );
	}
	
	$( "#rootParentSelect" ).on( "click", function() {
		$("#layerGroupId").val(0);
		$("#parentName").val("${layerGroup.parentName}");
		layerGroupDialog.dialog( "close" );
	});
	
	function check() {
		if ($("#layerName").val() == "") {
			alert("Layer 명을 입력하여 주십시오.");
			$("#layerName").focus();
			return false;
		}
	}
	
	var fileUploadDialog = $( ".spinner-dialog" ).dialog({
		autoOpen: false,
		width: 250,
		height: 290,
		modal: true,
		resizable: false
	});

    // 업로딩 파일 개수
    var uploadFileCount = 0;
    // dropzone 업로딩 결과(n개 파일을 올리면 n개 리턴이 옴)
    var uploadFileResultCount = 0;
    Dropzone.options.myDropzone = {
        url: "/layer/insert",
        //paramName: "file",
        // Prevents Dropzone from uploading dropped files immediately
        timeout: 3600000,
        autoProcessQueue: false,
        // 여러개의 파일 허용
        uploadMultiple: true,
        method: "post",
        // 병렬 처리
        parallelUploads: 10,
        // 최대 파일 업로드 갯수
        maxFiles: 10,
        // 최대 업로드 용량 Mb단위
        maxFilesize: 2000,
        dictDefaultMessage: "업로딩 하려면 Shape 파일을 올리거나 클릭 하십시오.",
        /* headers: {
            "x-csrf-token": document.querySelectorAll("meta[name=csrf-token]")[0].getAttributeNode("content").value,
        }, */
        // 허용 확장자
        acceptedFiles: ".cpg, .dbf, .idx, .sbn, .sbx, .shp, .shx, .prj, .qpj, .zip",
        // 업로드 취소 및 추가 삭제 미리 보기 그림 링크를 기본 추가 하지 않음
        // 기본 true false 로 주면 아무 동작 못함
        //clickable: true,
        fallback: function() {
            // 지원하지 않는 브라우저인 경우
            alert("죄송합니다. 최신의 브라우저로 Update 후 사용해 주십시오.");
            return;
        },
        init: function() {
            var myDropzone = this; // closure
            var uploadTask = document.querySelector("#allFileUpload");
            var clearTask = document.querySelector("#allFileClear");

            uploadTask.addEventListener("click", function(e) {
                if (check() === false) {
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
                    //send empty
                    //myDropzone.uploadFiles([{ name: 'nofiles', upload: { filename: 'nofiles' } }]);
                    myDropzone._uploadData([{ upload: { filename: '' } }], [{ filename: '', name: '', data: new Blob() }]);
                }
            });

            clearTask.addEventListener("click", function () {
                // Using "_this" here, because "this" doesn't point to the dropzone anymore
                if (confirm("정말 전체 항목을 삭제하겠습니까?")) {
                    // true 주면 업로드 중인 파일도 다 같이 삭제
                    myDropzone.removeAllFiles(true);
                }
            });

            this.on("sending", function(file, xhr, formData) {
                formData.append("layerGroupId", $("#layerGroupId").val());
                formData.append("sharing", $(':radio[name="sharing"]:checked').val());
                formData.append("layerName", $("#layerName").val());
                formData.append("layerKey", $("#layerKey").val());
                formData.append("serviceType", $("select[name=serviceType]").val());
                formData.append("layerType", $("select[name=layerType]").val());
                formData.append("geometryType", $("select[name=geometryType]").val());
                formData.append("layerLineColor", $("#layerLineColor").val());
                formData.append("layerLineStyle", $("#layerLineStyle").val());
                formData.append("layerFillColor", $("#layerFillColor").val());
                formData.append("layerAlphaStyle", $("#sliderRange").val());
                formData.append("layerFillColor", $("#layerFillColor").val());
                formData.append("defaultDisplay", $(':radio[name="defaultDisplay"]:checked').val());
                formData.append("available", $(':radio[name="available"]:checked').val());
                formData.append("labelDisplay", $(':radio[name="labelDisplay"]:checked').val());
                formData.append("coordinate", $("#coordinate").val());
                formData.append("description", $("#description").val());
                formData.append("shapeEncoding", $("#shapeEncoding").val());
                var zIndex = 0;
                if($("#zIndex").val() !== null && $("#zIndex").val() !== "") zIndex = $("#zIndex").val();
                formData.append("zIndex", zIndex);
            });

            // maxFiles 카운터를 초과하면 경고창
            this.on("maxfilesexceeded", function (data) {
                alert("최대 업로드 파일 수는 10개 입니다.");
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

            // 무한 루프 빠지네....
            /* this.on("error", function(response) {
                alert("파일 업로딩 중 오류가 발생하였습니다. 로그를 확인해 주십시오.");
            }); */
        }
    };
	
</script>
</body>
</html>