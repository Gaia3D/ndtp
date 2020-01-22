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
				<tr style="height: 30px;">
					<th rowspan="2" style="vertical-align: middle; text-align: center; background-color: #f3f3f3;">번호</th>
					<th colspan="3" style="background-color: #f3f3f3;">데이터명</th>
				</tr>
				<tr style="height: 30px;">
					<th style="background-color: #f3f3f3;">데이터타입</th>
					<th style="background-color: #f3f3f3;">속성</th>
					<th style="background-color: #f3f3f3;">보기</th>
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
				<tr style="height: 35px;">
					<td rowspan="2" style="vertical-align: middle; text-align: center; padding: 0px;">${pagination.rowNumber - status.index }</td>
					<td colspan="3" style="vertical-align: middle; text-align: left; padding: 0px 0px 0px 5px;">${dataInfo.dataName }</td>
				</tr>
				<tr style="height: 35px;">
					<td style="padding: 0px; vertical-align: middle; text-align: left; padding: 0px 0px 0px 5px;">${dataInfo.dataType }</td>
					<td style="padding: 0px; vertical-align: middle; ">
			<c:if test="${dataInfo.status eq 'use' }">
						사용중
			</c:if>
			<c:if test="${dataInfo.status eq 'unused' }">
						사용중지
			</c:if>
			<c:if test="${dataInfo.status eq 'delete' }">
						삭제
			</c:if>		
					</td>
					<td style="padding: 0px; vertical-align: middle; ">
						<button type="button" title="바로가기" class="goto" style="margin: 0px; padding: 0px;" 
							onclick="flyToData('${dataInfo.longitude}', '${dataInfo.latitude}', '${dataInfo.altitude}', '2');">바로가기</button></td>
				</tr>
		</c:forEach>
	</c:if>
			</tbody>
		</table>
	</div>

	<%@ include file="/WEB-INF/views/common/small-pagination.jsp" %>
</div>