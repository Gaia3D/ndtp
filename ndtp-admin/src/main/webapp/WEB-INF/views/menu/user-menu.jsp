<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>관리자 메뉴 | NDTP</title>
	<link rel="stylesheet" href="/css/${lang}/font/font.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/externlib/normalize/normalize.min.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/css/fontawesome-free-5.2.0-web/css/all.min.css?cacheVersion=${contentCacheVersion}">
    <link rel="stylesheet" href="/css/${lang}/admin-style.css?cacheVersion=${contentCacheVersion}" />
    <link type="text/css" rel="stylesheet" href="/externlib/${lang}/axisj/ui/arongi/font-awesome.min.css?cacheVersion=${contentCacheVersion}" />
   	<link type="text/css" rel="stylesheet" href="../externlib/${lang}/axisj/ui/arongi/AXJ.min.css?cacheVersion=${contentCacheVersion}" />
	<link type="text/css" rel="stylesheet" href="../externlib/${lang}/axisj/ui/arongi/AXButton.css?cacheVersion=${contentCacheVersion}" />
	<link type="text/css" rel="stylesheet" href="../externlib/${lang}/axisj/ui/arongi/AXInput.css?cacheVersion=${contentCacheVersion}" />
	<link type="text/css" rel="stylesheet" href="../externlib/${lang}/axisj/ui/arongi/AXSelect.css?cacheVersion=${contentCacheVersion}" />
	<link type="text/css" rel="stylesheet" href="../externlib/${lang}/axisj/ui/arongi/AXTree.css?cacheVersion=${contentCacheVersion}" />

