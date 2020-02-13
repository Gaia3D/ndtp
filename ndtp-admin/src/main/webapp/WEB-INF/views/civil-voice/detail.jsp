<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>시민참여 상세 정보 | NDTP</title>
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
						<div class="content-desc u-pull-right"><span class="icon-glyph glyph-emark-dot color-warning"></span><spring:message code='check'/></div>
						<div class="tabs">
							<ul>
								<li><a href="#userInfoTab"><spring:message code='user.input.information'/></a></li>
								<%-- <li><a href="#userDeviceTab"><spring:message code='user.input.device'/></a></li> --%>
							</ul>
							<div id="userInfoTab">
								<table class="inner-table scope-row">
									<col class="col-label" />
									<col class="col-data" />
									<tr>
										<th class="col-label" scope="row"><spring:message code='user.id'/></th>
										<td class="col-data">${civilVoice.userId}</td>
									</tr>
									<tr>
										<th class="col-label" scope="row"><spring:message code='title'/></th>
										<td class="col-data">${civilVoice.title}</td>
									</tr>
									<tr>
										<th class="col-label" scope="row"><spring:message code='contant'/></th>
										<td class="col-data">${civilVoice.contents}</td>
									</tr>
									<tr>
										<th class="col-label" scope="row"><spring:message code='search.insert.date'/></th>
										<td class="col-data">
											<fmt:parseDate value="${civilVoice.insertDate}" var="viewInsertDate" pattern="yyyy-MM-dd HH:mm:ss"/>
											<fmt:formatDate value="${viewInsertDate}" pattern="yyyy-MM-dd HH:mm"/>
										</td>
									</tr>
								</table>
							</div>
						</div>
						<div class="button-group">
							<div class="center-buttons">
								<a href="/civil-voice/list?${listParameters}" class="button"><spring:message code='list'/></a>
								<a href="/civil-voice/modify?civilVoiceId=${civilVoice.civilVoiceId}&amp;${listParameters}" class="button"><spring:message code='modified'/></a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>

<%-- F4D Converter Job 등록 --%>
<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$( ".tabs" ).tabs();
	});

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
				headers: {"X-Requested-With": "XMLHttpRequest"},
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
					headers: {"X-Requested-With": "XMLHttpRequest"},
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
