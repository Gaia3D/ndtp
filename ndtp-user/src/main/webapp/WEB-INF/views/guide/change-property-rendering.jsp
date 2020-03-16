<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="api5" class="api-help-toggle">
	<div class="menu_tab">
		<ul>
			<li class="fst active"><a href="#" onclick="tabMenu(0);">Run</a></li>
			<li><a href="#" onclick="tabMenu(1);">Code</a></li>
		</ul>
	</div>
	<div id="panels" class="menu_tab00 mTs">
		<h2>changePropertyRenderingAPI</h2>
		<p>속성값에 의한 가시화 여부를 설정하는 API입니다.</p>
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
			<tr>
				<td>projectId</td>
				<td>String</td>
				<td>프로젝트 아이디</td>
			</tr>
			<tr>
				<td>property</td>
				<td>String</td>
				<td>속성 값</td>
			</tr>
		</table>
		<br/>
		<h4>실행</h4>
		<div class="paramContainer">
			<input type="radio" id="api5-opt1" name="api5-p1" value="true" />
			<label for="api5-opt1">true</label>
			<input type="radio" id="api5-opt2" name="api5-p1" value="false" checked />
			<label for="api5-opt2">false</label><br/>
			<label for="api5-p2">projectId</label>
			<input type="text" id="api5-p2" value="sample" data-require="true" disabled><br/>
			<label for="api5-p3">property</label>
			<input type="text" id="api5-p3" value="isPhysical=true" data-require="true" disabled>
		</div>
		<br/> 
		<input type="button" id="changePropertyRendering" value="Run" class="popupBtn">
	</div>
	<div id="panels" class="menu_tab01 mTs" style="display: none;"></div>
</div>
<script>
	var changePropertyRendering = function() {
		
		var flag = $("input[name=api5-p1]:checked").val();
		flag = (flag === 'true');
		var projectId = $('#api5-p2').val();
		var property = $('#api5-p3').val();

		changePropertyRenderingAPI(MAGO3D_INSTANCE2, flag, projectId, property);
	}
</script>