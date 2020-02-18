<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="api8" class="apihelptoggle" style="display: none;">
	<div class="menu_tab">
		<ul>
			<li class="fst active"><a href="#;" onclick="tab_menu(0);">Run</a></li>
			<li><a href="#;" onclick="tab_menu(1);">Code</a></li>
		</ul>
	</div>
	<div class="menu_tab00 mTs" id="panels">
	<h2>changeLocationAndRotationAPI</h2>
	
		<p>입력 받은 위치정보와 회전 정보로 블록을 변환 시킵니다.</p>
		<h4>파라미터</h4>
		<table>
		<tr><th>name</th><th>type</th><th>description</th></tr>
		<tr><td>managerFactoryInstance</td><td>ManagerFactory</td><td>mago3D 시작 부분</td></tr>
		<tr><td>projectId</td><td>String</td><td>프로젝트 아이디</td></tr>
		<tr><td>dataKey</td><td>String</td><td>데이터 고유키</td></tr>
		<tr><td>latitude</td><td>Number</td><td>위도</td></tr>
		<tr><td>longitude</td><td>Number</td><td>경도</td></tr>
		<tr><td>height</td><td>Number</td><td>높이</td></tr>
		<tr><td>heading</td><td>Number</td><td>좌, 우</td></tr>
		<tr><td>pitch</td><td>Number</td><td>위, 아래</td></tr>
		<tr><td>roll</td><td>Number</td><td>좌, 우 기울기</td></tr>
		</table></br>
		<h4>실행</h4>
	<div class="paramContainer">
		<p>projectId :</p><input type="text" id="api8-p1" value="sample"></br>
		<p>dataKey :</p><input type="text" id="api8-p2" value="SOCIALROOM"></br>
		<p>longitude :</p><input type="text" id="api8-p3" value="127.0000"></br>
		<p>latitude :</p><input type="text" id="api8-p4" value="37.000"></br>
		<p>height :</p><input type="text" id="api8-p5" value="550"></br>
		<p>heading :</p><input type="text" id="api8-p6" value="0"></br>
		<p>pitch :</p><input type="text" id="api8-p7" value="0"></br>
		<p>roll :</p>
		<input type="text" id="api8-p8" value="0"></div></br> <input
			type="button" value="Run" class="popupBtn" onclick="changeLocationAndRotation()">
	</div>
	<div class="menu_tab01 mTs" id="panels" style="display: none;">
		</div>
</div>
<script>

var changeLocationAndRotation = function(){

var p1 = $('#api8-p1').val();
var p2 = $('#api8-p2').val();
var p3 = $('#api8-p3').val();
var p4 = $('#api8-p4').val();
var p5 = $('#api8-p5').val();
var p6 = $('#api8-p6').val();
var p7 = $('#api8-p7').val();
var p8 = $('#api8-p8').val();

changeLocationAndRotationAPI(MAGO3D_INSTANCE2, p1, p2, parseFloat(p4), parseFloat(p3), parseFloat(p5), parseFloat(p6), parseFloat(p7), parseFloat(p8));
}
</script>