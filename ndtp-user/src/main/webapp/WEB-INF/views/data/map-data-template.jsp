<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script id="templateDataList" type="text/x-handlebars-template">
	<div>
		<span><spring:message code='all.d'/> <span class="totalCount">{{formatNumber pagination.totalCount}}</span> <spring:message code='search.what.count'/></span>
		<span class="float-right">{{formatNumber pagination.pageNo}} / {{formatNumber pagination.lastPage}} <spring:message code='search.page'/></span>
		<input type="hidden" name="pageNo" value="{{pagination.pageNo}}">
	</div>
	<div class="dataBtns"></div>
		<div class="tableList marT10 yScroll" style="height: calc(100% - 43px)">
			<table summary="데이터 리스트 테이블">
			<caption class="hiddenTag">데이터 목록</caption>
				<colgroup>
					<col class="col-width-12" />
					<col class="col-width-12" />
					<col />
					<col class="col-width-12" />
					<col class="col-width-12" />
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>공유 유형</th>
						<th>데이터명</th>
						<th>표시</th>
						<th>이동</th>
					</tr>
				</thead>
				<tbody>
{{#greaterThan dataList.length 0}}
	{{#each dataList}}
					<tr>
						<td rowspan="2"><span class="no">{{subtract ../pagination.rowNumber @index}}</span></td>
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
						<td class="alignLeft ellipsis" style="max-width:100px;">
							<span onclick="detailDataInfo('/datas/{{dataId}}');" class="link">{{dataName}}</span>
<%--
							<a href="/datas/{{dataId}}" onclick="detailDataInfo(this.href); return false;">{{dataName}}</a>
--%>
						</td>
						<td>
		{{#if groupVisible}}
							<button type="button" title="표시" class="showHideButton show" data-group-id="{{dataGroupId}}" data-key="{{dataKey}}" data-tiling="{{tiling}}">표시</button>
		{{else}}
							<button type="button" title="표시" class="showHideButton hide" data-group-id="{{dataGroupId}}" data-key="{{dataKey}}" data-tiling="{{tiling}}">표시</button>
		{{/if}}
						</td>
						<td>
		{{#if tiling}}
						<button type="button" title="바로가기" class="goto" style="margin: 0px; padding: 0px;"
							onclick="gotoFly('{{longitude}}', '{{latitude}}', '{{altitude}}');">바로가기</button>
		{{else}}
						<button type="button" title="바로가기" class="goto" style="margin: 0px; padding: 0px;" 	onclick="flyTo('{{dataGroupId}}', '{{dataKey}}');">바로가기</button>
		{{/if}}
						</td>
					</tr>
					<tr>
						<td class="alignLeft" colspan="4">
							<span class="infoTag ellipsis"><span>그룹명: </span>{{dataGroupName}}</span>
			{{#ifMatch dataGroupTarget 'admin'}}
				<span class="infoTag" style="color:blue">관리자</span>
			{{else}}
				{{#ifMatch userId ../owner}}
				<%-- <span class="infoTag">{{userId}}</span>  --%>
				{{else}}
				<span class="infoTag" style="color:blue">{{userId}}</span>
				{{/ifMatch}}
			{{/ifMatch}}
				<span class="infoTag"><span>상태:</span>
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
				<span class="infoTag"><span>타입:</span>{{dataType}}</span>
		{{/greaterThan}}
						</td>
					</tr>
	{{/each}}
{{else}}
			<tr><td colspan="5" style="height: 30px;">데이터가 존재하지 않습니다.</td></tr>
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