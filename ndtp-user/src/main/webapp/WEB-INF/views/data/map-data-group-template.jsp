<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script id="templateDataGroupList" type="text/x-handlebars-template">
	<div>
		<span><spring:message code='all.d'/> <span class="totalCount">{{formatNumber pagination.totalCount}}</span> <spring:message code='search.what.count'/></span>
		<span class="float-right">{{formatNumber pagination.pageNo}} / {{formatNumber pagination.lastPage}} <spring:message code='search.page'/></span>
	</div>
	<div class="dataGroupSummary table-data-group-summary table-font-small yScroll" style="height:100%">
		<table class="table-word-break" summary="데이터 그룹 목록 테이블">
		<caption class="hiddenTag">데이터 그룹 목록</caption>
			<colgroup>
				<col class="col-width-12" />
				<col class="col-width-22" />
				<col />
				<col class="col-width-27" />
				<col class="col-width-27" />
			</colgroup>
			<tbody>
{{#greaterThan dataGroupList.length 0}}
	{{#each dataGroupList}}
				<tr class="space-top">
					<th>번호</th>
					<th>공유 유형</th>
					<th colspan="3">그룹명</th>
				</tr>
				<tr>
					<td rowspan="3" class="space-bottom">{{subtract ../pagination.rowNumber @index}}</td>
					<td>
					{{#ifMatch sharing 'common'}}
						<span class="legend co mar0">C</span>
					{{/ifMatch}}
					{{#ifMatch sharing 'public'}}
						<span class="legend pu mar0">O</span>
					{{/ifMatch}}
					{{#ifMatch sharing 'private'}}
						<span class="legend pr mar0">P</span>
					{{/ifMatch}}
					{{#ifMatch sharing 'group'}}
						<span class="legend gr mar0">G</span>
					{{/ifMatch}}
					</td>
					<td colspan="3" class="ellipsis alignLeft" style="max-width:200px;">
					{{#ifMatch dataGroupTarget 'admin'}}
							[<span style="color:blue">관리자</span>]
					{{else}}
						{{#ifMatch userId ../owner}}
							<%-- [<span>{{userId}}</span>] --%>
						{{else}}
							[<span style="color:blue">{{userId}}</span>]
						{{/ifMatch}}
					{{/ifMatch}}
						<span onclick="detailDataGroup('/data-groups/{{dataGroupId}}');" class="link">{{dataGroupName}}</span>
						<%-- <a href="/data-groups/{{dataGroupId}}" onclick="detailDataGroup(this.href); return false;">
							{{dataGroupName}}
						</a> --%>
					</td>
				</tr>
				<tr>
					<th colspan="2">데이터 건수</th>
					<th>표시</th>
					<th>이동</th>
				</tr>
				<tr class="space-bottom">
					<td colspan="2">{{#formatNumber dataCount}}{{/formatNumber}}</td>
					<td>
					{{#if groupVisible}}
						<button type="button" title="표시" class="showHideButton show" data-group-id="{{dataGroupId}}">표시</button>
					{{else}}
						<button type="button" title="표시" class="showHideButton hide" data-group-id="{{dataGroupId}}">표시</button>
					{{/if}}
					</td>
					<td>
						<button type="button" title="바로가기" class="goto" onclick="flyToGroup('{{longitude}}', '{{latitude}}', '{{altitude}}', '2');">바로가기</button>
					</td>
				</tr>
	{{/each}}
{{else}}
				<tr>
					<td colspan="6" class="center">데이터 그룹이 존재하지 않습니다.</td>
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