</head>
<body>
	<%@ include file="/WEB-INF/views/layouts/header.jsp" %>
	<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
	<div class="site-body">
		<div class="container">
			<div class="site-content">
				<%@ include file="/WEB-INF/views/layouts/sub_menu.jsp" %>
				<div class="page-area">
					<%@ include file="/WEB-INF/views/layouts/page_header.jsp" %>
					<div class="page-content">
						<div class="row">
							<div class="one-third column">
								<div id="AXTreeTarget" class="tree"></div>
								<div style="margin-top: 15px;">
									<button type="button" class="detailBtn" onclick="addTree(); return false;">추가</button>
									<button type="button" class="detailBtn" onclick="addChildTree(); return false;">하위 메뉴 추가</button>
									<button type="button" class="detailBtn" onclick="delTree(); return false;">선택 삭제</button>
									<button type="button" class="detailBtn" onclick="moveUpTree(); return false;">위로</button>
									<button type="button" class="detailBtn" onclick="moveDownTree(); return false;">아래로</button>
								</div>
							</div>
							<div class="two-third column">
								<div class="node">
									<div id="tree_content_area" class="info">
										<form:form id="menuForm" name="menuForm" method="post" onsubmit="return false;">
							    			<input type="hidden" id="writeMode" name="writeMode" value="" />
											<input type="hidden" id="menuId" name="menuId" value="" />
											<input type="hidden" id="ancestor" name="ancestor" value="" />
											<input type="hidden" id="parent" name="parent" value="" />
											<input type="hidden" id="depth" name="depth" value="" />
											<input type="hidden" id="viewOrder" name="viewOrder" value="1" />
											<input type="hidden" id="updateType" name="updateType" value="" />
											<input type="hidden" id="menuTarget" name="menuTarget" value=""/>
											<input type="hidden" id="menuType" name="menuType" value=""/>
										<table class="input-table scope-row" summary="사용자 메뉴 테이블">
										<caption class="hiddenTag">사용자 메뉴</caption>
											<col class="col-label" />
											<col class="col-input" />
											<tr>
												<th class="col-label" scope="row">
													<label for="viewMenuTarget">메뉴 Target</label>
													<span class="icon-glyph glyph-emark-dot color-warning"></span>
												</th>
												<td><input type="text" id="viewMenuTarget" value="사용자 사이트" readOnly/></td>
											</tr>
											<tr>
												<th class="col-label" scope="row">
													<label for="viewMenuType">메뉴 타입</label>
													<span class="icon-glyph glyph-emark-dot color-warning"></span>
												</th>
												<td><input type="text" id="viewMenuType" value="HTML ID" readOnly/></td>
											</tr>
											<tr>
												<th class="col-label" scope="row">
													<label for="name">메뉴명</label>
													<span class="icon-glyph glyph-emark-dot color-warning"></span>
												</th>
												<td><input type="text" id="name" name="name"/></td>
											</tr>
											<tr>
												<th class="col-label" scope="row">
													<label for="nameEn">메뉴명(영어)</label>
													<span class="icon-glyph glyph-emark-dot color-warning"></span>
												</th>
												<td><input type="text" id="nameEn" name="nameEn"/></td>
											</tr>
											<tr>
												<th class="col-label" scope="row">
													<label for="url">URL</label>
													<span class="icon-glyph glyph-emark-dot color-warning"></span>
												</th>
												<td><input type="text" id="url" name="url"/></td>
											</tr>
											<tr>
												<th class="col-label" scope="row">
													<label for="urlAlias">URL Alias</label>
												</th>
												<td><input type="text" id="urlAlias" name="urlAlias"></td>
											</tr>
											<tr>
												<th class="col-label" scope="row">
													<label for="htmlId">HTML ID</label>
													<span class="icon-glyph glyph-emark-dot color-warning"></span>
												</th>
												<td><input type="text" id="htmlId" name="htmlId"/></td>
											</tr>
											<tr>
												<th class="col-label" scope="row">
													<label for="htmlContentId">HTML Content ID</label>
													<span class="icon-glyph glyph-emark-dot color-warning"></span>
												</th>
												<td><input type="text" id="htmlContentId" name="htmlContentId"/></td>
											</tr>
											<tr>
												<th class="col-label" scope="row">
													<label for="image">이미지</label>
												</th>
												<td><input type="text" id="image" name="image"/></td>
											</tr>
											<tr>
												<th class="col-label" scope="row">
													<label for="imageAlt">이미지 Alt</label>
												</th>
												<td><input type="text" id="imageAlt" name="imageAlt"/></td>
											</tr>
											<tr>
												<th class="col-label" scope="row">
													<label for="cssClass">CSS Class</label>
												</th>
												<td><input type="text" id="cssClass" name="cssClass"/></td>
											</tr>
											<tr>
												<th class="col-label" scope="row">
													<label for="defaultY">기본 사용 유무</label>
													<span class="icon-glyph glyph-emark-dot color-warning"></span>
												</th>
												<td>
													<input type="radio" id="defaultY" name="defaultYn" value="Y" class="marT10" />
													<label for="defaultY">기본</label>
													<input type="radio" id="defaultN" name="defaultYn" value="N" class="marT10" />
													<label for="defaultN">선택</label>
												</td>
											</tr>
											<tr>
												<th class="col-label" scope="row">
													<label for="useY">사용 여부</label>
													<span class="icon-glyph glyph-emark-dot color-warning"></span>
												</th>
												<td>
													<input type="radio" id="useY" name="useYn" value="Y" class="marT10" />
													<label for="useY">사용</label>
													<input type="radio" id="useN" name="useYn" value="N" class="marT10" />
													<label for="useN">미사용</label>
												</td>
											</tr>
											<tr>
												<th class="col-label" scope="row">
													<label for="displayY">화면 표시 여부</label>
													<span class="icon-glyph glyph-emark-dot color-warning"></span>
												</th>
												<td>
													<input type="radio" id="displayY" name="displayYn" value="Y" class="marT10" />
													<label for="displayY">표시</label>
													<input type="radio" id="displayN" name="displayYn" value="N" class="marT10" />
													<label for="displayN">비표시</label>
												</td>
											</tr>
											<tr>
												<th class="col-label" scope="row">
													<label for="description">설명</label>
												</th>
												<td><input type="text" id="description" name="description" size="80" /></td>
											</tr>
											<tr>
												<td colspan="2">
													<div class="button-group">
														<div class="center-buttons">
															<button type="submit" onclick="appendTree();">저장</button>
															<button type="reset" onclick="reset();">취소</button>
														</div>
													</div>
												</td>
											</tr>
										</table>
										</form:form>
									</div>

								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>

