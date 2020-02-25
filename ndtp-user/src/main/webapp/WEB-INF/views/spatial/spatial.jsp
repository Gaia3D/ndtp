<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<ul class="listDrop">
	<li class="on">
		<p>방사형 가시성 분석<span class="collapse-icon">icon</span></p>
		<div class="listContents" id="analysisRadialLineOfSight">
			<ul class="analysisGroup">
				<li>
					<label for="radialLineDataType">분석 자료</label>
					<select id="radialLineDataType" class="dataType">
						<option value="DEM" selected>DEM (DEM)</option>
						<option value="DSM">DSM (DSM)</option>
						<!-- <option value="DSM">DSM (DSM)</option> -->
					</select>
				</li>
				<li>
					<label for="rlosOffset">관찰 높이 (m)</label>
					<input id="rlosOffset" class="observerOffset" type="text" placeholder="" value="1.7" title="지표로부터 관측자 지점의 높이">
				</li>
				<li>
					<label for="rlosRadius">반경 (m)</label>
					<input id="rlosRadius" class="radius" type="text" placeholder="" value="100" title="관찰자 지점으로부터의 가시선 분석 수행 반경. 단위는 m">
				</li>
				<li>
					<label for="rlosSidex">선분 수 (number)</label>
					<input id="rlosSidex" class="sides" type="text" placeholder="" value="90" title="방사형 가시선의 수">
				</li>
				<li>
					<label for="radialLineObserverPoint">관찰자 위치</label>
					<input type="text" id="radialLineObserverPoint" placeholder="" class="withBtn observerPointMGRS" disabled>
					<input type="hidden" class="observerPoint">
					<button type="button" class="btnText drawObserverPoint" data-draw-type="POINT">위치지정</button>
				</li>
				<li class="btns">
					<button type="button" class="btnTextF execute" title="방사형 가시성 분석">분석</button>
					<button type="button" class="btnText reset" title="취소">취소</button>
				</li>
			</ul>
		</div>
	</li>
	<li>
		<p>가시선 분석<span class="collapse-icon">icon</span></p>
		<div class="listContents" id="analysisLinearLineOfSight">
			<ul class="analysisGroup">
				<li>
					<label for="linearLineDataType">분석 자료</label>
					<select id="linearLineDataType" class="dataType">
						<option value="DEM" selected>DEM (DEM)</option>
						<option value="DSM">DSM (DSM)</option>
					</select>
				</li>
				<li>
					<label for="llosOffsete">관찰 높이 (m)</label>
					<input id="llosOffsete" class="observerOffset" type="text" placeholder="" value="1.7" title="지표로부터 관측자 지점의 높이">
				</li>
				<li>
					<label for="linearLineObserverPoint">관찰 위치</label>
					<input type="text" id="linearLineObserverPoint" placeholder="" class="withBtn observerPointMGRS" disabled>
					<input type="hidden" class="observerPoint">
					<button type="button" class="btnText drawObserverPoint" data-draw-type="POINT">위치지정</button>
				</li>
				<li>
					<label for="linearLineTargetPoint">대상 위치</label>
					<input type="text" id="linearLineTargetPoint" placeholder="" class="withBtn targetPointMGRS" disabled>
					<input type="hidden" class="targetPoint">
					<button type="button" class="btnText drawTargetPoint" data-draw-type="POINT">위치지정</button>
				</li>
				<li class="btns">
					<button type="button" class="btnTextF execute" title="가시선 분석">분석</button>
					<button type="button" class="btnText reset" title="취소">취소</button>
				</li>
			</ul>
		</div>
	</li>
	<li>
		<p>지형 단면 분석<span class="collapse-icon">icon</span></p>
		<div class="listContents" id="analysisRasterProfile">
			<ul class="analysisGroup">
				<li>
					<label for="RasterProfileDataType">분석 자료</label>
					<select id="RasterProfileDataType" class="dataType">
						<option value="DEM" selected>DEM (DEM)</option>
						<option value="DSM">DSM (DSM)</option>
					</select>
				</li>
				<li>
					<label for="rpInterval">간격 (number)</label>
					<input id="rpInterval" class="interval" type="text" placeholder="" value="20">
				</li>
				<li>
					<label for="RasterProfileDrawUserLine">사용자 입력 선분</label>
					<button type="button" id="RasterProfileDrawUserLine" class="btnText drawUserLine" data-draw-type="LINE">위치지정</button>
					<input type="hidden" class="userLine">
					<div class="coordsText"></div>
				</li>
				<li class="btns">
					<button type="button" class="btnTextF execute" title="지형 단면 분석">분석</button>
					<button type="button" class="btnText reset" title="취소">취소</button>
				</li>

				<li class="profileInfo">
					<div class="legend"></div>
				</li>
			</ul>
		</div>
	</li>
	<li id="analysisRasterHighLowPointsList">
		<p>지형 최고/최저 점<span class="collapse-icon">icon</span></p>
		<div class="listContents" id="analysisRasterHighLowPoints">
			<ul class="analysisGroup">
				<li>
					<label for="rasterHighLowPointsDataType">분석 자료</label>
					<select id="rasterHighLowPointsDataType" class="dataType">
						<option value="DEM" selected>DEM (DEM)</option>
						<option value="DSM">DSM (DSM)</option>
					</select>
				</li>
				<li>
					<label for="rasterHighLowPointsAreaType">면적 타입</label>
					<select id="rasterHighLowPointsAreaType" class="areaType">
						<option value="useArea">사용자 영역</option>
						<option value="extent">현재 지도 영역</option>
					</select>
				</li>
				<li class="wrapCropShape">
					<label for="rasterHighLowPointsDrawCropShape">영역 그리기</label>
					<input type="hidden" class="cropShape">
					<button type="button" id="rasterHighLowPointsDrawCropShape" class="btnText drawCropShape" data-draw-type="POLYGON">위치지정</button>
				</li>
				<li class="extentInfo" style="display:none;">
					<span style="color:red;"> - 지도 영역 선택 시, 지도가 2D모드로 전환됩니다.</span>
				</li>
				<li>
					<label for="rasterHighLowPointsValueType">최고/최저</label>
					<select id="rasterHighLowPointsValueType" class="valueType">
						<option value="High">최고</option>
						<option value="Low">최저</option>
					</select>
				</li>
				<li class="btns">
					<input type="hidden" class="wcsExtent">
					<button type="button" class="btnTextF execute" title="지형 최고/최저 점 분석">분석</button>
					<button type="button" class="btnText reset" title="취소">취소</button>
				</li>
			</ul>
		</div>
	</li>
	<li>
		<p>위험 돔 분석<span class="collapse-icon">icon</span></p>
		<div class="listContents" id="analysisRangeDome">
			<ul class="analysisGroup">
				<li>
					<label for="rdRadius">반경 (m)</label>
					<input id="rdRadius" class="radius" type="text" placeholder="" value="1000">
				</li>
				<li>
					<label for="rangeDomeObserverPoint">관찰 위치</label>
					<input type="text" id="rangeDomeObserverPoint" placeholder="" class="withBtn observerPointMGRS" disabled>
					<input type="hidden" class="observerPoint">
					<button type="button" class="btnText drawObserverPoint" data-draw-type="POINT">위치지정</button>
				</li>
				<li class="btns">
					<button type="button" class="btnTextF execute" title="위험 돔 분석 실행">분석</button>
					<button type="button" class="btnText reset" title="취소">취소</button>
				</li>
			</ul>
		</div>
	</li>
</ul>