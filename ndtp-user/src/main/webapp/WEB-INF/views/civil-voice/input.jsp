<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- S: 시민참여 의견 등록 -->
<div id="civilVoiceInputContent" class="contents mar0 pad0 border-none" style="display:none;">
	<h3 class="h3-heading">시민참여 의견등록</h3>
	<form:form id="civilVoiceForm" modelAttribute="civilVoice" method="post" onsubmit="return false;">
		<ul class="commentNew">
			<li>
				<label for="">제목</label>
				<input type="text" name="title" style="width:94%;" maxlength="256">
				<!-- <p class="info"><span>256</span>자 / 256자 이내</p> -->
 				<p class="info">256자 이내</p>
			</li>
			<li>
				<label for="">위치</label>
				<input type="text" name="longitude" style="width:30%;">
				<input type="text" name="latitude" style="width:30%;">
				<button type="button" id="civilVoiceLocation" class="basicA" title="위치지정">위치지정</button>
			</li>
			<li>
				<label for="contents">내용</label>
				<textarea name="contents" id="contents" cols="46" rows="10"></textarea>
			</li>
			<li class="btnCenter">
				<button id="civilVoiceCreateButton" class="focusA" title="등록" style="width: 200px;">등록</button>
				<button id="civilVoiceCancleButton" class="focusC" title="취소">취소</button>
			</li>
		</ul>
	</form:form>
</div>
<!-- E: 시민참여 의견 등록 -->
