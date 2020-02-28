<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="api43" class="api-help-toggle">
	<div class="menu_tab">
		<ul>
			<li class="fst active"><a href="#" onclick="tabMenu(0);">Run</a></li>
			<li><a href="#" onclick="tabMenu(1);">Code</a></li>
		</ul>
	</div>
	<div id="panels" class="menu_tab00 mTs">
		<h2>isDataReadyToRenderAPI</h2>
		<p>데이터를 렌더링 할 준비가 되어있는지 확인하는 API입니다.</p>
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
		<table>
		<caption>Return</caption>
			<tr>
				<th scope="col">type</th>
				<th scope="col">description</th>
			</tr>
			<tr>
				<td>Boolean</td>
				<td>true: 존재, false: 없음</td>
			</tr>
		</table>
		<br>
		<h4>실행</h4>
		<div class="paramContainer">
			<label for="api43-p1">projectId</label>
			<input type="text" id="api43-p1" value="sample" data-require="true"><br>
			<label for="api43-p2">dataKey</label>
			<input type="text" id="api43-p2" value="SOCIALROOM" data-require="true">
		</div>
		<br> 
		<input type="button" id="isDataReadyToRender" value="Run" class="popupBtn">
		<div id="resultContainer">
			<h4>결과</h4>
			<div id="api43-result"></div>
		</div>
	</div>
	<div id="panels" class="menu_tab01 mTs" style="display: none;"></div>
</div>
<script>
	var isDataReadyToRender = function() {

		var projectId = $('#api43-p1').val();
		var dataKey = $('#api43-p2').val();
		var result = isDataReadyToRenderAPI(MAGO3D_INSTANCE2, projectId, dataKey);

		document.getElementById("api43-result").innerText = result.toString();

	}
</script>