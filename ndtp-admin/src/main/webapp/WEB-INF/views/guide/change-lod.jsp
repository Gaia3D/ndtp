<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div id="api19" class="api-help-toggle">
	<div class="menu_tab">
		<ul>
			<li class="fst active"><a href="#" onclick="tabMenu(0);">Run</a></li>
			<li><a href="#" onclick="tabMenu(1);">Code</a></li>
		</ul>
	</div>
	<div id="panels" class="menu_tab00 mTs">
		<h2>changeLodAPI</h2>
		<p>LOD(Level Of Detail)설정을 변경해주는 API입니다.</p>
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
			<label for="api19-p1">lod0DistInMeters</label>
			<input type="text" id="api19-p1" value="15" data-require="false"><br/>
			<label for="api19-p2">lod1DistInMeters</label>
			<input type="text" id="api19-p2" value="60" data-require="false"><br/>
			<label for="api19-p3">lod2DistInMeters</label>
			<input type="text" id="api19-p3" value="90" data-require="false"><br/>
			<label for="api19-p4">lod3DistInMeters</label>
			<input type="text" id="api19-p4" value="200" data-require="false"><br/>
			<label for="api19-p5">lod4DistInMeters</label>
			<input type="text" id="api19-p5" value="1000" data-require="false"><br/>
			<label for="api19-p6">lod5DistInMeters</label>
			<input type="text" id="api19-p6" value="500000" data-require="false">
		</div>
		<br/> <input type="button" id="changeLod" value="Run" class="popupBtn">
	</div>
	<div id="panels" class="menu_tab01 mTs" style="display: none;"></div>
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