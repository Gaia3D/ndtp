<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="ctrlWrap">
	<div class="zoom">
		<button type="button" class="reset" id="mapCtrlReset" title="초기화">초기화</button>
		<button type="button" class="zoomall" title="전체보기">전체보기</button>
		<button type="button" class="zoomin" id="mapCtrlZoomIn" title="확대">확대</button>
		<button type="button" class="zoomout" id="mapCtrlZoomOut" title="축소">축소</button>
		<button type="button" class="measures distance" id="mapCtrlDistance" data-type="LineString" title="거리">거리</button>
		<button type="button" class="measures area" id="mapCtrlArea" data-type="Polygon" title="면적">면적</button>
	</div>
	<div class="rotate"> 
		<button type="button" class="rotateReset on" id="rotateReset" title="방향초기화">방향 초기화</button>
		<!-- <input type="text" placeholder="0" id="rotateInput"/>&deg; --> 
		<input type="text" id="rotateInput" placeholder="0" readonly>&deg;
        <input type="text" id="pitchInput" placeholder="-90" readonly>&deg;
		<button type="button" class="rotateLeft" id="rotateLeft" title="왼쪽으로 회전">왼쪽으로 회전</button>
		<button type="button" class="rotateRight" id="rotateRight" title="오른쪽으로 회전">오른쪽으로 회전</button>
	</div>
</div>