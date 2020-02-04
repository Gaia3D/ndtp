<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="civilVoiceListContent" class="contents" style="display:block;">
	<h3 class="h3-margin">시민참여</h3>
<!-- 데이터 검색 -->
	<div class="listSearch search-margin flex-align-center">
		<input type="text" placeholder="검색어를 입력하세요.">
		<button type="button" class="btnTotalSearch" title="검색">검색</button>
	</div>

	<div class="bothSide flex-align-center">
		<div>
			전체
			<span>78</span> 건
		</div>
		<div>
			<button type="button" id="civilVoiceInputButton" title="의견등록" class="focusA padding-7">의견등록</button>
		</div>
	</div>

	<ul id="civilVoiceList" class="comment">
		<li class="flex-align-center">
			<p>
				이 구간에 과속하는 차량이 많습니다
				<span class="id">pororo178</span>
			</p>
			<p class="count"><span class="likes-icon">icon</span>123</p>
		</li>
		<li class="flex-align-center">
			<p>
				이 구간에 과속하는 차량이 많습니다 글자수가 넘치면 이렇게 됩니다.
				<span class="id">pororo178</span>
			</p>
			<p class="count"><span class="likes-icon">icon</span>1,234</p>
		</li>
		<li class="flex-align-center">
			<p>
				이 구간에 과속하는 차량이 많습니다
				<span class="id"><span class="likes-icon">icon</span>pororo178</span>
			</p>
			<p class="count"><span class="likes-icon">icon</span>123</p>
		</li>
		<li class="flex-align-center">
			<p>
				이 구간에 과속하는 차량이 많습니다
				<span class="id">pororo178</span>
			</p>
			<p class="count"><span class="likes-icon">icon</span>123</p>
		</li>
		<li class="flex-align-center">
			<p>
				이 구간에 과속하는 차량이 많습니다
				<span class="id">pororo178</span>
			</p>
			<p class="count"><span class="likes-icon">icon</span>123</p>
		</li>
		<li class="flex-align-center">
			<p>
				이 구간에 과속하는 차량이 많습니다
				<span class="id">pororo178</span>
			</p>
			<p class="count"><span class="likes-icon">icon</span>123</p>
		</li>
		<li class="flex-align-center">
			<p>
				이 구간에 과속하는 차량이 많습니다
				<span class="id">pororo178</span>
			</p>
			<p class="count"><span class="likes-icon">icon</span>123</p>
		</li>
		<li class="flex-align-center">
			<p>
				이 구간에 과속하는 차량이 많습니다
				<span class="id">pororo178</span>
			</p>
			<p class="count"><span class="likes-icon">icon</span>123</p>
		</li>
		<li class="flex-align-center">
			<p>
				이 구간에 과속하는 차량이 많습니다
				<span class="id">pororo178</span>
			</p>
			<p class="count"><span class="likes-icon">icon</span>123</p>
		</li>
		<li class="flex-align-center">
			<p>
				이 구간에 과속하는 차량이 많습니다
				<span class="id">pororo178</span>
			</p>
			<p class="count"><span class="likes-icon">icon</span>123</p>
		</li>
		<li class="flex-align-center">
			<p>
				이 구간에 과속하는 차량이 많습니다
				<span class="id">pororo178</span>
			</p>
			<p class="count"><span class="likes-icon">icon</span>123</p>
		</li>
		<li class="flex-align-center">
			<p>
				이 구간에 과속하는 차량이 많습니다
				<span class="id">pororo178</span>
			</p>
			<p class="count"><span class="likes-icon">icon</span>123</p>
		</li>
		<li class="flex-align-center">
			<p>
				이 구간에 과속하는 차량이 많습니다
				<span class="id">pororo178</span>
			</p>
			<p class="count"><span class="likes-icon">icon</span>123</p>
		</li>
	</ul>

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
</div>
<!-- E: 시민참여 목록 -->
<%@ include file="/WEB-INF/views/civil-voice/detail.jsp" %>
<%@ include file="/WEB-INF/views/civil-voice/input.jsp" %>
<%@ include file="/WEB-INF/views/civil-voice/modify.jsp" %>
