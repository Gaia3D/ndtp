<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="dataGroupInfoContent" style="display:none;">
	<h3 style="margin-top: 10px;">데이터 공유 유형별 현황</h3>
	<form:form id="searchDataGroupForm" modelAttribute="searchDataGroupForm" method="post" onsubmit="return false;">
	<div class="dataGroupSummary" style="margin: 10px 0px 10px 0px;">
		<table>
			<colgroup>
		        <col class="col-number" />
				<col class="col-number" />
				<col class="col-number" />
				<col class="col-number" />
		    </colgroup>
		    <thead>
				<tr>
					<th scope="col" class="col-number" style="background-color: #f3f3f3;">공공</th>
					<th scope="col" class="col-number" style="background-color: #f3f3f3;">공개</th>
					<th scope="col" class="col-number" style="background-color: #f3f3f3;">비공개</th>
					<th scope="col" class="col-number" style="background-color: #f3f3f3;">그룹</th>
		        </tr>
		        <tr>
		        	<td class="col-number"><fmt:formatNumber value="${commonDataCount }" type="number"/></td>
		        	<td class="col-number"><fmt:formatNumber value="${publicDataCount }" type="number"/></td>
		        	<td class="col-number"><fmt:formatNumber value="${privateDataCount }" type="number"/></td>
		        	<td class="col-number"><fmt:formatNumber value="${groupDataCount }" type="number"/></td>
		        </tr>
		    </thead>
		</table>
	</div>
	</form:form>
	
	<div class="listSearch">
		<input type="text" id="searchDataGroupName" name="searchDataGroupName" placeholder="그룹명을 입력하세요">
		<button type="button" id="mapDataGroupSearch" title="검색">검색</button>
	</div>
	
	<div id="dataGroupListArea">
	</div>
</div>