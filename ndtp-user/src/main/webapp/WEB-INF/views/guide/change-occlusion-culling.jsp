<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="api15" class="api-help-toggle">
	<div class="menu_tab">
		<ul>
			<li class="fst active"><a href="#" onclick="tabMenu(0);">Run</a></li>
			<li><a href="#" onclick="tabMenu(1);">Code</a></li>
		</ul>
	</div>
	<div id="panels" class="menu_tab00 mTs">
		<h2>changeOcclusionCullingAPI</h2>
		<p>객체 Occlusion Culling 기능을 활성화, 비활성화 하는 기능입니다.</p>
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
				<td>dataKey</td>
				<td>String</td>
				<td>데이터 고유키</td>
			</tr>
		</table>
		<br/>
		<h4>실행</h4>
		<div class="paramContainer">
			<input type="radio" id="api15-opt1" name="api15-p1" value="true" />
			<label for="api15-opt1">활성</label>
			<input type="radio" id="api15-opt2" name="api15-p1" value="false" checked />
			<label for="api15-opt2">비활성</label><br/>
			<label for="api15-p2">dataKey</label>
			<input type="text" id="api15-p2" value="SOCIALROOM" data-require="true" disabled>
			
		</div>
		<br/> 
		<input type="button" id="changeOcclusionCulling" value="Run" class="popupBtn">
	</div>
	<div id="panels" class="menu_tab01 mTs" style="display: none;"></div>
</div>
<script>
	var changeOcclusionCulling = function() {
		var flag = $("input[name=api15-p1]:checked").val();
		flag = (flag === 'true');
		var dataKey = $('#api15-p2').val();

		changeOcclusionCullingAPI(MAGO3D_INSTANCE2, flag, dataKey);
	}
</script>