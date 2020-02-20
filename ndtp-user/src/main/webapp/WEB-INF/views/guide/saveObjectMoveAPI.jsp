<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="api10" class="api-help-toggle" style="display: none;">
	<div class="menu_tab">
		<ul>
			<li class="fst active"><a href="#" onclick="tabMenu(0);">Run</a></li>
			<li><a href="#" onclick="tabMenu(1);">Code</a></li>
		</ul>
	</div>
	<div class="menu_tab00 mTs" id="panels">
		<h2>saveObjectMoveAPI</h2>
		<p>모든 객체 마우스 이동 이력을 Cache로 저장합니다.</p>
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
				<td>objectMoveMode</td>
				<td>Number</td>
				<td>0 = All, 1 = Object, 2 = None</td>
			</tr>
		</table>
		<br>
		<h4>실행</h4>
		<div class="paramContainer">
			<p>objectMoveMode :</p>
			<label><input type="radio" name="api10-p1" value="0" />all</label> 
			<label><input type="radio" name="api10-p1" value="1" />object</label> 
			<label><input type="radio" name="api10-p1" value="2" checked />non</label>
		</div>
		<br> 
		<input type="button" value="Run" class="popupBtn" onclick="saveObjectMove()">
	</div>
	<div class="menu_tab01 mTs" id="panels" style="display: none;"></div>
</div>
<script>
	var saveObjectMove = function() {

		var objectMoveMode = $("input[name=api10-p1]:checked").val();

		saveObjectMoveAPI(MAGO3D_INSTANCE2, objectMoveMode);
	}
</script>