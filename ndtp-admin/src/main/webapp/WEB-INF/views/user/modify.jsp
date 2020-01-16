<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>사용자 수정 | NDTP</title>
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
	<link rel="stylesheet" href="/externlib/normalize/normalize.min.css" />
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css" />
	<link rel="stylesheet" href="/externlib/dropzone/dropzone.min.css">
    <link rel="stylesheet" href="/css/${lang}/style.css" />
    <script type="text/javascript" src="../externlib/handlebars-4.1.2/handlebars.js"></script>
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
						<form:form id="userInfo" modelAttribute="userInfo" method="post" onsubmit="return false;">
						<table class="input-table scope-row">
							<colgroup>
			                    <col class="col-label l" style="width: 15%" >
			                    <col class="col-input" style="width: 35%" >
			                    <col class="col-label l" style="width: 15%" >
			                    <col class="col-input" style="width: 35%" >
			                </colgroup>
			                <tr>
								<th class="col-label" scope="row">
									<form:label path="userId"><spring:message code='user.id'/></form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input">
									<form:input path="userId" cssClass="ml" readonly="true" />
								</td>
							</tr>
			                <tr>
								<th class="col-label" scope="row">
									<form:label path="userGroupName"><spring:message code='user.group.usergroup'/></form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input">
									<form:hidden path="userGroupId" />
									<form:input path="userGroupName" cssClass="ml" readonly="true" />
									<input type="button" id="userGroupButton" value="사용자 그룹 선택" />
								</td>
							</tr>
							<tr>
								<th class="col-label" scope="row">
			                        <label for="userName"><spring:message code='name'/></label>
			                    </th>
			                    <td class="col-input">
									<form:input path="userName" cssClass="ml"/>
								</td>
			                    <%-- <td class="col-input radio-set">
			                        <form:radiobutton id="sharingPublic"  path="sharing" value="public" label="공개" />
									<form:radiobutton id="sharingPrivate" path="sharing" value="private" label="비공개" />
									<form:radiobutton id="sharingGroup" path="sharing" value="group" label="그룹" />
			                    </td> --%>
							</tr>
							<%-- <tr>
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
									<input id="lineColorValue" placeholder="RGB" class="forRaster forLineColor" />
									<input type="color" id="layerLineColor" name="layerLineColor" class="picker forLineColor" alt="외곽선 색상" />
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
			                </tr> --%>
						</table>
						<div class="button-group">
							<div class="center-buttons">
								<input type="submit" value="<spring:message code='save'/>" onclick="update();"/>
								<a href="/user/detail?userId=1" class="button">목록</a>
							</div>
						</div>
						</form:form>
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
<script type="text/javascript" src="/js/navigation.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
	});

	var userGroupDialog = $( "#userGroupListdialog" ).dialog({
		autoOpen: false,
		height: 600,
		width: 1200,
		modal: true,
		overflow : "auto",
		resizable: false
	});

	// 사용자 그룹 선택
	$("#userGroupButton").on("click", function() {
		userGroupDialog.dialog("open");
		userGroupDialog.dialog("option", "title", "사용자 그룹 선택");
	});

	// 상위 Node
	function confirmParent(parent, parentName) {
		$("#userGroupId").val(parent);
		$("#userGroupName").val(parentName);
		userGroupDialog.dialog( "close" );
	}

	function check() {
		var number = /^[0-9]+$/;

		if(!$("#userGroupId").val() || !number.test($("#userGroupId").val())) {
			alert("사용자 그룹을 선택해 주세요.");
			$("#layerGroupName").focus();
			return false;
		}
		if (!$("#userName").val()) {
			alert("사용자 명을 입력하여 주십시오.");
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

	function alertMessage(response) {
		if(uploadFileResultCount === 0) {
			if(response.result === "upload.file.type.invalid") {
				alert("복수의 파일을 업로딩 할 경우 zip 파일은 사용할 수 없습니다.");
			} else if(response.result === "layer.name.empty") {
				alert("Layer 명이 유효하지 않습니다.");
			} else if("db.exception") {
				alert("죄송 합니다. 서버 실행중에 오류가 발생 하였습니다. \n 로그를 확인하여 주십시오.");
			}
			uploadFileResultCount++;
		}
		return;
	}

    // 업로딩 파일 개수
    var uploadFileCount = 0;
    // dropzone 업로딩 결과(n개 파일을 올리면 n개 리턴이 옴)
    var uploadFileResultCount = 0;
    Dropzone.options.myDropzone = {
   		url: "/layer/update/${layer.layerId}",
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
                formData.append("layerFillColor", $("#layerFillColor").val());
                formData.append("layerAlphaStyle", $("#sliderRange").val() / 100);
                formData.append("defaultDisplay", $(':radio[name="defaultDisplay"]:checked').val());
                formData.append("available", $(':radio[name="available"]:checked').val());
                formData.append("labelDisplay", $(':radio[name="labelDisplay"]:checked').val());
                formData.append("coordinate", $("#coordinate").val());
                formData.append("description", $("#description").val());
                formData.append("shapeEncoding", $("#shapeEncoding").val());
                var zIndex = 0;
                if($("#zIndex").val()) zIndex = $("#zIndex").val();
                formData.append("zIndex", zIndex);
                var layerLineStyle = 0;
                if($("#layerLineStyle").val()) layerLineStyle = $("#layerLineStyle").val();
                formData.append("layerLineStyle", layerLineStyle);
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
					if(response.statusCode === 200) {
						alert("수정하였습니다.");
					} else {
						alert("수정에 실패 하였습니다. \n" + response.message);
					}
				}
			});

            // 무한 루프 빠지네....
            /* this.on("error", function(response) {
                alert("파일 업로딩 중 오류가 발생하였습니다. 로그를 확인해 주십시오.");
            }); */
        }
    };

    var reloadLayerFileInfoListCount = 0;
	function reloadLayerFileInfoList() {
    	console.log("reloadLayerFileInfoListCount = " + reloadLayerFileInfoListCount);
    	$.ajax({
            url: "/layer/${layer.layerId}/layer-fileinfos",
            type: "GET",
            headers: {"X-Requested-With": "XMLHttpRequest"},
            dataType: "json",
            success: function(msg){
           		var source = $("#templateLayerFileInfoList").html();
				//핸들바 템플릿 컴파일
				var template = Handlebars.compile(source);

				// if helper
				Handlebars.registerHelper('if', function(conditional, options) {
					if(conditional === 'Y') {
						return options.fn(this);
					} else {
						return options.inverse(this);
					}
				});

				// 빼기 helper
				Handlebars.registerHelper("subtract", function(value1, value2) {
					return value1 - value2;
				});

				//핸들바 템플릿에 데이터를 바인딩해서 HTML 생성
				var reloadData = { layerFileInfoList: msg.layerFileInfoList };
				var layerFileInfoListHtml = template(reloadData);
				$("#layerFileInfoListArea").html("");
				$("#layerFileInfoListArea").append(layerFileInfoListHtml);

                reloadLayerFileInfoListCount++;
            },
            error: function(request, status, error) {
            	alert(" code : " + request.status + "\n" + ", message : " + request.responseText + "\n" + ", error : " + error);
            }
        });
    }

	// 비활성화 상태의 layer를 활성화 함
	function changeStatus(layerId, layerFileInfoGroupId, layerFileInfoId) {
		var info = "layerFileInfoGroupId=" + layerFileInfoGroupId;
		if(confirm("이 파일을 layer Shape 파일로 사용하시겠습니까?")) {
            $.ajax({
                url: "/layer/${layer.layerId}/layer-file-infos/" + layerFileInfoId,
				type: "POST",
				headers: {"X-Requested-With": "XMLHttpRequest"},
				data: info,
                dataType: "json",
                success: function(msg){
					reloadLayerFileInfoList();
					alert("적용 되었습니다.");
                },
                error: function(request, status, error) {
                	alert(" code : " + request.status + "\n" + ", message : " + request.responseText + "\n" + ", error : " + error);
                }
            });
        }
    }

    var fileInfoDetailDialog = $( "#fileInfoDetailDialog" ).dialog({
		autoOpen: false,
		width: 600,
		height: 310,
		modal: true,
		resizable: false
	});

 	// 상세 정보 보기
    function viewFileDetail(layerFileInfoId) {
    	fileInfoDetailDialog.dialog("open");

        $.ajax({
        	url: "/layer/file-info/" + layerFileInfoId,
        	type: "GET",
        	headers: {"X-Requested-With": "XMLHttpRequest"},
        	dataType: "json",
        	success: function(msg) {
        		var source = $("#templateFileInfoDetail").html();
				//핸들바 템플릿 컴파일
				var template = Handlebars.compile(source);

				// 빼기 helper
				Handlebars.registerHelper("multiply", function(value1, value2) {
					return value1 * value2;
				});
				Handlebars.registerHelper('ifEquals', function(arg1, arg2) {
				    return (arg1 === arg2) ? "" : arg1;
				});

				//핸들바 템플릿에 데이터를 바인딩해서 HTML 생성
				var fileInfoDetailHtml = template(msg.layerFileInfo);
				$("#fileInfoDetailDialog").html("");
				$("#fileInfoDetailDialog").append(fileInfoDetailHtml);
        	},
            error: function(request, status, error) {
            	alert(" code : " + request.status + "\n" + ", message : " + request.responseText + "\n" + ", error : " + error);
            }
        });
    }

 	// 지도 보기
    function viewLayerMap(layerId, layerName, layerFileInfoId) {
    	var url = "/layer/" + layerId + "/map?layerFileInfoId=" + layerFileInfoId;
		var width = 1000;
		var height = 700;

		var popWin = window.open(url, "","toolbar=no ,width=" + width + " ,height=" + height
				+ ", directories=no,status=yes,scrollbars=no,menubar=no,location=no");
		popWin.document.title = layerName;
    }

	// 저장
	var updateUserFlag = true;
	function update() {
		if (check() == false) {
			return false;
		}
		if(updateUserFlag) {
			updateUserFlag = false;
			var formData = $("#userInfo").serialize();
			$.ajax({
				url: "/user/update",
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
					updateUserFlag = true;
				},
				error:function(request, status, error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updateUserFlag = true;
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