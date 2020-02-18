<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="api31" class="apihelptoggle" style="display: none;">
	<div class="menu_tab">
		<ul>
			<li class="fst active"><a href="#;" onclick="tab_menu(0);">Run</a></li>
			<li><a href="#;" onclick="tab_menu(1);">Code</a></li>
		</ul>
	</div>
	<div class="menu_tab00 mTs" id="panels">
	<h2>gotoFlyAPI</h2>
	
	<p>해당 지점으로 카메라가 이동합니다.</p>
		<h4>파라미터</h4>
		<table>
		<tr><th>name</th><th>type</th><th>description</th></tr>
		<tr><td>managerFactoryInstance</td><td>ManagerFactory</td><td>mago3D 시작 부분</td></tr>
		<tr><td>longitude</td><td>Number</td><td>경도</td></tr>
		<tr><td>latitude</td><td>Number</td><td>위도</td></tr>
		<tr><td>height</td><td>Number</td><td>높이</td></tr>
		<tr><td>duration</td><td>Number</td><td>이동하는 시간</td></tr>
		</table></br>
		<h4>실행</h4>
	<div class="paramContainer">
		<p>longitude :</p>
		<input type="text" id="api31-p1" value="127.0000"></br>
		<p>latitude :</p>
		<input type="text" id="api31-p2" value="37.000"></br>
		<p>height :</p>
		<input type="text" id="api31-p3" value="100"></br>
		<p>duration :</p>
		<input type="text" id="api31-p4" value="10"></div></br> <input
			type="button" value="Run" class="popupBtn" onclick="gotofly()">
	</div>
	<div class="menu_tab01 mTs" id="panels" style="display: none;">
		</div>
</div>
<script>
	var gotofly = function() {

		var p1 = $('#api31-p1').val();
		var p2 = $('#api31-p2').val();
		var p3 = $('#api31-p3').val();
		var p4 = $('#api31-p4').val();

		gotoFlyAPI(MAGO3D_INSTANCE2, parseFloat(p1), parseFloat(p2),
				parseFloat(p3), parseFloat(p4));
	}
</script>