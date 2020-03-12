<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>데이터 목록 | NDTP</title>
	<link rel="shortcut icon" href="/images/favicon.ico?cacheVersion=${contentCacheVersion}">
	<link rel="stylesheet" href="/externlib/cesium/Widgets/widgets.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/css/${lang}/user-style.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/css/${lang}/style.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/externlib/json-viewer/json-viewer.css?cacheVersion=${contentCacheVersion}" />
	<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js?cacheVersion=${contentCacheVersion}"></script>
	<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js?cacheVersion=${contentCacheVersion}"></script>
	<script type="text/javascript" src="/externlib/json-viewer/json-viewer.js?cacheVersion=${contentCacheVersion}"></script>
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
				<li id="tabDataGroupList"><a href="/data-group/list">데이터 그룹</a></li>
				<li id="tabDataGroupInput"><a href="/data-group/input">데이터 그룹 등록</a></li>
				<li id="tabUploadDataInput"><a href="/upload-data/input">업로딩 데이터</a></li>
			   	<li id="tabUploadDataList"><a href="/upload-data/list">업로딩 데이터 목록</a></li>
			  	<li id="tabConverterList"><a href="/converter/list">업로딩 데이터 변환 목록</a></li>
			  	<li id="tabDataList"><a href="/data/list">데이터 목록</a></li>
			  	<li id="tabDataLogList"><a href="/data-log/list">데이터 변경 이력</a></li>
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
					<input type="text" class="s date" id="startDate" name="startDate" autocomplete="off" />
					<span class="delimeter tilde">~</span>
					<input type="text" class="s date" id="endDate" name="endDate" autocomplete="off" />
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
					<spring:message code='all.d'/> <span class="totalCount"><fmt:formatNumber value="${pagination.totalCount}" type="number"/></span> <spring:message code='search.what.count'/>,
					<fmt:formatNumber value="${pagination.pageNo}" type="number"/> / <fmt:formatNumber value="${pagination.lastPage }" type="number"/> <spring:message code='search.page'/>
				</div>
			</div>
			<table class="list-table scope-col" summary="데이터 목록 테이블">
			<caption class="hiddenTag">데이터 목록 테이블</caption>
				<col class="col-number" />
				<col class="col-name" />
				<col class="col-name" />
				<col class="col-type" />
				<col class="col-type" />
				<col class="col-type" />
				<col class="col-type" />
				<col class="col-type" />
				<col class="col-type" />
				<col class="col-type" />
				<col class="col-type" />
				<col class="col-functions" />
				<thead>
					<tr>
						<th scope="col" class="col-number"><spring:message code='number'/></th>
						<th scope="col" class="col-name">그룹명</th>
						<th scope="col" class="col-name">데이터명</th>
						<th scope="col" class="col-type">등록자</th>
						<th scope="col" class="col-type">데이터 타입</th>
						<th scope="col" class="col-type">공유 유형</th>
						<th scope="col" class="col-type">매핑타입</th>
						<th scope="col" class="col-type">상태</th>
						<th scope="col" class="col-type">지도</th>
						<th scope="col" class="col-type">속성</th>
						<th scope="col" class="col-type">Object 속성</th>
						<th scope="col" class="col-functions">등록일</th>
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
						<td class="col-name ellipsis" style="min-width:100px;max-width:100px;">${dataInfo.dataGroupName }</td>
						<td class="col-name ellipsis" style="min-width:160px;max-width:160px;">
							<a href="/data/modify?dataId=${dataInfo.dataId}">${dataInfo.dataName }</a>
						</td>
						<td class="col-type">
		<c:if test="${dataInfo.userId eq owner}">
							${dataInfo.userId }
		</c:if>
		<c:if test="${dataInfo.userId ne owner}">
							<span style="color: blue;">${dataInfo.userId }</span>
		</c:if>
						</td>
						<td class="col-type">${dataInfo.dataType }</td>
						<td class="col-type">
		<c:if test="${dataInfo.sharing eq 'common'}">공통</c:if>
		<c:if test="${dataInfo.sharing eq 'public'}">공개</c:if>
		<c:if test="${dataInfo.sharing eq 'private'}">개인</c:if>
		<c:if test="${dataInfo.sharing eq 'group'}">그룹</c:if>
						</td>
						<td class="col-type ellipsis" style="min-width:80px;max-width:80px;">${dataInfo.mappingType }</td>
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
							<a href="#" onclick="detailDataAttribute('${dataInfo.dataId }', '${dataInfo.dataName }'); return false;">보기</a>
		</c:if>
		<c:if test="${dataInfo.attributeExist eq 'false' }">
							미등록
		</c:if>
						</td>
						<td class="col-type">
		<c:if test="${dataInfo.objectAttributeExist eq 'true' }">
							<a href="#" onclick="detailDataObjectAttribute('${dataInfo.dataId }', '${dataInfo.dataName }'); return false;">보기</a>
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

