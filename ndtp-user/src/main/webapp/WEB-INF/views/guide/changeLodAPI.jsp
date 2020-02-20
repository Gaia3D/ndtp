<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="api19" class="api-help-toggle" style="display: none;">
	<div class="menu_tab">
		<ul>
			<li class="fst active"><a href="#" onclick="tabMenu(0);">Run</a></li>
			<li><a href="#" onclick="tabMenu(1);">Code</a></li>
		</ul>
	</div>
	<div class="menu_tab00 mTs" id="panels">
		<h2>changeLodAPI</h2>
		<p>LOD(Level Of Detail)설정을 변경해주는 API입니다.</p>
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
				<td>lod0DistInMeters</td>
				<td>Number</td>
				<td>lod0이 적용될 최소거리</td>
			</tr>
			<tr>
				<td>lod1DistInMeters</td>
				<td>Number</td>
				<td>lod1이 적용될 최소거리</td>
			</tr>
			<tr>
				<td>lod2DistInMeters</td>
				<td>Number</td>
				<td>lod2이 적용될 최소거리</td>
			</tr>
			<tr>
				<td>lod3DistInMeters</td>
				<td>Number</td>
				<td>lod3이 적용될 최소거리</td>
			</tr>
			<tr>
				<td>lod4DistInMeters</td>
				<td>Number</td>
				<td>lod4이 적용될 최소거리</td>
			</tr>
			<tr>
				<td>lod5DistInMeters</td>
				<td>Number</td>
				<td>lod5이 적용될 최소거리</td>
			</tr>
		</table>
		<br/>
		<h4>실행</h4>
		<div class="paramContainer">
			<label>lod0DistInMeters :</label>
			<input type="text" id="api19-p1" value="15"><br/>
			<label>lod1DistInMeters :</label>
			<input type="text" id="api19-p2" value="60"><br/>
			<label>lod2DistInMeters :</label>
			<input type="text" id="api19-p3" value="90"><br/>
			<label>lod3DistInMeters :</label>
			<input type="text" id="api19-p4" value="200"><br/>
			<label>lod4DistInMeters :</label>
			<input type="text" id="api19-p5" value="1000"><br/>
			<label>lod5DistInMeters :</label>
			<input type="text" id="api19-p6" value="500000">
		</div>
		<br/> <input type="button" value="Run" class="popupBtn" onclick="changeLod()">
	</div>
	<div class="menu_tab01 mTs" id="panels" style="display: none;"></div>
</div>
<script>
	var changeLod = function() {

		var lod0DistInMeters = $('#api19-p1').val();
		var lod1DistInMeters = $('#api19-p2').val();
		var lod2DistInMeters = $('#api19-p3').val();
		var lod3DistInMeters = $('#api19-p4').val();
		var lod4DistInMeters = $('#api19-p5').val();
		var lod5DistInMeters = $('#api19-p6').val();

		changeLodAPI(MAGO3D_INSTANCE2, parseFloat(lod0DistInMeters), parseFloat(lod1DistInMeters),
				parseFloat(lod2DistInMeters), parseFloat(lod3DistInMeters), parseFloat(lod4DistInMeters), parseFloat(lod5DistInMeters));
	}
</script>