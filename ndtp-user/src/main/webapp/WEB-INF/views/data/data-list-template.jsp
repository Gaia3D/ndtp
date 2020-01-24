<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script id="templateDataList" type="text/x-handlebars-template">	
	<h3 style="margin-top: 30px; margin-bottom: 10px;">
		<spring:message code='all.d'/> {{formatNumber pagination.totalCount}} <spring:message code='search.what.count'/>, 
		{{formatNumber pagination.pageNo}} / {{formatNumber pagination.lastPage}} <spring:message code='search.page'/>
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
{{#greaterThan dataList.length 0}}
	{{#each dataList}}		
				<tr style="height: 35px;">
					<td rowspan="2" style="vertical-align: middle; text-align: center; padding: 0px;">{{subtract ../pagination.rowNumber @index}}</td>
					<td colspan="3" style="vertical-align: middle; text-align: left; padding: 0px 0px 0px 5px;">
						<a href="#" onclick="detailDataInfo('{{dataId}}'); return false;">{{dataName}}</a> [{{dataType}}]
					</td>
				</tr>
				<tr style="height: 35px;">
					<td style="padding: 0px; vertical-align: middle; text-align: left; padding: 0px 0px 0px 5px;">{{dataGroupName}}</td>
					<td style="padding: 0px; vertical-align: middle; ">
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
					<td style="padding: 0px; vertical-align: middle; ">
						<button type="button" title="바로가기" class="goto" style="margin: 0px; padding: 0px;" 	
							onclick="flyTo('{{longitude}}', '{{latitude}}', '{{altitude}}', '2');">바로가기</button></td>
				</tr>
	{{/each}}
{{else}}
				<tr>
					<td colspan="4" class="col-none">데이터가 존재하지 않습니다.</td>
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