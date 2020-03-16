<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="api44" class="api-help-toggle">
	<div class="menu_tab">
		<ul>
			<li class="fst active"><a href="#" onclick="tabMenu(0);">Run</a></li>
			<li><a href="#" onclick="tabMenu(1);">Code</a></li>
		</ul>
	</div>
	<div id="panels" class="menu_tab00 mTs">
		<h2>setNodeAttributeAPI</h2>
		<p>데이터의 속성을 설정하는 API입니다.</p>
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
				<td>option</td>
				<td>Object</td>
				<td>데이터 속성</td>
			</tr>
		</table>
		<br>
		<h4>실행</h4>
		<div class="paramContainer">
			<label for="api44-p1">projectId</label>
			<input type="text" id="api44-p1" value="sample" data-require="true" disabled><br>
			<label for="api44-p2">dataKey</label>
			<input type="text" id="api44-p2" value="SOCIALROOM" data-require="true" disabled><br>
			<label for="api44-p3">isVisible</label>
			<select id="api44-p3">
				<option value="true">true</option>
				<option value="false" selected>false</option>
			</select><br/>
		</div>
		<br> <input type="button" id="setNodeAttribute" value="Run" class="popupBtn">
	</div>
	<div id="panels" class="menu_tab01 mTs" style="display: none;"></div>
</div>
<script>
	var setNodeAttribute = function() {

		var projectId = $('#api44-p1').val();
		var dataKey = $('#api44-p2').val();
		var isVisible = $('#api44-p3').val();
		flag = (isVisible === 'true');
		var optionObject = {
			isVisible : flag
		}
		var result = setNodeAttributeAPI(MAGO3D_INSTANCE2, projectId, dataKey, optionObject);
	}
</script>