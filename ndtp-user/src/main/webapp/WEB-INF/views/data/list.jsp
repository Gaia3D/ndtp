<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>데이터 목록 | NDTP</title>
	
	<link rel="stylesheet" href="/externlib/cesium/Widgets/widgets.css" />
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
	<link rel="stylesheet" href="/css/${lang}/user-style.css" />
	<link rel="stylesheet" href="/css/${lang}/style.css" />
	<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
	<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>
</head>
<body>

<%@ include file="/WEB-INF/views/layouts/header.jsp" %>

<div id="wrap">
	<!-- S: NAVWRAP -->
	<div class="navWrap">
	 	<%@ include file="/WEB-INF/views/layouts/menu.jsp" %> 
	</div>
	<!-- E: NAVWRAP -->
	
	<div class="container" style="float:left; width: calc(100% - 78px);">
		<div style="padding: 20px 20px 0px 10px; font-size: 18px;">3D 업로딩 데이터 자동 변환</div>
		<div class="tabs" >
			<ul class="tab">
				<li onclick="location.href='/data-group/list'">데이터 그룹</li>
				<li onclick="location.href='/data-group/input'">데이터 그룹 등록</li>
				<li onclick="location.href='/upload-data/input'">업로딩 데이터</li>
			   	<li onclick="location.href='/upload-data/list'">업로딩 데이터 목록</li>
			  	<li onclick="location.href='/converter/list'">업로딩 데이터 변환 목록</li>
			  	<li onclick="location.href='/data/list'" class="on">데이터 목록</li>
			</ul>
		</div>
		<div class="filters">
			<form:form id="searchForm" modelAttribute="dataInfo" method="get" action="/data/list" onsubmit="return searchCheck();">
			<div class="input-group row">
				<div class="input-set">
					<label for="searchWord"><spring:message code='search.word'/></label>
					<select id="searchWord" name="searchWord" class="selectBoxClass">
						<option value=""><spring:message code='select'/></option>
	          			<option value="data_name">데이터명</option>
					</select>
					<select id="searchOption" name="searchOption" class="selectBoxClass">
						<option value="0"><spring:message code='search.same'/></option>
						<option value="1"><spring:message code='search.include'/></option>
					</select>
					<form:input path="searchValue" type="search" cssClass="m" cssStyle="float: right;" />
				</div>
				<div class="input-set">
					<label for="startDate"><spring:message code='search.date'/></label>
					<input type="text" class="s date" id="startDate" name="startDate" />
					<span class="delimeter tilde">~</span>
					<input type="text" class="s date" id="endDate" name="endDate" />
				</div>
				<div class="input-set">
					<label for="orderWord"><spring:message code='search.order'/></label>
					<select id="orderWord" name="orderWord" class="selectBoxClass">
						<option value=""> <spring:message code='search.basic'/> </option>
						<option value="data_name">데이터명</option>
						<option value="insert_date"> <spring:message code='search.insert.date'/> </option>
					</select>
					<select id="orderValue" name="orderValue" class="selectBoxClass">
                		<option value=""> <spring:message code='search.basic'/> </option>
	                	<option value="ASC"> <spring:message code='search.ascending'/> </option>
						<option value="DESC"> <spring:message code='search.descending.order'/> </option>
					</select>
					<select id="listCounter" name="listCounter" class="selectBoxClass">
                		<option value="10"> <spring:message code='search.ten.count'/> </option>
	                	<option value="50"> <spring:message code='search.fifty.count'/> </option>
						<option value="100"> <spring:message code='search.hundred.count'/> </option>
					</select>
				</div>
				<div class="input-set">
					<input type="submit" value="<spring:message code='search'/>" />
				</div>
			</div>
			</form:form>
		</div>
		
		<div class="list">
			<form:form id="listForm" modelAttribute="dataInfo" method="post">
				<input type="hidden" id="checkIds" name="checkIds" value="" />
			<div class="list-header row">
				<div class="list-desc u-pull-left">
					<spring:message code='all.d'/> <em><fmt:formatNumber value="${pagination.totalCount}" type="number"/></em><spring:message code='search.what.count'/> 
					<fmt:formatNumber value="${pagination.pageNo}" type="number"/> / <fmt:formatNumber value="${pagination.lastPage }" type="number"/> <spring:message code='search.page'/>
				</div>
			</div>
			<table class="list-table scope-col">
				<col class="col-number" />
				<col class="col-name" />
				<col class="col-name" />
				<col class="col-name" />
				<col class="col-name" />
				<col class="col-name" />
				<col class="col-name" />
				<col class="col-name" />
				<col class="col-functions" />
				<col class="col-functions" />
				<col class="col-functions" />
				<col class="col-functions" />
				<thead>
					<tr>
						<th scope="col" class="col-number"><spring:message code='number'/></th>
						<th scope="col" class="col-name">그룹명</th>
						<th scope="col" class="col-name">데이터명</th>
						<th scope="col" class="col-name">아이디</th>
						<th scope="col" class="col-name">데이터 타입</th>
						<th scope="col" class="col-name">공유 유형</th>
						<th scope="col" class="col-name">매핑타입</th>
						<th scope="col" class="col-name">상태</th>
						<th scope="col" class="col-name">지도</th>
						<th scope="col" class="col-name">속성</th>
						<th scope="col" class="col-name">Object 속성</th>
						<th scope="col" class="col-date">등록일</th>
					</tr>
				</thead>
				<tbody>
