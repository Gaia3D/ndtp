<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="dataInfoContent" style="display:block;">
	<table class="tableTemplate" style="width: 100%;">
		<colgroup>
			<col class="col-label l" style="width: 30%" >
			<col class="col-input" style="width: 70%" >
        </colgroup>
		<tr style="margin: 7px 0px 7px 0px;">
			<td>
				<label for="searchDataName">데이터명</label>
			</td>
			<td>
				<input type="text" placeholder="데이터명을 입력하여 주십시오." style="height: 26px;" size="30" />
			</td>	
		</tr>
		<tr style="margin: 7px 0px 7px 0px;">
			<td>
				<select id="" name="" style="height: 30px;">
					<option value="전체">전체</option>
					<option value="상태">상태</option>
				</select>
			</td>
			<td>
				<input type="radio" id="showPropertyRendering" name="propertyRendering" value="true" />
						<label for="showLabel"> 표시 </label>
						<input type="radio" id="hidePropertyRendering" name="propertyRendering" value="false" />
						<label for="hideLabel"> 비표시 </label>
			</td>
		</tr>
		<tr style="margin: 7px 0px 7px 0px;">
			<td>
				<select id="" name="" style="height: 30px;">
					<option value="전체">타입</option>
				</select>
			</td>
			<td>
			</td>
		</tr>
		<tr>
			<td></td>
			<td>
				<button type="button" title="검색">검색</button>
			</td>
		</tr>
	</table>
	
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
					<th colspan="3" style="background-color: #f3f3f3;">데이터명[타입]</th>
				</tr>
				<tr style="height: 30px;">
					<th style="background-color: #f3f3f3;">데이터그룹</th>
					<th style="background-color: #f3f3f3;">상태</th>
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
					<td colspan="3" style="vertical-align: middle; text-align: left; padding: 0px 0px 0px 5px;">
						<a href="#" onclick="detailDataInfo('${dataInfo.dataId}'); return false;">${dataInfo.dataName }</a> [${dataInfo.dataType }]
					</td>
				</tr>
				<tr style="height: 35px;">
					<td style="padding: 0px; vertical-align: middle; text-align: left; padding: 0px 0px 0px 5px;">${dataInfo.dataGroupName }</td>
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
	
<c:if test="${!empty dataList }">
	<%@ include file="/WEB-INF/views/common/small-pagination.jsp" %>
</c:if>
</div>