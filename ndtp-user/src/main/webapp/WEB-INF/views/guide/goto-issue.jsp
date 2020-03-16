<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="api25" class="api-help-toggle">
	<div class="menu_tab">
		<ul>
			<li class="fst active"><a href="#" onclick="tabMenu(0);">Run</a></li>
			<li><a href="#" onclick="tabMenu(1);">Code</a></li>
		</ul>
	</div>
	<div id="panels" class="menu_tab00 mTs">
		<h2>gotoIssueAPI</h2>
		<p>해당 프로젝트를 로딩하고 그 이슈로 이동하는 API입니다.</p>
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
				<td>projectId</td>
				<td>String</td>
				<td>프로젝트 아이디</td>
			</tr>
			<tr>
				<td>projectData</td>
				<td>Object</td>
				<td>프로젝트 데이터</td>
			</tr>
			<tr>
				<td>projectDataFolder</td>
				<td>String</td>
				<td>프로젝트 데이터 폴더</td>
			</tr>
			<tr>
				<td>issueId</td>
				<td>String</td>
				<td>이슈 아이디</td>
			</tr>
			<tr>
				<td>issueType</td>
				<td>String</td>
				<td>이슈 타입</td>
			</tr>
			<tr>
				<td>latitude</td>
				<td>Number</td>
				<td>위도</td>
			</tr>
			<tr>
				<td>longitude</td>
				<td>Number</td>
				<td>경도</td>
			</tr>
			<tr>
				<td>height</td>
				<td>Number</td>
				<td>높이</td>
			</tr>
			<tr>
				<td>duration</td>
				<td>Number</td>
				<td>이동하는 시간</td>
			</tr>
		</table>
		<br>
		<h4>실행</h4>
		<div class="paramContainer">
			<label for="api25-p1">projectId</label>
			<input type="text" id="api25-p1" value="gotoIssueSample" data-require="true"><br>
			<label for="api25-p2">projectData</label>
			<input type="text" id="api25-p2" value="ProjectDataObject" data-require="true" disabled><br>
			<label for="api25-p3">projectDataFolder</label>
			<input type="text" id="api25-p3" value="sample" data-require="true" disabled><br>
			<label for="api25-p4">issueId</label>
			<input type="text" id="api25-p4" value="128" data-require="true"><br>
			<label for="api25-p5">issueType</label>
			<input type="text" id="api25-p5" value="ISSUE_TYPE_BUGGER" data-require="true"><br>
			<label for="api25-p6">longitude</label>
			<input type="text" id="api25-p6" value="127.000" data-require="true"><br>
			<label for="api25-p7">latitude</label>
			<input type="text" id="api25-p7" value="37.000" data-require="true"><br>
			<label for="api25-p8">height</label>
			<input type="text" id="api25-p8" value="550" data-require="true"><br>
			<label for="api25-p9">duration</label>
			<input type="text" id="api25-p9" value="10" data-require="true">
		</div>
		<br> 
		<input type="button" id="gotoIssue" value="Run" class="popupBtn">
	</div>
	<div id="panels" class="menu_tab01 mTs" style="display: none;"></div>
</div>
<script>
	var gotoIssue = function() {

		var projectId = $('#api25-p1').val();
		var projectData  = {
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
					"latitude" : 37.58358288958673,
					"longitude" : 126.60890424717905,
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
					"latitude" : 37.58358288958673,
					"longitude" : 126.61055424717905,
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

		var projectDataFolder = $('#api25-p3').val();
		var issueId = $('#api25-p4').val();
		var issueType = $('#api25-p5').val();
		var longitude = $('#api25-p6').val();
		var latitude = $('#api25-p7').val();
		var height = $('#api25-p8').val();
		var duration = $('#api25-p9').val();

		gotoIssueAPI(MAGO3D_INSTANCE2, projectId, projectData, projectDataFolder, issueId, issueType, parseFloat(longitude), parseFloat(latitude), parseFloat(height), parseFloat(duration));
	}
</script>