<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="dataInfoContent" style="display:block;">
<div class="listSearch">
	<input type="text" placeholder="데이터명을 입력하세요">
	<button type="button" title="검색">검색</button>
</div>

<h3 style="margin-top: 30px; margin-bottom: 10px;">
	<spring:message code='all.d'/> <fmt:formatNumber value="${pagination.totalCount}" type="number"/> <spring:message code='search.what.count'/>, 
	<fmt:formatNumber value="${pagination.pageNo}" type="number"/> / <fmt:formatNumber value="${pagination.lastPage }" type="number"/> <spring:message code='search.page'/>
</h3>
<div class="dataBtns"></div>
<div class="dataGroupSummary">
	<table>
		<thead>
			<tr>
				<th rowspan="2" style="vertical-align: middle; text-align: center;">번호</th>
				<th colspan="3">데이터명</th>
			</tr>
			<tr>
				<th>상태</th>
				<th>속성</th>
				<th>위치</th>
			</tr>
		</thead>
		<tbody>
<c:if test="${empty dataList }">
			<tr>
				<td colspan="4" class="col-none">데이터가 존재하지 않습니다.</td>
			</tr>
</c:if>								
<c:if test="${!empty dataList }">
	<c:forEach var="dataInfo" items="${dataList}" varStatus="status">		
			<tr style="height: 25px;">
				<td rowspan="2" style="vertical-align: middle; text-align: center;">${pagination.rowNumber - status.index }</td>
				<td colspan="3" style="text-align: left;">${dataInfo.dataName }</td>
			</tr>
			<tr style="height: 25px;">
				<td>${dataInfo.status }</td>
				<td><a href="">보기</a></td>
				<td></td>
			</tr>
	</c:forEach>
</c:if>
		</tbody>
	</table>
</div>

<ul class="pagination">
	<li class="ico first" title="맨앞으로">처음</li>
	<li class="ico forward" title="앞으로">앞으로</li>
	<li>1</li>
	<li>2</li>
	<li>3</li>
	<li class="on">4</li>
	<li>5</li>
	<li>6</li>
	<li class="ico back" title="뒤로">뒤로</li>
	<li class="ico end" title="맨뒤로">마지막</li>
</ul>
</div>