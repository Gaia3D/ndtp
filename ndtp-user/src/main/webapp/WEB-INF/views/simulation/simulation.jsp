<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/simulation/simulationCityPlanRepot.jsp" %>
<script src="/externlib/amchart/core.js"></script>
<script src="/externlib/amchart/charts.js"></script>
<script src="/externlib/amchart/themes/animated.js"></script>
<script src="/externlib/amchart/themes/material.js"></script>
<script src="/externlib/amchart/lang/de_DE.js"></script>
<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<style>
	#smulationToolbar .line {
		width: 90%;
		height: 0;
		border: 0.5px solid #C4C4C4;
		margin-bottom: 6px;
		display:block;
	}
	/* Tooltip container */
	.tooltip {
		position: relative;
		display: inline-block;
		border-bottom: 1px dotted black; /* If you want dots under the hoverable text */
	}

	/* Tooltip text */
	.tooltip .tooltiptext {
		visibility: hidden;
		width: 120px;
		background-color: black;
		color: #fff;
		text-align: center;
		padding: 5px 0;
		border-radius: 6px;

		/* Position the tooltip text - see examples below! */
		position: absolute;
		z-index: 1;
	}

	/* Show the tooltip text when you mouse over the tooltip container */
	.tooltip:hover .tooltiptext {
		visibility: visible;
	}
</style>

<ul class="listDrop">
	<li class="on">
		<p>좌표 정보<span class="collapse-icon">icon</span></p>
		<div class="listContents" id="solarAnalysis">
			<ul class="analysisGroup">
				<li>
					<label for="">위도</label>
					<label id="monitorLon" for="">OO</label>
					<label for="">경도</label>
					<label id="monitorLat" for="">OO</label>
					<label for="">높이</label>
					<label id="monitorHeight" for="">OO</label>
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
					<button id="sun_condition" type="button" class="btnTextF" style="float:left;">일조 조건</button>
					<button type="button" class="btnTextF execute" title="분석">분석</button>
					<button type="button" class="btnText reset" title="취소">취소</button>
				</li>
				<li>
					<label for="">카메라 위치</label>
					<button id="cameraLocaSave" type="button" class="btnText">카메라 위치 저장</button>
					
					<label for="">경관 리스트</label>
					<select id="camera_scene_list" name="searchDataStatus">
						<option value="none">선택안함</option>
						<option value=0>통경축 반영구간</option>
						<option value=1>에코델타 전망대</option>
						<option value=2>에코델타 1층</option>
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
					<button type="button" id="constUploadBtn" class="btnTextF">건설 공정 파일 업로드</button>
				</li>
				<li>
					<span style="display: inline-block;padding: 3px 0;margin-right: 20px;">위치</span>
					<select id="consBuildLoca" name="searchDataStatus">
						<option value="">선택안함</option>
						<option value="sa">세종 전체</option>
						<option value="s">세종 행복도시</option>
						<option value="p">델타루</option>
						<option value="b">56빌리지</option>
						<option value="g">금강 보행교</option>
					</select>
					<button type="button" id="processStatusCheck" class="btnTextF" style="float:right;">공정현황조회</button>
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
	<li style="display: none;">
		<p>도시 계획<span class="collapse-icon">icon</span></p>
		<div class="listContents" id="">
			<ul class="analysisGroup">
				<li>
					<iframe name="dummyframe" id="dummyframe" style="display: none;"></iframe>
					<form id="file_upload" name="file_upload"method="post" enctype="multipart/form-data" action="simulation-rest/upload" style="width:100%" target="dummyframe">
						<input type="file" name="files" style="width:100%" multiple>
						<button id="upload_cityplan" type="submit" class="btnTextF" title="업로드">업로드</button>
						<button id="run_cityplan" type="button" class="btnTextF" title="가시화">가시화</button>
						<button id="run_sample_raster" type="button" class="btnTextF" title="가시화">도시계획정보가시화</button>
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
			</ul>
		</div>
	</li>
	<li>
		<p>도시 계획<span class="collapse-icon">icon</span></p>
		<div class="listContents" id="">
			<ul class="analysisGroup">
				<li >
					<div id="smulationToolbar">
						<label for="">위치</label>
						<select id="curLocation" name="curLocation">
							<option value="sejong">세종시</option>
							<option value="pusan">부산시</option>
						</select>
						<label for="">필지 선택</label>
						<select id="selectPiece" name="selectPiece">
							<option value="">선택안함</option>
							<option value="sejong6_4">6-4 생활권</option>
							<option value="ecoDelta">에코델타시티</option>
						</select>
						<button type="button" id="deleteDistrict" class="btnText drawObserverPoint" style="margin-bottom: 5px;">필지 삭제</button>
						<div class="line"></div>

						<label for="">지역</label>
						<select id="selectDistrict" name="selectDistrict">
							<option value="">선택안함</option>
							<option value="sejong_apartmentComplex1">세종시 아파트단지</option>
							<option value="sejong_church1">세종시 교회</option>
							<option value="ecodelta_district">에코델타 지역</option>
						</select>
