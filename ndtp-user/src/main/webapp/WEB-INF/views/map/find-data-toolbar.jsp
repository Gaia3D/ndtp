<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="ctrlWrap">
	<div class="zoom">
		<button type="button" id="mapCtrlReset" class="reset" title="초기화">초기화</button>
		<button type="button" id="mapCtrlAll" class="zoomall" title="전체보기">전체보기</button>
		<button type="button" id="mapCtrlZoomIn" class="zoomin" title="확대">확대</button>
		<button type="button" id="mapCtrlZoomOut" class="zoomout" title="축소">축소</button>
		<button type="button" id="mapCtrlDistance" class="measures distance" data-type="LineString" title="거리">거리</button>
		<button type="button" id="mapCtrlArea" class="measures area" data-type="Polygon" title="면적">면적</button>
		<button type="button" id="mapCapture" class="save" data-type="" title="저장">저장</button>
	</div>
	<div class="rotate">
		<button type="button" class="rotateReset on" id="rotateReset" title="방향초기화"></button>
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
<div id="mago3DSettingLabelLayer" class="labelLayer" style="display:none;">
    <div class="layerHeader">
        <h3 class="ellipsis" style="max-width:260px;">Mago3D 설정</h3>
        <button type="button" class="layerClose" title="닫기">닫기</button>
    </div>
    <div class="layerContents">
		<div id="datainfoDisplay" class="layerDiv marT0">
			<h4 class="category">객체정보</h4>
			<input type="radio" id="datainfoDisplayY" name="datainfoDisplay" value="true">
			<label for="datainfoDisplayY">표시</label>
			<input type="radio" id="datainfoDisplayN" name="datainfoDisplay" value="false" checked>
			<label for="datainfoDisplayN">비표시</label>
		</div>

		<div class="layerDiv">
			<h4 class="category">Origin</h4>
			<input type="radio" id="originDisplayY" name="originDisplay" value="true">
			<label for="originDisplayY">표시</label>
			<input type="radio" id="originDisplayN" name="originDisplay" value="false" checked>
			<label for="originDisplayN">비표시</label>
		</div>

		<div class="layerDiv">
			<h4 class="category">Bounding Box</h4>
			<input type="radio" id="bboxDisplayY" name="bboxDisplay" value="true">
			<label for="bboxDisplayY">표시</label>
			<input type="radio" id="bboxDisplayN" name="bboxDisplay" value="false" checked>
			<label for="bboxDisplayN">비표시</label>
		</div>

		<div class="layerDiv">
			<h4 class="category">선택 및 이동</h4>
			<input type="radio" id="objectNoneMove" name="objectMoveMode" value="2" checked>
			<label for="objectNoneMove">None</label>
			<input type="radio" id="objectAllMove" name="objectMoveMode" value="0">
			<label for="objectAllMove">All</label>
			<input type="radio" id="objectMove" name="objectMoveMode" value="1">
			<label for="objectMove">Object</label>
		</div>

		<div id="dataControllWrap" style="display:none;">
			<p class="layerDivTit">선택된 데이터 :  <span>test / 오전반1조_행복관_s</span></p>
			<div class="layerDiv">
				<h4 class="category">색상 변경</h4>
				<ul>
					<li>
						<label for="dcColorPicker">색상</label>
						<input type="color" id="dcColorPicker">
						<input type="text" id="dcColorInput" value="#000000" size="6" readonly style="color: rgb(0, 0, 0);">
						<button type="button" id="dcColorApply" class="btnTextF">적용</button>
						<button type="button" id="dcColorCancle" class="btnText">되돌리기</button>
					</li>
				</ul>
			</div>
			<form id="dcRotLocForm" class="layerDiv marB0">
				<input type="hidden" name="dataId" value="${dataInfo.dataId}" />
				<h4 class="category">위치 변경</h4>
				<ul class="layerDiv">
					<li>
						<label for="dcLongitude">경도</label>
						<input type="text" id="dcLongitude" name="longitude" readonly>
					</li>
					<li>
						<label for="dcLatitude">위도</label>
						<input type="text" id="dcLatitude" name="latitude" readonly>
					</li>
					<li>
						<label for="dcAltitude">높이</label>
						<input type="text" id="dcAltitude" name="altitude" size="10" readonly>
						<button id="dcAltUp" data-type="up" type="button" class="up"></button>
						<button id="dcAltDown" data-type="down" type="button" class="down"></button>
						<label for="dcAltitudeOffset" style="width: 40px;">offset</label>
						<input type="text" id="dcAltitudeOffset" value="1" size="1">
					</li>
				</ul>

				<h4 class="category">회전 변경</h4>
				<ul class="layerDiv">
					<li>
						<label for="dcPitch">x(pitch)</label>
						<input type="text" id="dcPitch" name="pitch" size="2" readonly>
						<button type="button" class="dcRangeBtn rangePrev" data-type="prev" id="rcPitchPrev"></button>
						<input id="dcPitchRange" data-type="Pitch" style="width: 140px;" type="range" min="-360" max="360" step="1" value="1">
						<button type="button" class="dcRangeBtn rangeNext" data-type="next" id="rcPitchNext"></button>
					</li>

					<li>
						<label for="dcRoll">y(roll)</label>
						<input type="text" id="dcRoll" name="roll" size="2" readonly>
						<button type="button" class="dcRangeBtn rangePrev" data-type="prev" id="rcRollPrev"></button>
						<input id="dcRollRange" data-type="Roll" style="width: 140px;" type="range" min="-360" max="360" step="1" value="1">
						<button type="button" class="dcRangeBtn rangeNext" data-type="next" id="rcRollNext"></button>
					</li>

					<li>
						<label for="dcHeading">z(heading)</label>
						<input type="text" id="dcHeading" name="heading" size="2" readonly>
						<button type="button" class="dcRangeBtn rangePrev" data-type="prev" id="rcHeadingPrev"></button>
						<input id="dcHeadingRange" data-type="Heading" style="width: 140px;" type="range" min="-360" max="360" step="1" value="1">
						<button type="button" class="dcRangeBtn rangeNext" data-type="next" id="rcHeadingNext"></button>
					</li>
				</ul>

				<div>
					<c:if test="${dataInfo.dataGroupTarget eq 'admin'}">
						<button type="button" id="dcSavePosRotReqPop" class="btnTextF" 
								title="<spring:message code='data.transform.save.request'/>">
								<spring:message code='data.transform.save.request'/>
						</button>
					</c:if>
					<c:if test="${dataInfo.dataGroupTarget eq 'user'}">
						<c:if test="${dataInfo.userId eq owner}">
							<button type="button" id="dcSavePosRotPop" class="btnTextF" 
									title="<spring:message code='data.transform.save'/>">
								<spring:message code='data.transform.save'/>
							</button>
						</c:if>
						<c:if test="${dataInfo.userId ne owner}">
							<button type="button" id="dcSavePosRotReqPop" class="btnTextF" 
									title="<spring:message code='data.transform.save.request'/>">
									<spring:message code='data.transform.save.request'/>
							</button>	
						</c:if>
					</c:if>
					<button type="button" id="dcShowAttr" class="btnTextF">속성조회</button>
				</div>
			</form>
		</div>
	</div>
</div>