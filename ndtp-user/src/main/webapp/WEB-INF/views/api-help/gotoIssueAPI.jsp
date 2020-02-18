<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="api25" class="apihelptoggle" style="display: none;">
	<div class="menu_tab">
		<ul>
			<li class="fst active"><a href="#;" onclick="tab_menu(0);">Run</a></li>
			<li><a href="#;" onclick="tab_menu(1);">Code</a></li>
		</ul>
	</div>
	<div class="menu_tab00 mTs" id="panels">
	<h2>gotoIssueAPI</h2>
	
	<p>해당 프로젝트를 로딩하고 그 이슈로 이동하는 API입니다.</p>
		<h4>파라미터</h4>
		<table>
		<tr><th>name</th><th>type</th><th>description</th></tr>
		<tr><td>managerFactoryInstance</td><td>ManagerFactory</td><td>mago3D 시작 부분</td></tr>
		<tr><td>projectId</td><td>String</td><td>프로젝트 아이디</td></tr>
		<tr><td>projectData</td><td>Object</td><td>프로젝트 데이터</td></tr>
		<tr><td>projectDataFolder</td><td>String</td><td>프로젝트 데이터 폴더</td></tr>
		<tr><td>issueId</td><td>String</td><td>이슈 아이디</td></tr>
		<tr><td>issueType</td><td>String</td><td>이슈 타입</td></tr>
		<tr><td>latitude</td><td>Number</td><td>위도</td></tr>
		<tr><td>longitude</td><td>Number</td><td>경도</td></tr>
		<tr><td>height</td><td>Number</td><td>높이</td></tr>
		<tr><td>duration</td><td>Number</td><td>이동하는 시간</td></tr>
		</table></br>
		<h4>실행</h4>
	<div class="paramContainer">
		<p>projectId :</p>
		<input type="text" id="api25-p1" value="ifc"></br>
		<p>projectData :</p>
		<input type="text" id="api25-p2" value="ProjectDataObject"></br>
		<p>projectDataFolder :</p>
		<input type="text" id="api25-p3" value="factory"></br>
		<p>issueId :</p>
		<input type="text" id="api25-p4" value="128"></br>
		<p>issueType :</p>
		<input type="text" id="api25-p5" value="ISSUE_TYPE_BUGGER"></br>
		<p>longitude :</p>
		<input type="text" id="api25-p6" value="127.000"></br>
		<p>latitude :</p>
		<input type="text" id="api25-p7" value="37.000"></br>
		<p>height :</p>
		<input type="text" id="api25-p8" value="550"></br>
		<p>duration :</p>
		<input type="text" id="api25-p9" value="10"></div></br> <input
			type="button" value="Run" class="popupBtn" onclick="gotoIssue()">
	</div>
	<div class="menu_tab01 mTs" id="panels" style="display: none;">
		</div>
</div>
<script>

var gotoIssue = function(){

var p1 = $('#api25-p1').val();
var p2 = $('#api25-p2').val();
var p3 = $('#api25-p3').val();
var p4 = $('#api25-p4').val();
var p5 = $('#api25-p5').val();
var p6 = $('#api25-p6').val();
var p7 = $('#api25-p7').val();
var p8 = $('#api25-p8').val();
var p9 = $('#api25-p9').val();

gotoIssueAPI(MAGO3D_INSTANCE2, p1, p2, p3, p4, p5, parseFloat(p6), parseFloat(p7), parseFloat(p8), parseFloat(p9));
}
</script>