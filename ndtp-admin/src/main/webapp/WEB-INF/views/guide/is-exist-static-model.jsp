<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="api41" class="api-help-toggle">
	<div class="menu_tab">
		<ul>
			<li class="fst active"><a href="#" onclick="tabMenu(0);">Run</a></li>
			<li><a href="#" onclick="tabMenu(1);">Code</a></li>
		</ul>
	</div>
	<div id="panels" class="menu_tab00 mTs">
		<h2>isExistStaticModelAPI</h2>
		<p>정적 모델이 존재하는지 판단하는 API입니다.</p>
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
			<label for="api41-p1">projectId</label>
			<input type="text" id="api41-p1" value="static_sample" data-require="true">
		</div>
		<br> 
		<input type="button" id="isExistStaticModel" value="Run" class="popupBtn">
		<div id="resultContainer">
			<h4>결과</h4>
			<div id="api41-result"></div>
		</div>
	</div>
	<div id="panels" class="menu_tab01 mTs" style="display: none;"></div>
</div>
<script>
	var isExistStaticModel = function() {

		var projectId = $('#api41-p1').val();
		var result = isExistStaticModelAPI(MAGO3D_INSTANCE2, projectId);
		
		document.getElementById("api41-result").innerText = result.toString();
	}
</script>