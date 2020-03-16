<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="api8" class="api-help-toggle">
	<div class="menu_tab">
		<ul>
			<li class="fst active"><a href="#" onclick="tabMenu(0);">Run</a></li>
			<li><a href="#" onclick="tabMenu(1);">Code</a></li>
		</ul>
	</div>
	<div id="panels" class="menu_tab00 mTs">
		<h2>changeLocationAndRotationAPI</h2>
		<p>입력 받은 위치정보와 회전 정보로 블록을 변환 시킵니다.</p>
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
				<td>heading</td>
				<td>Number</td>
				<td>좌, 우</td>
			</tr>
			<tr>
				<td>pitch</td>
				<td>Number</td>
				<td>위, 아래</td>
			</tr>
			<tr>
				<td>roll</td>
				<td>Number</td>
				<td>좌, 우 기울기</td>
			</tr>
		</table>
		<br/>
		<h4>실행</h4>
		<div class="paramContainer">
			<label for="api8-p1">projectId</label>
			<input type="text" id="api8-p1" value="sample" data-require="true" disabled><br/>
			<label for="api8-p2">dataKey</label>
			<input type="text" id="api8-p2" value="SOCIALROOM" data-require="true" disabled><br/>
			<label for="api8-p3">longitude</label>
			<input type="text" id="api8-p3" value="126.923785" data-require="true"><br/>
			<label for="api8-p4">latitude</label>
			<input type="text" id="api8-p4" value="37.521868" data-require="true"><br/>
			<label for="api8-p5">height</label>
			<input type="text" id="api8-p5" value="100" data-require="false"><br/>
			<label for="api8-p6">heading</label>
			<input type="text" id="api8-p6" value="0" data-require="false"><br/>
			<label for="api8-p7">pitch</label>
			<input type="text" id="api8-p7" value="0" data-require="false"><br/>
			<label for="api8-p8">roll</label>
			<input type="text" id="api8-p8" value="0" data-require="false">
		</div>
		<br/> 
		<input type="button" id="changeLocationAndRotation" value="Run" class="popupBtn">
	</div>
	<div id="panels" class="menu_tab01 mTs" style="display: none;"></div>
</div>
<script>
	var changeLocationAndRotation = function() {

		var projectId = $('#api8-p1').val();
		var dataKey = $('#api8-p2').val();
		var longitude = $('#api8-p3').val();
		var latitude = $('#api8-p4').val();
		var height = $('#api8-p5').val();
		var heading = $('#api8-p6').val();
		var pitch = $('#api8-p7').val();
		var roll = $('#api8-p8').val();

		changeLocationAndRotationAPI(MAGO3D_INSTANCE2, projectId, dataKey, parseFloat(latitude),
				parseFloat(longitude), parseFloat(height), parseFloat(heading), parseFloat(pitch),
				parseFloat(roll));
	}
</script>