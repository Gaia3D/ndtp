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
						<div class="filters">
							<form:form id="layer" modelAttribute="layer" method="post" action="/layer/list" onsubmit="return searchCheck();">
							<div class="input-group row">
								<div class="input-set">
									<label for="searchWord">검색어</label>
									<select id="searchWord" name="searchWord" class="select">
										<option value="">선택</option>
										<option value="layerName">이름</option>
									</select>
									<select id="searchOption" name="searchOption" class="select">
										<option value="0">일치</option>
										<option value="1">포함</option>
									</select>
									<form:input path="searchValue" cssClass="m" />
								</div>
								<div class="input-set">
									<label for="start_date">기간</label>
									<input type="text" id="startDate" name="startDate" class="s date" />
									<span class="delimeter tilde">~</span>
									<input type="text" id="endDate" name="endDate" class="s date" />
								</div>
							
								<div class="input-set">
									<label for="orderWord">표시순서</label>
									<select id="orderWord" name="orderWord" class="select">
										<option value="">기본</option>
										<option value="layerName">이름</option>
										<option value="insertDate">등록일</option>
									</select>
									<select id="orderValue" name="orderValue" class="select">
										<option value="">기본</option>
										<option value="ASC">오름차순</option>
										<option value="DESC">내림차순</option>
									</select>
								</div>
								<div class="input-set">
									<input type="submit" value="검색" />
								</div>
							</div>
							</form:form>
						</div>
						<div class="list">
							<form:form id="listForm" modelAttribute="layer" method="post">
							<div class="list-header row">
								<div class="list-desc u-pull-left">
									<spring:message code='all.d'/> <em><fmt:formatNumber value="${pagination.totalCount}" type="number"/></em><spring:message code='search.what.count'/>
									<fmt:formatNumber value="${pagination.pageNo}" type="number"/> / <fmt:formatNumber value="${pagination.lastPage }" type="number"/> 
									<spring:message code='search.page'/>
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
	<c:forEach var="layer" items="${layerList}" varStatus="status">
									<tr class="${depthClass } ${depthParentClass} ${ancestorClass }" style="${depthStyleDisplay}">
										<td class="col-key">
                        					${layer.layerName }
										</td>
					                    <td class="col-key" style="text-align: left;" nowrap="nowrap">${layer.layerKey }</td>
                    					<td class="col-key" nowrap="nowrap">${layer.viewZIndex }</td>
					                    <td class="col-type">
        <c:if test="${layer.available eq 'true' }">
                        					사용
        </c:if>
        <c:if test="${layer.available eq 'false' }">
                        					미사용
        </c:if>
					                    </td>
					                    <td class="col-key">
                        					<a href="#" onclick="viewLayer('${layer.layerId}', '${layer.layerName}'); return false;" class="linkButton">보기</a>
					                    </td>
					                    <td class="col-key">
                        					<a href="/layers/${layer.layerId }" class="linkButton">수정</a>
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
							</form:form>
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