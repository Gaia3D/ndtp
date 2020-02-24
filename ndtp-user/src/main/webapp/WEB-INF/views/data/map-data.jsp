<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="dataInfoContent" class="contents contents-margin-none fullHeight" style="display:block;">
	<form:form id="searchDataForm" modelAttribute="searchDataForm" method="post" onsubmit="return false;">
	<div class="form-group form-group-data">
		<label>데이터명</label>
		<input type="text" id="searchDataName" name="searchDataName" placeholder=" 데이터명을 입력하여 주십시오. " size="30" />
	</div>
	<div class="form-group form-group-data">
		<label>상태</label>
		<select id="searchDataStatus" name="searchDataStatus">
			<option value="">전체</option>
			<option value="use">사용중</option>
			<option value="unused">사용중지</option>
		</select>
	</div>
	<div class="form-group form-group-data">
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
	<dl class="legendWrap">
		<dt>공유 유형</dt>
		<dd><span class="legend co">C</span>공통</dd>
		<dd><span class="legend pu">O</span>공개</dd>
		<dd><span class="legend pr">P</span>비공개</dd>
		<dd><span class="legend gr">G</span>그룹공개</dd>
	</dl>
	<div id="dataInfoListArea" style="height:calc(100% - 255px)">
		<div>
			<span><spring:message code='all'/> : <span><fmt:formatNumber value="${pagination.totalCount}" type="number"/></span> <spring:message code='search.what.count'/></span>
			<span class="float-right"><fmt:formatNumber value="${pagination.pageNo}" type="number"/> / <fmt:formatNumber value="${pagination.lastPage }" type="number"/> <spring:message code='search.page'/></span>
		</div>
		<div class="dataBtns"></div>
		<div class="tableList marT10 yScroll" style="height: calc(100% - 43px)">
			<table>
				<colgroup>
					<col class="col-width-12" />
					<col class="col-width-12" />
					<col />
					<col class="col-width-12" />
					<col class="col-width-12" />
				</colgroup>
				<thead>
					<tr>
						<th rowspan="2">번호</th>
						<th>공유 유형</th>
						<th>데이터명</th>
						<th>표시</th>
						<th>이동</th>
					</tr>
				</thead>
				<tbody>
<c:if test="${empty dataList }">
					<tr><td colspan="5">데이터가 존재하지 않습니다.</td></tr>
</c:if>
<c:if test="${!empty dataList }">
	<c:forEach var="dataInfo" items="${dataList}" varStatus="status">
					<tr>
						<td rowspan="2"><span class="no">${pagination.rowNumber - status.index}</span></td>
						<td>
		<c:if test="${dataInfo.sharing eq 'common'}">
				<span class="legend co">C</span>	
		</c:if>
		<c:if test="${dataInfo.sharing eq 'public'}">
				<span class="legend pu">O</span>
		</c:if>
		<c:if test="${dataInfo.sharing eq 'private'}">
				<span class="legend pr">P</span>
		</c:if>
		<c:if test="${dataInfo.sharing eq 'group'}">
				<span class="legend gr">G</span>
		</c:if>
						</td>
						<td class="alignLeft"><a href="#" onclick="detailDataInfo('${dataInfo.dataId}'); return false;">${dataInfo.dataName}</a></td>
						<td><button type="button" title="표시" class="showHideButton show" data-group-id="${dataInfo.dataGroupId}" data-key="${dataInfo.dataKey}">표시</button></td>
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
					<tr>
						<td class="alignLeft" colspan="4">
				<span class="infoTag"><span>그룹명:</span>${dataInfo.dataGroupName}</span>
		<c:if test="${dataInfo.dataGroupTarget eq 'admin'}">
				<span class="infoTag" style="color:blue">관리자</span>
		</c:if>
		<c:if test="${dataInfo.dataGroupTarget eq 'user'}">
			<c:if test="${dataInfo.userId eq owner}">
				<%-- <span class="infoTag">${dataInfo.userId}</span> --%>
			</c:if>
			<c:if test="${dataInfo.userId ne owner}">
				<span class="infoTag" style="color:blue">${dataInfo.userId}</span>
			</c:if>
		</c:if>
				<span class="infoTag"><span>상태:</span>
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
				</span>
		<c:if test="${!empty dataInfo.dataType}">
			<span class="infoTag"><span>타입:</span>${dataInfo.dataType}</span>
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