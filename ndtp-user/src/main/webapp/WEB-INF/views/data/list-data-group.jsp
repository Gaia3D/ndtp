<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="dataGroupInfoContent" style="display:none;">
	<h3 style="margin-top: 10px;">데이터 공유 유형별 현황( 총 : <span><fmt:formatNumber value="${totalCount }" type="number"/></span> 건 )</h3>
	<div class="dataGroupSummary" style="margin: 10px 0px 10px 0px;">
		<table>
			<colgroup>
		        <col class="col-number" />
				<col class="col-number" />
				<col class="col-number" />
				<col class="col-number" />
		    </colgroup>
		    <thead>
				<tr>
					<th scope="col" class="col-number" style="background-color: #f3f3f3;">공공</th>
					<th scope="col" class="col-number" style="background-color: #f3f3f3;">공개</th>
					<th scope="col" class="col-number" style="background-color: #f3f3f3;">비공개</th>
					<th scope="col" class="col-number" style="background-color: #f3f3f3;">그룹</th>
		        </tr>
		        <tr>
		        	<td class="col-number"><fmt:formatNumber value="${commonDataCount }" type="number"/></td>
		        	<td class="col-number"><fmt:formatNumber value="${publicDataCount }" type="number"/></td>
		        	<td class="col-number"><fmt:formatNumber value="${privateDataCount }" type="number"/></td>
		        	<td class="col-number"><fmt:formatNumber value="${groupDataCount }" type="number"/></td>
		        </tr>
		    </thead>
		</table>
	</div>
	
	<div class="listSearch">
		<input type="text" placeholder="그룹명을 입력하세요">
		<button type="button" title="검색">검색</button>
	</div>
	
	<h3 style="margin-top: 30px; margin-bottom: 10px;">
		<spring:message code='all.d'/> <fmt:formatNumber value="${pagination.totalCount}" type="number"/> <spring:message code='search.what.count'/>, 
		<fmt:formatNumber value="${pagination.pageNo}" type="number"/> / <fmt:formatNumber value="${pagination.lastPage }" type="number"/> <spring:message code='search.page'/>
	</h3>
	<div class="tableList">
		<table>
			<thead>
				<tr>
					<th>번호</th>
					<th>그룹명</th>
					<th>공유유형</th>
					<th>데이터건수</th>
					<th>보기</th>
				</tr>
			</thead>
			<tbody>
<c:if test="${empty dataGroupList }">
				<tr>
					<td colspan="5" class="col-none">데이터 그룹이 존재하지 않습니다.</td>
				</tr>
</c:if>								
<c:if test="${!empty dataGroupList }">
	<c:forEach var="dataGroup" items="${dataGroupList}" varStatus="status">
				<tr>
					<td>${pagination.rowNumber - status.index }</td>
					<td>${dataGroup.dataGroupName }</td>
					<td>${dataGroup.sharing }</td>
					<td>${dataGroup.dataCount }</td>
					<td>
						<button type="button" title="바로가기" class="goto" onclick="flyToData('${dataGroup.longitude}', '${dataGroup.latitude}', '${dataGroup.altitude}', '2');">바로가기</button></td>
				</tr>
	</c:forEach>
</c:if>
			</tbody>
		</table>
	</div>
	
<c:if test="${!empty dataGroupList }">	
	<%@ include file="/WEB-INF/views/common/small-pagination.jsp" %>
</c:if>
</div>