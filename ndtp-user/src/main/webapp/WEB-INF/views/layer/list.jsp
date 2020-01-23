<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="btnGroup">
	<!-- 사용자 설정 정보 ==> settings.js -->
	<button class="textBtnSub" onClick="turnOffAllLayer(); return false;">전체 끄기</button>
	<button class="textBtnSub" onClick="resetAllLayer(); return false;">전체 켜기</button>
	<button class="textBtnSub" onClick="updateUserLayer(); return false;">접기</button>
	<button class="textBtnSub" onClick="updateUserLayer(); return false;">펼치기</button>
</div>
<ul id="layerTreeList" class="layerList" style="overflow-y: auto;margin-top:10px;">
</ul>
<%@include file="/WEB-INF/views/layer/layer-template.jsp"%>