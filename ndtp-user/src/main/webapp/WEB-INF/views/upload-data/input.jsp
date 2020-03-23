<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>업로딩 데이터 | NDTP</title>
	<link rel="shortcut icon" href="/images/favicon.ico?cacheVersion=${contentCacheVersion}">
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/css/${lang}/user-style.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/css/${lang}/style.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/css/fontawesome-free-5.2.0-web/css/all.min.css?cacheVersion=${contentCacheVersion}">
	<link rel="stylesheet" href="/externlib/dropzone/dropzone.min.css?cacheVersion=${contentCacheVersion}">
	<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js?cacheVersion=${contentCacheVersion}"></script>
	<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js?cacheVersion=${contentCacheVersion}"></script>
	<script type="text/javascript" src="/externlib/dropzone/dropzone.min.js?cacheVersion=${contentCacheVersion}"></script>
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

<div id="wrap">
	<!-- S: NAVWRAP -->
	<div class="navWrap">
	 	<%@ include file="/WEB-INF/views/layouts/menu.jsp" %> 
	</div>
	<!-- E: NAVWRAP -->
	
	<div class="container" style="float:left; width: calc(100% - 78px);">
		<div style="padding: 20px 20px 0px 10px; font-size: 18px;">3D 업로딩 데이터 자동 변환</div>
		<div class="tabs" >
			<ul class="tab">
				<li id="tabDataGroupList"><a href="/data-group/list">데이터 그룹</a></li>
				<li id="tabDataGroupInput"><a href="/data-group/input">데이터 그룹 등록</a></li>
				<li id="tabUploadDataInput"><a href="/upload-data/input">업로딩 데이터</a></li>
			   	<li id="tabUploadDataList"><a href="/upload-data/list">업로딩 데이터 목록</a></li>
			  	<li id="tabConverterList"><a href="/converter/list">업로딩 데이터 변환 목록</a></li>
			  	<li id="tabDataList"><a href="/data/list">데이터 목록</a></li>
			  	<li id="tabDataLogList"><a href="/data-log/list">데이터 변경 이력</a></li>
			</ul>
		</div>
		<form:form id="uploadData" modelAttribute="uploadData" method="post" onsubmit="return false;">
		<table class="input-table scope-row">
			<colgroup>
				<col class="col-label l" style="width: 13%" >
				<col class="col-input" style="width: 37%" >
				<col class="col-label l" style="width: 13%" >
				<col class="col-input" style="width: 37%" >
            </colgroup>
			<tr>
				<th class="col-label" scope="row">
					<form:label path="dataName">데이터명</form:label>
					<span class="icon-glyph glyph-emark-dot color-warning"></span>
				</th>
				<td class="col-input">
					<form:input path="dataName" class="l" maxlength="255" />
 					<form:errors path="dataName" cssClass="error" />
				</td>
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
                	<form:label path="sharing">공유 유형</form:label>
					<span class="icon-glyph glyph-emark-dot color-warning"></span>
				</th>
				<td class="col-input">
					<select id="sharing" name="sharing" class="selectBoxClass">
						<option value="public">공개</option>
						<option value="common">공통</option>
						<option value="private">비공개</option>
						<option value="group">그룹 공개</option>
					</select>
				</td>
				<th class="col-label m" scope="row">
					<form:label path="dataType">데이터 타입</form:label>
					<span class="icon-glyph glyph-emark-dot color-warning"></span>
				</th>
				<td class="col-input">
					<select id="dataType" name="dataType" class="selectBoxClass">
						<option value="citygml" selected="selected"> CITYGML </option>
						<option value="indoorgml"> INDOORGML </option>
						<option value="ifc"> IFC </option>
						<option value="las"> LAS(POINT CLOUD) </option>
						<option value="3ds"> 3DS </option>
						<option value="obj"> OBJ </option>
		          		<option value="dae"> COLLADA(DAE) </option>
					</select>
				</td>
			</tr>
			<tr>
				<th class="col-label" scope="row">
					<form:label path="longitude">대표 위치 (경도/위도/높이) </form:label>
					<!-- <span class="icon-glyph glyph-emark-dot color-warning"></span> -->
				</th>
				<td colspan="3"  class="col-input">
					<form:input path="longitude" cssClass="m" placeholder="longitude" />
					<form:input path="latitude" cssClass="m" placeholder="latitude" />
					<form:input path="altitude" cssClass="m" placeholder="altitude" />
					<input type="button" id="mapButtion" value="지도" />
					<form:errors path="longitude" cssClass="error" />
					<form:errors path="latitude" cssClass="error" />
					<form:errors path="altitude" cssClass="error" />
				</td>
			</tr>
			<tr>
				<th class="col-label" scope="row">
					<form:label path="description"><spring:message code='description'/></form:label>
				</th>
				<td colspan="3" class="col-input">
					<form:input path="description" class="xl" maxlength="255" />
 					<form:errors path="description" cssClass="error" />
				</td>
			</tr>
		</table>
		</form:form>
		<div style="padding: 20px 20px 10px 10px; font-size: 18px;">파일 업로딩</div>
		<div class="fileSection" style="font-size: 17px;">
	    	<form id="my-dropzone" action="" class="dropzone hzScroll"></form>
	    </div>
	    <div class="button-group" style="margin-top: 30px;">
			<div class="center-buttons">
				<button id="allFileUpload">업로드</button>
				<button id="allFileClear">파일 초기화</button>
				<a href="/upload-data/list" class="button">목록</a>
			</div>
		</div>

	</div>
