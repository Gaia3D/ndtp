<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script id="templateDataGroupList" type="text/x-handlebars-template">	
	<h3 style="margin-top: 30px; margin-bottom: 10px;">
		<spring:message code='all.d'/> {{formatNumber pagination.totalCount}} <spring:message code='search.what.count'/>, 
		{{formatNumber pagination.pageNo}} / {{formatNumber pagination.lastPage}} <spring:message code='search.page'/>
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
{{#greaterThan dataGroupList.length 0}}
	{{#each dataGroupList}}		
				<tr style="height: 35px;">
					<td>{{subtract ../pagination.rowNumber @index}}</td>
					<td>
						{{dataGroupName}}
					</td>
					<td>
						{{sharing}}
					</td>
					<td>
						{{dataCount}}
					</td>
					<td>
						<button type="button" title="바로가기" class="goto" onclick="flyTo('{{longitude}}', '{{latitude}}', '{{altitude}}', '2');">바로가기</button>
					</td>					
				</tr>
	{{/each}}
{{else}}
				<tr>
					<td colspan="5" class="col-none">데이터 그룹이 존재하지 않습니다.</td>
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