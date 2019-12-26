<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>Layer 목록 | NDTP</title>
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
	<link rel="stylesheet" href="/externlib/normalize/normalize.min.css" />
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css" />
	<link rel="stylesheet" href="/css/fontawesome-free-5.2.0-web/css/all.min.css">
    <link rel="stylesheet" href="/css/${lang}/style.css" />
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
						<!-- <div class="filters">
						</div> -->
						<div style="height: 30px;"></div>
						<div class="list">
							<div class="list-header row">
								<div class="list-desc u-pull-left">
									<div class="button-group">
										<a href="#" onclick="openAll(); return false;" class="button">펼치기</a>
										<a href="#" onclick="closeAll(); return false;" class="button">접기</a>
										<a href="/layer/tree" class="button">그룹 수정/등록</a>
									</div>
								</div>
							</div>
							<table class="list-table scope-col">
								<col class="col-name" />
								<col class="col-id" />
								<col class="col-toggle" />
								<col class="col-toggle" />
								<col class="col-functions" />
								<col class="col-functions" />
								<col class="col-date" />
								<thead>
									<tr>
										<th scope="col">Layer 명</th>
					                    <th scope="col">Layer Key</th>
					                    <th scope="col">표시순서(Z-Index)</th>
					                    <th scope="col">사용유무</th>
					                    <th scope="col">지도</th>
					                    <th scope="col">수정</th>
					                    <th scope="col">최종 수정일</th>
									</tr>
								</thead>
								<tbody>
<c:if test="${empty layerList }">
									<tr>
										<td colspan="7" class="col-none">Layer 가 존재하지 않습니다.</td>
									</tr>
