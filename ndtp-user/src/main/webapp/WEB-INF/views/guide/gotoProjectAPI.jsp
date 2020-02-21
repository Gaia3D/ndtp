<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="api24" class="api-help-toggle" style="display: none;">
	<div class="menu_tab">
		<ul>
			<li class="fst active"><a href="#" onclick="tabMenu(0);">Run</a></li>
			<li><a href="#" onclick="tabMenu(1);">Code</a></li>
		</ul>
	</div>
	<div class="menu_tab00 mTs" id="panels">
		<h2>gotoProjectAPI</h2>
		<p>해당 프로젝트를 로딩하고 그 프로젝트로 이동하는 API입니다.</p>
		<h4>파라미터</h4>
		<table>
			<tr>
				<th>name</th>
				<th>type</th>
				<th>description</th>
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
			<label>projectId :</label>
			<input type="text" id="api24-p1" value="sample2"><br>
			<label>projectData :</label>
			<input type="text" id="api24-p2" value="sample_f4d"><br>
			<label>projectDataFolder :</label>
			<input type="text" id="api24-p3" value="sample"><br>
			<label>longitude :</label>
			<input type="text" id="api24-p4" value="126.60890424717905"><br>
			<label>latitude :</label>
			<input type="text" id="api24-p5" value="37.58358288958673"><br>
			<label>height :</label>
			<input type="text" id="api24-p6" value="550"><br>
			<label>duration :</label>
			<input type="text" id="api24-p7" value="1">
		</div>
		<br> 
		<input type="button" value="Run" class="popupBtn" onclick="gotoProject()">
	</div>
	<div class="menu_tab01 mTs" id="panels" style="display: none;"></div>
</div>
<script>
	var gotoProject = function() {

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

		var projectId = $('#api24-p1').val();
		var projectData = $('#api24-p2').val();
		var projectDataFolder = $('#api24-p3').val();
		var longitude = $('#api24-p4').val();
		var latitude = $('#api24-p5').val();
		var height = $('#api24-p6').val();
		var duration = $('#api24-p7').val();

		gotoProjectAPI(MAGO3D_INSTANCE2, projectId, obj1, projectDataFolder, parseFloat(longitude), parseFloat(latitude), parseFloat(height), parseFloat(duration));
	}
</script>