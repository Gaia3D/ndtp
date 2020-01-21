<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<div class="userPolicyContentWrap">
<form:form id="userPolicy" modelAttribute="userPolicy" method="post" onsubmit="return false;">
<form:hidden path="userPolicyId"/>
<div>
	<p>LOD</p>
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
<!-- 		<button type="button" id="changeLodButton" class="btnTextF">변경</button> -->
	</div>
</div>
<div style="height: 30px;margin-top:5px;">
	<div style="display: inline-block; width: 70px;">SSAO 반경</div>
	<form:input type="text" id="ssaoRadius" path="ssaoRadius" size="15" />&nbsp;M
<!-- 	<button type="button" id="changeLodButton" class="btnTextF">변경</button> -->
</div>
<button class="focusA" style="width:100%;margin-top:20px;" title="저장" onclick="update();">저장</button>
</form:form>
</div>
<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$("input[name='datainfoDisplay']").filter("[value='${userPolicy.datainfoDisplay}']").prop("checked", true);
	$("input[name='originDisplay']").filter("[value='${userPolicy.originDisplay}']").prop("checked", true);
	$("input[name='bboxDisplay']").filter("[value='${userPolicy.bboxDisplay}']").prop("checked", true);
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
// 					window.location.reload();
				} else {
					alert(JS_MESSAGE[msg.errorCode]);
					console.log("---- " + msg.message);
				}
				updateUserPolicyFlag = true;
			},
	        error: function(request, status, error) {
	        	ajaxErrorHandler(request);
	        	updateUserPolicyFlag = true;
	        }
		});
	} else {
		alert("진행 중입니다.");
		return;
	}
}
</script>