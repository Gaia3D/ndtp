<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="dataInfoContent" class="contents contents-margin-none fullHeight" style="display:block;">
	<form:form id="searchDataForm" modelAttribute="searchDataForm" method="post" onsubmit="return false;">
	<div class="form-group form-group-data">
		<label for="searchDataName">데이터명</label>
		<input type="text" id="searchDataName" name="searchDataName" placeholder=" 데이터명을 입력하여 주십시오. " size="30" />
	</div>
	<div class="form-group form-group-data">
		<label for="searchDataStatus">상태</label>
		<select id="searchDataStatus" name="searchDataStatus">
			<option value="">전체</option>
			<option value="use">사용중</option>
			<option value="unused">사용중지</option>
		</select>
	</div>
	<div class="form-group form-group-data">
		<label for="searchDataType">타입</label>
		<select id="searchDataType" name="searchDataType">
			<option value="">전체</option>
			<option value="citygml">citygml</option>
			<option value="indoorgml">indoorgml</option>
			<option value="las">las</option>
			<option value="ifc">ifc</option>
			<!-- <option value="collada">collada</option> -->
			<option value="dae">dae(collada)</option>
			<option value="obj">obj</option>
			<option value="3ds">3ds</option>
		</select>
	</div>
	<div class="form-group button-group-center">
		<button type="submit" id="mapDataSearch" class="btnTextF search-text" title="검색">검색</button>
	</div>
	</form:form>
	<dl class="legendWrap">
		<dt>공유 유형</dt>
		<dd><span class="legend co">C</span>공통</dd>
		<dd><span class="legend pu">O</span>공개</dd>
		<dd><span class="legend pr">P</span>비공개</dd>
		<dd><span class="legend gr">G</span>그룹공개</dd>
	</dl>
	<div id="dataInfoListArea" style="height:calc(100% - 255px)"></div>
</div>