<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- S: 시민참여 의견 등록 -->
<div id="civilVoiceInputContent" class="contents mar0 pad0 border-none" style="display:none;">
	<div class="button-group-align marB10">
		<h3 class="h3-heading">시민참여 의견등록</h3>
		<button type="button" id="civilVoiceCancleButton" data-goto="list" class="btnText right-align reset" title="취소">취소</button>
	</div>

	<form:form id="civilVoiceForm" modelAttribute="civilVoice" method="post" onsubmit="return false;">
		<ul class="commentNew">
			<li>
				<label for="">제목 <span style="color: red;">*</span></label>
				<input type="text" name="title" style="width:94%;" maxlength="256">
				<!-- <p class="info"><span>256</span>자 / 256자 이내</p> -->
 				<p class="info">256자 이내</p>
			</li>
			<li>
				<label for="">위치 <span style="color: red;">*</span></label>
				<input type="text" name="longitude" style="width:30%;">
				<input type="text" name="latitude" style="width:30%;">
				<button type="button" id="civilVoiceLocation" onClick="civilVoice.getGeographicCoord();" class="basicA" title="위치지정">위치지정</button>
			</li>
			<li>
				<label for="contents">내용 <span style="color: red;">*</span></label>
				<textarea id="contents" name="contents" cols="47" rows="10"></textarea>
			</li>
			<li class="form-group button-group-center">
				<button id="civilVoiceCreateButton" onClick="saveCivilVoice();" class="btnTextF" title="등록" style="width: 200px;">등록</button>
				<!-- <button id="civilVoiceCancleButton" class="focusC" title="취소">취소</button> -->
			</li>
		</ul>
	</form:form>
</div>
<!-- E: 시민참여 의견 등록 -->
