<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<div id="api4" class="api-help-toggle" style="display: none;">
	<div class="menu_tab">
		<ul>
			<li class="fst active"><a href="#" onclick="tabMenu(0);">Run</a></li>
			<li><a href="#" onclick="tabMenu(1);">Code</a></li>
		</ul>
	</div>
	<div class="menu_tab00 mTs" id="panels">
		<h2>changeBoundingBoxAPI</h2>
		<p>changeBoundingBoxAPI 활성화 상태 값을 변경함으로써 BoundingBox가 표시, 비표시 됩니다.</p>
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
				<td>isShow</td>
				<td>Boolean</td>
				<td>true: 활성화, false: 비활성화</td>
			</tr>
		</table>
		<br/>
		<h4>실행</h4>
		<div class="paramContainer">
			<input type="radio" id="api4-opt1" name="api4-p1" value="true" />
			<label for="api4-opt1">활성</label>
			<input type="radio" id="api4-opt2" name="api4-p1" value="false"	checked />
			<label for="api4-opt2">비활성</label>
		</div><br/>
		 
		<input type="button" id="changeBoundingBox" value="Run" class="popupBtn">
	</div>
	<div class="menu_tab01 mTs" id="panels" style="display: none;"></div>
</div>
<script>
	var changeBoundingBox = function() {

		var flag = $("input[name=api4-p1]:checked").val();
		var isFalseBoolean = (flag === "true");

		changeBoundingBoxAPI(MAGO3D_INSTANCE2, isFalseBoolean);
	}
</script>