</div>
<!-- E: WRAP -->
<%@ include file="/WEB-INF/views/upload-data/data-group-dialog.jsp" %>
<%@ include file="/WEB-INF/views/upload-data/spinner-dialog.jsp" %>

<script type="text/javascript" src="/js/${lang}/common.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/message.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/map-controll.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/ui-controll.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript">
	$(document).ready(function() {
	});
	
	var dataGroupDialog = $( ".dialog" ).dialog({
		autoOpen: false,
		height: 500,
		width: 1000,
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
		url: "/upload-datas",
		//paramName: "file",
		// Prevents Dropzone from uploading dropped files immediately
		timeout: 3600000,
	    autoProcessQueue: false,
	    // 여러개의 파일 허용
		uploadMultiple: true,
		method: "post",
		// 병렬 처리
		parallelUploads: 500,
		// 최대 파일 업로드 갯수
		maxFiles: 500,
		// 최대 업로드 용량 Mb단위
		maxFilesize: 5000,
		dictDefaultMessage: "업로딩 하려면 파일을 올리거나 클릭 하십시오.",
		/* headers: {
			"x-csrf-token": document.querySelectorAll("meta[name=csrf-token]")[0].getAttributeNode("content").value,
		}, */
		// 허용 확장자
		acceptedFiles: "${acceptedFiles}",
		// 업로드 취소 및 추가 삭제 미리 보기 그림 링크 를 기본 추가 하지 않음
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
				if (validate() === false) {
					return;
				}
				
				uploadFileCount = 0;
	            uploadFileResultCount = 0;
	            e.preventDefault();
	            e.stopPropagation();
				
	            if (myDropzone.getQueuedFiles().length > 0) {
	                uploadFileCount = myDropzone.getQueuedFiles().length;
	                myDropzone.processQueue();
	                fileUploadDialog.dialog( "open" );
	            } else {
	                alert("업로딩 할 파일이 존재하지 않습니다.");
	                return;
	            }
			});

			clearTask.addEventListener("click", function () {
	            if (confirm("[파일 업로딩]의 모든 파일을 삭제하겠습니까?")) {
	            	// true 주면 업로드 중인 파일도 다 같이 삭제
	            	myDropzone.removeAllFiles(true);
	            }
	        });

			this.on("sending", function(file, xhr, formData) {
				formData.append("dataName", $("#dataName").val());
				formData.append("dataGroupId", $("#dataGroupId").val());
				formData.append("sharing", $("#sharing").val());
				formData.append("dataType", $("#dataType").val());
				formData.append("longitude", $("#longitude").val());
				formData.append("latitude", $("#latitude").val());
				formData.append("altitude", $("#altitude").val());
				formData.append("description", $("#description").val());
			});
			
			// maxFiles 카운터를 초과하면 경고창
			this.on("maxfilesexceeded", function (data) {
				myDropzone.removeAllFiles(true);
				alert("최대 업로드 파일 수는 500개 입니다.");
				return;
			});
			
			this.on("success", function(file, response) {
				if(file !== undefined && file.name !== undefined) {
	                console.log("file name = " + file.name);
	                fileUploadDialog.dialog( "close" );
	                if(response.statusCode <= 200) {
	                	if(response.errorCode === undefined || response.errorCode === null) {
	                		uploadFileResultCount ++;
							if(uploadFileCount === uploadFileResultCount) {
							    alert("업로딩을 완료 하였습니다.");
							    uploadFileCount = 0;
							    uploadFileResultCount = 0;
							    myDropzone.removeAllFiles(true);
							}
		                } else {
		                	alertMessage(response);
		                }
	                } else {
                        alertMessage(response);
	                	//alert(JS_MESSAGE[response.errorCode]);
						//alert(response.message);
						console.log("---- " + response.message);
	                }
	            } else {
					console.log("------- success response = " + response);
	            }
	        });
		}
	};
	
	function validate() {
		if ($("#dataName").val() === "") {
			alert("데이터명을 입력하여 주십시오.");
			$("#dataName").focus();
			return false;
		}
		
		// citygml 인 경우 longitude, latitude를 입력하지 않음
		if($("#dataType").val() !== "citygml") {
			if ($("#longitude").val() === "") {
				alert("대표 위치(경도)를 입력하여 주십시오.");
				$("#longitude").focus();
				return false;
			}
			if ($("#latitude").val() === "") {
				alert("대표 위치(위도)를 입력하여 주십시오.");
				$("#latitude").focus();
				return false;
			}
			if ($("#altitude").val() === "") {
				alert("대표 위치(높이)를 입력하여 주십시오.");
				$("#altitude").focus();
				return false;
			}
			if(!locationValidation($("#longitude").val(), $("#latitude").val(), $("#altitude").val())) {
				return false;
			}	
		}
	}
	
	function alertMessage(response) {
		if(uploadFileResultCount === 0) {
			if(response.errorCode === "converter.target.count.invalid") {
	    		alert("변환 대상인 3D 파일이 존재하지 않습니다.");
			} else if(response.errorCode === "data.name.empty") {
	    		alert("데이터명이 유효하지 않습니다.");
	    	} else if(response.errorCode === "data.group.id.empty") {
	    		alert("데이터 그룹명을 입력하여 주십시오.");
	    	} else if(response.errorCode === "data.sharing.empty") {
	    		alert("공유 유형을 입력하여 주십시오.");
	    	} else if(response.errorCode === "data.longitude.empty") {
	    		alert("대표 위치(경도)를 입력하여 주십시오.");
	    	} else if(response.errorCode === "data.latitude.empty") {
	    		alert("대표 위치(위도)를 입력하여 주십시오.");
	    	} else if(response.errorCode === "data.altitude.empty") {
	    		alert("대표 위치(높이)를 입력하여 주십시오.");
	    	} else if(response.errorCode === "data.file.empty") {
	    		alert("파일이 유효하지 않습니다. 다시 업로딩 해 주십시오.");
	    	} else if(response.errorCode === "file.name.invalid") {
				alert("파일명이 유효하지 않습니다.");
	    	} else if(response.errorCode === "file.ext.invalid") {
				alert("파일 확장자가 유효하지 않습니다.");
	        } else if(response.errorCode === "file.size.invalid") {
	            alert("파일 용량이 너무 커서 업로딩 할 수 없습니다.");
	        } else if(response.errorCode === "upload.file.type.invalid") {
	            alert("업로딩 데이터의 데이터 타입이 올바르지 않습니다.");
	        } else if(response.errorCode === "db.exception") {
	            alert("죄송 합니다. 서버 실행중에 오류가 발생 하였습니다. \n 로그를 확인하여 주십시오.");
	        } else if(response.errorCode === "io.exception") {
	            alert("입출력 처리 과정중 오류가 발생하였습니다. 잠시 후 다시 이용하여 주시기 바랍니다.");
	        } else if(response.errorCode === "runtime.exception") {
	            alert("프로그램 실행중 오류가 발생하였습니다. 잠시 후 다시 이용하여 주시기 바랍니다.");
	        } else if(response.errorCode === "unknown.exception") {
	            alert("서버 장애가 발생하였습니다. 잠시 후 다시 이용하여 주시기 바랍니다.");
	        } else {
	        	alert(response.errorCode);
	        }
	        uploadFileResultCount++;
		}
	    return;
	}
	
	//지도에서 찾기
	$( "#mapButtion" ).on( "click", function() {
		var url = "/map/find-point";
		var width = 800;
		var height = 700;
	
		var popupX = (window.screen.width / 2) - (width / 2);
		// 만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음
		var popupY= (window.screen.height / 2) - (height / 2);
		
	    var popWin = window.open(url, "","toolbar=no ,width=" + width + " ,height=" + height + ", top=" + popupY + ", left="+popupX
	            + ", directories=no,status=yes,scrollbars=no,menubar=no,location=no");
	    //popWin.document.title = layerName;
	});
</script>
</body>
</html>
