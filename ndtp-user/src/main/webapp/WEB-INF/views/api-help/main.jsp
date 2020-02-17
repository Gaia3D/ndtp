<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="api0" class="apihelptoggle" >
	 <img src="/images/ko/common/main.png">
	<div class="menu_tab00 mTs" id="panels">
	
		<div class="paramContainer">
		</div>
	</div>
	<div class="menu_tab01 mTs" id="panels" style="display: none;">
		</div>
</div>
<script>
	var addStaticModel = function() {

		var p1 = $('#api38-p1').val();
		var p2 = $('#api38-p2').val();
		var p3 = $('#api38-p3').val();

		var attrObject = {
			projectId : p1,
			projectFolderName : p2,
			buildingFolderName : p3

		}

		addStaticModelAPI(MAGO3D_INSTANCE2, attrObject);
	}
</script>