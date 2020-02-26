<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/simulation/simulationCityPlanRepot.jsp" %>

<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>

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
					<button type="button" id="constUploadBtn" class="btnTextF">건설 공정 파일 업로드</button>
				</li>
				<li>
					<span style="display: inline-block;padding: 3px 0;margin-right: 20px;">위치</span>
					<label style="width:26px;" for="cpSejong">세종</label>
					<input style="width:20px;" type="radio" id="cpSejong" name="cpProtoArea" value="s" checked/>
					<label style="width:26px;" for="cpBusan">부산</label>
					<input style="width:20px;" type="radio" id="cpBusan"  name="cpProtoArea" value="p"/>
					<label style="width:26px;" for="cpEtc">기타</label>
					<input style="width:20px;" type="radio" id="cpEtc"  name="cpProtoArea" value="etc"/>
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
				<li>
					<button id="result_build" type="button" class="btnText drawObserverPoint">결과 산출</button>
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
					<button type="button" id="testFly" class="btnTextF" style="margin-top:10px;">Fly Test</button>
					<button type="button" id="testingPicking" class="btnTextF" style="margin-top:10px;">testingPicking</button>

					<button type="button" id="testBuilding" class="btnTextF" style="margin-top:10px; display:none;">testBuilding</button>
					<button type="button" id="comment" class="btnTextF" style="margin-top:10px;">comment</button>
					<button type="button" id="test111" class="btnTextF" style="margin-top:10px;">test111</button>
					<button type="button" id="test222" class="btnTextF" style="margin-top:10px;">test222</button>
					<button type="button" id="test333" class="btnTextF" style="margin-top:10px;">test333</button>
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
						<label style="width:26px;" for="cpSejong">세종</label>
						<input style="width:20px;" type="radio" id="cpSejong" name="cityTypeString" value="s" checked/>
						<label style="width:26px;" for="cpBusan">부산</label>
						<input style="width:20px;" type="radio" id="cpBusan"  name="cityTypeString" value="p"/>
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
	// setTimeout(()=> {
	// 	_viewer.camera.flyTo({
	// 		destination : Cesium.Cartesian3.fromDegrees(126.9785978787040,  37.56690158584144, 100)
	// 	});
	// }, 1000);

	$("#comment").on('click', function() {
		let commentData = {
			// todo: 클릭시 오브젝트에서 정보 가져와서 셋팅
			objectName: "testObject"
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
		let urlParam = "http://localhost/data/simulation-rest/cityPlanModelSelect";
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
				console.log("msg  =", msg);
				// $("#testBuilding").attr('style', "display:none;");
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

	function genBuild(urlParam, lon, lat, scale) {
		debugger;
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



</script>


