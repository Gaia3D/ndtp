<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script id="templateDataList" type="text/x-handlebars-template">	
		<h3 style="margin-top: 30px; margin-bottom: 10px;">
			<spring:message code='all.d'/> <fmt:formatNumber value="0" type="number"/> <spring:message code='search.what.count'/>, 
			<fmt:formatNumber value="3333" type="number"/> / <fmt:formatNumber value="44444" type="number"/> <spring:message code='search.page'/>
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
			{{#each dataList}}		
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
			{{/each}}
		</c:if>
				</tbody>
			</table>
		</div>
		
	<!--
	<c:if test="${!empty dataList }">
		<c:if test="${pagination.totalCount > 0}">			
			<ul class="pagination">
				<li class="ico first" onclick="location.href='${pagination.uri }?pageNo=${pagination.firstPage }${pagination.searchParameters}'">처음</li>
		<c:if test="${pagination.existPrePage == 'true' }">
				<li class="ico forward" onclick="location.href='${pagination.uri }?pageNo=${pagination.prePageNo }${pagination.searchParameters}'">앞으로</li>
		</c:if>
						
		<c:forEach var="pageIndex" begin="${pagination.startPage }" end="${pagination.endPage }" step="1">
			<c:if test="${pageIndex == pagination.pageNo }">
				<li class="on" >${pageIndex }</li>
			</c:if>
			<c:if test="${pageIndex != pagination.pageNo }">
				<li onclick="location.href='${pagination.uri }?pageNo=${pageIndex }${pagination.searchParameters}'">${pageIndex }</li>
			</c:if>
		</c:forEach>
		
		<c:if test="${pagination.existNextPage == 'true' }">
				<li class="ico back" onclick="location.href='${pagination.uri }?pageNo=${pagination.nextPageNo }${pagination.searchParameters}'">뒤로</li>
		</c:if>		
				<li class="ico end"  onclick="location.href='${pagination.uri }?pageNo=${pagination.lastPage }${pagination.searchParameters}'">마지막</li>
			</ul>
		</c:if>
	</c:if>
-->
</script>