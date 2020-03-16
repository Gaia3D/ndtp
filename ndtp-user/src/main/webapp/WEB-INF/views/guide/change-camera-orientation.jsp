<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="api36" class="api-help-toggle">
	<div class="menu_tab">
		<ul>
			<li class="fst active"><a href="#" onclick="tabMenu(0);">Run</a></li>
			<li><a href="#" onclick="tabMenu(1);">Code</a></li>
		</ul>
	</div>
	<div id="panels" class="menu_tab00 mTs">
		<h2>changeCameraOrientationAPI</h2>
		<p>카메라의 회전정보를 변경하는 API입니다.</p>
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
				<td>heading</td>
				<td>String | undefined | null</td>
				<td>좌, 우(degree)</td>
			</tr>
			<tr>
				<td>pitch</td>
				<td>String | undefined | null</td>
				<td>상, 하(degree)</td>
			</tr>
			<tr>
				<td>roll</td>
				<td>String | undefined | null</td>
				<td>좌, 우 기울기(degree)</td>
			</tr>
			<tr>
				<td>duration</td>
				<td>String | undefined | null</td>
				<td>이동하는 시간</td>
			</tr>
		</table>
		<br/>
		<h4>실행</h4>
		<div class="paramContainer">
			<label for="api36-p1">heading</label>
			<input type="text" id="api36-p1" value="89.2471" data-require="false"><br/>
			<label for="api36-p2">pitch</label>
			<input type="text" id="api36-p2" value="43.1837" data-require="false"><br/>
			<label for="api36-p3">roll</label>
			<input type="text" id="api36-p3" value="30.9415" data-require="false"><br/>
			<label for="api36-p4">duration</label>
			<input type="text" id="api36-p4" value="0" data-require="false">
		</div>
		<br/> 
		<input type="button" id="changeCameraOrientation" value="Run" class="popupBtn">
	</div>
	<div id="panels" class="menu_tab01 mTs" style="display: none;"></div>
</div>
<script>
	var changeCameraOrientation = function() {

		var heading = $('#api36-p1').val();
		var pitch = $('#api36-p2').val();
		var roll = $('#api36-p3').val();
		var duration = $('#api36-p4').val();

		changeCameraOrientationAPI(MAGO3D_INSTANCE2, heading, pitch, roll, duration);
	}
</script>