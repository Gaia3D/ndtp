<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="civilVoiceListContent" class="contents mar0 pad0 border-none" style="display:block;">
	<h3 class="h3-margin">시민참여</h3>

	<!-- 시민참여 검색 -->
	<div class="listSearch search-margin flex-align-center">
		<input type="text" id="getCivilVoiceListTitle" name="getCivilVoiceListTitle" placeholder="검색어를 입력하세요.">
		<button type="button" id="civilVoiceSearch" class="btnTotalSearch" title="검색">검색</button>
	</div>

	<div class="bothSide">
		<div><spring:message code='all'/> <span id="civilVoiceTotalCount">0</span> <spring:message code='search.what.count'/></div>
		<div><span id="civilVoiceCurrentPage">0</span> / <span id="civilVoiceLastPage">0</span> <spring:message code='search.page'/></div>
	</div>

	<ul id="civilVoiceList" class="commentWrap"></ul>
	<ul id="civilVoicePagination" class="pagination"></ul>

	<div class="form-group button-group-top-center">
		<button type="button" id="civilVoiceInputButton" title="의견등록" class="btnTextF">의견 등록</button>
	</div>
</div>
<!-- E: 시민참여 목록 -->
<%@ include file="/WEB-INF/views/civil-voice/detail.jsp" %>
<%@ include file="/WEB-INF/views/civil-voice/input.jsp" %>
<%@ include file="/WEB-INF/views/civil-voice/modify.jsp" %>

<script id="templateCivilVoiceList" type="text/x-handlebars-template">
	{{#if civilVoiceList}}
		{{#each civilVoiceList}}
			<li class="comment flex-align-center" data-id="{{civilVoiceId}}">
				<p>
					<span class="title">{{title}}</span>
					<span class="id">{{userId}}</span>
				</p>
         	   <p class="count">{{commentCount}}</p>
			</li>
		{{/each}}
	{{else}}
		<li class="none">등록된 글이 없습니다.</li>
	{{/if}}
</script>

<script id="templateCivilVoicePagination" type="text/x-handlebars-template">
	{{#if pagination.totalCount}}
    	<ul class="pagination">
    	{{#if pagination.existPrePage}}
       	 	<li class="ico first" onClick="getCivilVoiceList({{pagination.firstPage}});"></li>
        	<li class="ico forward" onClick="getCivilVoiceList({{pagination.prePageNo}});"></li>
    	{{/if}}

    	{{#forEachStep pagination.startPage pagination.endPage 1}}
        	{{#if (indexCompare this ../pagination.pageNo)}}
           		<li class="on"><a href='#'>{{this}}</a></li>
        	{{else}}
         		<li onClick="getCivilVoiceList({{this}});"><a href='#'>{{this}}</a></li>
        	{{/if}}
    	{{/forEachStep}}

    	{{#if pagination.existNextPage}}
        	<li class="ico back" onClick="getCivilVoiceList({{pagination.nextPageNo}});"></li>
        	<li class="ico end" onClick="getCivilVoiceList({{pagination.lastPage}});"></li>
    	{{/if}}
    	</ul>
	{{/if}}
</script>

<!-- <span class="likes-icon">icon</span> -->