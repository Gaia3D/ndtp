<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>운영정책 | NDTP</title>
	<link rel="stylesheet" href="/css/${lang}/font/font.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/externlib/normalize/normalize.min.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/css/fontawesome-free-5.2.0-web/css/all.min.css?cacheVersion=${contentCacheVersion}">
    <link rel="stylesheet" href="/css/${lang}/admin-style.css?cacheVersion=${contentCacheVersion}" />
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

<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/common.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/message.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/navigation.js?cacheVersion=${contentCacheVersion}"></script>
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
				url: "/policies/user/" + "${policy.policyId}",
				type: "POST",
				headers: {"X-Requested-With": "XMLHttpRequest"},
		        data: formData,
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
				url: "/policies/password/" + "${policy.policyId}",
				type: "POST",
				headers: {"X-Requested-With": "XMLHttpRequest"},
		        data: formData,
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
				url: "/policies/notice/" + "${policy.policyId}",
				type: "POST",
				headers: {"X-Requested-With": "XMLHttpRequest"},
		        data: formData,
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
				url: "/policies/security/" + "${policy.policyId}",
				type: "POST",
				headers: {"X-Requested-With": "XMLHttpRequest"},
		        data: formData,
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
				url: "/policies/content/" + "${policy.policyId}",
				type: "POST",
				headers: {"X-Requested-With": "XMLHttpRequest"},
		        data: formData,
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
				url: "/policies/upload/" + "${policy.policyId}",
				type: "POST",
				headers: {"X-Requested-With": "XMLHttpRequest"},
		        data: formData,
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

	function numkeyCheck(event) {
		var keyValue = event.keyCode;
		if((keyValue >= 48) && (keyValue <= 57)) {
			return true;
		}
		return false;
	}

	function userCheck() {
		if(!$('#userIdMinLength').val()) {
			alert('사용자 아이디 최소길이를 입력해주세요.');
			$('#userIdMinLength').focus();
			return false;
		}
		if(!$('#userFailSigninCount').val()) {
			alert('로그인 실패 횟수를 입력해주세요.');
			$('#userFailSigninCount').focus();
			return false;
		}
		if(!$('#userFailLockRelease').val()) {
			alert('로그인 실패 잠금 해제 기간을 입력해주세요.');
			$('#userFailLockRelease').focus();
			return false;
		}
		if(!$('#userLastSigninLock').val()) {
			alert('마지막 로그인으로부터 잠금 기간을 입력해주세요.');
			$('#userLastSigninLock').focus();
			return false;
		}
		return true;
	}

	function passwordCheck() {
		if(!$('#passwordChangeTerm').val()) {
			alert('패스워드 변경 주기를 입력해주세요.');
			$('#passwordChangeTerm').focus();
			return false;
		}
		if(!$('#passwordMinLength').val()) {
			alert('패스워드 최소 길이를 입력해주세요.');
			$('#passwordMinLength').focus();
			return false;
		}
		if(!$('#passwordMaxLength').val()) {
			alert('패스워드 최대 길이를 입력해주세요.');
			$('#passwordMaxLength').focus();
			return false;
		}
		if(!$('#passwordEngUpperCount').val()) {
			alert('패스워드 영문 대문자 개수를 입력해주세요.');
			$('#passwordEngUpperCount').focus();
			return false;
		}
		if(!$('#passwordEngLowerCount').val()) {
			alert('패스워드 영문 소문자 개수를 입력해주세요.');
			$('#passwordEngLowerCount').focus();
			return false;
		}
		if(!$('#passwordNumberCount').val()) {
			alert('패스워드 숫자 개수를 입력해주세요.');
			$('#passwordNumberCount').focus();
			return false;
		}
		if(!$('#passwordSpecialCharCount').val()) {
			alert('패스워드 특수문자 개수를 입력해주세요.');
			$('#passwordSpecialCharCount').focus();
			return false;
		}
		if(!$('#passwordContinuousCharCount').val()) {
			alert('패스워드 연속 문자 제한 개수를 입력해주세요.');
			$('#passwordContinuousCharCount').focus();
			return false;
		}
		if(!$('#passwordCreateChar').val()) {
			alert('초기 패스워드 생성 문자열을 입력해주세요.');
			$('#passwordCreateChar').focus();
			return false;
		}
		if(!$('#passwordExceptionChar').val()) {
			alert('초기 패스워드로 사용할수 없는 특수문자를 입력해주세요.');
			$('#passwordExceptionChar').focus();
			return false;
		}
		return true;
	}

	function securityCheck() {
		if(!$('#securitySessionTimeout').val()) {
			alert('보안 세션 타임아웃 시간을 입력해주세요.');
			$('#securitySessionTimeout').focus();
			return false;
		}
		return true;
	}

	function contentCheck() {
		if(!$('#contentCacheVersion').val()) {
			alert('css, js 갱신용 cache version을 입력해주세요.');
			$('#contentCacheVersion').focus();
			return false;
		}
		if(!$('#contentMenuGroupRoot').val()) {
			alert('메뉴 그룹 최상위 그룹명을 입력해주세요.');
			$('#contentMenuGroupRoot').focus();
			return false;
		}
		if(!$('#contentUserGroupRoot').val()) {
			alert('사용자 그룹 최상위 그룹명을 입력해주세요.');
			$('#contentUserGroupRoot').focus();
			return false;
		}
		if(!$('#contentLayerGroupRoot').val()) {
			alert('레이어 그룹 최상위 그룹명을 입력해주세요.');
			$('#contentLayerGroupRoot').focus();
			return false;
		}
		if(!$('#contentDataGroupRoot').val()) {
			alert('데이터 그룹 최상위 그룹명을 입력해주세요.');
			$('#contentDataGroupRoot').focus();
			return false;
		}
		return true;
	}

	function uploadCheck() {
		if(!$('#userUploadType').val()) {
			alert('업로딩 가능 확장자를 입력해주세요.');
			$('#userUploadType').focus();
			return false;
		}
		if(!$('#userConverterType').val()) {
			alert('변환 가능 확장자를 입력해주세요.');
			$('#userConverterType').focus();
			return false;
		}
		if(!$('#shapeUploadType').val()) {
			alert('shpae 업로딩 가능 확장자를 입력해주세요.');
			$('#shapeUploadType').focus();
			return false;
		}
		if(!$('#userUploadMaxFilesize').val()) {
			alert('최대 업로딩 사이즈를 입력해주세요.');
			$('#userUploadMaxFilesize').focus();
			return false;
		}
		if(!$('#userUploadMaxCount').val()) {
			alert('최대 업로딩 파일 수를 입력해주세요.');
			$('#userUploadMaxCount').focus();
			return false;
		}
		return true;
	}

	function noticeCheck() {
		return true;
	}


</script>
</body>
</html>