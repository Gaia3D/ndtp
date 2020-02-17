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
										<th class="col-label" scope="row"><spring:message code='title'/></th>
										<td class="col-data">${civilVoice.title}</td>
									</tr>
									<tr>
										<th class="col-label" scope="row">위치</th>
										<td class="col-data">
											${civilVoice.longitude}, ${civilVoice.latitude}
											<input type="button" id="mapButtion" value="지도에서 보기" />
										</td>
									</tr>
									<tr>
										<th class="col-label" scope="row"><spring:message code='contant'/></th>
										<td class="col-data">${civilVoice.contents}</td>
									</tr>
									<tr>
										<th class="col-label" scope="row">작성자</th>
										<td class="col-data">${civilVoice.userId}</td>
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

						<!-- 댓글 등록 -->
						<form:form id="civilVoiceCommentForm" modelAttribute="civilVoiceComment" method="post" onsubmit="return false;">
						<h4 class="comment">댓글쓰기</h4>
						<div class="commentWrite">
							<p class="user"></p>
							<textarea name="" id="" class="reply"></textarea>
							<span class="textCount">0/256</span>
							<button type="button" title="등록" class="regist">등록</button>
						</div>
						</form:form>
						<ul id="civilVoiceComment" class="reply"></ul>
						<div id="civilVoiceCommentPagination" class="pagination"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
	<%@ include file="/WEB-INF/views/civil-voice/comment.jsp" %>

<%-- F4D Converter Job 등록 --%>
<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script type="text/javascript" src="/externlib/handlebars-4.1.2/handlebars.js"></script>
<script type="text/javascript" src="/js/${lang}/handlebarsHelper.js"></script>
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript">

	$(document).ready(function() {
		getCivilVoiceCommentList();
	});

	// 시민참여 댓글 등록
	$('#civilVoiceAgree').on('click', function() {
		saveCivilVoiceComment();
	});

	function drawHandlebarsHtml(data, templateId, targetId) {
		var source = $('#' + templateId).html();
		var template = Handlebars.compile(source);
		var html = template(data);
		$('#' + targetId).empty().append(html);
	}

	function initFormContent(formId) {
		$('#' + formId + ' input').val("");
		$('#' + formId + ' textarea').val("");
	}

	// 시민참여 댓글 조회
	function getCivilVoiceCommentList(page) {
		if(!page) page = 1;
		var id = '392';

		$.ajax({
			url: '/civil-voice-comments/' + id,
			type: 'GET',
			headers: {'X-Requested-With': 'XMLHttpRequest'},
			contentType: "application/json; charset=utf-8",
			dataType: 'json',
			data: {pageNo: page},
			success: function(res){
				if(res.statusCode <= 200) {
					debugger
					$('#civilVoiceCommentTotalCount').text(res.totalCount);
					drawHandlebarsHtml(res, 'templateCivilVoiceComment', 'civilVoiceComment');
					drawHandlebarsHtml(res, 'templateCivilVoiceCommentPagination', 'civilVoiceCommentPagination');
				} else {
					alert(JS_MESSAGE[res.errorCode]);
					console.log("---- " + res.message);
				}
			},
			error: function(request, status, error) {
				alert(JS_MESSAGE["ajax.error.message"]);
			}
		});
	}

	// 시민참여 댓글 등록
	var insertCivilVoiceCommentFlag = true;
	function saveCivilVoiceComment() {
		if(insertCivilVoiceCommentFlag) {
			insertCivilVoiceCommentFlag = false;
			var id = '392';
			var url = "/civil-voice-comments";
			var formId = 'civilVoiceCommentForm';
			var formData = $('#' + formId).serialize();

			$.ajax({
				url: url,
				type: "POST",
				headers: {"X-Requested-With": "XMLHttpRequest"},
				data: formData + '&civilVoiceId=' + id,
				dataType: "json",
				success: function(msg) {
					if(msg.statusCode <= 200) {
						alert("등록 되었습니다.");
						initFormContent(formId);
						getCivilVoiceCommentList();
					} else {
						alert(msg.message);
						console.log("---- " + msg.message);
					}
					insertCivilVoiceCommentFlag = true;
				},
		        error: function(request, status, error) {
		        	alert(JS_MESSAGE["ajax.error.message"]);
		        	insertCivilVoiceCommentFlag = true;
		        }
			});
		} else {
			alert("진행 중입니다.");
			return;
		}
	}

	// 지도에서 찾기
	$( "#mapButtion" ).on( "click", function() {
		var url = "/map/find-point";
		var width = 800;
		var height = 700;

		var popupX = (window.screen.width / 2) - (width / 2);
		// 만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음
		var popupY= (window.screen.height / 2) - (height / 2);

	    var popWin = window.open(url, "","toolbar=no,width=" + width + ",height=" + height + ",top=" + popupY + ",left="+popupX
	            + ",directories=no,status=yes,scrollbars=no,menubar=no,location=no");
	    //popWin.document.title = layerName;
	});

</script>
</body>
</html>
