<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="api26" class="api-help-toggle">
	<div class="menu_tab">
		<ul>
			<li class="fst active"><a href="#" onclick="tabMenu(0);">Run</a></li>
			<li><a href="#" onclick="tabMenu(1);">Code</a></li>
		</ul>
	</div>
	<div id="panels" class="menu_tab00 mTs">
		<h2>searchDataAPI</h2>
		<p>프로젝트 아이디(projectId)와 데이터 고유키(dataKey)에 해당하는 지도 상의 데이터를 찾아 이동하는
			API입니다.</p>
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
		<h4>실행</h4>
		<div class="paramContainer">
			<label for="api26-p1">projectId</label>
			<input type="text" id="api26-p1" value="sample" data-require="true" disabled><br>
			<label for="api26-p2">dataKey</label>
			<input type="text" id="api26-p2" value="SOCIALROOM" data-require="true" disabled>
		</div>
		<br> 
		<input type="button" id="searchData" value="Run" class="popupBtn">
	</div>
	<div id="panels" class="menu_tab01 mTs" style="display: none;"></div>
</div>
<script>
	var searchData = function() {

		var projectId = $('#api26-p1').val();
		var dataKey = $('#api26-p2').val();

		searchDataAPI(MAGO3D_INSTANCE2, projectId, dataKey);
	}
</script>