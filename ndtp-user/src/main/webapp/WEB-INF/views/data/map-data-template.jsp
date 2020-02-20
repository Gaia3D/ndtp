<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script id="templateDataList" type="text/x-handlebars-template">
	<div>
		<span><spring:message code='all.d'/> <span>{{formatNumber pagination.totalCount}}</span> <spring:message code='search.what.count'/></span>
		<span class="float-right">{{formatNumber pagination.pageNo}} / {{formatNumber pagination.lastPage}} <spring:message code='search.page'/></span>
	</div>
	<div class="dataBtns"></div>

		<div class="marT10 yScroll" style="height: calc(100% - 59px)">
		
{{#greaterThan dataList.length 0}}
	{{#each dataList}}
		<ul class="dataList">
			<li class="group">
				<span class="no">{{subtract ../pagination.rowNumber @index}}</span>
		{{#ifMatch sharing 'common'}}
				<span class="legend co">C</span>	
		{{/ifMatch}}
		{{#ifMatch sharing 'public'}}
				<span class="legend pu">O</span>
		{{/ifMatch}}
		{{#ifMatch sharing 'private'}}
				<span class="legend pr">P</span>
		{{/ifMatch}}
		{{#ifMatch sharing 'group'}}
				<span class="legend gr">G</span>
		{{/ifMatch}}
				<span class="tag">그룹명</span>{{dataGroupName}}
			</li>
			<li class="dataName">
				<a href="#" onclick="detailDataInfo('{{dataId}}'); return false;">{{dataName}}</a>
			</li>
			<li class="dataInfo">

			{{#ifMatch dataGroupTarget 'admin'}}
				<span class="infoTag" style="color:blue">관리자</span>
			{{else}}
				{{#ifMatch userId ../owner}}
				<%-- <span class="infoTag">{{userId}}</span>  --%>
				{{else}}
				<span class="infoTag" style="color:blue">{{userId}}</span>
				{{/ifMatch}}
			{{/ifMatch}}
				<span class="infoTag marR5"><span>상태:</span>
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
				</span>

		{{#greaterThan dataType.length 0}}
				<span class="infoTag marR5"><span>타입:</span>{{dataType}}</span>
		{{/greaterThan}}

			</li>
			<li class="btn">
				<button type="button" title="표시" class="showHideButton show" data-group-id="{{dataGroupId}}" data-key="{{dataKey}}">표시</button>
		{{#if tiling}}
						<button type="button" title="바로가기" class="goto" style="margin: 0px; padding: 0px;"
							onclick="gotoFly('{{longitude}}', '{{latitude}}', '{{altitude}}');">바로가기</button>
		{{else}}
						<button type="button" title="바로가기" class="goto" style="margin: 0px; padding: 0px;" 	onclick="flyTo('{{dataGroupId}}', '{{dataKey}}');">바로가기</button>
		{{/if}}
			</li>
		</ul>
	{{/each}}
{{else}}
			데이터가 존재하지 않습니다.
{{/greaterThan}}
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