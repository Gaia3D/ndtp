<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="btnGroup">
	<!-- 사용자 설정 정보 ==> settings.js -->
	<button class="textBtnSub" onClick="turnOffAllLayer(); return false;">전체 끄기</button>
	<button class="textBtnSub" onClick="resetAllLayer(); return false;">시스템 설정으로</button>
	<button class="textBtn" onClick="updateUserLayer(); return false;">현재 설정 저장</button>
</div>
<ul class="layerList" style="overflow-y: auto;">
    <!-- layer 삽입되는 영역 ==> layer.js ==> createLayerHtmlParents() -->
	<%@include file="/WEB-INF/views/layer/layer-template.jsp"%>
</ul>