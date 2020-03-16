<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="api16" class="api-help-toggle">
	<div class="menu_tab">
		<ul>
			<li class="fst active"><a href="#" onclick="tabMenu(0);">Run</a></li>
			<li><a href="#" onclick="tabMenu(1);">Code</a></li>
		</ul>
	</div>
	<div id="panels" class="menu_tab00 mTs">
		<h2>changeFPVModeAPI</h2>
		<p>카메라를 1인칭, 3인칭 모드로 변경해주는 API입니다.</p>
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
				<td>flag</td>
				<td>Boolean</td>
				<td>true: 활성화, false: 비활성화</td>
			</tr>
		</table>
		<br/>
		<h4>실행</h4>
		<div class="paramContainer">
			<input type="radio" id="api16-opt1" name="api16-p1" value="true" />
			<label for="api16-opt1">활성</label>
			<input type="radio" id="api16-opt2" name="api16-p1" value="false" checked />
			<label for="api16-opt2">비활성</label>
		</div>
		<br/> 
		<input type="button" id="changeFPVMode" value="Run" class="popupBtn">
	</div>
	<div id="panels" class="menu_tab01 mTs" style="display: none;"></div>
</div>
<script>
	var changeFPVMode = function() {

		var flag = $("input[name=api16-p1]:checked").val();
		flag = (flag === 'true');

		changeFPVModeAPI(MAGO3D_INSTANCE2, flag);
	}
</script>