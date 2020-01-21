<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<div class="userPolicyContentWrap">
<form:form id="userPolicy" modelAttribute="userPolicy" method="post" onsubmit="return false;">
<form:hidden path="userPolicyId"/>
<div class="userPolicyContent">
	<h3>시작 위치</h3>
	<div class="userPolicyContentDetail">
		<div style="height: 30px;">
			<div style="display: inline-block; width: 70px;">위도</div>
			<form:input type="text" id="initLatitude" path="initLatitude" size="15" />&nbsp;M
			<button type="button" id="findStartPoint" class="btnTextF" style="margin-left: 5px;">지도에서 선택</button>
		</div>
		<div style="height: 30px;">
			<div style="display: inline-block; width: 70px;">경도</div>
			<form:input type="text" id="initLongitude" path="initLongitude" size="15" />&nbsp;M
		</div>
		<div style="height: 30px;">
			<div style="display: inline-block; width: 70px;">높이</div>
			<form:input type="text" id="initAltitude" path="initAltitude" size="15" />&nbsp;M
		</div>
		<div style="height: 30px;">
			<div style="display: inline-block; width: 70px;">이동 속도</div>
			<form:input type="text" id="initDuration" path="initDuration" size="15" />&nbsp;초
		</div>
	</div>
</div>
<div style="height: 30px;margin-top:5px;" class="userPolicyContent">
	<h3 style="display:inline-block;float:left;">Field Of View</h3>
	<div class="userPolicyContentDetail" style="float:left;">
		<form:input type="text" id="initfieldOfView" path="initDefaultFov" size="11" style="margin-left:3px;" />&nbsp;M
<!-- 		<button type="button" id="fieldOfViewButton" class="btnTextF" style="margin-left: 51px;">변경</button> -->
	</div>
</div>
<div class="userPolicyContent">
	<h3>LOD</h3>
	<div class="userPolicyContentDetail">
		<div style="height: 30px;">
			<div style="display: inline-block; width: 70px;">LOD0</div>
			<form:input type="text" id="geoLod0" path="lod0" size="15" />&nbsp;M
		</div>
		<div style="height: 30px;">
			<div style="display: inline-block; width: 70px;">LOD1</div>
			<form:input type="text" id="geoLod1" path="lod1" size="15" />&nbsp;M
		</div>
		<div style="height: 30px;">
			<div style="display: inline-block; width: 70px;">LOD2</div>
			<form:input type="text" id="geoLod2" path="lod2" size="15" />&nbsp;M
		</div>
		<div style="height: 30px;">
			<div style="display: inline-block; width: 70px;">LOD3</div>
			<form:input type="text" id="geoLod3" path="lod3" size="15" />&nbsp;M
		</div>
		<div style="height: 30px;">
			<div style="display: inline-block; width: 70px;">LOD4</div>
			<form:input type="text" id="geoLod4" path="lod4" size="15" />&nbsp;M
		</div>
		<div style="height: 30px;">
			<div style="display: inline-block; width: 70px;">LOD5</div>
			<form:input type="text" id="geoLod5" path="lod5" size="15" />&nbsp;M
			<button type="button" id="changeLodButton" class="btnTextF" style="margin-left: 50px;">변경</button>
		</div>
	</div>
</div>
<div style="height: 30px;margin-top:5px;" class="userPolicyContent">
	<h3 style="display:inline-block;float:left;">SSAO 반경</h3>
	<div class="userPolicyContentDetail" style="float:left;">
		<form:input type="text" id="ssaoRadius" path="ssaoRadius" size="15" />&nbsp;M
		<button type="button" id="changeSsaoButton" class="btnTextF" style="margin-left: 50px;">변경</button>
	</div>
</div>

<button class="focusA" style="width:100%;margin-top:20px;" title="저장" onclick="update();">저장</button>
</form:form>
</div>
<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
});

var updateUserPolicyFlag = true;
function update() {
	if(updateUserPolicyFlag) {
		updateUserPolicyFlag = false;
		var url = "/user-policy/update";
		var formData = $("#userPolicy").serialize();
		$.ajax({
			url: url,
			type: "POST",
			headers: {"X-Requested-With": "XMLHttpRequest"},
			data: formData,
			dataType: "json",
			success: function(msg) {
				if(msg.statusCode <= 200) {
					alert("저장 되었습니다.");
				} else {
					alert(JS_MESSAGE[msg.errorCode]);
					console.log("---- " + msg.message);
				}
				updateUserPolicyFlag = true;
			},
	        error: function(request, status, error) {
	        	alert(JS_MESSAGE["ajax.error.message"]);
	        	updateUserPolicyFlag = true;
	        }
		});
	} else {
		alert("진행 중입니다.");
		return;
	}
}
</script>