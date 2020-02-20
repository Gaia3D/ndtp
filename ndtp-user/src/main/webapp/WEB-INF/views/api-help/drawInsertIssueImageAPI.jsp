<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="api23" class="api-help-toggle" style="display: none;">
	<div class="menu_tab">
		<ul>
			<li class="fst active"><a href="#" onclick="tabMenu(0);">Run</a></li>
			<li><a href="#" onclick="tabMenu(1);">Code</a></li>
		</ul>
	</div>
	<div class="menu_tab00 mTs" id="panels">
		<h2>drawInsertIssueImageAPI</h2>
		<p>이슈 등록시 화면에 표출되는 고정핀 이미지를 그려주는 API입니다.</p>
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
				<td>drawType</td>
				<td>Number</td>
				<td>이미지 유형</td>
			</tr>
			<tr>
				<td>issue_id</td>
				<td>String</td>
				<td>이슈 고유키</td>
			</tr>
			<tr>
				<td>issue_type</td>
				<td>String</td>
				<td>이슈 타입</td>
			</tr>
			<tr>
				<td>data_key</td>
				<td>String</td>
				<td>데이터 고유키</td>
			</tr>
			<tr>
				<td>latitude</td>
				<td>Number</td>
				<td>위도</td>
			</tr>
			<tr>
				<td>longitude</td>
				<td>Number</td>
				<td>경도</td>
			</tr>
			<tr>
				<td>height</td>
				<td>Number</td>
				<td>높이</td>
			</tr>
		</table>
		<br>
		<h4>실행</h4>
		<div class="paramContainer">
			<p>drawType :</p>
			<input type="text" id="api23-p1" value="1"><br>
			<p>issue_id :</p>
			<input type="text" id="api23-p2" value="128"><br>
			<p>issue_type :</p>
			<input type="text" id="api23-p3" value="ISSUE_TYPE_BUGGER"><br>
			<p>data_key :</p>
			<input type="text" id="api23-p4" value="factory"><br>
			<p>longitude :</p>
			<input type="text" id="api23-p5" value="127.000"><br>
			<p>latitude :</p>
			<input type="text" id="api23-p6" value="37.000"><br>
			<p>height :</p>
			<input type="text" id="api23-p7" value="550">
		</div>
		<br> 
		<input type="button" value="Run" class="popupBtn" onclick="drawInsertIssueImage()">
	</div>
	<div class="menu_tab01 mTs" id="panels" style="display: none;"></div>
</div>
<script>
	var drawInsertIssueImage = function() {

		var drawType = $('#api23-p1').val();
		var issue_id = $('#api23-p2').val();
		var issue_type = $('#api23-p3').val();
		var data_key = $('#api23-p4').val();
		var longitude = $('#api23-p5').val();
		var latitude = $('#api23-p6').val();
		var height = $('#api23-p7').val();

		drawInsertIssueImageAPI(MAGO3D_INSTANCE2, parseFloat(drawType), issue_id, issue_type, data_key, parseFloat(longitude), parseFloat(latitude), parseFloat(height));
	}
</script>