<%--						<input id="objectName" type="text" placeholder="" />--%>

						<label for="">지역 타입</label>
						<select id="districtType" name="districtType">
							<option value="">선택안함</option>
							<option value="dType1">제1종 일반주거지역</option>
							<option value="dType2">중심 상업지역</option>
							<option value="dType3">일반 공업지역</option>
							<option value="dType4">공동 주거지역</option>
						</select>

						<div class="line" style="margin-top:5px;"></div>
						<button type="button" id="create3dModel" class="btnText drawObserverPoint" style="">3D모형 생성</button>
						<button type="button" id="delete3dModel" class="btnText drawObserverPoint" style="margin-bottom: 5px; margin-right: 95px;">3D모형 삭제</button>


						<label for="">지역 전시</label>
						<select id="districtDisplay" name="districtDisplay">
							<option value="disable">Disable</option>
							<option value="enable">Enable</option>
						</select>
						<label for="">건물 그림자 생성</label>
						<select id="buildingShadow" name="buildingShadow">
							<option value="disable">Disable</option>
							<option value="enable">Enable</option>
						</select>

						<div class="line" style="margin-top:5px;"></div>

						<%--						<label for="">건물 전시</label>--%>
						<%--						<select id="buildingDisplay" name="buildingDisplay">--%>
						<%--							<option value="disable">Disable</option>--%>
						<%--							<option value="enable">Enable</option>--%>
