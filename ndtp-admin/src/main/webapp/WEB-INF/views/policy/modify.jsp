<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>운영정책 | NDTP</title>
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
	<link rel="stylesheet" href="/externlib/normalize/normalize.min.css" />
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css" />
	<link rel="stylesheet" href="/css/fontawesome-free-5.2.0-web/css/all.min.css">
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
						<div class="content-desc u-pull-right"><span class="icon-glyph glyph-emark-dot color-warning"></span><spring:message code='check' />&nbsp;&nbsp;</div>
						<div class="tabs">
							<ul>
								<li><a href="#userTab">사용자</a></li>
								<li><a href="#passwordTab">비밀번호</a></li>
								<!-- <li><a href="#noticeTab">알림</a></li> -->
								<li><a href="#securityTab">보안</a></li>
								<li><a href="#contentTab">컨텐트</a></li>
								<li><a href="#uploadTab">사용자 업로딩 파일</a></li>
							</ul>
							<spring:message var="notuse" code='not.use'/>
							<spring:message var="use" code='use'/>
							<%@ include file="/WEB-INF/views/policy/modify-user.jsp" %>
							<%@ include file="/WEB-INF/views/policy/modify-password.jsp" %>
							<%-- <%@ include file="/WEB-INF/views/policy/modify-notice.jsp" %> --%>
							<%@ include file="/WEB-INF/views/policy/modify-security.jsp" %>
							<%@ include file="/WEB-INF/views/policy/modify-content.jsp" %>
							<%@ include file="/WEB-INF/views/policy/modify-upload.jsp" %>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>

<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript" src="/js/navigation.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$( ".tabs" ).tabs();
	});

	var updatPolicyUserFlag = true;
	function updatePolicyUser() {
	    if(updatPolicyUserFlag) {
	        if( userCheck() === false ) return false;

	        updatPolicyUserFlag = false;
	        var formData = $('#policyUser').serialize();
	        $.ajax({
				url: "/policy/modify-user",
				type: "POST",
				headers: {"X-Requested-With": "XMLHttpRequest"},
		        data: formData + "&policyId=${policy.policyId}",
				success: function(msg){
					if(msg.statusCode <= 200) {
						alert("사용자 정책이 수정 되었습니다");
					} else {
						alert(JS_MESSAGE[msg.errorCode]);
						console.log("---- " + msg.message);
					}
					updatPolicyUserFlag = true;
				},
				error:function(request, status, error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updatPolicyUserFlag = true;
				}
			});
	    } else {
	        alert("진행 중입니다.");
	        return;
		}
	}

	var updatPolicyPasswordFlag = true;
	function updatePolicyPassword() {
		if(updatPolicyPasswordFlag) {
	        if( passwordCheck() === false ) return false;

	        updatPolicyPasswordFlag = false;
	        var formData = $('#policyPassword').serialize();
	        $.ajax({
				url: "/policy/modify-password",
				type: "POST",
				headers: {"X-Requested-With": "XMLHttpRequest"},
		        data: formData + "&policyId=${policy.policyId}",
				success: function(msg){
					if(msg.statusCode <= 200) {
						alert("비밀번호 정책이 수정 되었습니다");
					} else {
						alert(JS_MESSAGE[msg.errorCode]);
						console.log("---- " + msg.message);
					}
					updatPolicyPasswordFlag = true;
				},
				error:function(request, status, error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updatPolicyPasswordFlag = true;
				}
			});
	    } else {
	        alert("진행 중입니다.");
	        return;
		}
	}

	var updatPolicyNoticeFlag = true;
	function updatePolicyNotice() {
		if(updatPolicyNoticeFlag) {
	        if( noticeCheck() === false ) return false;

	        updatPolicyNoticeFlag = false;
	        var formData = $('#policyNotice').serialize();
	        $.ajax({
				url: "/policy/modify-notice",
				type: "POST",
				headers: {"X-Requested-With": "XMLHttpRequest"},
		        data: formData + "&policyId=${policy.policyId}",
				success: function(msg){
					if(msg.statusCode <= 200) {
						alert("알림 정책이 수정 되었습니다");
					} else {
						alert(JS_MESSAGE[msg.errorCode]);
						console.log("---- " + msg.message);
					}
					updatPolicyNoticeFlag = true;
				},
				error:function(request, status, error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updatPolicyNoticeFlag = true;
				}
			});
	    } else {
	        alert("진행 중입니다.");
	        return;
		}
	}

	var updatPolicySecurityFlag = true;
	function updatePolicySecurity() {
		if(updatPolicySecurityFlag) {
	        if( securityCheck() === false ) return false;

	        updatPolicySecurityFlag = false;
	        var formData = $('#policySecurity').serialize();
	        $.ajax({
				url: "/policy/modify-security",
				type: "POST",
				headers: {"X-Requested-With": "XMLHttpRequest"},
		        data: formData + "&policyId=${policy.policyId}",
				success: function(msg){
					if(msg.statusCode <= 200) {
						alert("보안 정책이 수정 되었습니다");
					} else {
						alert(JS_MESSAGE[msg.errorCode]);
						console.log("---- " + msg.message);
					}
					updatPolicySecurityFlag = true;
				},
				error:function(request, status, error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updatPolicySecurityFlag = true;
				}
			});
	    } else {
	        alert("진행 중입니다.");
	        return;
		}
	}

	var updatPolicyContentFlag = true;
	function updatePolicyContent() {
		if(updatPolicyPasswordFlag) {
	        if( contentCheck() === false ) return false;

	        updatPolicyContentFlag = false;
	        var formData = $('#policyContent').serialize();
	        $.ajax({
				url: "/policy/modify-content",
				type: "POST",
				headers: {"X-Requested-With": "XMLHttpRequest"},
		        data: formData + "&policyId=${policy.policyId}",
				success: function(msg){
					if(msg.statusCode <= 200) {
						alert("컨텐트 정책이 수정 되었습니다");
					} else {
						alert(JS_MESSAGE[msg.errorCode]);
						console.log("---- " + msg.message);
					}
					updatPolicyContentFlag = true;
				},
				error:function(request, status, error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updatPolicyContentFlag = true;
				}
			});
	    } else {
	        alert("진행 중입니다.");
	        return;
		}
	}

	var updatPolicyUploadFlag = true;
	function updatePolicyUpload() {
		if(updatPolicyPasswordFlag) {
	        if( uploadCheck() === false ) return false;

	        updatPolicyUploadFlag = false;
	        var formData = $('#policyUpload').serialize();
	        $.ajax({
				url: "/policy/modify-upload",
				type: "POST",
				headers: {"X-Requested-With": "XMLHttpRequest"},
		        data: formData + "&policyId=${policy.policyId}",
				success: function(msg){
					if(msg.statusCode <= 200) {
						alert("업로드 정책이 수정 되었습니다");
					} else {
						alert(JS_MESSAGE[msg.errorCode]);
						console.log("---- " + msg.message);
					}
					updatPolicyUploadFlag = true;
				},
				error:function(request, status, error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updatPolicyUploadFlag = true;
				}
			});
	    } else {
	        alert("진행 중입니다.");
	        return;
		}
	}

	function userCheck() {
		return true;
	}

	function passwordCheck() {
		return true;
	}

	function noticeCheck() {
		return true;
	}

	function securityCheck() {
		return true;
	}

	function contentCheck() {
		return true;
	}

	function uploadCheck() {
		return true;
	}



</script>
</body>
</html>