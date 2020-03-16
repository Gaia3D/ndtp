<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="api28" class="api-help-toggle">
	<div class="menu_tab">
		<ul>
			<li class="fst active"><a href="#" onclick="tabMenu(0);">Run</a></li>
			<li><a href="#" onclick="tabMenu(1);">Code</a></li>
		</ul>
	</div>
	<div id="panels" class="menu_tab00 mTs">
		<h2>getDataAPI</h2>
		<p>data map에 담겨있는 데이터정보(json)를 불러오는 API입니다.</p>
		<table>
		<caption>Parameter</caption>
			<tr>
				<th scope="col">name</th>
				<th scope="col">type</th>
				<th scope="col">description</th>
			</tr>
			<tr>
				<td>dataKey</td>
				<td>String</td>
				<td>데이터 고유키</td>
			</tr>
		</table>
		<br>
		<table>
		<caption>Return</caption>
			<tr>
				<th scope="col">type</th>
				<th scope="col">description</th>
			</tr>
			<tr>
				<td>Object</td>
				<td>프로젝트 데이터</td>
			</tr>
		</table>
		<br>
		<h4>실행</h4>
		<div class="paramContainer">
			<label for="api28-p1">projectId</label>
			<input type="text" id="api28-p1" value="sample" data-require="true">
		</div>
		<br> 
		<input type="button" id="getData" value="Run" class="popupBtn">
		<div id="resultContainer">
			<h4>결과</h4>
			<table id="api28-result"></table>
		</div>
	</div>
	<div id="panels" class="menu_tab01 mTs" style="display: none;"></div>
</div>
<script>
	var getData = function() {

		var dataKey = $('#api28-p1').val();
		var result = getDataAPI("projectId_" + dataKey.toString());
		var table = document.getElementById("api28-result");
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