<%--						</select>--%>

						<label for="">기준 용적률</label>
						<input id="standardFloorAreaRatio" type="number"  value="0" style="background-color: gainsboro;" readonly />
						<label for="">용적률</label>
						<input id="curFloorAreaRatio" type="number"  value="0" readonly />
						<label for="">기준 건폐율</label>
						<input id="standardBuildingToLandRatio" type="number" value="0" style="background-color: gainsboro;" readonly />
						<label for="">건폐율</label>
						<input id="curBuildingToLandRatio" type="number" value="0" readonly />
						<div class="line" style="margin-top:5px;"></div>

						<label for="">기준 층수</label>
						<input id="standardFloorCount" type="number" data-bind="value: standardFloorCount" style="background-color: gainsboro;" readonly />
						<label for="">층수</label>
						<input id="inputBuildingHeight" type="number" data-bind="value: buildingHeight" />
						<label for="">높이 커스터마이징</label>
						<input id="inputCustomizing" type="number" data-bind="value: buildingAdjust" />
						<%--						<button id="dd" type="button" class="btnText drawObserverPoint">면적 설정</button>--%>

						<label for="">라이브러리</label>
						<select id="objectSelect" name="">
							<option value="">선택안함</option>
							<option value="obj_select_mode">객체선택 모드</option>
							<option value="multi_select_mode">다중선택 모드</option>
							<option value="">------------</option>
							<option value="obj_lamp">가로등</option>
							<option value="obj_tree">나무</option>
							<option value="obj_tree2">나무2</option>
							<option value="obj_cone">교통 꼬깔콘</option>
							<option value="obj_bench">의자</option>
							<option value="obj_bus1">버스1</option>
							<option value="obj_bus2">버스2</option>
							<option value="obj_car1">자동차1</option>
							<option value="obj_car2">자동차2</option>
							<option value="obj_truck1">트럭1</option>
							<option value="obj_truck2">트럭2</option>
							<option value="maple_green">나무(green)</option>
							<option value="maple_light_green">나무(light_green)</option>
							<option value="maple_orange">나무(orange)</option>
							<option value="maple_red">나무(red)</option>
							<option value="maple_yellow">나무(yellow)</option>
							<option value="test123">가로등</option>
							<option value="building1">빌딩1</option>
							<option value="building2">빌딩2</option>
							<option value="building3">빌딩3</option>
							<option value="obj_stool">stool</option>
						</select>
					</div>
				</li>
				<li style="text-align: right;">
					<button id="sejong_lod1_buildings" type="button" class="btnTextF" style="float:left;" >세종시 도시 표출</button>
					<button id="result_build" type="button" class="btnTextF" >결과 산출</button>
				</li>
			</ul>
		</div>
	</li>
	<li>
		<p id="forEvent">건축인 허가 신청<span class="collapse-icon">icon</span></p>
		<div class="listContents" id="">
			<ul class="analysisGroup">
				<li id="addrSearchLi">
					<label for="addrSearch" style="width:50px;">주소: </label>
					<input id="addrSearch" type="text" style="width: 190px;" />
					<button type="button" id="addrSearchBtn" title="인허가 시뮬레이션" class="btnTextF" style="float: right; margin-top: 5px;">검색</button>
				</li>
				<li>
					<div>
						<label for="">처리 목록</label>
						<div style="display: flex; align-items: center; justify-content: space-between;">
							<select id="acceptBuildList" name="searchDataStatus" style="width:110px; ">
								<option value="">선택없음</option>
							</select>
							<div>
<%--								<button type="button" id="permView" title="인허가 시뮬레이션" class="btnTextF" style="">인허가 확인</button>--%>
								<button type="button" id="permRequest" title="건축인 허가 신청" class="btnTextF" style="">건축인 허가 신청</button>
								<button type="button" id="permView" title="인허가 시뮬레이션" class="btnTextF" style="">인허가 시뮬레이션</button>
								<button type="button" id="comment" class="btnTextF">대화</button>
							</div>
						</div>
					</div>
					<div>
						<label for="">완료 목록</label>
						<div style="display: flex; align-items: center; justify-content: space-between;">
							<select id="acceptCompleteBuildList" name="searchDataStatus" style="width:110px; ">
								<option value="">선택없음</option>
							</select>
							<button type="button" id="permCompleteView" title="인허가 시뮬레이션" class="btnTextF" style="width: 52%;">완료 인허가 확인</button>
						</div>
					</div>
