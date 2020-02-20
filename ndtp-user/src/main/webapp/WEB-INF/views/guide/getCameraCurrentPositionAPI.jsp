<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="api34" class="api-help-toggle" style="display: none;">
	<div class="menu_tab">
		<ul>
			<li class="fst active"><a href="#" onclick="tabMenu(0);">Run</a></li>
			<li><a href="#" onclick="tabMenu(1);">Code</a></li>
		</ul>
	</div>
	<div class="menu_tab00 mTs" id="panels">
		<h2>getCameraCurrentPositionAPI</h2>

		<p>현재 카메라의 위치를 구하는 API입니다.</p>
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
				<td>unit</td>
				<td>Number</td>
				<td>위치 단위 (기본값 : 1) 0 : 미터, 1 : 도(degree), 2 : 라디안(radian)</td>
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
				<td>현재 카메라의 위치</td>
			</tr>
		</table>
		<br>
		<h4>실행</h4>
		<div class="paramContainer">
			<p>unit :</p>
			<label><input type="radio" name="api34-p1" value="0" />미터</label> 
			<label><input type="radio" name="api34-p1" value="1" />도</label> 
			<label><input type="radio" name="api34-p1" value="2" checked />라디안</label>
		</div>
		<br> 
		<input type="button" value="Run" class="popupBtn" onclick="getCameraCurrentPosition()">
		결과 :<table id="api34-result"></table>
	</div>
	<div class="menu_tab01 mTs" id="panels" style="display: none;"></div>
</div>
<script>
	var getCameraCurrentPosition = function() {

		var unit = $("input[name=api34-p1]:checked").val();
		var result = getCameraCurrentPositionAPI(MAGO3D_INSTANCE2, parseFloat(unit));
		var table = document.getElementById("api34-result");
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