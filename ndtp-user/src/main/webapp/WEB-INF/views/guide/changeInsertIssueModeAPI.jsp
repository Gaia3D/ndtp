<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="api13" class="api-help-toggle" style="display: none;">
	<div class="menu_tab">
		<ul>
			<li class="fst active"><a href="#" onclick="tabMenu(0);">Run</a></li>
			<li><a href="#" onclick="tabMenu(1);">Code</a></li>
		</ul>
	</div>
	<div class="menu_tab00 mTs" id="panels">
		<h2>changeInsertIssueModeAPI</h2>
		<p>changeInsertIssueModeAPI란 이슈 기능을 활성화하는 API입니다. 이 API에 파라미터인
			flag는 Boolean 타입이고 true이면 이슈 모드가 활성화되고 false이면 비활성화되는 방식입니다. 활성화되어있는
			상태에서 이슈를 등록하고 싶은 Object를 클릭하면 callback함수를 관리해주는 데이터베이스 운영정책에 따라서 이슈등록
			callback함수가 호출이되어 이슈등록 창이 나옵니다. 이슈등록 창에 내용을 적고 저장하면 데이터베이스에 등록이됩니다.
			또한, 이슈등록 callback함수는 사용자가 Customizing이 가능합니다.</p>
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
				<td>flag</td>
				<td>Boolean</td>
				<td>true: 활성화, false: 비활성화</td>
			</tr>
		</table>
		<br/>
		<h4>실행</h4>
		<div class="paramContainer">
			<label for="api13-opt1">활성</label>
			<input type="radio" id="api13-opt1" name="api13-p1" value="true" />
			<label for="api13-opt2">비활성</label>
			<input type="radio" id="api13-opt2" name="api13-p1" value="false" checked />
		</div>
		<br/> 
		<input type="button" value="Run" class="popupBtn" onclick="changeInsertIssueMode()">
	</div>
	<div class="menu_tab01 mTs" id="panels" style="display: none;"></div>
</div>
<script>
	var changeInsertIssueMode = function() {

		var flag = $("input[name=api13-p1]:checked").val();

		var isFalseBoolean = (flag === 'true');

		changeInsertIssueModeAPI(MAGO3D_INSTANCE2, isFalseBoolean);
	}
</script>