<%--					<button type="button" id="testFly" class="btnTextF" style="margin-top:10px; /*display: none;*/">Fly Test</button>--%>
<%--					<button type="button" id="testingPicking" class="btnTextF" style="margin-top:10px;">testingPicking</button>--%>
					<button type="button" id="testBuilding" class="btnTextF" style="margin-top:10px; display:none;">testBuilding</button>
				</li>
			</ul>
		</div>
	</li>
	<li>
		<p id="forEvent">IoT 시뮬레이션<span class="collapse-icon">icon</span></p>
		<div class="listContents" id="">
			<ul class="analysisGroup">
				<li>
					<div>
						<label for="">종류</label>
						<div style="display: flex; align-items: center; justify-content: space-between;">
							<select id="iotList" name="iotDataStatus" style="width:150px; ">
								<option value="">선택없음</option>
								<option value="bus">자동차</option>
								<option value="drone">드론</option>
							</select>
						</div>
						<div style = "margin:5px">
							<button type="button" id="iotSimReq" title="Iot시뮬레이션" class="btnTextF" style="">등록</button>
							<button type="button" id="iotSimTrack" title="Iot시뮬레이션" class="btnTextF" style="">트랙킹</button>
				            <button type="button" id="iotsiminterval" title="Iot시뮬레이션" class="btnTextF" style="">실행</button>
						</div>
					</div>
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
<div id="constructionProcessUploadDialog" title="건설 공정 파일 업로드">
	<div class="listContents">
		<ul class="analysisGroup">
			<li>
				<form id="construc_proc_file_upload" name="file_upload" style="width:100%" target="dummyConsProcessFrame">
					<div>
						<label>위치</label>
						<select id="consBuildLocaModal" name="cityTypeString">
							<option value="">선택안함</option>
							<option value="sa">세종 전체</option>
							<option value="s">세종 행복도시</option>
							<option value="p">델타루</option>
							<option value="b">56빌리지</option>
							<option value="g">금강 보행교</option>
						</select>
					</div>
					<div>
						<label for="consRatio">단계 공정률</label>
						<input type="number" id="consRatio" name="consRatio" value="100"/>
					</div>
					<div>
						<label for="">업로드 시점 선택</label>
						<select id="consProcessType" name="consTypeString">
							<option value="">선택안함</option>
							<option value="0">1단계</option>
							<option value="1">2단계</option>
							<option value="2">3단계</option>
							<option value="3">4단계</option>
							<option value="4">5단계</option>
							<option value="5">6단계</option>
						</select>
					</div>
					<div>
						<input type="file" name="files" style="width:80%" multiple>
					</div>
				</form>
				<div style="margin-top:5px; float: right">
					<button id="upload_constructionProcess" class="btnTextF" style="margin-left:5px" title="업로드">업로드</button>
				</div>
			</li>
		</ul>
	</div>
