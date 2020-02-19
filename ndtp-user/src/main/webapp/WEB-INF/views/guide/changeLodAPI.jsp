<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="api19" class="apihelptoggle" style="display: none;">
	<div class="menu_tab">
		<ul>
			<li class="fst active"><a href="#;" onclick="tab_menu(0);">Run</a></li>
			<li><a href="#;" onclick="tab_menu(1);">Code</a></li>
		</ul>
	</div>
	<div class="menu_tab00 mTs" id="panels">
	<h2>changeLodAPI</h2>
	
		<p>LOD(Level Of Detail)설정을 변경해주는 API입니다.</p>
		<h4>파라미터</h4>
		<table>
		<tr><th>name</th><th>type</th><th>description</th></tr>
		<tr><td>managerFactoryInstance</td><td>ManagerFactory</td><td>mago3D 시작 부분</td></tr>
		<tr><td>lod0DistInMeters</td><td>Number</td><td>lod0이 적용될 최소거리</td></tr>
		<tr><td>lod1DistInMeters</td><td>Number</td><td>lod1이 적용될 최소거리</td></tr>
		<tr><td>lod2DistInMeters</td><td>Number</td><td>lod2이 적용될 최소거리</td></tr>
		<tr><td>lod3DistInMeters</td><td>Number</td><td>lod3이 적용될 최소거리</td></tr>
		<tr><td>lod4DistInMeters</td><td>Number</td><td>lod4이 적용될 최소거리</td></tr>
		<tr><td>lod5DistInMeters</td><td>Number</td><td>lod5이 적용될 최소거리</td></tr>
		</table></br>
		<h4>실행</h4>
	
	<div class="paramContainer">
		<p>lod0DistInMeters :</p>
		<input type="text" id="api19-p1" value="15"></br>
		<p>lod1DistInMeters :</p>
		<input type="text" id="api19-p2" value="60"></br>
		<p>lod2DistInMeters :</p>
		<input type="text" id="api19-p3" value="90"></br>
		<p>lod3DistInMeters :</p>
		<input type="text" id="api19-p4" value="200"></br>
		<p>lod4DistInMeters :</p>
		<input type="text" id="api19-p5" value="1000"></br>
		<p>lod5DistInMeters :</p>
		<input type="text" id="api19-p6" value="500000"></div></br> <input
			type="button" value="Run" class="popupBtn" onclick="changeLod()">
	</div>
	<div class="menu_tab01 mTs" id="panels" style="display: none;">
		</div>
</div>
<script>

var changeLod = function(){

var p1 = $('#api19-p1').val();
var p2 = $('#api19-p2').val();
var p3 = $('#api19-p3').val();
var p4 = $('#api19-p4').val();
var p5 = $('#api19-p5').val();
var p6 = $('#api19-p6').val();

changeLodAPI(MAGO3D_INSTANCE2, parseFloat(p1), parseFloat(p2), parseFloat(p3), parseFloat(p4), parseFloat(p5), parseFloat(p6));
}
</script>