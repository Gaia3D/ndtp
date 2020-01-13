<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<ul class="listDrop">
	<li class="on">
		<p>경관 분석(일조분석)</p>
		<div class="listContents" id="">
			<ul class="analysisGroup">
				<li>
					<label for="">관찰자 위치</label>
					<input class="" type="text" placeholder="" value=""/>
					<button type="button" class="btnText drawObserverPoint">위치지정</button>
				</li>
				<li>
					<label for="">날짜</label>
					<input class="" type="text" placeholder="" value=""/>
				</li>
				<li class="btns">
					<button type="button" class="btnTextF execute" title="분석">분석</button>
					<button type="button" class="btnText reset" title="취소">취소</button>
				</li>
			</ul>
		</div>
	</li>
	<li>
		<p>건설 공정</p>
		<div class="listContents" id="">
			<ul class="analysisGroup">
				<li>
					<label for="">데이터그룹</label>
					<input class="" type="text" placeholder="" value=""/>
					<button type="button" class="btnText drawObserverPoint">찾기</button>
				</li>
				
				<li class="btns">
					<button type="button" class="btnTextF execute" title="공정 조회">조회</button>
					<button type="button" class="btnText reset" title="취소">취소</button>
				</li>
			</ul>
		</div>
	</li>
</ul>