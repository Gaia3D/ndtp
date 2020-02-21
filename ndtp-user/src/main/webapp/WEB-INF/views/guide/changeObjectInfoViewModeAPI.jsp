<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="api14" class="api-help-toggle" style="display: none;">
	<div class="menu_tab">
		<ul>
			<li class="fst active"><a href="#" onclick="tabMenu(0);">Run</a></li>
			<li><a href="#" onclick="tabMenu(1);">Code</a></li>
		</ul>
	</div>
	<div class="menu_tab00 mTs" id="panels">
		<h2>changeObjectInfoViewModeAPI</h2>
		<p>changeObjectInfoViewModeAPI는 Object정보표시 기능을 활성화하는 API입니다. 이
			API에 파라미터인 flag는 Boolean 타입이고 true이면 정보 표시 모드가 활성화되고 false이면 비활성화되는
			방식입니다. 활성화되어있는 상태에서 정보를 알고 싶은 Object를 클릭하면 callback함수를 관리해주는 데이터베이스
			운영정책에 따라서 정보표시 callback함수가 호출되고 Jquery Plugin Toast통하여 Object정보가
			나옵니다. 또한, 정보표시 callback함수는 사용자가 Customizing이 가능합니다.</p>
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
				<td>flag</td>
				<td>Boolean</td>
				<td>true: 활성화, false: 비활성화</td>
			</tr>
		</table>
		<br/>
		<h4>실행</h4>
		<div class="paramContainer">
			<label><input type="radio" name="api14-p1" value="true" />활성</label>
			<label><input type="radio" name="api14-p1" value="false" checked />비활성</label>
		</div>
		<br/> <input type="button" value="Run" class="popupBtn" onclick="changeObjectInfoViewMode()">
	</div>
	<div class="menu_tab01 mTs" id="panels" style="display: none;"></div>
</div>
<script>
	var changeObjectInfoViewMode = function() {

		var flag = $("input[name=api14-p1]:checked").val();
		var isFalseBoolean = (flag === 'true');

		changeObjectInfoViewModeAPI(MAGO3D_INSTANCE2, isFalseBoolean);
	}
</script>