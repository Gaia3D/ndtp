<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="api39" class="api-help-toggle" style="display: none;">
	<div class="menu_tab">
		<ul>
			<li class="fst active"><a href="#" onclick="tabMenu(0);">Run</a></li>
			<li><a href="#" onclick="tabMenu(1);">Code</a></li>
		</ul>
	</div>
	<div class="menu_tab00 mTs" id="panels">
		<h2>setTrackNodeAPI</h2>
		<p>트래킹 할 노드를 설정하는 API입니다. 설정한 데이터를 카메라가 계속 바라보게 됩니다.</p>
		<table>
		<caption>파라미터</caption>
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
				<td>트래킹 카메라 옵션</td>
			</tr>
		</table>
		<br>
		<h4>실행</h4>
		<div class="paramContainer">
			<label for="api39-p1">projectId :</label>
			<input type="text" id="api39-p1" value="sample"><br>
			<label for="api39-p2">dataKey :</label>
			<input type="text" id="api39-p2" value="SOCIALROOM"><br>
			<label for="api39-p3">option_y :</label>
			<input type="text" id="api39-p3" value="-1"><br>
			<label for="api39-p4">option_z :</label>
			<input type="text" id="api39-p4" value="12">
		</div>
		<br> 
		<input type="button" value="Run" class="popupBtn" onclick="setTrackNode()">
	</div>
	<div class="menu_tab01 mTs" id="panels" style="display: none;"></div>
</div>
<script>
	var setTrackNode = function() {

		var projectId = $('#api39-p1').val();
		var dataKey = $('#api39-p2').val();
		var option_y = $('#api39-p3').val();
		var option_z = $('#api39-p4').val();
		var optionObject = {
			y : parseFloat(option_y),
			z : parseFloat(option_z)
		};

		setTrackNodeAPI(MAGO3D_INSTANCE2, projectId, dataKey, optionObject);
	}
</script>