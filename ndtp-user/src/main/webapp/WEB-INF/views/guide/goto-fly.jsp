<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="api31" class="api-help-toggle">
	<div class="menu_tab">
		<ul>
			<li class="fst active"><a href="#" onclick="tabMenu(0);">Run</a></li>
			<li><a href="#" onclick="tabMenu(1);">Code</a></li>
		</ul>
	</div>
	<div id="panels" class="menu_tab00 mTs">
		<h2>gotoFlyAPI</h2>
		<p>해당 지점으로 카메라가 이동합니다.</p>
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
				<td>longitude</td>
				<td>Number</td>
				<td>경도</td>
			</tr>
			<tr>
				<td>latitude</td>
				<td>Number</td>
				<td>위도</td>
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
			<label for="api31-p1">longitude</label>
			<input type="text" id="api31-p1" value="127.0000" data-require="true"><br>
			<label for="api31-p2">latitude</label>
			<input type="text" id="api31-p2" value="37.000" data-require="true"><br>
			<label for="api31-p3">height</label>
			<input type="text" id="api31-p3" value="100" data-require="true"><br>
			<label for="api31-p4">duration</label>
			<input type="text" id="api31-p4" value="10" data-require="true">
		</div>
		<br>
		<input type="button" id="gotofly" value="Run" class="popupBtn">
	</div>
	<div id="panels" class="menu_tab01 mTs" style="display: none;"></div>
</div>
<script>
	var gotofly = function() {

		var longitude = $('#api31-p1').val();
		var latitude = $('#api31-p2').val();
		var height = $('#api31-p3').val();
		var duration = $('#api31-p4').val();

		gotoFlyAPI(MAGO3D_INSTANCE2, parseFloat(longitude), parseFloat(latitude), parseFloat(height), parseFloat(duration));
	}
</script>