<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="api37" class="apihelptoggle" style="display: none;">
	<div class="menu_tab">
		<ul>
			<li class="fst active"><a href="#;" onclick="tab_menu(0);">Run</a></li>
			<li><a href="#;" onclick="tab_menu(1);">Code</a></li>
		</ul>
	</div>
	<div class="menu_tab00 mTs" id="panels">
	<h2>instantiateStaticModelAPI</h2>
	
	<p>정적 모델 인스턴스를 생성하는 API입니다.</p>
		<h4>파라미터</h4>
		<table>
		<tr><th>name</th><th>type</th><th>description</th></tr>
		<tr><td>managerFactoryInstance</td><td>ManagerFactory</td><td>mago3D 시작 부분</td></tr>
		<tr><td>attribute</td><td>Object</td><td>정적 모델 인스턴스화를 위한 환경 설정 변수</td></tr>
		</table></br>
		<h4>실행</h4>
	<div class="paramContainer">
		<p>projectId :</p>
		<input type="text" id="api37-p1" value="static_sample"></br>
		<p>instanceId :</p>
		<input type="text" id="api37-p2" value="building"></br>
		<p>longitude :</p>
		<input type="text" id="api37-p3" value="127.000"></br>
		<p>latitude :</p>
		<input type="text" id="api37-p4" value="37.000"></br>
		<p>height :</p>
		<input type="text" id="api37-p5" value="100"></br>
		<p>heading :</p>
		<input type="text" id="api37-p6" value="93.03254"></br>
		<p>pitch :</p>
		<input type="text" id="api37-p7" value="223.84163"></br>
		<p>roll :</p>
		<input type="text" id="api37-p8" value="123.74897"></div></br> <input
			type="button" value="Run" class="popupBtn" onclick="instantiateStaticModel()">
	</div>
	<div class="menu_tab01 mTs" id="panels" style="display: none;">
		</div>
</div>
<script>

var instantiateStaticModel = function(){

var p1 = $('#api37-p1').val();
var p2 = $('#api37-p2').val();
var p3 = $('#api37-p3').val();
var p4 = $('#api37-p4').val();
var p5 = $('#api37-p5').val();
var p6 = $('#api37-p6').val();
var p7 = $('#api37-p7').val();
var p8 = $('#api37-p8').val();

var attrObject = {
   projectId : p1,
   instanceId : p2,
   longitude : p3,
   latitude : p4,
   height : p5,
   heading : p6,
   pitch : p7,
   roll : p8
}

instantiateStaticModelAPI(MAGO3D_INSTANCE2, attrObject);
}
</script>