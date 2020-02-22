<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="api30" class="api-help-toggle" style="display: none;">
	<div class="menu_tab">
		<ul>
			<li class="fst active"><a href="#" onclick="tabMenu(0);">Run</a></li>
			<li><a href="#" onclick="tabMenu(1);">Code</a></li>
		</ul>
	</div>
	<div class="menu_tab00 mTs" id="panels">
		<h2>drawAppendDataAPI</h2>

		<p>프로젝트 단위 데이터를 추가하고 렌더링 하는 API입니다.</p>
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
				<td>projectIdArray</td>
				<td>Object[]</td>
				<td>프로젝트 이름들</td>
			</tr>
			<tr>
				<td>projectDataArray</td>
				<td>Object[]</td>
				<td>프로젝트 데이터들</td>
			</tr>
			<tr>
				<td>projectDataFolderArray</td>
				<td>Object[]</td>
				<td>프로젝트 f4d 파일 경로</td>
			</tr>
		</table>
		<br/>
		<h4>실행</h4>
		<div class="paramContainer">
			<label for="api30-p1">projectIdArray</label>
			<input type="text" id="api30-p1" value='["ifc, ifc1, ifc2"]'><br/>
			<label for="api30-p2">projectDataArray</label>
			<input type="text" id="api30-p2" value='["factory, factory1, factory2"]'><br/>
			<label for="api30-p3">projectDataFolderArray</label>
			<input type="text" id="api30-p3" value='["D:\reposit, D:\reposit1, D:\reposit2"]'>
		</div>
		<br/> 
		<input type="button" id="drawAppendData" value="Run" class="popupBtn">
	</div>
	<div class="menu_tab01 mTs" id="panels" style="display: none;"></div>
</div>
<script>
	var drawAppendData = function() {

		var projectIdArray = $('#api30-p1').val();
		var projectDataArray = $('#api30-p2').val();
		var projectDataFolderArray = $('#api30-p3').val();

		drawAppendDataAPI(MAGO3D_INSTANCE2, projectIdArray, projectDataArray, projectDataFolderArray);
	}
</script>