<c:if test="${empty dataInfoList }">
					<tr>
						<td colspan="12" class="col-none">데이터가 존재하지 않습니다.</td>
					</tr>
</c:if>
<c:if test="${!empty dataInfoList }">
	<c:forEach var="dataInfo" items="${dataInfoList}" varStatus="status">

					<tr>
						<td class="col-number">${pagination.rowNumber - status.index }</td>
						<td class="col-name">${dataInfo.dataGroupName }</td>
						<td class="col-name">
		<c:if test="${dataInfo.dataGroupTarget eq 'admin'}">
							<a href="/data-log/modify?dataId=${dataInfo.dataId}">${dataInfo.dataName }</a>
		</c:if>
		<c:if test="${dataInfo.dataGroupTarget eq 'user'}">
			<c:if test="${dataInfo.userId eq owner}">
							<a href="/data/modify?dataId=${dataInfo.dataId}">${dataInfo.dataName }</a>
			</c:if>
			<c:if test="${dataInfo.userId ne owner}">
							<a href="/data-log/modify?dataId=${dataInfo.dataId}">${dataInfo.dataName }</a>
			</c:if>
		</c:if>					
						</td>
						<td class="col-name">
		<c:if test="${dataInfo.userId eq owner}">				
							${dataInfo.userId }
		</c:if>
		<c:if test="${dataInfo.userId ne owner}">
							<span style="color: blue;">${dataInfo.userId }</span>
		</c:if>
						</td>	
						<td class="col-name">${dataInfo.dataType }</td>
						<td class="col-type">
		<c:if test="${dataInfo.sharing eq 'common'}">공통</c:if>
		<c:if test="${dataInfo.sharing eq 'public'}">공개</c:if>
		<c:if test="${dataInfo.sharing eq 'private'}">개인</c:if>
		<c:if test="${dataInfo.sharing eq 'group'}">그룹</c:if>
						</td>
						<td class="col-name">${dataInfo.mappingType }</td>
						<td class="col-type">
		<c:if test="${dataInfo.status eq 'processing' }">
							변환중
		</c:if>
		<c:if test="${dataInfo.status eq 'use' }">
							사용중
		</c:if>
		<c:if test="${dataInfo.status eq 'unused' }">
							사용중지
		</c:if>
		<c:if test="${dataInfo.status eq 'delete' }">
							삭제
		</c:if>		
						</td>
						<td class="col-type">
							<a href="#" onclick="viewDataInfo('${dataInfo.dataId}'); return false;">보기</a>
						</td>
						<td class="col-type">
		<c:if test="${dataInfo.attributeExist eq 'true' }">	
							등록
		</c:if>
		<c:if test="${dataInfo.attributeExist eq 'false' }">
							미등록
		</c:if>				
						</td>
						<td class="col-type">
		<c:if test="${dataInfo.objectAttributeExist eq 'true' }">	
							등록
		</c:if>
		<c:if test="${dataInfo.objectAttributeExist eq 'false' }">
							미등록
		</c:if>							
						<td class="col-date">
							<fmt:parseDate value="${dataInfo.insertDate}" var="viewInsertDate" pattern="yyyy-MM-dd HH:mm:ss"/>
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
<!-- E: WRAP -->

<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript" src="/js/${lang}/map-controll.js"></script>
<script type="text/javascript" src="/js/${lang}/ui-controll.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		var searchWord = "${dataInfo.searchWord}";
		var searchOption = "${dataInfo.searchOption}";
		var orderWord = "${dataInfo.orderWord}";
		var orderValue = "${dataInfo.orderValue}";
		var listCounter = "${dataInfo.listCounter}";
		
		if(searchWord != "") $("#searchWord").val("${dataInfo.searchWord}");
		if(searchOption != "") $("#searchOption").val("${dataInfo.searchOption}");
		if(orderWord != "") $("#orderWord").val("${dataInfo.orderWord}");
		if(orderValue != "") $("#orderValue").val("${dataInfo.orderValue}");
		if(listCounter != "") $("#listCounter").val("${dataInfo.listCounter}");
		
		initDatePicker();
		initCalendar(new Array("startDate", "endDate"), new Array("${dataInfo.startDate}", "${dataInfo.endDate}"));
	});
	
	//전체 선택 
	$("#chkAll").click(function() {
		$(":checkbox[name=dataId]").prop("checked", this.checked);
	});
	
	//지도에서 찾기
	function viewDataInfo(dataId) {
		var url = "/map/find-data-point?dataId=" + dataId + "&referrer=list";
		var width = 1024;
		var height = 700;
	
		var popupX = (window.screen.width / 2) - (width / 2);
		// 만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음
		var popupY= (window.screen.height / 2) - (height / 2);
		
	    var popWin = window.open(url, "", "toolbar=no, width=" + width + ", height=" + height + ", top=" + popupY + ", left=" + popupX
	            + ", directories=no, status=yes, scrollbars=no, menubar=no, location=no");
	    //popWin.document.title = layerName;
	}
</script>
</body>
</html>
