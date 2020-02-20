<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="api41" class="api-help-toggle" style="display: none;">
	<div class="menu_tab">
		<ul>
			<li class="fst active"><a href="#" onclick="tabMenu(0);">Run</a></li>
			<li><a href="#" onclick="tabMenu(1);">Code</a></li>
		</ul>
	</div>
	<div class="menu_tab00 mTs" id="panels">
		<h2>isExistDataAPI</h2>
		<p>데이터가 존재하는지 판단하는 API입니다.</p>
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
		</table>
		<br>
		<h4>리턴</h4>
		<table>
			<tr>
				<th>type</th>
				<th>description</th>
			</tr>
			<tr>
				<td>Boolean</td>
				<td>true: 존재, false: 없음</td>
			</tr>
		</table>
		<br>
		<h4>실행</h4>
		<div class="paramContainer">
			<label>projectId :</label>
			<input type="text" id="api41-p1" value="sample"><br>
			<label>dataKey :</label>
			<input type="text" id="api41-p2" value="SOCIALROOM">
		</div>
		<br> <input type="button" value="Run" class="popupBtn" onclick="isExistData()">
		<div id="api41-result">결과 :</div>
	</div>
	<div class="menu_tab01 mTs" id="panels" style="display: none;"></div>
</div>
<script>
	var isExistData = function() {

		var projectId = $('#api41-p1').val();
		var dataKey = $('#api41-p2').val();

		var result = isExistDataAPI(MAGO3D_INSTANCE2, projectId, dataKey);
		document.getElementById("api41-result").innerText = result.toString();
	}
</script>