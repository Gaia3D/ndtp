<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/simulation/simulationCityPlanRepot.jsp" %>

<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>

<ul class="listDrop">
	<li>
		<p>경관 분석(일조분석)<span class="collapse-icon">icon</span></p>
		<div class="listContents" id="solarAnalysis">
			<ul class="analysisGroup">
				<li>
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
	<li >
		<p>도시 계획<span class="collapse-icon">icon</span></p>
		<div class="listContents" id="constructionProcess">
			<ul class="analysisGroup">
				<li>
					<iframe name="dummyframe" id="dummyframe" style="display: none;"></iframe>
					<form id="file_upload" name="file_upload"method="post" enctype="multipart/form-data" action="simulation-rest/upload" style="width:100%" target="dummyframe">
						<input type="file" name="files" style="width:100%" multiple>
						<button id="upload_cityplan" type="submit" class="btnTextF" title="업로드">업로드</button>
						<button type="button" class="btnText reset" title="취소">취소</button>
					</form>
					<button id="run_cityplan" type="button" class="btnTextF" title="가시화">가시화</button>
					<button id="move_cityplan" type="button" class="btnTextF" title="가시화">이동</button>
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
						<option value="none">선택안함</option>
						<option value="imsiBuild">임시 건물 배치 모드</option>
						<option value="autoBuild">자동 건물 배치 모드</option>
						<option value="location">경관 좌표 배치 모드</option>
					</select>
				</li>
				<li>
					<button id="result_build" type="button" class="btnText drawObserverPoint">결과 산출</button>
					<button id="modelView">모델보기</button>
				</li>
			</ul>
		</div>
	</li>
	<li class="on">
		<p>건축인 허가 신청<span class="collapse-icon">icon</span></p>
		<div class="listContents" id="">
			<ul class="analysisGroup">
				<li>
					<button type="button" id="permRequest" title="건축인 허가 신청" class="btnTextF" style="margin-top:10px;">건축인 허가 신청</button>
					<button type="button" id="permView" title="인허가 시뮬레이션" class="btnTextF" style="margin-top:10px;">인허가 시뮬레이션</button>
<%--					<button type="button" id="testFly" class="btnTextF" style="margin-top:10px;">Fly Test</button>--%>
<%--					<button type="button" id="testingPicking" class="btnTextF" style="margin-top:10px;">testingPicking</button>--%>

					<button type="button" id="testBuilding" class="btnTextF" style="margin-top:10px;">testBuilding</button>
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

<script>
	$("#testBuilding").click(()=> {
		console.log("testBuilding");
		// genBuild(127.786754, 36.643957, 5);
		genBuild(126.92377563766438, 37.5241752651257 , 0.3);
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
		permRequestDialog.dialog( "open" );
	});

	$("#permView").on('click', function() {
		// todo: change data
		let data = {
			isComplete: "N",
			constructor: "건축주1",
		};
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

				permViewDialog.dialog("open");
			},
			error:function(request,status,error) {
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
				console.log("msg  =", msg);
				$("#testBuilding").attr('style', "display:none;");
				if (msg === "admin") {
					$("#permRequest").attr('style', "display:none;");
					// $("#testBuilding").trigger("click");
				} else {
					$("#permView").attr('style', "display:none;");
				}
			},
			error:function(request,status,error) {
				console.log("err=", request, status, error);
			}
		});
	}

	function genBuild(lon, lat, scale) {
		var position = Cesium.Cartesian3.fromDegrees(lon, lat, 0);
		var modelMatrix = Cesium.Transforms.eastNorthUpToFixedFrame(position);
		// fromGltf 함수를 사용하여 key : value 값으로 요소를 지정
		var name = '슬퍼하지마NONONO';
		var model = whole_viewer.scene.primitives.add(Cesium.Model.fromGltf({
			url : 'http://localhost/data/simulation-rest/cityPlanModelSelect',
			modelMatrix : modelMatrix,
			scale : scale,
			shadows : 1,
			name : name
		}));
		whole_viewer.scene.primitives.add(model);
		Cesium.when(model.readyPromise).then(function(model) {
		}).otherwise(function(error){
			window.alert(error);
		});
	}

</script>