</div>
<script>
	$("#addrSearchBtn").click(() => {
		let val = document.getElementById("addrSearch").value;
		if (val === "" ) {
			alert("주소를 먼저 입력해 주시기 바랍니다.");
			return;
		}
		const fileName = "6-4_field.geojson";
		createSpecificField(fileName);

		whole_viewer.scene.camera.flyTo({
			destination : Cesium.Cartesian3.fromDegrees(127.27372, 36.52424, 150)
		});

		addrSearchDialog.dialog("open");
	});

	$("#comment").on('click', function() {
		if (buildAcceptPermSeq === undefined || buildAcceptPermSeq === "") {
			alert("목록을 먼저 선택해 주시기 바랍니다.");
			return;
		}
		let commentData = {
			// todo: 클릭시 오브젝트에서 정보 가져와서 셋팅
			permSeq: buildAcceptPermSeq
		};
		$.ajax({
			url: "/data/simulation-rest/commentList",
			type: "POST",
			headers: {"X-Requested-With": "XMLHttpRequest"},
			data: commentData,
			dataType: "json",
			success: function(commentList){
				const commentListViewer = document.getElementById("commentListViewer");
				commentListViewer.setAttribute("objectName", commentData.objectName);
				const abc = document.getElementById("commentViewDialog");
				abc.setAttribute("title", "의견 교환창" + commentData.objectName);

				commentViewFunc(commentList);

				$("#commentContent").val("");
				commentViewDialog.dialog("open");
			},
			error:function(request,status,error) {
				console.log("err=", request, status, error);
			}
		});
	});

	$("#testBuilding").click(()=> {
		console.log("testBuilding");
		let urlParam = "/data/simulation-rest/cityPlanModelSelect";
		let lon = 126.92377563766438;
		let lat = 37.5241752651257;
		let height = 0.3;
		genBuild(urlParam, lon, lat, height);
	});
	var testingPickingDialog = $( "#testingPickingDialog" ).dialog({
		autoOpen: false,
		width: 1100,
		height: 750,
		modal: true,
		overflow : "auto",
		resizable: false
	});
	$("#testingPicking").on('click', function() {
		testingPickingDialog.dialog("open");
	});
	var testingDialog = $( "#testingDialog" ).dialog({
		autoOpen: false,
		width: 1100,
		height: 750,
		modal: true,
		overflow : "auto",
		resizable: false
	});
	$("#testFly").on('click', function() {
		testingDialog.dialog("open");
	});


	$("#permRequest").on('click', function() {
		let val = document.getElementById("addrSearch").value;
		if (val === "" ) {
			alert("주소를 먼저 입력해 주시기 바랍니다.");
			return;
		}
		permRequestDialog.dialog( "open" );
	});

	$("#permView").on('click', function() {
		if (buildAcceptPermSeq === undefined || buildAcceptPermSeq === "") {
			alert("처리 목록을 먼저 선택해 주시기 바랍니다.");
			return;
		}
		let data = {
			permSeq: buildAcceptPermSeq
		};
		// debugger
		$.ajax({
			url: "/data/simulation-rest/getPermRequestByConstructor",
			type: "POST",
			headers: {"X-Requested-With": "XMLHttpRequest"},
			data: data,
			dataType: "json",
			success: function(msg){
				console.log("getPermRequestByConstructor msg=", msg);
				$("#permViewDialog #constructor").get(0).value = msg.constructor;
				$("#permViewDialog #constructor_type").get(0).value = msg.constructorType;
				$("#permViewDialog #constructor_type").get(0).disabled = true;
				$("#permViewDialog #birthday").get(0).value = msg.birthday;
				$("#permViewDialog #license_num").get(0).value = msg.licenseNum;
				// $("#permViewDialog #phone_number").get(0).value = msg.phoneNumber;
				$("#permViewDialog #district_unit_plan").get(0).value = msg.saveFileName;

				$("#permViewDialog #longitude").get(0).value = msg.longitude;
				$("#permViewDialog #latitude").get(0).value = msg.latitude;
				$("#permViewDialog #altitude").get(0).value = msg.altitude;

				permViewDialog.dialog("open");
			},
			error:function(request,status,error) {
				alert('error');
				console.log("err=", request, status, error);
			}
		});
	});

	function getUserInfo() {
		$.ajax({
			url: "/data/simulation-rest/getUserInfo",
			type: "POST",
			headers: {"X-Requested-With": "XMLHttpRequest"},
			// data: "",
			// dataType: "json",
			success: function(msg){
				// $("#testBuilding").attr('style', "display:none;");
				if (msg === "admin" || msg === "supervisor" || msg === "admin2") {
					$("#permRequest").attr('style', "display:none;");
					$("#addrSearchLi").attr('style', "display:none;");
					// $("#testBuilding").trigger("click");
				} else {
					$("#permView").attr('style', "display:none;");
					$("#addrSearchLi").attr('style', "display:block;");
				}
			},
			error:function(request,status,error) {
				console.log("err=", request, status, error);
			}
		});
	}

	function genBuild(urlParam, lon, lat, scale) {
		let position = Cesium.Cartesian3.fromDegrees(lon, lat, 0);
		let pinBuilder = new Cesium.PinBuilder();
		let modelMatrix = Cesium.Transforms.eastNorthUpToFixedFrame(position);
		let carto_loc  = Cesium.Ellipsoid.WGS84.cartesianToCartographic(position);
		console.log("lon=", Cesium.Math.toDegrees(carto_loc.longitude), " lat=", Cesium.Math.toDegrees(carto_loc.latitude), " h=", carto_loc.height);

		let name = 'testObject';
		let model = whole_viewer.scene.primitives.add(Cesium.Model.fromGltf({
			url : urlParam,
			modelMatrix : modelMatrix,
			scale : scale,
			shadows : 1,
			id : name,
			name: name
		}));
		model.type = "accept";
		whole_viewer.scene.primitives.add(model);

		let cartesian3 = whole_viewer.scene.clampToHeight(position);
		let carto  = Cesium.Ellipsoid.WGS84.cartesianToCartographic(cartesian3);
		console.log("lon=", Cesium.Math.toDegrees(carto.longitude), " lat=", Cesium.Math.toDegrees(carto.latitude), " h=", carto.height);
		let entity = whole_viewer.entities.add({
			name : urlParam,
			billboard : {
				image : pinBuilder.fromText('!', Cesium.Color.BLACK, 48).toDataURL(),
				verticalOrigin: Cesium.VerticalOrigin.BOTTOM,
				eyeOffset: new Cesium.Cartesian3(0, carto.height + 20, 0)
			},
			position : cartesian3,
		});

		whole_viewer.trackedEntity = entity;

		let lon2 = Cesium.Math.toDegrees(carto.longitude);
		let lat2 = Cesium.Math.toDegrees(carto.latitude);
		console.log(lon2, lat2, carto.height);

		Cesium.when(model.readyPromise).then(function(model) {
	        $.growl.notice({
	            message: "파일등록이 완료되었습니다",
	            duration: 1000
	        });
		}).otherwise(function(error){
// 			window.alert(error);
		});
	}

	function commentViewFunc(commentList){
		const commentListViewer = document.getElementById("commentListViewer");

		commentListViewer.innerHTML = "";
		// console.log("commentList=", commentList);

		commentList.map((comment, idx) => {
			const li = document.createElement("li");
			li.setAttribute("class", "comment flex-align-center");
			li.setAttribute("commentSeq", comment.commentSeq);
			li.setAttribute("objectName", comment.objectName);
			li.setAttribute("commentTitle", comment.commentTitle);
			li.setAttribute("commentContent", comment.commentContent);

			const idSpan = document.createElement("span");
			idSpan.setAttribute("class", "id");
			idSpan.textContent = comment.writer + ":";
			const titleSpan = document.createElement("span");
			titleSpan.setAttribute("class", "title");
			titleSpan.textContent = comment.commentContent;
			// titleSpan.textContent = comment.commentTitle;
			const timeSpan = document.createElement("div");
			let writeDate = new Date(comment.applyDate);
			timeSpan.setAttribute("class", "commentTime");
			timeSpan.textContent = writeDate.format('yyyy-MM-dd(KS) HH:mm:ss');

			li.append(idSpan);
			li.append(titleSpan);
			commentListViewer.append(li);
			commentListViewer.append(timeSpan);
		});
	}

	function commentViewFunc2(commentList){
		const commentListViewer = document.getElementById("commentListViewer2");

		commentListViewer.innerHTML = "";
		// console.log("commentList=", commentList);

		commentList.map((comment, idx) => {
			const li = document.createElement("li");
			li.setAttribute("class", "comment flex-align-center");
			li.setAttribute("commentSeq", comment.commentSeq);
			li.setAttribute("objectName", comment.objectName);
			li.setAttribute("commentTitle", comment.commentTitle);
			li.setAttribute("commentContent", comment.commentContent);

			const idSpan = document.createElement("span");
			idSpan.setAttribute("class", "id");
			idSpan.textContent = comment.writer + ":";
			const titleSpan = document.createElement("span");
			titleSpan.setAttribute("class", "title");
			titleSpan.textContent = comment.commentContent;
			// titleSpan.textContent = comment.commentTitle;
			const timeSpan = document.createElement("div");
			let writeDate = new Date(comment.applyDate);
			timeSpan.setAttribute("class", "commentTime");
			timeSpan.textContent = writeDate.format('yyyy-MM-dd(KS) HH:mm:ss');

			li.append(idSpan);
			li.append(titleSpan);
			commentListViewer.append(li);
			commentListViewer.append(timeSpan);
		});
	}

	$("#forEvent").click(()=> {
		getUserInfo();
	});

</script>


