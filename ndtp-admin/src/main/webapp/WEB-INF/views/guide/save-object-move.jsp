<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="api10" class="api-help-toggle">
	<div class="menu_tab">
		<ul>
			<li class="fst active"><a href="#" onclick="tabMenu(0);">Run</a></li>
			<li><a href="#" onclick="tabMenu(1);">Code</a></li>
		</ul>
	</div>
	<div id="panels" class="menu_tab00 mTs">
		<h2>saveObjectMoveAPI</h2>
		<p>모든 객체 마우스 이동 이력을 Cache로 저장합니다.</p>
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
			<tr>
				<td>objectMoveMode</td>
				<td>Number</td>
				<td>0 = All, 1 = Object, 2 = None</td>
			</tr>
		</table>
		<br>
		<h4>실행</h4>
		<div class="paramContainer">
			<input type="radio" id="api10-opt1" name="api10-p1" value="0" /> 
			<label for="api10-opt1">all</label>
			<input type="radio" id="api10-opt2" name="api10-p1" value="1" />
			<label for="api10-opt2">object</label>
			<input type="radio" id="api10-opt3" name="api10-p1" value="2" checked />
			<label for="api10-opt3">non</label>
		</div>
		<br> 
		<input type="button" id="saveObjectMove" value="Run" class="popupBtn">
	</div>
	<div id="panels" class="menu_tab01 mTs" style="display: none;"></div>
</div>
<script>
	var saveObjectMove = function() {
		var objectMoveMode = $("input[name=api10-p1]:checked").val();

		saveObjectMoveAPI(MAGO3D_INSTANCE2, objectMoveMode);
	}
</script>