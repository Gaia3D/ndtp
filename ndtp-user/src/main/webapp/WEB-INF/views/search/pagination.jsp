<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script id="templateDynamicPagination" type="text/x-handlebars-template">
{{#if pagination.totalCount}}
    <ul class="pagination">
    {{#if pagination.existPrePage}}
        <li class="ico first" onClick="districtSearch(1);"></li>
        <li class="ico forward" onClick="districtSearch({{pagination.prePageNo}});"></li>
    {{/if}}

    {{#each pagination.pageList}}
        {{#if (indexCompare this ../pagination.pageNo)}}
            <li class="on"><a href='#'>{{this}}</a></li>
        {{else}}
            <li onClick="districtSearch({{this}});"><a href='#'>{{this}}</a></li>
        {{/if}}
    {{/each}}

    {{#if pagination.existNextPage}}
        <li class="ico back" onClick="districtSearch({{pagination.nextPageNo}});"></li>
        <li class="ico end" onClick="districtSearch({{pagination.lastPage}});"></li>
    {{/if}}
    </ul>
{{/if}}
</script>