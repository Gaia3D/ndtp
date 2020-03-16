<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="api29" class="api-help-toggle">
	<div class="menu_tab">
		<ul>
			<li class="fst active"><a href="#" onclick="tabMenu(0);">Run</a></li>
			<li><a href="#" onclick="tabMenu(1);">Code</a></li>
		</ul>
	</div>
	<div id="panels" class="menu_tab00 mTs">
		<h2>getDataInfoByDataKeyAPI</h2>
		<p>데이터 고유키를 이용하여 데이터의 위치정보, 회전정보를 취득하는 API입니다.</p>
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
				<td>dataKey</td>
				<td>String</td>
				<td>데이터 고유키</td>
			</tr>
		</table>
		<br>
		<h4>실행</h4>
		<div class="paramContainer">
			<label for="api29-p1">projectId</label>
			<input type="text" id="api29-p1" value="sample" data-require="true"><br>
			<label for="api29-p2">dataKey</label>
			<input type="text" id="api29-p2" value="SOCIALROOM" data-require="true">
		</div>
		<br>
		<input type="button" id="getDataInfoByDataKey" value="Run" class="popupBtn">
		<div id="resultContainer">
			<h4>결과</h4>
			<table id="api29-result"></table>
		</div>
	</div>
	<div id="panels" class="menu_tab01 mTs" style="display: none;"></div>
</div>
<script>
	var getDataInfoByDataKey = function() {
		
		var projectId = $('#api29-p1').val();
		var dataKey = $('#api29-p2').val();
		var result = getDataInfoByDataKeyAPI(MAGO3D_INSTANCE2, projectId, dataKey);
		var table = document.getElementById("api29-result");
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