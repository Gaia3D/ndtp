<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>데이터 상세 정보 | NDTP</title>
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
	<link rel="stylesheet" href="/externlib/normalize/normalize.min.css" />
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css" />
    <link rel="stylesheet" href="/css/${lang}/admin-style.css" />
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
					<div class="tabs">
						<ul>
							<li><a href="#dataInfoTab">기본정보</a></li>
						</ul>
						<div id="dataInfoTab">
							<form:form id="dataInfo" modelAttribute="dataInfo" method="post" onsubmit="return false;">
							<form:hidden path="dataId"/>
							<table class="inner-table scope-row">
								<col class="col-label" />
								<col class="col-data" />
								<tr>
									<th class="col-label" scope="row">데이터 그룹명</th>
									<td class="col-data">${dataInfo.dataGroupName }</td>
								</tr>	
								<tr>
									<th class="col-label" scope="row">데이터명</th>
									<td class="col-data">${dataInfo.dataName }</td>
								</tr>
								<tr>
									<th class="col-label" scope="row">데이터 Key</th>
										<td class="col-data">${dataInfo.dataKey }</td>
								</tr>
								<tr>
									<th class="col-label" scope="row">공유 유형</th>
										<td class="col-data">${dataInfo.sharing }</td>
								</tr>		
								<tr>
									<th class="col-label" scope="row">매핑 타입</th>
									<td class="col-data">${dataInfo.mappingType }</td>
								</tr>
								<tr>
									<th class="col-label" scope="row"><spring:message code='longitude'/></th>
									<td class="col-data">${dataInfo.longitude }</td>
								</tr>
								<tr>
									<th class="col-label" scope="row"><spring:message code='latitude'/></th>
									<td class="col-data">${dataInfo.latitude }</td>
								</tr>	
								<tr>
									<th class="col-label" scope="row">높이</th>
									<td class="col-data">${dataInfo.altitude }</td>
								</tr>
								<tr>
									<th class="col-label" scope="row">Heading</th>
									<td class="col-data">${dataInfo.heading }</td>
								</tr>
								<tr>
									<th class="col-label" scope="row">Pitch</th>
									<td class="col-data">${dataInfo.pitch }</td>
								</tr>
								<tr>
									<th class="col-label" scope="row">Roll</th>
									<td class="col-data">${dataInfo.roll }</td>
								</tr>
								<tr>
									<th class="col-label" scope="row">메타 정보</th>
									<td class="col-data">${dataInfo.metainfo }</td>
								</tr>
								<tr>
									<th class="col-label" scope="row">상태</th>
									<td class="col-data">${dataInfo.status }</td>
								</tr>
								<tr>
									<th class="col-label" scope="row">속성 존재 여부</th>
									<td class="col-data">${dataInfo.attributeExist }</td>
								</tr>
								<tr>
									<th class="col-label" scope="row"><spring:message code='description'/></th>
									<td class="col-data">${dataInfo.description }</td>
								</tr>			
							</table>
							</form:form>
						</div>
					</div>
					
					<div class="button-group">
						<div class="center-buttons">
							<a href="/data/list?${listParameters}" class="button"><spring:message code='list'/></a>
							<a href="/data/modify?dataId=${dataInfo.dataId }&amp;${listParameters}" class="button"><spring:message code='modified'/></a>
						</div>
					</div>
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
<script type="text/javascript">
	$(document).ready(function() {
		$( ".tabs" ).tabs();
	});
</script>
</body>
</html>