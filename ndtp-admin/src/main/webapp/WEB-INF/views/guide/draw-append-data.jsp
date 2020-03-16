<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="api30" class="api-help-toggle">
	<div class="menu_tab">
		<ul>
			<li class="fst active"><a href="#" onclick="tabMenu(0);">Run</a></li>
			<li><a href="#" onclick="tabMenu(1);">Code</a></li>
		</ul>
	</div>
	<div id="panels" class="menu_tab00 mTs">
		<h2>drawAppendDataAPI</h2>

		<p>프로젝트 단위 데이터를 추가하고 렌더링 하는 API입니다.</p>
		<table>
		<caption>Parameter</caption>
			<tr>
				<th scope="col">name</th>
				<th scope="col">type</th>
				<th scope="col">description</th>
			</tr>
			<tr>
				<td>managerFactoryInstance</td>
				<td>ManagerFactory</td>
				<td>mago3D 시작 부분</td>
			</tr>
			<tr>
				<td>projectIdArray</td>
				<td>Object[]</td>
				<td>프로젝트 이름들</td>
			</tr>
			<tr>
				<td>projectDataArray</td>
				<td>Object[]</td>
				<td>프로젝트 데이터들</td>
			</tr>
			<tr>
				<td>projectDataFolderArray</td>
				<td>Object[]</td>
				<td>프로젝트 f4d 파일 경로</td>
			</tr>
		</table>
		<br/>
		<h4>실행</h4>
		<div class="paramContainer">
			<label for="api30-p1">projectIdArray</label>
			<input type="text" id="api30-p1" value="appendId1, appendId2" data-require="true"><br/>
			<label for="api30-p2">projectDataArray</label>
			<input type="text"id="api30-p2" value="sample_obj1, sample_obj1" data-require="true"  disabled><br/>
			<label for="api30-p3">projectDataFolderArray</label>
			<input type="text" id="api30-p3" value="sample" data-require="true" disabled>
		</div>
		<br/> 
		<input type="button" id="drawAppendData" value="Run" class="popupBtn">
	</div>
	<div id="panels" class="menu_tab01 mTs" style="display: none;"></div>
</div>
<script>
	var drawAppendData = function() {
		
		var obj1 = {
				"attributes" : {
					"isPhysical" : false,
					"nodeType" : "root",
					"projectType" : "workshop",
					"specularLighting" : true
				},
				"children" : [ {
					"attributes" : {
						"isPhysical" : true,
						"nodeType" : "workshop"
					},
					"children" : [],
					"data_key" : "SOCIALROOM",
					"data_name" : "SOCIALROOM",
					"mapping_type" : "origin",
					"latitude" : 37.521168,
					"longitude" : 126.924785,
					"height" : 100,
					"heading" : 0,
					"pitch" : 0,
					"roll" : 0
				}, {
					"attributes" : {
						"isPhysical" : true,
						"nodeType" : "workshop"
					},
					"children" : [],
					"data_key" : "STUDENTROOM",
					"data_name" : "STUDENTROOM",
					"mapping_type" : "origin",
					"latitude" : 37.521178000000006,
					"longitude" : 126.924795,
					"height" : 100,
					"heading" : 0,
					"pitch" : 0,
					"roll" : 0
				} ],
				"parent" : 0,
				"depth" : 1,
				"view_order" : 2,
				"data_key" : "sample",
				"data_name" : "sample",
				"mapping_type" : "origin"
			};
		
		var obj2 = {
				"attributes" : {
					"isPhysical" : false,
					"nodeType" : "root",
					"projectType" : "workshop",
					"specularLighting" : true
				},
				"children" : [ {
					"attributes" : {
						"isPhysical" : true,
						"nodeType" : "workshop"
					},
					"children" : [],
					"data_key" : "SOCIALROOM",
					"data_name" : "SOCIALROOM",
					"mapping_type" : "origin",
					"latitude" : 37.521728,
					"longitude" : 126.924785,
					"height" : 100,
					"heading" : 0,
					"pitch" : 0,
					"roll" : 0
				}, {
					"attributes" : {
						"isPhysical" : true,
						"nodeType" : "workshop"
					},
					"children" : [],
					"data_key" : "STUDENTROOM",
					"data_name" : "STUDENTROOM",
					"mapping_type" : "origin",
					"latitude" : 37.521738000000006,
					"longitude" : 126.924795,
					"height" : 100,
					"heading" : 0,
					"pitch" : 0,
					"roll" : 0
				} ],
				"parent" : 0,
				"depth" : 1,
				"view_order" : 2,
				"data_key" : "sample",
				"data_name" : "sample",
				"mapping_type" : "origin"
			};

		var projectIdArray = [];
		projectIdArray = $('#api30-p1').val().split(",");
		
		var projectDataArray = [obj1, obj2];
		
		var projectDataFolderArray = [];
		projectDataFolderArray.push($('#api30-p3').val());
		projectDataFolderArray.push($('#api30-p3').val());

		drawAppendDataAPI(MAGO3D_INSTANCE2, projectIdArray, projectDataArray, projectDataFolderArray);
	}
</script>