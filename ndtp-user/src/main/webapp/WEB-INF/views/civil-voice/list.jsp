<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="civilVoiceListContent" class="contents mar0 pad0 border-none" style="display:block;">
	<div class="button-group-align marB10">
		<h3 class="h3-heading">시민참여</h3>
		<button type="button" id="civilVoiceInputButton" title="의견등록" class="btnTextF right-align">의견 등록</button>
	</div>

	<!-- 시민참여 검색 -->
	<form:form id="civilVoiceSearchForm" modelAttribute="civilVoice" method="get" onsubmit="return false;">
	<div class="listSearch search-margin flex-align-center">
		<input type="text" id="getCivilVoiceListTitle" name="title" maxlength="256" placeholder="검색어를 입력하세요.">
		<button type="button" id="civilVoiceSearch" class="btnTotalSearch" title="검색">검색</button>
	</div>
	</form:form>

	<div class="bothSide">
		<div><spring:message code='all'/> <span id="civilVoiceTotalCount">0</span> <spring:message code='search.what.count'/></div>
		<div><span id="civilVoiceCurrentPage">0</span> / <span id="civilVoiceLastPage">0</span> <spring:message code='search.page'/></div>
	</div>

	<ul id="civilVoiceList" class="commentWrap"></ul>
	<ul id="civilVoicePagination" class="pagination"></ul>

</div>
<style>
	.button-group-align {
		height: auto;
	}
</style>

<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>

<button type="button" id="permRequest" title="건축인 허가 신청" class="btnTextF" style="margin-top:10px;">건축인 허가 신청</button>
<button type="button" id="permView" title="인허가 시뮬레이션" class="btnTextF" style="margin-top:10px;">인허가 시뮬레이션</button>
<button type="button" id="testFly" class="btnTextF" style="margin-top:10px;">Fly Test</button>
<button type="button" id="testingPicking" class="btnTextF" style="margin-top:10px;">testingPicking</button>

<button type="button" id="testBuilding" class="btnTextF" style="margin-top:10px;">testBuilding</button>

<script>
	$("#testBuilding").click(()=> {
		console.log("testBuilding");
		genBuild(127.786754, 36.643957, 0.5);
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
			is_complete: "N",
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
				$("#permViewDialog #phone_number").get(0).value = msg.phoneNumber;
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
				if (msg === "admin") {
					$("#permRequest").attr('style', "display:none;");
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



<!-- E: 시민참여 목록 -->
<%@ include file="/WEB-INF/views/civil-voice/detail.jsp" %>
<%@ include file="/WEB-INF/views/civil-voice/input.jsp" %>
<%@ include file="/WEB-INF/views/civil-voice/modify.jsp" %>

<script id="templateCivilVoiceList" type="text/x-handlebars-template">
	{{#if civilVoiceList}}
		{{#each civilVoiceList}}
			<li class="comment flex-align-center" data-id="{{civilVoiceId}}" title="상세보기">
				<button type="button" class="goto" data-longitude={{longitude}} data-latitude={{latitude}} style="width:30px; margin-right:10px;" title="위치보기">위치보기</button>
				<p>
					<span class="title">{{title}}</span>
					<span class="id">{{userId}}</span>
				</p>
         	   	<p class="count" style="width: 60px;"><span class="likes-icon">icon</span>{{commentCount}}</p>
			</li>
		{{/each}}
	{{else}}
		<li class="none">등록된 글이 없습니다.</li>
	{{/if}}
</script>

<script id="templateCivilVoicePagination" type="text/x-handlebars-template">
	{{#if pagination.totalCount}}
    	<ul class="pagination">
    	{{#if pagination.existPrePage}}
       	 	<li class="ico first" onClick="getCivilVoiceList({{pagination.firstPage}});"></li>
        	<li class="ico forward" onClick="getCivilVoiceList({{pagination.prePageNo}});"></li>
    	{{/if}}

    	{{#forEachStep pagination.startPage pagination.endPage 1}}
        	{{#if (indexCompare this ../pagination.pageNo)}}
           		<li class="on"><a href='#'>{{this}}</a></li>
        	{{else}}
         		<li onClick="getCivilVoiceList({{this}});"><a href='#'>{{this}}</a></li>
        	{{/if}}
    	{{/forEachStep}}

    	{{#if pagination.existNextPage}}
        	<li class="ico back" onClick="getCivilVoiceList({{pagination.nextPageNo}});"></li>
        	<li class="ico end" onClick="getCivilVoiceList({{pagination.lastPage}});"></li>
    	{{/if}}
    	</ul>
	{{/if}}
</script>