</c:if>								
<c:if test="${!empty layerList }">
	<c:set var="paddingLeftValue" value="0" />
    <!-- depth 별 css 제어를 위한 변수 -->
    <c:set var="depthClass" value="" />
    <c:set var="depthStyleDisplay" value="" />
    <!-- 클릭 이벤트 발생시 자손 css 를 제어하기 위한 변수 -->
    <c:set var="ancestorClass" value="" />
    <!-- 클릭 이벤트 발생시 자식 css 를 제어하기 위한 변수 -->
    <c:set var="depthParentClass" value="" />
    <c:set var="ancestorArrowClass" value="" />
    <c:set var="ancestorFolderClass" value="" />
    <c:forEach var="layer" items="${layerList}" varStatus="status">
        <c:if test="${layer.depth eq '1' }">
            <c:set var="depthClass" value="oneDepthClass" />
            <c:set var="paddingLeftValue" value="0px" />
            <c:set var="depthStyleDisplay" value="" />
            <c:set var="ancestorClass" value="" />
            <c:set var="depthParentClass" value="" />
        </c:if>
        <c:if test="${layer.depth eq '2' }">
            <c:set var="depthClass" value="twoDepthClass" />
            <c:set var="paddingLeftValue" value="40px" />
            <c:set var="depthStyleDisplay" value="display: none;" />
            <c:set var="depthParentClass" value="oneDepthParent-${layer.parent }" />
            <c:set var="ancestorClass" value="" />
            <c:set var="ancestorArrowClass" value="ancestorArrow-${layer.ancestor }" />
            <c:set var="ancestorFolderClass" value="ancestorFolder-${layer.ancestor }" />
        </c:if>
        <c:if test="${layer.depth eq '3' }">
            <c:set var="depthClass" value="threeDepthClass" />
            <c:set var="paddingLeftValue" value="80px" />
            <c:set var="depthStyleDisplay" value="display: none;" />
            <c:set var="depthParentClass" value="twoDepthParent-${layer.parent }" />
            <c:set var="ancestorClass" value="ancestor-${layer.ancestor }" />
        </c:if>
									<tr class="${depthClass } ${depthParentClass} ${ancestorClass }" style="${depthStyleDisplay}">
										<td class="col-key" style="text-align: left;" nowrap="nowrap">
        <c:if test="${layer.depth eq '1' }">
					                        <span style="padding-left: ${paddingLeftValue}; font-size: 1.6em;" onclick="childrenDisplayToggle('${layer.depth}', '${layer.layerId}', '${layer.ancestor}');">
					                            <i id="oneDepthArrow-${layer.layerId }" class="fa fa-caret-right oneArrow" aria-hidden="true"></i>
					                        </span>&nbsp;
					                        <span style="font-size: 1.5em; color: Dodgerblue;">
					                            <i id="oneDepthFolder-${layer.layerId }" class="fa fa-folder oneFolder" aria-hidden="true"></i>
					                        </span>
        </c:if>
        <c:if test="${layer.depth eq '2' }">
            <c:if test="${layer.childYn eq 'N' }">
                        					<span style="padding-left: ${paddingLeftValue}; font-size: 1.5em; color: Tomato;"><i class="fa fa-file-alt" aria-hidden="true"></i></span>
            </c:if>
            <c:if test="${layer.childYn eq 'Y' }">
					                        <span style="padding-left: ${paddingLeftValue}; font-size: 1.6em;" onclick="childrenDisplayToggle('${layer.depth}', '${layer.layerId}', '${layer.ancestor}');">
					                            <i id="twoDepthArrow-${layer.layerId }" class="fa fa-caret-right twoArrow ${ancestorArrowClass }" aria-hidden="true"></i></span>&nbsp;
					                        <span style="font-size: 1.5em; color: Mediumslateblue;">
					                            <i id="twoDepthFolder-${layer.layerId }" class="fa fa-folder twoFolder ${ancestorFolderClass }" aria-hidden="true"></i>
					                        </span>
            </c:if>
        </c:if>
        <c:if test="${layer.depth eq '3' }">
                        					<span style="padding-left: ${paddingLeftValue}; font-size: 1.5em; color: Tomato;"><i class="fa fa-file-alt" aria-hidden="true"></i></span>
        </c:if>

                        					${layer.layerName }
										</td>
					                    <td class="col-key" style="text-align: left;" nowrap="nowrap">${layer.layerKey }</td>
                    					<td class="col-key" nowrap="nowrap">${layer.viewZIndex }</td>
					                    <td class="col-type">
        <c:if test="${layer.useYn eq 'Y' }">
                        					사용
        </c:if>
        <c:if test="${layer.useYn eq 'N' }">
                        					미사용
        </c:if>
					                    </td>
					                    <td class="col-key">
        <c:if test="${layer.shapeInsertYn eq 'Y' }">
                        					<a href="#" onclick="viewLayer('${layer.layerId}', '${layer.layerName}'); return false;" class="linkButton">보기</a>
        </c:if>
        <c:if test="${layer.shapeInsertYn eq 'N' }">
        </c:if>
					                    </td>
					                    <td class="col-key">
        <c:if test="${layer.shapeInsertYn eq 'Y' }">
                        					<a href="/layers/${layer.layerId }" class="linkButton">수정</a>
        </c:if>
        <c:if test="${layer.shapeInsertYn eq 'N' }">
        </c:if>
                    					</td>
					                    <td class="col-date">
					                    	<fmt:parseDate value="${layer.insertDate}" var="viewInsertDate" pattern="yyyy-MM-dd HH:mm:ss"/>
											<fmt:formatDate value="${viewInsertDate}" pattern="yyyy-MM-dd HH:mm"/>
					                    </td>
					                </tr>
    </c:forEach>
</c:if>
								</tbody>
							</table>
						</div>
						<%@ include file="/WEB-INF/views/common/pagination.jsp" %>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
	