<%@ include file="/WEB-INF/views/data/data-attribute-dialog.jsp" %>
<%@ include file="/WEB-INF/views/data/data-object-attribute-dialog.jsp" %>

<script type="text/javascript" src="/js/${lang}/common.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/message.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/map-controll.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/ui-controll.js?cacheVersion=${contentCacheVersion}"></script>
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

	// 데이터 속성 다이얼 로그
	var dataAttributeDialog = $( "#dataAttributeDialog" ).dialog({
		autoOpen: false,
		width: 800,
		height: 550,
		modal: true,
		resizable: false
	});

	// 데이터 속성
	function detailDataAttribute(dataId, dataName) {
		dataAttributeDialog.dialog( "open" );
		$("#dataNameForAttribute").html(dataName);

		$.ajax({
			url: "/datas/attributes/" + dataId,
			type: "GET",
			headers: {"X-Requested-With": "XMLHttpRequest"},
			dataType: "json",
			success: function(msg){
				if(msg.statusCode <= 200) {
					if(msg.dataAttribute !== null) {
						//$("#dataAttributeForOrigin").html(msg.dataAttribute.attributes);
						$("#dataAttributeViewer").html("");
						var jsonViewer = new JSONViewer();
						document.querySelector("#dataAttributeViewer").appendChild(jsonViewer.getContainer());
						jsonViewer.showJSON(JSON.parse(msg.dataAttribute.attributes), -1, -1);
					}
				} else {
					alert(JS_MESSAGE[msg.errorCode]);
				}
			},
			error:function(request,status,error){
				alert(JS_MESSAGE["ajax.error.message"]);
			}
		});
	}

	// 데이터 Object 속성 다이얼 로그
	var dataObjectAttributeDialog = $( "#dataObjectAttributeDialog" ).dialog({
		autoOpen: false,
		width: 800,
		height: 550,
		modal: true,
		resizable: false
	});

	// 데이터 Object 속성
	function detailDataObjectAttribute(dataId, dataName) {
		dataObjectAttributeDialog.dialog( "open" );
		$("#dataNameForObjectAttribute").html(dataName);

		$.ajax({
			url: "/datas/object/attributes/" + dataId,
			type: "GET",
			headers: {"X-Requested-With": "XMLHttpRequest"},
			dataType: "json",
			success: function(msg){
				if(msg.statusCode <= 200) {
					if(msg.dataObjectAttribute !== null) {
						//$("#dataObjectAttributeForOrigin").html(msg.dataObjectAttribute.attributes);
						$("#dataObjectAttributeViewer").html("");
						var jsonViewer = new JSONViewer();
						document.querySelector("#dataObjectAttributeViewer").appendChild(jsonViewer.getContainer());
						jsonViewer.showJSON(JSON.parse(msg.dataObjectAttribute.attributes), -1, -1);
					}
				} else {
					alert(JS_MESSAGE[msg.errorCode]);
				}
			},
			error:function(request,status,error){
				alert(JS_MESSAGE["ajax.error.message"]);
			}
		});
	}

	// 지도에서 찾기 -- common.js, openFindDataPoint
	function viewDataInfo(dataId) {
		openFindDataPoint(dataId, "list");
	}
</script>
</body>
</html>
