<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="api27" class="apihelptoggle" style="display: none;">
	<div class="menu_tab">
		<ul>
			<li class="fst active"><a href="#;" onclick="tab_menu(0);">Run</a></li>
			<li><a href="#;" onclick="tab_menu(1);">Code</a></li>
		</ul>
	</div>
	<div class="menu_tab00 mTs" id="panels">
	<h2>isDataExistAPI</h2>
	
	<p>환경 설정 data map에 key 값의 존재 유무를 판별하는 API입니다.</p>
		<h4>파라미터</h4>
		<table>
		<tr><th>name</th><th>type</th><th>description</th></tr>
		<tr><td>dataKey</td><td>String</td><td>데이터 고유키</td></tr>
		</table></br>
		<h4>리턴</h4>
		<table>
		<tr><th>type</th><th>description</th></tr>
		<tr><td>Boolean</td><td>true: 존재, false: 없음</td></tr>
		</table></br>
		<h4>실행</h4>
	<div class="paramContainer">
		<p>dataKey :</p>
		<input type="text" id="api27-p1" value="sample"></div></br> <input
			type="button" value="Run" class="popupBtn" onclick="isDataExist()">
		<div id="api27-result">결과 :</div>
	</div>

	<div class="menu_tab01 mTs" id="panels" style="display: none;">
		</div>
</div>
<script>
	var isDataExist = function() {

		var p1 = $('#api27-p1').val();
		var r1 = isDataExistAPI("projectId_"+p1.toString());
		console.log(r1);

		document.getElementById("api27-result").innerText = r1.toString();

	}
</script>