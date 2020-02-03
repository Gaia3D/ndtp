<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script id="templateDistrictSearchResult" type="text/x-handlebars-template">
<li id="districtList" class="on list-drop-button-none">
	<p>행정구역<span> {{totalCount}}건</span></p>
		<ul id="districtSearchList">
		{{#if districtList}}
			{{#each districtList}}
				<li>
					<span>
					<button type="button" class="btnTextF button-right-margin" onclick="gotoFly({{longitude}}, {{latitude}}, 300, 2)">바로가기</button>
					{{name}}
					</span>
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