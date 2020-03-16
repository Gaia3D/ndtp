<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="api20" class="api-help-toggle">
	<div class="menu_tab">
		<ul>
			<li class="fst active"><a href="#" onclick="tabMenu(0);">Run</a></li>
			<li><a href="#" onclick="tabMenu(1);">Code</a></li>
		</ul>
	</div>
	<div id="panels" class="menu_tab00 mTs">
		<h2>changeLightingAPI</h2>
		<p>선택한 객체에 밝기를 조절하는 API입니다.</p>
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
				<td>ambientReflectionCoef</td>
				<td>Number</td>
				<td>다이렉트 빛이 아닌 반사율 범위. 기본값 0.5</td>
			</tr>
			<tr>
				<td>diffuseReflectionCoef</td>
				<td>Number</td>
				<td>자기 색깔의 반사율 범위. 기본값 1.0</td>
			</tr>
			<tr>
				<td>specularReflectionCoef</td>
				<td>Number</td>
				<td>표면의 반질거림 범위. 기본값 1.0</td>
			</tr>
			<tr>
				<td>ambientColor</td>
				<td>String</td>
				<td>다이렉트 빛이 아닌 반사율 RGB, 콤마로 연결</td>
			</tr>
			<tr>
				<td>specularColor</td>
				<td>String</td>
				<td>표면의 반질거림 색깔. RGB, 콤마로 연결</td>
			</tr>
		</table>
		<br/>
		<h4>실행</h4>
		<div class="paramContainer">
			<label for="api20-p1">ambientReflectionCoef</label>
			<input type="text" id="api20-p1" value="0.5" data-require="false"><br/>
			<label for="api20-p2">diffuseReflectionCoef</label>
			<input type="text" id="api20-p2" value="1" data-require="false"><br/>
			<label for="api20-p3">specularReflectionCoef</label>
			<input type="text" id="api20-p3" value="1" data-require="false"><br/>
			<label for="api20-p4">ambientColor</label>
			<input type="text" id="api20-p4" value="255, 0, 0" data-require="false"><br/>
			<label for="api20-p5">specularColor</label>
			<input type="text" id="api20-p5" value="0, 255, 0" data-require="false">
		</div>
		<br/> 
		<input type="button" id="changeLighting" value="Run" class="popupBtn">
	</div>
	<div id="panels" class="menu_tab01 mTs" style="display: none;"></div>
</div>
<script>
	var changeLighting = function() {

		var ambientReflectionCoef = $('#api20-p1').val();
		var diffuseReflectionCoef = $('#api20-p2').val();
		var specularReflectionCoef = $('#api20-p3').val();
		var ambientColor = $('#api20-p4').val();
		var specularColor = $('#api20-p5').val();

		changeLightingAPI(MAGO3D_INSTANCE2, parseFloat(ambientReflectionCoef), parseFloat(diffuseReflectionCoef),
				parseFloat(specularReflectionCoef), ambientColor, specularColor);
	}
</script>