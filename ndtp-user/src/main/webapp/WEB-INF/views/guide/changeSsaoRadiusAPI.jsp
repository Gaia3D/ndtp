<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="api21" class="api-help-toggle" style="display: none;">
	<div class="menu_tab">
		<ul>
			<li class="fst active"><a href="#" onclick="tabMenu(0);">Run</a></li>
			<li><a href="#" onclick="tabMenu(1);">Code</a></li>
		</ul>
	</div>
	<div class="menu_tab00 mTs" id="panels">
		<h2>changeSsaoRadiusAPI</h2>
		<p>선택한 객체의 그림자 반경를 설정해주는 API입니다.</p>
		<h4>파라미터</h4>
		<table>
			<tr>
				<th>name</th>
				<th>type</th>
				<th>description</th>
			</tr>
			<tr>
				<td>managerFactoryInstance</td>
				<td>ManagerFactory</td>
				<td>mago3D 시작 부분</td>
			</tr>
			<tr>
				<td>ssaoRadius</td>
				<td>Number</td>
				<td>그림자 반경</td>
			</tr>
		</table>
		<br/>
		<h4>실행</h4>
		<div class="paramContainer">
			<label>ssaoRadius :</label>
			<input type="text" id="api21-p1" value="0.15">
		</div>
		<br/> 
		<input type="button" value="Run" class="popupBtn" onclick="changeSsaoRadius()">
	</div>
	<div class="menu_tab01 mTs" id="panels" style="display: none;"></div>
</div>
<script>
	var changeSsaoRadius = function() {

		var ssaoRadius = $('#api21-p1').val();

		changeSsaoRadiusAPI(MAGO3D_INSTANCE2, parseFloat(ssaoRadius));
	}
</script>