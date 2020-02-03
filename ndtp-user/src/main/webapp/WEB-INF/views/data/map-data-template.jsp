<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script id="templateDataList" type="text/x-handlebars-template">
	<div>
		<span><spring:message code='all.d'/> {{formatNumber pagination.totalCount}} <spring:message code='search.what.count'/></span>
		<span class="float-right">{{formatNumber pagination.pageNo}} / {{formatNumber pagination.lastPage}} <spring:message code='search.page'/></span>
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
{{#greaterThan dataList.length 0}}
	{{#each dataList}}
				<tr>
					<td rowspan="2">{{subtract ../pagination.rowNumber @index}}</td>
					<td colspan="3" class="ellipsis" style="max-width:260px;">
						<a href="#" onclick="detailDataInfo('{{dataId}}'); return false;">{{dataName}}</a> [{{dataType}}]
					</td>
				</tr>
				<tr>
					<td class="ellipsis" style="max-width:100px;">{{dataGroupName}}</td>
					<td>
		{{#ifMatch status 'processing'}}
						변환중
		{{/ifMatch}}
		{{#ifMatch status 'use'}}
						사용중
		{{/ifMatch}}
		{{#ifMatch status 'unused'}}
						사용중지
		{{/ifMatch}}
		{{#ifMatch status 'delete'}}
						삭제
		{{/ifMatch}}
					</td>
					<td>
						<button type="button" title="바로가기" class="goto" style="margin: 0px; padding: 0px;"
							onclick="flyTo('{{dataGroupId}}', '{{dataKey}}');">바로가기</button></td>
				</tr>
	{{/each}}
{{else}}
				<tr>
					<td colspan="4" class="center">데이터가 존재하지 않습니다.</td>
				</tr>
{{/greaterThan}}
			</tbody>
		</table>
	</div>

{{#greaterThan pagination.totalCount 0}}
	<ul class="pagination">
		<li class="ico first" onclick="pagingDataInfoList({{pagination.firstPage}}, '{{pagination.searchParameters}}');">처음</li>
	{{#if pagination.existPrePage}}
		<li class="ico forward" onclick="pagingDataInfoList({{pagination.prePageNo}}, '{{pagination.searchParameters}}');">앞으로</li>
	{{/if}}

	{{#forEachStep pagination.startPage pagination.endPage 1}}
		{{#numberEqual this ../pagination.pageNo}}
			<li class="on" >{{this}}</li>
		{{else}}
			<li onclick="pagingDataInfoList({{this}}, '{{../pagination.searchParameters}}');">{{this}}</li>
		{{/numberEqual}}
	{{/forEachStep}}

	{{#if pagination.existNextPage}}
		<li class="ico back" onclick="pagingDataInfoList({{pagination.nextPageNo}}, '{{pagination.searchParameters}}');">뒤로</li>
	{{/if}}
		<li class="ico end"  onclick="pagingDataInfoList({{pagination.lastPage}}, '{{pagination.searchParameters}}');">마지막</li>
	</ul>
{{/greaterThan}}
</script>