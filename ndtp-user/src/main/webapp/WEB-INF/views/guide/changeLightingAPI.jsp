<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="api20" class="apihelptoggle" style="display: none;">
	<div class="menu_tab">
		<ul>
			<li class="fst active"><a href="#;" onclick="tab_menu(0);">Run</a></li>
			<li><a href="#;" onclick="tab_menu(1);">Code</a></li>
		</ul>
	</div>
	<div class="menu_tab00 mTs" id="panels">
	<h2>changeLightingAPI</h2>
	
	<p>선택한 객체에 밝기를 조절하는 API입니다.</p>
		<h4>파라미터</h4>
		<table>
		<tr><th>name</th><th>type</th><th>description</th></tr>
		<tr><td>managerFactoryInstance</td><td>ManagerFactory</td><td>mago3D 시작 부분</td></tr>
		<tr><td>ambientReflectionCoef</td><td>Number</td><td>다이렉트 빛이 아닌 반사율 범위. 기본값 0.5</td></tr>
		<tr><td>diffuseReflectionCoef</td><td>Number</td><td>자기 색깔의 반사율 범위. 기본값 1.0</td></tr>
		<tr><td>specularReflectionCoef</td><td>Number</td><td>표면의 반질거림 범위. 기본값 1.0</td></tr>
		<tr><td>ambientColor</td><td>String</td><td>다이렉트 빛이 아닌 반사율 RGB, 콤마로 연결</td></tr>
		<tr><td>specularColor</td><td>String</td><td>표면의 반질거림 색깔. RGB, 콤마로 연결</td></tr>
		</table></br>
		<h4>실행</h4>
	<div class="paramContainer">
		<p>ambientReflectionCoef :</p><input type="text" id="api20-p1" value="0.5"></br>
		<p>diffuseReflectionCoef :</p><input type="text" id="api20-p2" value="1"></br>
		<p>specularReflectionCoef :</p><input type="text" id="api20-p3" value="1"></br>
		<p>ambientColor :</p><input type="text" id="api20-p4" value="255, 0, 0"></br>
		<p>specularColor :</p><input type="text" id="api20-p5" value="0, 255, 0"></div></br> 
		<input type="button" value="Run" class="popupBtn" onclick="changeLighting()">
	</div>
	<div class="menu_tab01 mTs" id="panels" style="display: none;">
		</div>
</div>
<script>

var changeLighting = function(){

var p1 = $('#api20-p1').val();
var p2 = $('#api20-p2').val();
var p3 = $('#api20-p3').val();
var p4 = $('#api20-p4').val();
var p5 = $('#api20-p5').val();

changeLightingAPI(MAGO3D_INSTANCE2, parseFloat(p1), parseFloat(p2), parseFloat(p3), p4, p5);
}
</script>