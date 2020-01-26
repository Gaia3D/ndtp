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
<!-- 		<button type="button" class="mapPolicy" id="mapPolicy" title="지도 설정">지도 설정</button> -->
	</div>
	<div class="index">
		<button type="button" class="magoSet" id="mapPolicy" title="Mago3D 설정">Mago3D</button>
	</div>
</div>
<div class="labelLayer" style="display:none;">
    <div class="layerHeader">
        <h3>Mago3D 설정</h3>
        <button type="button" class="layerClose" title="닫기">닫기</button>
    </div>
    <div class="layerContents">
    	<ul class="category">
    		<li>객체정보</li>
    	</ul>
			<input type="radio" id="datainfoDisplayY" name="datainfoDisplay" value="true"/>
			<label for="datainfoDisplayY">표시</label>
			<input type="radio" id="datainfoDisplayN" name="datainfoDisplay" value="false" checked/>
			<label for="datainfoDisplayN">비표시</label>
		<ul class="category">
    		<li>Origin</li>
    	</ul>
			<input type="radio" id="originDisplayY" name="originDisplay" value="true"/>
			<label for="originDisplayY">표시</label>
			<input type="radio" id="originDisplayN" name="originDisplay" value="false" checked/>
			<label for="originDisplayN">비표시</label>
		<ul class="category">
    		<li>Bounding Box</li>
    	</ul>
	    	<input type="radio" id="bboxDisplayY" name="bboxDisplay" value="true"/>
			<label for="bboxDisplayY">표시</label>
			<input type="radio" id="bboxDisplayN" name="bboxDisplay" value="false" checked/>
			<label for="bboxDisplayN">비표시</label>
		<ul class="category">
    		<li>선택 및 이동</li>
    	</ul>
	    	<input type="radio" id="objectNoneMove" name="objectMoveMode" value="2" checked/>
			<label for="objectNoneMove">None</label>
			<input type="radio" id="objectAllMove" name="objectMoveMode" value="0"/>
			<label for="objectAllMove">All</label>
			<input type="radio" id="objectMove" name="objectMoveMode" value="1"/>
			<label for="objectMove">Object</label>
		<div id="dataControllWrap" style="display:none;">
			<h3>mipo blockA</h3>
			<ul class="category">
	    		<li>색상 변경</li>
	    	</ul>
		    	<label for="dcColorPicker">색상</label>
		    	<input type="color" id="dcColorPicker"/>
		    	<input type="text" id="dcColorInput" value="#000000" size="6" readonly/>
		    	<button type="button" id="dcColorApply" class="btnTextF">적용</button>
		    	<button type="button" id="dcColorCancle" class="btnText">되돌리기</button>
		    <ul class="category">
	    		<li>위치 변경</li>
	    	</ul>
	    		<label for="dcLongitude">위도</label>
		    	<input type="text" id="dcLongitude" readonly/><br/>
		    	<label for="dcLatitude" >경도</label>
		    	<input type="text" id="dcLatitude" readonly/><br/>
		    	<label for="dcAltitude" >높이</label>
		    	<input type="text" id="dcAltitude" readonly/>
		    	<button id="dcAltUp" data-type="up" type="button" style="height:26px;width:28px;background-image:url(/images/ko/black_arrow_26.png);"></button>
		    	<button id="dcAltDown" data-type="down" type="button" style="height:26px;width:28px;background-image:url(/images/ko/black_arrow_26.png);transform: rotate(180deg);"></button>
		    	<label for="dcAltitude" >높이 offset</label>
		    	<input type="text" id="dcAltitudeOffset" value="1" size="1"/>
		    <ul class="category">
	    		<li>회전 변경</li>
	    	</ul>
	    		<label for="dcPitch">x(pitch)</label>
		    	<input type="text" id="dcPitch" size="1" readonly/><input id="dcPitchRange" data-type="Pitch" style="margin-left: 5px;width: 200px;" type="range" min="-360" max="360" step="1" value="1"/><br/>
		    	<label for="dcRoll">y(roll)</label>
		    	<input type="text" id="dcRoll" size="1" readonly/><input id="dcRollRange" data-type="Roll" style="margin-left: 5px;width: 200px;" type="range" min="-360" max="360" step="1" value="1"/><br/>
		    	<label for="dcHeading">z(heading)</label>
		    	<input type="text" id="dcHeading" size="1" readonly/><input id="dcHeadingRange" data-type="Heading" style="margin-left: 5px;width: 200px;" type="range" min="-360" max="360" step="1" value="1"/>
		    	<button type="button" id="dcSavePosRot" class="btnTextF" style="display: block;margin-top: 8px;">높이회전 저장</button>
	    </div>
    </div>
</div>