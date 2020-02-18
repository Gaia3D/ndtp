<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="civilVoiceListContent" class="contents mar0 pad0 border-none" style="display:block;">
	<div class="button-group-align marB10">
		<h3 class="h3-heading">시민참여</h3>
		<button type="button" id="civilVoiceInputButton" title="의견등록" class="btnTextF right-align">의견 등록</button>
	</div>

	<!-- 시민참여 검색 -->
	<form:form id="civilVoiceSearchForm" modelAttribute="civilVoice" method="get" onsubmit="return false;">
	<div class="listSearch search-margin flex-align-center">
		<input type="text" id="getCivilVoiceListTitle" name="title" maxlength="256" placeholder="검색어를 입력하세요.">
		<button type="button" id="civilVoiceSearch" class="btnTotalSearch" title="검색">검색</button>
	</div>
	</form:form>

	<div class="bothSide">
		<div><spring:message code='all'/> <span id="civilVoiceTotalCount">0</span> <spring:message code='search.what.count'/></div>
		<div><span id="civilVoiceCurrentPage">0</span> / <span id="civilVoiceLastPage">0</span> <spring:message code='search.page'/></div>
	</div>

	<ul id="civilVoiceList" class="commentWrap"></ul>
	<ul id="civilVoicePagination" class="pagination"></ul>

</div>
<!-- E: 시민참여 목록 -->
<%@ include file="/WEB-INF/views/civil-voice/detail.jsp" %>
<%@ include file="/WEB-INF/views/civil-voice/input.jsp" %>
<%@ include file="/WEB-INF/views/civil-voice/modify.jsp" %>

<script id="templateCivilVoiceList" type="text/x-handlebars-template">
	{{#if civilVoiceList}}
		{{#each civilVoiceList}}
			<li class="comment flex-align-center" data-id="{{civilVoiceId}}" title="상세보기">
				<p class="count" style=""><span class="likes-icon">icon</span>{{commentCount}}</p>
				<p>
					<span class="title">{{title}}</span>
					<span class="id">{{userId}}</span>
				</p>
				<button type="button" class="goto" data-longitude={{longitude}} data-latitude={{latitude}} style="width:30px; margin-right:10px;" title="위치보기">위치보기</button>
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
