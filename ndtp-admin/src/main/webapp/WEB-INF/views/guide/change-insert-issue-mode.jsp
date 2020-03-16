<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="api13" class="api-help-toggle">
	<div class="menu_tab">
		<ul>
			<li class="fst active"><a href="#" onclick="tabMenu(0);">Run</a></li>
			<li><a href="#" onclick="tabMenu(1);">Code</a></li>
		</ul>
	</div>
	<div id="panels" class="menu_tab00 mTs">
		<h2>changeInsertIssueModeAPI</h2>
		<p>changeInsertIssueModeAPI란 이슈 기능을 활성화하는 API입니다. 이 API에 파라미터인
			flag는 Boolean 타입이고 true이면 이슈 모드가 활성화되고 false이면 비활성화되는 방식입니다. 활성화되어있는
			상태에서 이슈를 등록하고 싶은 Object를 클릭하면 Object의 정보가 표시되며 이슈등록 callback함수는 사용자가 Customizing이 가능합니다.</p>
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
		</table>
		<br/>
		<h4>실행</h4>
		<div class="paramContainer">
			<input type="radio" id="api13-opt1" name="api13-p1" value="true" />
			<label for="api13-opt1">활성</label>
			<input type="radio" id="api13-opt2" name="api13-p1" value="false" checked />
			<label for="api13-opt2">비활성</label>
		</div>
		<br/> 
		<input type="button" id="changeInsertIssueMode" value="Run" class="popupBtn">
		<div id="resultContainer">
			<h4>결과</h4>
			<table id="api13-result"></table>
		</div>
		</div>
	<div id="panels" class="menu_tab01 mTs" style="display: none;"></div>
</div>
<script>
	var changeInsertIssueMode = function() {
		var table = document.getElementById("api13-result");
		table.innerHTML = '';
		var flag = $("input[name=api13-p1]:checked").val();
		flag = (flag === 'true');

		changeInsertIssueModeAPI(MAGO3D_INSTANCE2, flag);
	}

	function insertIssueCallBack(projectId, dataKey, objectId, latitude, longitude, altitude){
		var table = document.getElementById("api13-result");
		if(table) {
			table.innerHTML = '';
			var result = {
	        		projectId: projectId,
	        		dataKey : dataKey,
	        		objectId : objectId,
	        		latitude : latitude,
	        		longitude : longitude,
	        		altitude : altitude
	        }
			
			for ( var i in Object.keys(result)) {
				var row = table.insertRow();
				var th = document.createElement("th");
				var td = document.createElement("td");
				var key = document.createTextNode(Object.keys(result)[i]);
				var value = document.createTextNode(Object.values(result)[i]);
				th.appendChild(key);
				td.appendChild(value);
				row.appendChild(th);
				row.appendChild(td);
			}
		}
		if($('#api13').length!=0){
			$('.popupGroup').stop().animate({scrollTop:$('.menu_tab00').height()},800);
		}
    }
</script>