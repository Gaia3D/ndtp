<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="api11" class="api-help-toggle" style="display: none;">
	<div class="menu_tab">
		<ul>
			<li class="fst active"><a href="#" onclick="tabMenu(0);">Run</a></li>
			<li><a href="#" onclick="tabMenu(1);">Code</a></li>
		</ul>
	</div>
	<div class="menu_tab00 mTs" id="panels">
		<h2>deleteAllObjectMoveAPI</h2>
		<p>모든 객체 마우스 이동 이력을 Cache로 삭제합니다.</p>
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
		</table>
		<br/>
		<div class="paramContainer">
			
		</div>
		<br/> 
		<input type="button" id="deleteAllObjectMove" value="Run" class="popupBtn">
	</div>
	<div class="menu_tab01 mTs" id="panels" style="display: none;"></div>
</div>
<script>
	var deleteAllObjectMove = function() {
		var objectMoveMode = "0";
		deleteAllObjectMoveAPI(MAGO3D_INSTANCE2, objectMoveMode);
	}
</script>