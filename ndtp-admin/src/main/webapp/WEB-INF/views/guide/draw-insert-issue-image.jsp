<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="api23" class="api-help-toggle">
	<div class="menu_tab">
		<ul>
			<li class="fst active"><a href="#" onclick="tabMenu(0);">Run</a></li>
			<li><a href="#" onclick="tabMenu(1);">Code</a></li>
		</ul>
	</div>
	<div id="panels" class="menu_tab00 mTs">
		<h2>drawInsertIssueImageAPI</h2>
		<p>이슈 등록시 화면에 표출되는 고정핀 이미지를 그려주는 API입니다.</p>
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
		<br/>
		<h4>실행</h4>
		<div class="paramContainer">
			<label for="api23-p1">drawType</label>
			<input type="text" id="api23-p1" value="1" data-require="true"><br/>
			<label for="api23-p2">issue_id</label>
			<input type="text" id="api23-p2" value="128" data-require="true"><br/>
			<label for="api23-p3">issue_type</label>
			<input type="text" id="api23-p3" value="ISSUE_TYPE_BUGGER" data-require="true"><br/>
			<label for="api23-p4">data_key</label>
			<input type="text" id="api23-p4" value="factory" data-require="true"><br/>
			<label for="api23-p5">longitude</label>
			<input type="text" id="api23-p5" value="126.923785" data-require="true"><br/>
			<label for="api23-p6">latitude</label>
			<input type="text" id="api23-p6" value="37.521168" data-require="true"><br/>
			<label for="api23-p7">height</label>
			<input type="text" id="api23-p7" value="100" data-require="true">
		</div>
		<br/> 
		<input type="button" id="drawInsertIssueImage" value="Run" class="popupBtn">
	</div>
	<div id="panels" class="menu_tab01 mTs" style="display: none;"></div>
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

		drawInsertIssueImageAPI(MAGO3D_INSTANCE2, parseFloat(drawType), issue_id, issue_type, data_key, parseFloat(latitude), parseFloat(longitude), parseFloat(height));
	}
</script>