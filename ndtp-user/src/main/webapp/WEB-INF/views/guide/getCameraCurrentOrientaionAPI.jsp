<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="api35" class="apihelptoggle" style="display: none;">
	<div class="menu_tab">
		<ul>
			<li class="fst active"><a href="#;" onclick="tab_menu(0);">Run</a></li>
			<li><a href="#;" onclick="tab_menu(1);">Code</a></li>
		</ul>
	</div>
	<div class="menu_tab00 mTs" id="panels">
	<h2>getCameraCurrentOrientaionAPI</h2>
	
	<p>현재 카메라의 회전정보를 구하는 API입니다.</p>
		<h4>파라미터</h4>
		<table>
		<tr><th>name</th><th>type</th><th>description</th></tr>
		<tr><td>managerFactoryInstance</td><td>ManagerFactory</td><td>mago3D 시작 부분</td></tr>
		</table><br>
		<h4>리턴</h4>
		<table>
		<tr><th>type</th><th>description</th></tr>
		<tr><td>object</td><td>현재 카메라의 회전정보</td></tr>
		</table><br>
		<h4>실행</h4>
	<div class="paramContainer"></div>
		<input type="button" value="Run" class="popupBtn" 
			onclick="getCameraCurrentOrientaion()">
			<table id="api35-result">결과 :</table>
	</div>
	<div class="menu_tab01 mTs" id="panels" style="display: none;">
		</div>
</div>
<script>
	var getCameraCurrentOrientaion = function() {

		var r1 = getCameraCurrentOrientaionAPI(MAGO3D_INSTANCE2);
		console.log(r1);
		
		
		var table = document.getElementById("api35-result");
		table.innerHTML = '';
		for(var i in Object.keys(r1)){
			var row = table.insertRow();
			var th = document.createElement("th");
			var td = document.createElement("td");
			var key = document.createTextNode(Object.keys(r1)[i]);
			var value = document.createTextNode(Object.values(r1)[i]);
			th.appendChild(key);
			td.appendChild(value);
		    row.appendChild(th);
		    row.appendChild(td);
		}


	}
</script>