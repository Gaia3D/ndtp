<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="dataInfoDialog" class="basicTable" style="display: none;">
</div>
<script id="templateDataInfo" type="text/x-handlebars-template">
	<table summary="데이터 다이얼로그">
	<caption class="hiddenTag">데이터 다이얼로그</caption> 
		<col class="col-label" />
		<col class="col-data" />
		<tr>
			<th class="col-label" scope="row">데이터 그룹명</th>
			<td id="dataGroupName" class="col-data ellipsis" style="max-width: 300px;">{{dataGroupName}}</td>
		</tr>
		<tr>
			<th class="col-label" scope="row">데이터 Key</th>
			<td id="dataKey" class="col-data">{{dataKey}}</td>
		</tr>
		<tr>
			<th class="col-label" scope="row">데이터 타입</th>
			<td id="dataType" class="col-data">{{dataType}}</td>
		</tr>
		<tr>
			<th class="col-label" scope="row">사용자 아이디</th>
			<td id="userId" class="col-data">{{userId}}</td>
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
			<th class="col-label" scope="row">매핑 타입</th>
			<td id="mappingType" class="col-data">{{mappingType}}</td>
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
			<th class="col-label" scope="row">Heading</th>
			<td id="heading" class="col-data">{{heading}}</td>
		</tr>
		<tr>
			<th class="col-label" scope="row">Pitch</th>
			<td id="pitch" class="col-data">{{pitch}}</td>
		</tr>
		<tr>
			<th class="col-label" scope="row">Roll</th>
			<td id="roll" class="col-data">{{roll}}</td>
		</tr>
		<tr>
			<th class="col-label" scope="row">메타정보</th>
			<td id="metainfo" class="col-data">{{metainfo}}</td>
		</tr>
		<tr>
			<th class="col-label" scope="row">속성 존재 유무</th>
			<td id="attributeExist" class="col-data">
{{#if attributeExist}}
				<a href="#" onclick="detailDataAttribute('{{dataId }}', '{{dataGroupKey}}', '{{dataKey}}', '{{dataName}}'); return false;">보기</a>	
{{else}}
				미등록
{{/if}}
			</td>
		</tr>
		<tr>
			<th class="col-label" scope="row">Object 속성 존재 유무</th>
			<td id="objectAttributeExist" class="col-data">
{{#if objectAttributeExist}}
				<a href="#" onclick="detailDataObjectAttribute('{{dataId }}', '{{dataName}}'); return false;">보기</a>
{{else}}
				미등록
{{/if}}
			</td>
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