<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="api7" class="api-help-toggle" style="display: none;">
	<div class="menu_tab">
		<ul>
			<li class="fst active"><a href="#" onclick="tabMenu(0);">Run</a></li>
			<li><a href="#" onclick="tabMenu(1);">Code</a></li>
		</ul>
	</div>
	<div class="menu_tab00 mTs" id="panels">
		<h2>changeColorAPI</h2>

		<p>프로젝트 단위로 원하는 데이터나 데이터의 객체에 색상을 변경해주는 API입니다.</p>
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
				<td>objectIds</td>
				<td>String[]</td>
				<td>object id. 복수개의 경우 , 로 입력</td>
			</tr>
			<tr>
				<td>property</td>
				<td>String</td>
				<td>속성값 예)isMain=true</td>
			</tr>
			<tr>
				<td>color</td>
				<td>String</td>
				<td>R, G, B 색깔을 ',' 로 연결한 string 값을 받음.</td>
			</tr>
		</table>
		<br/>
		<h4>실행</h4>
		<div class="paramContainer">
			<p>projectId :</p>
			<input type="text" id="api7-p1" value="sample"><br/>
			<p>dataKey :</p>
			<input type="text" id="api7-p2" value="STUDENTROOM"><br/>
			<p>objectIds :</p>
			<input type="text" id="api7-p3" value="2Dzz1wTo51BAnDnXy3jXLd"><br/>
			<p>property :</p>
			<input type="text" id="api7-p4" value="isMain=true"><br/>
			<p>color :</p>
			<input type="text" id="api7-p5" value="255, 0, 255">
		</div>
		<br/>
		<input type="button" value="Run" class="popupBtn" onclick="changeColor()">
	</div>
	<div class="menu_tab01 mTs" id="panels" style="display: none;"></div>
</div>
<script>
	var changeColor = function() {

		var arr1 = [];

		var projectId = $('#api7-p1').val();
		var dataKey = $('#api7-p2').val();
		var objectIds = $('#api7-p3').val();
		var property = $('#api7-p4').val();
		var color = $('#api7-p5').val();
		arr1[0] = objectIds;

		changeColorAPI(MAGO3D_INSTANCE2, projectId, dataKey, arr1, property, color);
	}
</script>