<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="api6" class="apihelptoggle" style="display: none;">
	<div class="menu_tab">
		<ul>
			<li class="fst active"><a href="#;" onclick="tab_menu(0);">Run</a></li>
			<li><a href="#;" onclick="tab_menu(1);">Code</a></li>
		</ul>
	</div>
	<div class="menu_tab00 mTs" id="panels">
	<h2>changeShadowAPI</h2>

		
		<p>그림자 표시 유무를 설정하는 API입니다.</p>
		<h4>파라미터</h4>
		<table>
		<tr><th>name</th><th>type</th><th>description</th></tr>
		<tr><td>managerFactoryInstance</td><td>ManagerFactory</td><td>mago3D 시작 부분</td></tr>
		<tr><td>isShow</td><td>Boolean</td><td>true: 활성화, false: 비활성화</td></tr>
		</table></br>
		<h4>실행</h4>
		<div class="paramContainer">
		<select id="api6-p1">
			<option value="true" selected>활성</option>
			<option value="false">비활성</option>
		</select></div></br> <input type="button" value="Run" class="popupBtn" onclick="changeShadow()">
	</div>
	<div class="menu_tab01 mTs" id="panels" style="display: none;">
		</div>
</div>
<script>
   var changeShadow = function() {

      var p1 = $('#api6-p1').val();

      var isFalseBoolean = (p1 === 'true');
      
      changeShadowAPI(MAGO3D_INSTANCE2, isFalseBoolean);
   }
</script>