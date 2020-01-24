<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="dataInfoContent" style="display:block;">
	<div class="listSearch">
		<form:form id="searchDataForm" modelAttribute="searchDataForm" method="post" onsubmit="return false;">
		<table class="basicTable" style="width: 100%; background-color: white; padding: 5px;">
			<colgroup>
				<col class="col-label l" style="width: 25%" >
				<col class="col-input" style="width: 75%" >
	        </colgroup>
			<tr style="height: 30px;">
				<td style="padding: 7px 7px 3px 7px;">
					<span style="display: inline-block; width: 80px; height:23px;  background-color: #f3f3f3; text-align: center; padding-top: 6px;"><b>데이터명</b></span>
				</td>
				<td style="padding: 7px 7px 3px 7px;">
					<input type="text" id="searchDataName" name="searchDataName" placeholder=" 데이터명을 입력하여 주십시오. " style="height: 26px;" size="30" />
				</td>	
			</tr>
			<tr style="height: 30px;">
				<td style="text-align: left; padding: 4px 7px 3px 7px;">
					<span style="display: inline-block; width: 80px; height:23px;  background-color: #f3f3f3; text-align: center; padding-top: 6px;"><b>상태</b></span>
				</td>
				<td style="width: 100%; background-color: white; padding: 4px 7px 3px 7px;">
					<select id="searchDataStatus" name="searchDataStatus" style="height: 30px;">
						<option value="">&nbsp;&nbsp;전체&nbsp;&nbsp;</option>
						<option value="use">&nbsp;&nbsp;사용중&nbsp;&nbsp;</option>
						<option value="unused">&nbsp;&nbsp;사용중지&nbsp;&nbsp;</option>
					</select>&nbsp;&nbsp;
				</td>
			</tr>
			<tr style="height: 30px;">
				<td style="text-align: left; padding: 4px 7px 3px 7px;">
					<span style="display: inline-block; width: 80px; height:23px;  background-color: #f3f3f3; text-align: center; padding-top: 6px;"><b>타입</b></span>
				</td>
				<td style="padding: 7px; padding: 4px 7px 3px 7px;">
					<select id="searchDataType" name="searchDataType" style="height: 30px;">
						<option value="">&nbsp;&nbsp;전체&nbsp;&nbsp;</option>
						<option value="citygml">&nbsp;&nbsp;citygml&nbsp;&nbsp;</option>
						<option value="indoorgml">&nbsp;&nbsp;indoorgml&nbsp;&nbsp;</option>
						<option value="las">&nbsp;&nbsp;las&nbsp;&nbsp;</option>
						<option value="ifc">&nbsp;&nbsp;ifc&nbsp;&nbsp;</option>
						<option value="collada">&nbsp;&nbsp;collada&nbsp;&nbsp;</option>
						<option value="dae">&nbsp;&nbsp;dae&nbsp;&nbsp;</option>
						<option value="obj">&nbsp;&nbsp;obj&nbsp;&nbsp;</option>
						<option value="3ds">&nbsp;&nbsp;3ds&nbsp;&nbsp;</option>
					</select>&nbsp;&nbsp;
					<button type="button" id="mapDataSearch" title="검색" style="width: 70px; height: 30px;">검색</button>
				</td>
			</tr>
		</table>
		</form:form>
	</div>
	
	<div id="dataInfoListArea">
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
				<c:if test="${dataInfo.status eq 'processing' }">
							변환중
				</c:if>
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
								onclick="flyTo('${dataInfo.longitude}', '${dataInfo.latitude}', '${dataInfo.altitude}', '2');">바로가기</button></td>
					</tr>
			</c:forEach>
		</c:if>
				</tbody>
			</table>
		</div>
		
		<%@ include file="/WEB-INF/views/data/data-pagination.jsp" %>
	</div>
</div>