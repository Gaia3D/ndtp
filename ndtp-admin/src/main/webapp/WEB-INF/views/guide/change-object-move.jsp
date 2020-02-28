<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="api9" class="api-help-toggle">
	<div class="menu_tab">
		<ul>
			<li class="fst active"><a href="#" onclick="tabMenu(0);">Run</a></li>
			<li><a href="#" onclick="tabMenu(1);">Code</a></li>
		</ul>
	</div>
	<div id="panels" class="menu_tab00 mTs">
		<h2>changeObjectMoveAPI</h2>
		<p>객체의 이동 모드를 변경하는 API입니다. 이동 모드(objectMoveMode) 값이 0(All)일 경우 건물
			전체가 선택 및 이동되며, 1(Object)일 경우 창문과 같이 객체 단위로 선택 및 이동이 가능하며, 2(None)일 경우
			객체가 선택되지 않고 화면이 이동됩니다.</p>
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
		<br/>
		<h4>실행</h4>
		<div class="paramContainer">
			<input type="radio" id="api9-opt1" name="api9-p1" value="0" />
			<label for="api9-opt1">All</label> 
			<input type="radio" id="api9-opt2" name="api9-p1" value="1" />
			<label for="api9-opt2">Object</label> 
			<input type="radio" id="api9-opt3" name="api9-p1" value="2" checked />
			<label for="api9-opt3">None</label>
		</div>
		<br/> 
		<input type="button" id="changeObjectMove" value="Run" class="popupBtn">
	</div>
	<div id="panels" class="menu_tab01 mTs" style="display: none;"></div>
</div>
<script>
	var changeObjectMove = function() {

		var objectMoveMode = $("input[name=api9-p1]:checked").val();

		changeObjectMoveAPI(MAGO3D_INSTANCE2, objectMoveMode);
	}
</script>