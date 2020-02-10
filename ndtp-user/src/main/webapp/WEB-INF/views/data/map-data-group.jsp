<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="dataGroupInfoContent" class="contents contents-margin-none yScroll fullHeight" style="display:none;">
	<h3>데이터 공유 유형별 현황</h3>
	<form:form id="searchDataGroupForm" modelAttribute="searchDataGroupForm" method="post" onsubmit="return false;">
	<div class="dataGroupSummary table-data-group-summary">
		<table class="table-word-break">
			<colgroup>
		        <col class="col-number" />
				<col class="col-number" />
				<col class="col-number" />
				<col class="col-number" />
		    </colgroup>
		    <thead>
				<tr>
					<th scope="col" class="col-number">공공</th>
					<th scope="col" class="col-number">공개</th>
					<th scope="col" class="col-number">비공개</th>
					<th scope="col" class="col-number">그룹</th>
		        </tr>
		    </thead>
		    <tbody>
		    	<tr>
		        	<td class="col-number"><fmt:formatNumber value="${commonDataCount}" type="number"/></td>
		        	<td class="col-number"><fmt:formatNumber value="${publicDataCount}" type="number"/></td>
		        	<td class="col-number"><fmt:formatNumber value="${privateDataCount}" type="number"/></td>
		        	<td class="col-number"><fmt:formatNumber value="${groupDataCount}" type="number"/></td>
		        </tr>
		    </tbody>
		</table>
	</div>
	</form:form>
	<div class="summary-group-divide"></div>
	<h3>데이터 그룹 검색</h3>
	<div class="listSearch search-text">
		<input type="text" id="searchDataGroupName" name="searchDataGroupName" placeholder="그룹명을 입력하세요">
		<button type="button" id="mapDataGroupSearch" class="btnTextF" title="검색">검색</button>
	</div>

	<div id="dataGroupListArea">
	</div>
</div>