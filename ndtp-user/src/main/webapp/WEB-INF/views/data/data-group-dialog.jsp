<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="dataGroupDialog" class="basicTable" style="display: none;">
</div>
<script id="templateDataGroup" type="text/x-handlebars-template">
	<table summary="데이터 그룹 다이얼로그">
	<caption class="hiddenTag">데이터 그룹 다이얼로그</caption>
		<col class="col-label" />
		<col class="col-data" />
		<tr>
			<th class="col-label" scope="row">데이터 그룹명</th>
			<td id="dataGroupName" class="col-data ellipsis" style="max-width: 300px;">{{dataGroupName}}</td>
		</tr>
		<tr>
			<th class="col-label" scope="row">데이터 타켓</th>
			<td id="dataGroupTarget" class="col-data">{{dataGroupTarget}}</td>
		</tr>
		<tr>
			<th class="col-label" scope="row">공유 유형</th>
			<td id="sharing" class="col-data">
{{#ifMatch sharing 'common'}}
				공통
{{/ifMatch}}
{{#ifMatch sharing 'public'}}
				공개
{{/ifMatch}}
{{#ifMatch sharing 'private'}}
				개인
{{/ifMatch}}
{{#ifMatch sharing 'group'}}
				그룹
{{/ifMatch}}			
			</td>
		</tr>
		<tr>
			<th class="col-label" scope="row">사용자 아이디</th>
			<td id="userId" class="col-data">{{userId}}</td>
		</tr>
		<tr>
			<th class="col-label" scope="row">기본유무</th>
			<td id="basic" class="col-data">
{{#if basic}}
				기본
{{else}}
				선택
{{/if}}			
			</td>
		</tr>
		<tr>
			<th class="col-label" scope="row">사용유무</th>
			<td id="available" class="col-data">
{{#if available}}
				사용
{{else}}
				미사용
{{/if}}			
			</td>
		</tr>
		<tr>
			<th class="col-label" scope="row">데이터 건수</th>
			<td id="dataCount" class="col-data">{{dataCount}}</td>
		</tr>
		<tr>
			<th class="col-label" scope="row">경도</th>
			<td id="longitude" class="col-data">{{longitude}}</td>
		</tr>
		<tr>
			<th class="col-label" scope="row">위도</th>
			<td id="latitude" class="col-data">{{latitude}}</td>
		</tr>
		<tr>
			<th class="col-label" scope="row">높이</th>
			<td id="altitude" class="col-data">{{altitude}}</td>
		</tr>
		<tr>
			<th class="col-label" scope="row">이동시간</th>
			<td id="duration" class="col-data">{{duration}}</td>
		</tr>
		<tr>
			<th class="col-label" scope="row">메타정보</th>
			<td id="metainfo" class="col-data">{{metainfo}}</td>
		</tr>
		<tr>
			<th class="col-label" scope="row">설명</th>
			<td id="description" class="col-data">{{description}}</td>
		</tr>
		<tr>
			<th class="col-label" scope="row">수정일</th>
			<td id="updateDate" class="col-data">{{viewUpdateDate}}</td>
		</tr>
		<tr>
			<th class="col-label" scope="row">등록일</th>
			<td id="insertDate" class="col-data">{{viewInsertDate}}</td>
		</tr>
	</table>
</script>