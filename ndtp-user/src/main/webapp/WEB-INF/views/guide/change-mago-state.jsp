<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="api1" class="api-help-toggle">
	<div class="menu_tab">
		<ul>
			<li class="fst active"><a href="#" onclick="tabMenu(0);">Run</a></li>
			<li><a href="#" onclick="tabMenu(1);">Code</a></li>
		</ul>
	</div>
	<div id="panels" class="menu_tab00 mTs">
		<h2>changeMagoStateAPI</h2>
		<p>mago3D 활성화 상태 값을 변경함으로써 화면에 mago3D Object가 표시, 비표시 됩니다.</p>
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
			<input type="radio" id="api1-opt1" name="api1-p1" value="true" />
			<label for="api1-opt1">활성</label>
			<input type="radio" id="api1-opt2" name="api1-p1" value="false" checked />
			<label for="api1-opt2">비활성</label>
		</div>
		<br/> 
		<input type="button" id="changeMagoState" value="Run" class="popupBtn">
	</div>
	<div id="panels" class="menu_tab01 mTs" style="display: none; float: left"></div>
</div>
<script>
	var changeMagoState = function() {

		var flag = $("input[name=api1-p1]:checked").val();
		flag = (flag === 'true');
		changeMagoStateAPI(MAGO3D_INSTANCE2, flag);
	}
</script>