<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript" src="/js/navigation.js"></script>
<script type="text/javascript">
	//펼치기
	function openAll() {
	    $(".threeDepthClass").show();
	    $(".twoDepthClass").show();
	
	    // fa-caret-right
	    // fa-caret-down
	    $(".oneArrow").removeClass("fa-caret-right");
	    $(".oneArrow").addClass("fa-caret-down");
	    $(".twoArrow").removeClass("fa-caret-right");
	    $(".twoArrow").addClass("fa-caret-down");
	
	    $(".oneFolder").removeClass("fa-folder");
	    $(".oneFolder").addClass("fa-folder-open");
	    $(".twoFolder").removeClass("fa-folder");
	    $(".twoFolder").addClass("fa-folder-open");
	}
	
	// 접기
	function closeAll() {
	    $(".threeDepthClass").hide();
	    $(".twoDepthClass").hide();
	
	    $(".oneArrow").removeClass("fa-caret-down");
	    $(".oneArrow").addClass("fa-caret-right");
	    $(".twoArrwo").removeClass("fa-caret-down");
	    $(".twoArrwo").addClass("fa-caret-right");
	
	    $(".oneFolder").removeClass("fa-folder-open");
	    $(".oneFolder").addClass("fa-folder");
	    $(".twoFolder").removeClass("fa-folder-open");
	    $(".twoFolder").addClass("fa-folder");
	}
	
	// 화살표 클릭시
	function childrenDisplayToggle(depth, userGroupId, ancestor) {
	    if(depth === "1") {
	        console.log("--------- depth 1 = " + $(".oneDepthParent-" + userGroupId).css("display"));
	        if( $(".oneDepthParent-" + userGroupId).css("display") === "none" ) {
	            // 접힌 상태
	            $(".oneDepthParent-" + userGroupId).show();
	
	            $("#oneDepthArrow-" + userGroupId).removeClass("fa-caret-right");
	            $("#oneDepthArrow-" + userGroupId).addClass("fa-caret-down");
	            $("#oneDepthFolder-" + userGroupId).removeClass("fa-folder");
	            $("#oneDepthFolder-" + userGroupId).addClass("fa-folder-open");
	
	            $(".ancestorArrow-" + ancestor).removeClass("fa-caret-down");
	            $(".ancestorArrow-" + ancestor).addClass("fa-caret-right");
	            $(".ancestorFolder-" + ancestor).removeClass("fa-folder-open");
	            $(".ancestorFolder-" + ancestor).addClass("fa-folder");
	        } else {
	            // 펼친 상태
	            $(".ancestor-" + ancestor).hide();
	            $(".oneDepthParent-" + userGroupId).hide();
	
	            $("#oneDepthArrow-" + userGroupId).removeClass("fa-caret-down");
	            $("#oneDepthArrow-" + userGroupId).addClass("fa-caret-right");
	            $("#oneDepthFolder-" + userGroupId).removeClass("fa-folder-open");
	            $("#oneDepthFolder-" + userGroupId).addClass("fa-folder");
	
	            $(".ancestorArrow-" + ancestor).removeClass("fa-caret-down");
	            $(".ancestorArrow-" + ancestor).addClass("fa-caret-right");
	            $(".ancestorFolder-" + ancestor).removeClass("fa-folder-open");
	            $(".ancestorFolder-" + ancestor).addClass("fa-folder");
	        }
	    } else if(depth === "2") {
	        if( $(".twoDepthParent-" + userGroupId).css("display") === "none" ) {
	            // 접힌 상태
	            $(".twoDepthParent-" + userGroupId).show();
	
	            $("#twoDepthArrow-" + userGroupId).removeClass("fa-caret-right");
	            $("#twoDepthArrow-" + userGroupId).addClass("fa-caret-down");
	            $("#twoDepthFolder-" + userGroupId).removeClass("fa-folder");
	            $("#twoDepthFolder-" + userGroupId).addClass("fa-folder-open");
	        } else {
	            // 펼친 상태
	            $(".twoDepthParent-" + userGroupId).hide();
	
	            $("#twoDepthArrow-" + userGroupId).removeClass("fa-caret-down");
	            $("#twoDepthArrow-" + userGroupId).addClass("fa-caret-right");
	            $("#twoDepthFolder-" + userGroupId).removeClass("fa-folder-open");
	            $("#twoDepthFolder-" + userGroupId).addClass("fa-folder");
	        }
	    }
	}
	
	// 지도 보기
    function viewLayer(layerId, layerName) {
        var url = "/layer/" + layerId + "/map";
        //popupOpen(url, layerName, 1000, 700);
        var width = 800;
        var height = 700;

        var popWin = window.open(url, "","toolbar=no ,width=" + width + " ,height=" + height
                + ", directories=no,status=yes,scrollbars=no,menubar=no,location=no");
        popWin.document.title = layerName;
    }
</script>
</body>
</html>