<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/common.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/message.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/navigation.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="../externlib/${lang}/axisj/lib/AXJ.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="../externlib/${lang}/axisj/lib/AXInput.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="../externlib/${lang}/axisj/lib/AXModal.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="../externlib/${lang}/axisj/lib/AXSelect.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="../externlib/${lang}/axisj/lib/AXTree.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="../js/${lang}/menuTree.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript">
	var MENU_TREE_DATA = null;

	$(document).ready(function() {
		getMenuList();
	});

	// 메뉴 목록
	function getMenuList() {
		$.ajax({
			url: "/menus/user-tree",
			type: "GET",
			headers: {"X-Requested-With": "XMLHttpRequest"},
			dataType: "json",
			success: function(msg){
				if(msg.statusCode <= 200) {
					MENU_TREE_DATA = JSON.parse(msg.menuTree);
					TREE_OBJECT.pageStart.delay(0.1);
					// 웹접근성 때문에 a 태그에 value 값 넣어주고 hidden 처리
					setTimeout(function(){
						$("#AXTreeTarget > a").text("사용자 메뉴");
						$("#AXTreeTarget > a").attr("class","hiddenTag");
					},100);
				} else {
					alert(JS_MESSAGE[msg.errorCode]);
					console.log("---- " + msg.message);
				}
			},
			error:function(request, status, error){
		        alert(JS_MESSAGE["ajax.error.message"]);
			}
		});
	}

	function reset() {
		document.menuForm.reset();
	}

	function check() {
		var regExp = /^[0-9A-Za-z;\-_#$]*$/;

		if( $("#menuType").val() === "" ) {
			alert("메뉴 타입을 입력해 주세요.");
			return false;
		}
		else if( $("#menuTarget").val() === "" ) {
			alert("메뉴 Target을 입력해 주세요.");
			return false;
		}
		else if ( $("#name").val().trim() === "" ) {
			alert("메뉴명을 입력해 주세요.");
			$('#name').focus();
			return false;
		}
		else if ( $("#nameEn").val().trim() === "" ) {
			alert("영어 메뉴명을 입력해 주세요");
			$('#nameEn').focus();
			return false;
		}
		else if( $("#url").val().trim() === "" ) {
			alert("URL을 입력해 주세요");
			$('#url').focus();
			return false;
		}
		else if( $("#htmlId").val().trim() === "" ) {
			alert("HTML ID를 입력해 주세요..");
			$("#htmlId").focus();
			return false;
		}
		else if( $("#htmlContentId").val().trim() === "" ) {
			alert("HTML Content ID를 입력해 주세요..");
			$("#htmlContentId").focus();
			return false;
		}
		else if( $("[name=defaultYn]:checked").val() === "" || $("[name=defaultYn]:checked").val() === undefined ) {
			alert("기본 사용 유무를 선택해 주세요");
			return false;
		}
		else if( $('[name=useYn]:checked').val() === "" || $("[name=useYn]:checked").val() === undefined ) {
			alert("사용 여부를 선택해 주세요");
			return false;
		}
		else if( $("[name=displayYn]:checked").val() === "" || $("[name=displayYn]:checked").val() === undefined ) {
			alert("화면 표시 여부를 선택해 주세요");
			return false;
		}
	}

	// 메뉴 등록
	function insertMenu() {
		if( check() === false ) return false;

		// 관리자 사이트
		if( $("#menuType").val() === "0" ) {
			if( $("#menuTarget").val() === "0" ) {
				alert("관리자 사이트의 경우 메뉴 Target은 관리자 사이트만 가능합니다.");
				return;
			}
		}
		// 일반 사용자 사이트
		if( $("#menuType").val() !== "0" ) {
			if( $("#menuTarget").val() === "1" ) {
				alert("일반 사용자 사이트의 경우 메뉴 Target은 일반 사용자 사이트만 가능합니다.");
				return;
			}
		}

		var info = $("#menuForm").serialize();
		$.ajax({
			url: "/menus",
			type: "POST",
			headers: {"X-Requested-With": "XMLHttpRequest"},
			data: info,
			dataType: "json",
			success: function(msg){
				if(msg.statusCode <= 200) {
					MENU_TREE.setTree(JSON.parse(msg.menuTree));
					alert(JS_MESSAGE["insert"]);
				} else {
					alert(JS_MESSAGE[msg.errorCode]);
					console.log("---- " + msg.message);
				}
			},
			error:function(request, status, error){
		        alert(JS_MESSAGE["ajax.error.message"]);
			}
		});
	}

	// 메뉴 수정
	function updateMenu() {
		if( check() === false ) return false;

		// 관리자 사이트
		if( $("#menuType").val() === "0" ) {
			if( $("#menuTarget").val() === "0" ) {
				alert("관리자 사이트의 경우 메뉴 Target은 관리자 사이트만 가능합니다.");
				return;
			}
			if( $("#url").val() === null || $("#url").val() === "" ) {
				alert("URL을 입력하여 주십시오.");
				$("#url").focus();
				return;
			}
		}
		// 일반 사용자 사이트
		if( $("#menuType").val() !== "0" ) {
			if( $("#menuTarget").val() === "1" ) {
				alert("일반 사용자 사이트의 경우 메뉴 Target은 일반 사용자 사이트만 가능합니다.");
				return;
			}
			if( $("#htmlId").val() === null || $("#htmlId").val() === "" ) {
				alert("HTML ID를 입력하여 주십시오.");
				$("#htmlId").focus();
				return;
			}
		}

		var info = $("#menuForm").serialize();
		$.ajax({
			url: "/menus/" + $("#menuId").val(),
			type: "POST",
			headers: {"X-Requested-With": "XMLHttpRequest"},
			data: info,
			dataType: "json",
			success: function(msg){
				if(msg.statusCode <= 200) {
					MENU_TREE.setTree(JSON.parse(msg.menuTree));
					alert(JS_MESSAGE["update"]);
				} else {
					alert(JS_MESSAGE[msg.errorCode]);
					console.log("---- " + msg.message);
				}
			},
			error:function(request, status, error){
		        alert(JS_MESSAGE["ajax.error.message"]);
			}
		});
	}

	// 메뉴 삭제
	function deleteMenu() {
		if(confirm("삭제하시겠습니까?")) {
			$.ajax({
				url: "/menus/user/" + $("#menuId").val(),
				type: "DELETE",
				headers: {"X-Requested-With": "XMLHttpRequest"},
				dataType: "json",
				success: function(msg){
					if(msg.statusCode <= 200) {
						alert("삭제되었습니다.");
						MENU_TREE.setTree(JSON.parse(msg.menuTree));
						MENU_TREE.collapseAll();
					} else {
						alert(JS_MESSAGE[msg.errorCode]);
						console.log("---- " + msg.message);
					}
				},
				error:function(request, status, error){
			        alert(JS_MESSAGE["ajax.error.message"]);
				}
			});
		}
	}

	// 메뉴 트리 순서 위로/아래로 수정
	function updateMoveMenu() {
		if(confirm("이동하시겠습니까?")) {
			var info = $("#menuForm").serialize();
			$.ajax({
				url: "/menus/" + $("#menuId").val() + "/move",
				type: "POST",
				headers: {"X-Requested-With": "XMLHttpRequest"},
				data: info,
				dataType: "json",
				success: function(msg){
					if(msg.statusCode <= 200) {
						MENU_TREE.setTree(JSON.parse(msg.menuTree));
						//MENU_TREE.collapseAll();
					} else {
						alert(JS_MESSAGE[msg.errorCode]);
						console.log("---- " + msg.message);
					}
				},
				error:function(request, status, error){
			        alert(JS_MESSAGE["ajax.error.message"]);
				}
			});
		}
	}

	// 동일 레벨의 추가
	function addTree() {
		TREE_OBJECT.addTree();
	}
	// 하위 레벨의 추가
	function addChildTree() {
		TREE_OBJECT.addChildTree();
	}
	// 삭제
	function delTree() {
		TREE_OBJECT.delTree();
	}
	// 수정
	function updateTree() {
		TREE_OBJECT.updateTree();
	}
	// 정보 저장
	function appendTree() {
		TREE_OBJECT.appendTree();
	}

	// 위로 이동
	var upFlag = true;
	function moveUpTree() {
		if(upFlag) {
			upFlag = false;
			var validationCode = null;
			validationCode = MENU_TREE.moveUpTree();
			if(validationCode == "1") {
				TREE_OBJECT.updateMoveUpTree();
				upFlag = true;
			}
			upFlag = true;
		} else {
			alert("진행 중입니다.");
			return;
		}
	}

	// 아래로 이동
	var downFlag = true;
	function moveDownTree() {
		if(downFlag) {
			downFlag = false;
			var validationCode = null;
			validationCode = MENU_TREE.moveDownTree();
			if(validationCode == "1") {
				TREE_OBJECT.updateMoveDownTree();
				downFlag = true;
			}
			downFlag = true;
		} else {
			alert("진행 중입니다.");
			return;
		}
	}
</script>
</body>
</html>