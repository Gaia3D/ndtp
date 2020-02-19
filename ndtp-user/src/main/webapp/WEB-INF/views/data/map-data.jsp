<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="dataInfoContent" class="contents contents-margin-none yScroll fullHeight" style="display:block;">
	<form:form id="searchDataForm" modelAttribute="searchDataForm" method="post" onsubmit="return false;">
	<div class="form-group">
		<label>데이터명</label>
		<input type="text" id="searchDataName" name="searchDataName" placeholder=" 데이터명을 입력하여 주십시오. " size="30" />
	</div>
	<div class="form-group">
		<label>상태</label>
		<select id="searchDataStatus" name="searchDataStatus">
			<option value="">전체</option>
			<option value="use">사용중</option>
			<option value="unused">사용중지</option>
		</select>
	</div>
	<div class="form-group">
		<label>타입</label>
		<select id="searchDataType" name="searchDataType">
			<option value="">전체</option>
			<option value="citygml">citygml</option>
			<option value="indoorgml">indoorgml</option>
			<option value="las">las</option>
			<option value="ifc">ifc</option>
			<option value="collada">collada</option>
			<option value="dae">dae</option>
			<option value="obj">obj</option>
			<option value="3ds">3ds</option>
		</select>
	</div>
	<div class="form-group button-group-center">
		<button type="button" id="mapDataSearch" class="btnTextF search-text" title="검색">검색</button>
	</div>

	</form:form>

	<div id="dataInfoListArea">
		<div class="bothSide">
			<div><spring:message code='all'/> <span><fmt:formatNumber value="${pagination.totalCount}" type="number"/></span> <spring:message code='search.what.count'/></div>
			<div class="float-right"><fmt:formatNumber value="${pagination.pageNo}" type="number"/> / <fmt:formatNumber value="${pagination.lastPage }" type="number"/> <spring:message code='search.page'/></div>
		</div>
		<div class="dataBtns"></div>
		<div class="dataGroupSummary table-data-group-summary table-data-group table-font-small">
			<table class="table-word-break">
				<colgroup>
					<col />
					<col class="col-width-28" />
					<col class="col-width-28" />
					<col class="col-width-28" />
				</colgroup>
				<thead>
					<tr>
						<th rowspan="2">번호</th>
						<th colspan="3">데이터명[타입]</th>
					</tr>
					<tr>
						<th>데이터그룹</th>
						<th>상태</th>
						<th>보기</th>
					</tr>
				</thead>
				<tbody>
<c:if test="${empty dataList }">
					<tr>
						<td colspan="4" class="center">데이터가 존재하지 않습니다.</td>
					</tr>
		</c:if>
<c:if test="${!empty dataList }">
	<c:forEach var="dataInfo" items="${dataList}" varStatus="status">
					<tr>
						<td rowspan="2">${pagination.rowNumber - status.index }</td>
						<td colspan="3" class="ellipsis" style="max-width:260px;">
		<c:if test="${dataInfo.dataGroupTarget eq 'admin'}">
								[관리자]
		</c:if>
		<c:if test="${dataInfo.dataGroupTarget eq 'user'}">
			<c:if test="${dataInfo.userId eq owner}">
									[본인]
			</c:if>
			<c:if test="${dataInfo.userId ne owner}">
									[다른 사용자]
			</c:if>
		</c:if>
							<a href="#" onclick="detailDataInfo('${dataInfo.dataId}'); return false;">${dataInfo.dataName }</a> [${dataInfo.dataType }]
						</td>
					</tr>
					<tr>
						<td class="ellipsis" style="max-width:100px;">${dataInfo.dataGroupName }</td>
						<td>
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
						<td>
		<c:if test="${dataInfo.tiling eq 'true' }">				
							<button type="button" title="바로가기" class="goto" 
								onclick="gotoFly('${dataInfo.longitude}', '${dataInfo.latitude}', '${dataInfo.altitude}');">바로가기</button>
		</c:if>
		<c:if test="${dataInfo.tiling ne 'true' }">				
							<button type="button" title="바로가기" class="goto" onclick="flyTo('${dataInfo.dataGroupId}', '${dataInfo.dataKey}');">바로가기</button>
		</c:if>
						</td>
					</tr>
	</c:forEach>
</c:if>
				</tbody>
			</table>
		</div>

		<%@ include file="/WEB-INF/views/data/data-pagination.jsp" %>
	</div>
</div>