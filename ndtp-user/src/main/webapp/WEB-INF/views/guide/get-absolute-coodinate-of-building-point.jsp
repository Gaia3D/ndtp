<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="api33" class="api-help-toggle">
	<div class="menu_tab">
		<ul>
			<li class="fst active"><a href="#" onclick="tabMenu(0);">Run</a></li>
			<li><a href="#" onclick="tabMenu(1);">Code</a></li>
		</ul>
	</div>
	<div id="panels" class="menu_tab00 mTs">
		<h2>getAbsoluteCoodinateOfBuildingPointAPI</h2>
		<p>특정 건물의 원점을 기준으로 한 좌표를 세계좌표로 변환</p>
		<table>
			<caption>Parameter</caption>
			<tr>
				<th scope="col">name</th>
				<th scope="col">type</th>
				<th scope="col">description</th>
		<th scope="col">r>
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
		<br/>
		<table>
		<caption>Return</caption>
			<tr>
				<th scope="col">type</th>
				<th scope="col">description</th>
			</tr>
			<tr>
				<td>object</td>
				<td>절대 좌표 x, y, z</td>
			</tr>
		</table>
		<br/>
		<h4>실행</h4>
		<div class="paramContainer">
			<label for="api33-p1">projectId</label>
			<input type="text" id="api33-p1" value="sample" data-require="true" disabled><br/>
			<label for="api33-p2">dataKey</label>
			<input type="text" id="api33-p2" value="SOCIALROOM" data-require="true" disabled><br/>
			<label for="api33-p3">inputPoint_x</label>
			<input type="text" id="api33-p3" value="4713784.056940694" data-require="true"><br/>
			<label for="api33-p4">inputPoint_y</label> 
			<input type="text" id="api33-p4" value="-3158185.8634899906" data-require="true"><br/>
			<label for="api33-p5">inputPoint_z</label>
			<input type="text" id="api33-p5" value="4516771.367915208" data-require="true">
		</div>
		<br/> 
		<input type="button" id="getAbsoluteCoodinateOfBuildingPoint" value="Run" class="popupBtn">
		<div id="resultContainer">
			<h4>결과</h4>
			<table id="api33-result"></table>
		</div>
	</div>
	<div id="panels" class="menu_tab01 mTs" style="display: none;"></div>
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