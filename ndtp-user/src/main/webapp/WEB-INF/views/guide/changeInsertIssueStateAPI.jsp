<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="api18" class="api-help-toggle" style="display: none;">
	<div class="menu_tab">
		<ul>
			<li class="fst active"><a href="#" onclick="tabMenu(0);">Run</a></li>
			<li><a href="#" onclick="tabMenu(1);">Code</a></li>
		</ul>
	</div>
	<div class="menu_tab00 mTs" id="panels">
		<h2>changeInsertIssueStateAPI</h2>
		<p>mago3DJS 엔진이 이슈 등록을 위해서 좌표를 기억하고 있었는데
		changeInsertIssueStateAPI에 파라미터에 0을 넘겨 주면 좌표를 초기화합니다.</p>
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
				<td>insertIssueState</td>
				<td>String</td>
				<td>이슈 등록 좌표 상태</td>
			</tr>
		</table>
		<br/>
		<h4>실행</h4>
		<div class="paramContainer">
			<label>insertIssueState :</label>
			<input type="text" id="api18-p1" value="0">
		</div>
		<br/> 
		<input type="button" value="Run" class="popupBtn" onclick="changeInsertIssueState()">
	</div>
	<div class="menu_tab01 mTs" id="panels" style="display: none;"></div>
</div>
<script>
	var changeInsertIssueState = function() {

		var insertIssueState = $('#api18-p1').val();

		changeInsertIssueStateAPI(MAGO3D_INSTANCE2, parseFloat(insertIssueState));
	}
</script>