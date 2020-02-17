<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script id="templateCivilVoiceComment" type="text/x-handlebars-template">
	{{#if civilVoiceCommentList}}
		{{#each civilVoiceCommentList}}
			<li>
				<p class="user">{{userId}}</p>
					{{title}}
				<span class="date">{{insertData}}</span>
				<div class="btns">
					<button type="button" class="">수정</button>
					<button type="button" class="">삭제</button>
				</div>
			</li>
		{{/each}}
	{{/if}}
</script>

<script id="templateCivilVoiceCommentPagination" type="text/x-handlebars-template">
	{{#if pagination.totalCount}}
		<div class="pagination">
			<a href="#" onClick="getCivilVoiceCommentList({{pagination.firstPage}});" class="first"><span class="icon-glyph glyph-first"></span></a>
    	{{#if pagination.existPrePage}}
			<a href="#" onClick="getCivilVoiceCommentList({{pagination.prePageNo}});" class="prev"><span class="icon-glyph glyph-prev"></span></a>
    	{{/if}}

    	{{#forEachStep pagination.startPage pagination.endPage 1}}
        	{{#if (indexCompare this ../pagination.pageNo)}}
			<a href="#" class="current-page">{{this}}</a>
        	{{else}}
			<a href="#" onClick="getCivilVoiceCommentList({{this}});">{{this}}</a>
        	{{/if}}
    	{{/forEachStep}}

			<a href="#" onClick="getCivilVoiceCommentList({{pagination.nextPageNo}});" class="next"><span class="icon-glyph glyph-next"></span></a>
    	{{#if pagination.existNextPage}}
			<a href="#" onClick="getCivilVoiceCommentList({{pagination.lastPage}});" class="last"><span class="icon-glyph glyph-last"></span></a>
    	{{/if}}
    	</div>
   	{{/if}}
</script>
