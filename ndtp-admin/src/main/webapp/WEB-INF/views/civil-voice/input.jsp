<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>시민참여 등록 | NDTP</title>
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
						<form:form id="civilVoice" modelAttribute="civilVoice" method="post" onsubmit="return false;">
							<table class="input-table scope-row">
								<col class="col-label l" />
								<col class="col-input" />
								<tr>
									<th class="col-label" scope="row">
										<form:label path="title">제목</form:label>
										<span class="icon-glyph glyph-emark-dot color-warning"></span>
									</th>
									<td class="col-input">
										<form:input path="title" cssClass="l" maxlength="100" />
										<form:errors path="title" cssClass="error" />
									</td>
								</tr>
								<tr>
									<th class="col-label" scope="row">
										<form:label path="contents">내용</form:label>
										<span class="icon-glyph glyph-emark-dot color-warning"></span>
									</th>
									<td class="col-input">
										<form:input path="contents" cssClass="l" />
										<form:errors path="contents" cssClass="error" />
									</td>
								</tr>
							</table>
							<div class="button-group">
								<div class="center-buttons">
									<input type="submit" value="<spring:message code='save'/>" onclick="insertCivilCVoice();"/>
									<a href="/civil-voice/list" class="button">목록</a>
								</div>
							</div>
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>

	<%@ include file="/WEB-INF/views/data-group/parent-data-group-dialog.jsp" %>

<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript" src="/js/navigation.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
	});

	function validate() {
		// temp
		return true;


		var number = /^[0-9]+$/;
		if ($("#dataGroupName").val() === null || $("#dataGroupName").val() === "") {
			alert("데이터 그룹명을 입력해 주세요.");
			$("#dataGroupName").focus();
			return false;
		}
		if($("#duplication").val() === null || $("#duplication").val() === "") {
			alert(JS_MESSAGE["data.group.key.duplication.check"]);
			$("#dataGroupKey").focus();
			return false;
		} else if($("#duplication").val() === "true") {
			alert(JS_MESSAGE["data.group.key.duplication"]);
			$("#dataGroupKey").focus();
			return false;
		}
		if ($("#dataGroupKey").val() === null || $("#dataGroupKey").val() === "") {
			alert("데이터 그룹 Key(한글불가)을 입력해 주세요.");
			$("#dataGroupKey").focus();
			return false;
		}
		if ($("#dataGroupKey").val().length >= 60) {
			alert("데이터 그룹 Key는 60자를 넘길 수 없습니다.");
			$("#dataGroupKey").focus();
			return false;
		}
		//한글이 입력될 경우 "한글명은 이용할 수 없습니다."라고 출력 -> 한글 검사방법..?
		if($("#parent").val() === null || $("#parent").val() === "" || !number.test($("#parent").val())) {
			alert("상위 데이터 그룹을 선택해 주세요.");
			$("#parent").focus();
			return false;
		}
		if($("#duration").val() !== null && $("#duration").val() !== "") {
			if(!isNumber($("#duration").val())) {
				$("#duration").focus();
				return false;
			}
		}
	}

	// 저장
	var insertCivilCVoiceFlag = true;
	function insertCivilCVoice() {
		if (validate() == false) {
			return false;
		}
		if(insertCivilCVoiceFlag) {
			insertCivilCVoiceFlag = false;
			var formData = $("#civilVoice").serialize();
			$.ajax({
				url: "/civil-voices",
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
					insertCivilCVoiceFlag = true;
				},
				error:function(request, status, error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        insertCivilCVoiceFlag = true;
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