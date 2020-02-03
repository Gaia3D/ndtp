<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="tableList">
	<ul  id="districtSearchResult" class="listDrop">
		<li id="districtList" class="on list-drop-button-none">
			<p>행정구역<span> 0 건</span></p>
		</li>
	</ul>
	<div id="districtPage"></div>
	<%@ include file="/WEB-INF/views/search/list.jsp" %>
	<%@ include file="/WEB-INF/views/search/pagination.jsp" %>
</div>
