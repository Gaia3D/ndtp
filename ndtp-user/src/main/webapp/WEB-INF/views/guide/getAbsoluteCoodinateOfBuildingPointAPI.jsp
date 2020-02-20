<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="api33" class="api-help-toggle" style="display: none;">
	<div class="menu_tab">
		<ul>
			<li class="fst active"><a href="#" onclick="tabMenu(0);">Run</a></li>
			<li><a href="#" onclick="tabMenu(1);">Code</a></li>
		</ul>
	</div>
	<div class="menu_tab00 mTs" id="panels">
		<h2>getAbsoluteCoodinateOfBuildingPointAPI</h2>
		<p>건물의 절대 좌표를 구하는 API입니다.</p>
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
				<td>dataKey</td>
				<td>String</td>
				<td>데이터 고유키</td>
			</tr>
			<tr>
				<td>inputPoint</td>
				<td>object</td>
				<td>입력 지점 x, y, z</td>
			</tr>
			<tr>
				<td>resultPoint</td>
				<td>object</td>
				<td>절대 좌표 x, y, z</td>
			</tr>
		</table>
		<br>
		<h4>리턴</h4>
		<table>
			<tr>
				<th>type</th>
				<th>description</th>
			</tr>
			<tr>
				<td>object</td>
				<td>절대 좌표 x, y, z</td>
			</tr>
		</table>
		<br>
		<h4>실행</h4>
		<div class="paramContainer">
			projectId : <input type="text" id="api33-p1" value="sample"><br>
			dataKey : <input type="text" id="api33-p2" value="SOCIALROOM"><br>
			inputPoint_x : <input type="text" id="api33-p3" value="-3158185.8634899906"><br> 
			inputPoint_y : <input type="text" id="api33-p4" value="4713784.056940694"><br>
			inputPoint_z : <input type="text" id="api33-p5" value="4516771.367915208">
		</div>
		<br> <input type="button" value="Run" class="popupBtn"
			onclick="getAbsoluteCoodinateOfBuildingPoint()">
		결과<table id="api33-result"></table>
	</div>
	<div class="menu_tab01 mTs" id="panels" style="display: none;"></div>
</div>
<script>
	var getAbsoluteCoodinateOfBuildingPoint = function() {

		var projectId = $('#api33-p1').val();
		var dataKey = $('#api33-p2').val();
		var inputPoint_x = $('#api33-p3').val();
		var inputPoint_y = $('#api33-p4').val();
		var inputPoint_z = $('#api33-p5').val();

		var result = getAbsoluteCoodinateOfBuildingPointAPI(MAGO3D_INSTANCE2, projectId, dataKey, new Mago3D.Point3D(parseFloat(inputPoint_x), parseFloat(inputPoint_y), parseFloat(inputPoint_z)), new Mago3D.Point3D());
		var table = document.getElementById("api33-result");
		
		table.innerHTML = '';
		
		for ( var i in Object.keys(result)) {
			var row = table.insertRow();
			var th = document.createElement("th");
			var td = document.createElement("td");
			var key = document.createTextNode(Object.keys(result)[i]);
			var value = document.createTextNode(Object.values(result)[i]);
			th.appendChild(key);
			td.appendChild(value);
			row.appendChild(th);
			row.appendChild(td);
		}
	}
</script>