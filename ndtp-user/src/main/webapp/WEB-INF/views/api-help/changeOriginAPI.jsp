<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="api3" class="api-help-toggle" style="display: none;">
	<div class="menu_tab">
		<ul>
			<li class="fst active"><a href="#" onclick="tabMenu(0);">Run</a></li>
			<li><a href="#" onclick="tabMenu(1);">Code</a></li>
		</ul>
	</div>
	<div class="menu_tab00 mTs" id="panels">
		<h2>changeOriginAPI</h2>
		<p>changeOriginAPI 활성화 상태 값을 변경함으로써 Origin이 표시, 비표시 됩니다.</p>
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
				<td>isShow</td>
				<td>Boolean</td>
				<td>true: 활성화, false: 비활성화</td>
			</tr>
		</table>
		<br>
		<h4>실행</h4>
		<div class="paramContainer">
			<label><input type="radio" name="api3-p1" value="true" />활성</label>
			<label><input type="radio" name="api3-p1" value="false" checked />비활성</label>
		</div>
		<br> 
		<input type="button" value="Run" class="popupBtn" onclick="changeOrigin()">
	</div>
	<div class="menu_tab01 mTs" id="panels" style="display: none;"></div>
</div>
<script>
	var changeOrigin = function() {

		var flag = $("input[name=api3-p1]:checked").val();
		var isFalseBoolean = (flag === 'true');

		changeOriginAPI(MAGO3D_INSTANCE2, isFalseBoolean);
	}
</script>