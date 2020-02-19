<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script id="templateDistrictSearchResult" type="text/x-handlebars-template">
<li id="districtList" class="on">
	<p>행정구역<span>총 {{totalCount}} 건</span></p>
		<ul id="districtSearchList" class="yScroll">
		{{#if districtList}}
			{{#each districtList}}
				<li>
					<span>{{name}}</span>
					<button type="button" onclick="gotoFly({{longitude}}, {{latitude}}, 300, 2)" title="위치이동" class="goto">위치이동</button>
				</li>
			{{/each}}
		{{else}}
			<li>
				검색 결과가 없습니다.
			</li>
		{{/if}}
		</ul>
</li>
</script>