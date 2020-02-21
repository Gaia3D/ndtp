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
				<td>objectMoveMode</td>
				<td>Number</td>
				<td>0 = All, 1 = Object, 2 = None</td>
			</tr>
		</table>
		<br/>
		<h4>실행</h4>
		<div class="paramContainer">
			<p>objectMoveMode :</p>
			<label for="api11-opt1">all</label> 
			<input type="radio" id="api11-opt1" name="api11-p1" value="0" />
			<label for="api11-opt2">object</label> 
			<input type="radio" id="api11-opt2" name="api11-p1" value="1" />
			<label for="api11-opt3">non</label>
			<input type="radio" id="api11-opt3" name="api11-p1" value="2" checked />
		</div>
		<br/> 
		<input type="button" value="Run" class="popupBtn" onclick="deleteAllObjectMove()">
	</div>
	<div class="menu_tab01 mTs" id="panels" style="display: none;"></div>
</div>
<script>
	var deleteAllObjectMove = function() {

		var objectMoveMode = $("input[name=api11-p1]:checked").val();

		deleteAllObjectMoveAPI(MAGO3D_INSTANCE2, objectMoveMode);
	}
</script>