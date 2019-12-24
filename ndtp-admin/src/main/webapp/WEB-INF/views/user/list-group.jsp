<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>사용자 그룹 | NDTP</title>
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
										<a href="#" onclick="openAllLayer(); return false;" class="button">펼치기</a>
										<a href="#" onclick="closeAllLayer(); return false;" class="button">접기</a>
										<a href="/user/tree-group" class="button">그룹 수정/등록</a>
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
								<col class="col-functions" />
								<col class="col-date" />
								<thead>
									<tr>
										<th scope="col">그룹명</th>
					                    <th scope="col">그룹Key</th>
					                    <th scope="col">기본유무</th>
					                    <th scope="col">사용유무</th>
					                    <th scope="col">사용자</th>
					                    <th scope="col">메뉴</th>
					                    <th scope="col">Role</th>
					                    <th scope="col">등록일</th>
									</tr>
								</thead>
								<tbody>
<c:if test="${empty userGroupList }">
									<tr>
										<td colspan="8" class="col-none"><spring:message code='user.group.empty'/></td>
									</tr>
</c:if>								
<c:if test="${!empty userGroupList }">
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
    <c:forEach var="userGroup" items="${userGroupList}" varStatus="status">
        <c:if test="${userGroup.depth eq '1' }">
            <c:set var="depthClass" value="oneDepthClass" />
            <c:set var="paddingLeftValue" value="0px" />
            <c:set var="depthStyleDisplay" value="" />
            <c:set var="ancestorClass" value="" />
            <c:set var="depthParentClass" value="" />
        </c:if>
        <c:if test="${userGroup.depth eq '2' }">
            <c:set var="depthClass" value="twoDepthClass" />
            <c:set var="paddingLeftValue" value="40px" />
            <c:set var="depthStyleDisplay" value="display: none;" />
            <c:set var="depthParentClass" value="oneDepthParent-${userGroup.parent }" />
            <c:set var="ancestorClass" value="" />
            <c:set var="ancestorArrowClass" value="ancestorArrow-${userGroup.ancestor }" />
            <c:set var="ancestorFolderClass" value="ancestorFolder-${userGroup.ancestor }" />
        </c:if>
        <c:if test="${userGroup.depth eq '3' }">
            <c:set var="depthClass" value="threeDepthClass" />
            <c:set var="paddingLeftValue" value="80px" />
            <c:set var="depthStyleDisplay" value="display: none;" />
            <c:set var="depthParentClass" value="twoDepthParent-${userGroup.parent }" />
            <c:set var="ancestorClass" value="ancestor-${userGroup.ancestor }" />
        </c:if>
									<tr class="${depthClass } ${depthParentClass} ${ancestorClass }" style="${depthStyleDisplay}">
										<td class="col-key" style="text-align: left;" nowrap="nowrap">
        <c:if test="${userGroup.depth eq '1' }">
					                        <span style="padding-left: ${paddingLeftValue}; font-size: 1.6em;"
					                            onclick="childrenDisplayToggle('${userGroup.depth}', '${userGroup.userGroupId}', '${userGroup.ancestor}');">
					                            <i id="oneDepthArrow-${userGroup.userGroupId }" class="fa fa-caret-right oneArrow" aria-hidden="true"></i>
					                        </span>&nbsp;
					                        <span style="font-size: 1.5em; color: Mediumslateblue;">
					                            <i id="oneDepthFolder-${userGroup.userGroupId }" class="fa fa-folder oneFolder" aria-hidden="true"></i>
					                        </span>
        </c:if>
        <c:if test="${userGroup.depth eq '2' }">
            <c:if test="${userGroup.childYn eq 'N' }">
                        					<span style="padding-left: ${paddingLeftValue}; font-size: 1.5em; color: Tomato;"><i class="fa fa-file-alt" aria-hidden="true"></i></span>
            </c:if>
            <c:if test="${userGroup.childYn eq 'Y' }">
					                        <span style="padding-left: ${paddingLeftValue}; font-size: 1.6em;"
					                            onclick="childrenDisplayToggle('${userGroup.depth}', '${userGroup.userGroupId}', '${userGroup.ancestor}');">
					                            <i id="twoDepthArrow-${userGroup.userGroupId }" class="fa fa-caret-right twoArrow ${ancestorArrowClass }" aria-hidden="true"></i></span>&nbsp;
					                        <span style="font-size: 1.5em; color: Mediumslateblue;">
					                            <i id="twoDepthFolder-${userGroup.userGroupId }" class="fa fa-folder twoFolder ${ancestorFolderClass }" aria-hidden="true"></i>
					                        </span>
            </c:if>
        </c:if>
        <c:if test="${userGroup.depth eq '3' }">
                        					<span style="padding-left: ${paddingLeftValue}; font-size: 1.5em; color: Tomato;"><i class="fa fa-file-alt" aria-hidden="true"></i></span>
        </c:if>

                        					${userGroup.groupName }
										</td>
					                    <td class="col-key" style="text-align: left;" nowrap="nowrap">${userGroup.groupKey }</td>
					                    <td class="col-type">
        <c:if test="${userGroup.defaultYn eq 'Y' }">
                        					기본
        </c:if>
        <c:if test="${userGroup.defaultYn eq 'N' }">
                        					선택
        </c:if>
                    					</td>
                    					<td class="col-type">
        <c:if test="${userGroup.useYn eq 'Y' }">
                        					사용
        </c:if>
        <c:if test="${userGroup.useYn eq 'N' }">
                        					미사용
        </c:if>
					                    </td>
					                    <td class="col-type">
					                        <a href="/user/group/${userGroup.userGroupId }/menu" class="linkButton">수정</a>
					                    </td>	
					                    <td class="col-type">
					                        <a href="/user/group/${userGroup.userGroupId }/menu" class="linkButton">수정</a>
					                    </td>
					                    <td class="col-type">
					                        <a href="/user/group/${userGroup.userGroupId }/role" class="linkButton">수정</a>
					                    </td>
					                    <td class="col-date">
					                    	<fmt:parseDate value="${userGroup.insertDate}" var="viewInsertDate" pattern="yyyy-MM-dd HH:mm:ss"/>
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
	$(document).ready(function() {
		
	});
</script>
</body>
</html>