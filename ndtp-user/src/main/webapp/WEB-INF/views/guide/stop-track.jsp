<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="api40" class="api-help-toggle">
	<div class="menu_tab">
		<ul>
			<li class="fst active"><a href="#" onclick="tabMenu(0);">Run</a></li>
			<li><a href="#" onclick="tabMenu(1);">Code</a></li>
		</ul>
	</div>
	<div id="panels" class="menu_tab00 mTs">
		<h2>stopTrackAPI</h2>
		<p>트레킹을 중지하는 API입니다.</p>
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
		</table>
		<br>
		<br> 
		<input type="button" id="stopTrack" value="Run" class="popupBtn" >
	</div>
	<div id="panels" class="menu_tab01 mTs" style="display: none;"></div>
</div>
<script>
	var stopTrack = function() {

			stopTrackAPI(MAGO3D_INSTANCE2);
	}
</script>