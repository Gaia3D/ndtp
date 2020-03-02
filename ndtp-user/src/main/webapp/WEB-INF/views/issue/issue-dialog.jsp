<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<form:form id="issueForm" name="issueForm" method="post" onsubmit="return false;">
	<input type="hidden" id="issueDataId" name="issueDataId" value="" />
	<input type="hidden" id="issueDataKey" name="issueDataKey" value="" />
	<input type="hidden" id="issueObjectKey" name="issueObjectKey" value="" />
	<input type="hidden" id="issueDataGroupId" name="issueDataGroupId" value="" />
<div id="issueDialog" class="basicTable" style="display: none;" title="이슈 등록" >
	<table summary="이슈 등록 테이블">
	<caption class="hiddenTag">이슈 등록</caption>
		<col class="col-label" style="width: 100px;" />
		<col class="col-data" />
		<tr style="height: 30px;">
			<th class="col-label" scope="row">데이터 그룹명</th>
			<td id="issueDataGroupName" class="col-data ellipsis">
			</td>
		</tr>
		<tr>
			<th class="col-label" scope="row">데이터명</th>
			<td id="issueDataName" class="col-data">
			</td>
		</tr>
		<tr>
			<th class="col-label" scope="row">경도</th>
			<td class="col-data">
				<label for="issueLongitude" class="hiddenTag">경도</label>
				<input type="text" id="issueLongitude" name="issueLongitude" readonly="readonly" size="25" style="background-color: #CBCBCB;" />
			</td>
		</tr>
		<tr>
			<th class="col-label" scope="row">위도</th>
			<td class="col-data">
				<label for="issueLatitude" class="hiddenTag">위도</label>
				<input type="text" id="issueLatitude" name="issueLatitude" readonly="readonly" size="25" style="background-color: #CBCBCB;" />
			</td>
		</tr>
		<tr>
			<th class="col-label" scope="row">높이</th>
			<td class="col-data">
				<label for="issueAltitude" class="hiddenTag">높이</label>
				<input type="text" id="issueAltitude" name="issueAltitude" readonly="readonly" size="25" style="background-color: #CBCBCB;" />
			</td>
		</tr>
		<tr>
			<th class="col-label" scope="row">제목</th>
			<td class="col-data">
				<label for="issueTitle" class="hiddenTag">제목</label>
				<textarea id="issueTitle" name="issueTitle" rows="2" cols="47"></textarea>
			</td>
		</tr>
		<tr>
			<th class="col-label" scope="row">내용</th>
			<td class="col-data">
				<label for="issueContents" class="hiddenTag">내용</label>
				<textarea id="issueContents" name="issueContents" rows="5" cols="47"></textarea>
			</td>
		</tr>
	</table>
	
	<div class="btns" style="margin-top: 10px;">
		<button type="button" id="issueSaveButton" onclick="insertIssue(); return false;" class="focusA btn-full"><spring:message code='save'/></button>
	</div>
</div>
</form:form>