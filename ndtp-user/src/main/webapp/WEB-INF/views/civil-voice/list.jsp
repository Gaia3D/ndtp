<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="civilVoiceListContent" class="contents" style="display:block;">
	<h3 class="h3-margin">시민참여</h3>

	<!-- 시민참여 검색 -->
	<div class="listSearch search-margin flex-align-center">
		<input type="text" id="searchCivilVoiceTitle" name="searchCivilVoiceTitle" placeholder="검색어를 입력하세요.">
		<button type="button" id="civilVoiceSearch" class="btnTotalSearch" title="검색">검색</button>
	</div>

	<div class="bothSide">
		<div>전체 <span class="civilVoiceTotalCount">0</span>건</div>
		<div></div>
	</div>

	<ul id="civilVoiceList" class="commentWrap"></ul>

	<ul class="pagination">
		<li class="ico first" title="맨앞으로">처음</li>
		<li class="ico forward" title="앞으로">앞으로</li>
		<li>1</li>
		<li>2</li>
		<li>3</li>
		<li class="on">4</li>
		<li>5</li>
		<li>6</li>
		<li class="ico back" title="뒤로">뒤로</li>
		<li class="ico end" title="맨뒤로">마지막</li>
	</ul>

	<div class="form-group button-group-top-center">
		<button type="button" id="civilVoiceInputButton" title="의견등록" class="btnTextF">의견 등록</button>
	</div>
</div>
<!-- E: 시민참여 목록 -->
<%@ include file="/WEB-INF/views/civil-voice/detail.jsp" %>
<%@ include file="/WEB-INF/views/civil-voice/input.jsp" %>
<%@ include file="/WEB-INF/views/civil-voice/modify.jsp" %>

<script id="templateCivilVoiceList" type="text/x-handlebars-template">
	{{#if this}}
		{{#each this}}
			<li class="comment flex-align-center">
				<p>
					<span class="title">{{title}}</span>
					<span class="id">{{userId}}</span>
				</p>
         	   <p class="count">{{viewCount}}</p>
			</li>
		{{/each}}
	{{else}}
		<li class="none">등록된 글이 없습니다.</li>
	{{/if}}
</script>
<!-- <span class="likes-icon">icon</span> -->