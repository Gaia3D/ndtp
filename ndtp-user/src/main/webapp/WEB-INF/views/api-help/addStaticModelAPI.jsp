<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="api38" class="apihelptoggle" style="display: none;">
	<div class="menu_tab">
		<ul>
			<li class="fst active"><a href="#;" onclick="tab_menu(0);">Run</a></li>
			<li><a href="#;" onclick="tab_menu(1);">Code</a></li>
		</ul>
	</div>
	<div class="menu_tab00 mTs" id="panels">
	<h2>addStaticModelAPI</h2>
	<p>정적 모델을 추가하는 API입니다.</p>
		<h4>파라미터</h4>
		<table>
		<tr><th>name</th><th>type</th><th>description</th></tr>
		<tr><td>managerFactoryInstance</td><td>ManagerFactory</td><td>mago3D 시작 부분</td></tr>
		<tr><td>attribute</td><td>Object</td><td>정적 모델 추가를 위한 환경 설정 변수</td></tr>
		</table></br>
		<h4>실행</h4>
		<div class="paramContainer">
		<p>projectId :</p><input type="text" id="api38-p1" value="static_sample"></br>
		<p>projectFolderName :</p><input type="text" id="api38-p2" value="sample"></br>
		<p>buildingFolderName :</p><input type="text" id="api38-p3" value="F4D_SOCIALROOM"></div></br> 
		<input type="button" value="Run" class="popupBtn" onclick="addStaticModel()">
	</div>
	<div class="menu_tab01 mTs" id="panels" style="display: none;">
		</div>
</div>
<script>
	var addStaticModel = function() {

		var p1 = $('#api38-p1').val();
		var p2 = $('#api38-p2').val();
		var p3 = $('#api38-p3').val();

		var attrObject = {
			projectId : p1,
			projectFolderName : p2,
			buildingFolderName : p3

		}

		addStaticModelAPI(MAGO3D_INSTANCE2, attrObject);
	}
</script>