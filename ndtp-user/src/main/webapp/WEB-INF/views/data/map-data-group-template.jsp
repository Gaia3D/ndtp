<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script id="templateDataGroupList" type="text/x-handlebars-template">
	<div>
		<span><spring:message code='all.d'/> {{formatNumber pagination.totalCount}} <spring:message code='search.what.count'/></span>
		<span class="float-right">{{formatNumber pagination.pageNo}} / {{formatNumber pagination.lastPage}} <spring:message code='search.page'/></span>
	</div>
	<div class="dataGroupSummary table-data-group-summary table-font-small">
		<table class="table-word-break">
			<colgroup>
				<col class="col-width-12" />
				<col />
				<col class="col-width-19" />
				<col class="col-width-17" />
				<col class="col-width-12" />
			</colgroup>
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
{{#greaterThan dataGroupList.length 0}}
	{{#each dataGroupList}}
				<tr>
					<td>{{subtract ../pagination.rowNumber @index}}</td>
					<td class="ellipsis" style="max-width:100px;">
						{{#ifMatch dataGroupTarget 'admin'}}
							[관리자]
						{{else}}
							{{#ifMatch userId ../owner}}
								[본인]
							{{else}}
								[다른 사용자]
							{{/ifMatch}}
						{{/ifMatch}}
						<a href="#" onclick="detailDataGroup('{{dataGroupId}}'); return false;">
							{{dataGroupName}}
						</a>
					</td>
					<td>
						{{sharing}}
					</td>
					<td>
						{{dataCount}}
					</td>
					<td>
						<button type="button" title="바로가기" class="goto" onclick="flyToGroup('{{longitude}}', '{{latitude}}', '{{altitude}}', '2');">바로가기</button>
					</td>
				</tr>
	{{/each}}
{{else}}
				<tr>
					<td colspan="5" class="center">데이터 그룹이 존재하지 않습니다.</td>
				</tr>
{{/greaterThan}}
			</tbody>
		</table>
	</div>

{{#greaterThan pagination.totalCount 0}}
	<ul class="pagination">
		<li class="ico first" onclick="pagingDataGroupList({{pagination.firstPage}}, '{{pagination.searchParameters}}');">처음</li>
	{{#if pagination.existPrePage}}
		<li class="ico forward" onclick="pagingDataGroupList({{pagination.prePageNo}}, '{{pagination.searchParameters}}');">앞으로</li>
	{{/if}}

	{{#forEachStep pagination.startPage pagination.endPage 1}}
		{{#numberEqual this ../pagination.pageNo}}
			<li class="on" >{{this}}</li>
		{{else}}
			<li onclick="pagingDataGroupList({{this}}, '{{../pagination.searchParameters}}');">{{this}}</li>
		{{/numberEqual}}
	{{/forEachStep}}

	{{#if pagination.existNextPage}}
		<li class="ico back" onclick="pagingDataGroupList({{pagination.nextPageNo}}, '{{pagination.searchParameters}}');">뒤로</li>
	{{/if}}
		<li class="ico end"  onclick="pagingDataGroupList({{pagination.lastPage}}, '{{pagination.searchParameters}}');">마지막</li>
	</ul>
{{/greaterThan}}
</script>