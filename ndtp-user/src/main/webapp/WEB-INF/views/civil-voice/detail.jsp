<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- S: 시민참여 의견 -->
<div id="civilVoiceDetailContent" class="contents mar0 pad0 border-none" style="display:none;">
	<div class="commentView">
		<div style="margin-bottom: 15px;">
			<input type="hidden" id="civilVoiceId" value=""/>
			<span class="title"  id="civilVoiceTitle"></span>
			<!-- TODO: 본인 글에만 수정 버튼 -->
			<span class="modify" id="civilVoiceUpdateButton">수정</span>
		</div>
		<div class="con" id="civilVoiceContents"></div>
	</div>

	<p class="agreeCount">동의 <span id="civilVoiceCommentTotalCount">10</span> 건</p>
	<div class="agreeNew">
		<input type="text" placeholder="동의합니다">
		<button class="focusAgree" title="동의">동의</button>
	</div>
	<ul id="civilVoiceComment" class="agreeWrap"></ul>
	<ul id="civilVoiceCommentPagination" class="pagination"></ul>

	<div class="form-group button-group-top-center">
		<button type="button" id="civilVoiceListButton" title="목록" class="btnTextF">목록</button>
	</div>
</div>
<!-- E: 시민참여 의견 -->

<script id="templateCivilVoiceComment" type="text/x-handlebars-template">
	{{#if civilVoiceCommentList}}
		{{#each civilVoiceCommentList}}
			<li>
				<p class="agree">
					<span class="likes-icon">icon</span>
					{{title}}
					<span class="id">{{userId}}</span>
				</p>
			</li>
		{{/each}}
	{{/if}}
</script>

<script id="templateCivilVoiceCommentPagination" type="text/x-handlebars-template">
	{{#if pagination.totalCount}}
    	<ul class="pagination">
    	{{#if pagination.existPrePage}}
       	 	<li class="ico first" onClick="getCivilVoiceCommentList({{pagination.firstPage}});"></li>
        	<li class="ico forward" onClick="getCivilVoiceCommentList({{pagination.prePageNo}});"></li>
    	{{/if}}

    	{{#forEachStep pagination.startPage pagination.endPage 1}}
        	{{#if (indexCompare this ../pagination.pageNo)}}
           		<li class="on"><a href='#'>{{this}}</a></li>
        	{{else}}
         		<li onClick="getCivilVoiceCommentList({{this}});"><a href='#'>{{this}}</a></li>
        	{{/if}}
    	{{/forEachStep}}

    	{{#if pagination.existNextPage}}
        	<li class="ico back" onClick="getCivilVoiceCommentList({{pagination.nextPageNo}});"></li>
        	<li class="ico end" onClick="getCivilVoiceCommentList({{pagination.lastPage}});"></li>
    	{{/if}}
    	</ul>
	{{/if}}
</script>