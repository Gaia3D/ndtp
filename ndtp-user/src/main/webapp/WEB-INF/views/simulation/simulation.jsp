<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/simulation/simulationCityPlanRepot.jsp" %>
<ul class="listDrop">
	<li>
		<p>좌표 정보<span class="collapse-icon">icon</span></p>
		<div class="listContents" id="solarAnalysis">
			<ul class="analysisGroup">
				<li>
					<label for="">위도</label>
					<label id="monitorLon" for="">OO</label>
					<label for="">경도</label>
					<label id="monitorLat" for="">OO</label>
				</li>
				<li>
					<label for="">위치 정보 모니터링</label>
					<input id="locaMonitorChk" type="checkbox" class="btnText">
				</li>
			</ul>
		</div>
	</li>
	<li>
		<p>경관 분석(일조분석)<span class="collapse-icon">icon</span></p>
		<div class="listContents" id="solarAnalysis">
			<ul class="analysisGroup">
				<li style="display:none;">
					<label for="">관찰자 위치</label>
					<input class="" type="text" placeholder="" value=""/>
					<button type="button" class="btnText drawObserverPoint">위치지정</button>
				</li>
				<li>
					<label for="">날짜</label>
					<!-- <input class="" type="text" id="solayDatePicker" placeholder="" value=""/> -->
					 <div class="tui-datepicker-input tui-datetime-input tui-has-focus">
			            <input type="text" id="datepicker-input" aria-label="Date-Time">
			            <span class="tui-ico-date"></span>
			        </div>
			        <div id="solayDatePicker" style="margin-top: -1px;"></div>
				</li>
				<li class="btns">
					<button type="button" class="btnTextF execute" title="분석">분석</button>
					<button type="button" class="btnText reset" title="취소">취소</button>
				</li>
				<li>
					<label for="">카메라 위치</label>
					<button id="cameraLocaSave" type="button" class="btnText">카메라 위치 저장</button>
					
					<label for="">경관 리스트</label>
					<select id="camera_scene_list" name="searchDataStatus">
						<option value="none">선택안함</option>
					</select>
					<button id="cameraLocaMove" type="button" class="btnText">이동</button>
				</li>
			</ul>
		</div>
	</li>
	<li>
		<p>건설 공정<span class="collapse-icon">icon</span></p>
		<div class="listContents" id="constructionProcess">
			<ul class="analysisGroup">
				<li>
					<span style="display: inline-block;padding: 3px 0;margin-right: 20px;">위치</span>
					<!-- <input class="" type="text" placeholder="" value=""/>
					<button type="button" class="btnText drawObserverPoint">찾기</button> -->
					<label style="width:26px;" for="cpSejong">세종</label>
					<input style="width:20px;" type="radio" id="cpSejong" name="cpProtoArea" value="s" checked/>
					<label style="width:26px;" for="cpBusan">부산</label>
					<input style="width:20px;" type="radio" id="cpBusan"  name="cpProtoArea" value="p"/>
				</li>

				<li class="btns">
					<button type="button" class="btnTextF execute" title="공정 조회">조회</button>
					<button type="button" class="btnText reset" title="취소">취소</button>
				</li>
				<li class="profileInfo" style="display:none;cursor: default;">
					<div class="legend">
						<div class="geostats-legend">
							<div class="geostats-legend-title">Legend</div>
							<div class="level" data-level="1" style="width: 80px;display: inline-block;">
								<div class="geostats-legend-block" style="background-color:#e60800"></div>
								<span class="geostats-legend-counter" style="font-size: 1em;">1단계</span>
							</div>
							<div class="level" data-level="2" style="width: 80px;display: inline-block;">
								<div class="geostats-legend-block" style="background-color:#ff641c"></div>
								<span class="geostats-legend-counter" style="font-size: 1em;">2단계</span>
							</div>
							<div class="level" data-level="3" style="width: 80px;display: inline-block;">
								<div class="geostats-legend-block" style="background-color:#8d1e4d"></div>
								<span class="geostats-legend-counter" style="font-size: 1em;">3단계</span>
							</div>
							<div class="level" data-level="4" style="width: 80px;display: inline-block;">
								<div class="geostats-legend-block" style="background-color:#7d2c79"></div>
								<span class="geostats-legend-counter" style="font-size: 1em;">4단계</span>
							</div>
							<div class="level" data-level="5" style="width: 80px;display: inline-block;">
								<div class="geostats-legend-block" style="background-color:#ffd009"></div>
								<span class="geostats-legend-counter" style="font-size: 1em;">5단계</span>
							</div>
							<div class="level" data-level="6" style="width: 80px;display: inline-block;">
								<div class="geostats-legend-block" style="background-color:#00a9b6"></div>
								<span class="geostats-legend-counter" style="font-size: 1em;">6단계</span>
							</div>
						</div>
					</div>
				</li>
			</ul>
		</div>
	</li>
	<li class="on">
		<p>도시 계획<span class="collapse-icon">icon</span></p>
		<div class="listContents" id="constructionProcess">
			<ul class="analysisGroup">
				<li>
					<iframe name="dummyframe" id="dummyframe" style="display: none;"></iframe>
					<form id="file_upload" name="file_upload"method="post" enctype="multipart/form-data" action="simulation-rest/upload" style="width:100%" target="dummyframe">
						<input type="file" name="files" style="width:100%" multiple>
						<button id="upload_cityplan" type="submit" class="btnTextF" title="업로드">업로드</button>
						<button id="run_cityplan" type="button" class="btnTextF" title="가시화">가시화</button>
						<button id="move_cityplan" type="button" class="btnTextF" title="가시화" style='display:none'>이동</button>
					</form>
				</li>
				<li>
					<label for="">대상 면적</label>
					<input id="target_area_input" class="" type="number" placeholder="" value="0"/>
					<label for="">기준 용적률</label>
					<input id="target_floor_cov" class="" type="number" placeholder="" value="0"/>
					<label for="">기준 건폐율</label>
					<input id="target_build_cov" class="" type="number" placeholder="" value="0"/>
					<button id="set_target_area" type="button" class="btnText drawObserverPoint">면적 설정</button>
				</li>
				<li>
					<label id="targetfloorCoverateRatio" for="">기준 용적율 00%</label>
					<label id="floorCoverateRatio" for="">용적률 00%</label>
					<label id="targetbuildCoverateRatio" for="">기준 건폐율 00%</label>
					<label id="buildCoverateRatio" for="">건폐율 00%</label>
				</li>
				<li>
					<label for="">작업 선택</label>
					<select id="run_work_state" name="searchDataStatus">
						<option value="">선택안함</option>
						<option value="imsiBuildSelect">건물 선택 모드</option>
						<option value="imsiBuild">임시 건물 배치 모드</option>
						<option value="autoBuild">자동 건물 배치 모드</option>
						<option value="location">경관 좌표 배치 모드</option>
					</select>
				</li>
				<li>
					<button id="result_build" type="button" class="btnText drawObserverPoint">결과 산출</button>
				</li>
			</ul>
		</div>
	</li>    
</ul>
<div id="selectBuildDialog" title="건물 층수 설정">
	<label for="">건물 층수</label>
	<input id="height_building_input" class="" type="number" placeholder="" value="0"/>
	<button id="set_height_building" type="button" class="btnText drawObserverPoint">설정</button>
</div>