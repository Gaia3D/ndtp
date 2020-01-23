<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="dataInfoDialog" class="basicTable" style="display: none;">
</div>
<script id="templateDataInfo" type="text/x-handlebars-template">
	<table>
		<col class="col-label" />
		<col class="col-data" />
		<tr>
			<th class="col-label" scope="row">데이터 그룹명</th>
			<td id="dataGroupName" class="col-data">{{dataGroupName}}</td>
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
			<th class="col-label" scope="row">공유 유형</th>
			<td id="sharing" class="col-data">{{sharing}}</td>
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
			<td id="longitude" class="col-data">{{latitude}}</td>
		</tr>
		<tr>
			<th class="col-label" scope="row">높이</th>
			<td id="longitude" class="col-data">{{altitude}}</td>
		</tr>
		<tr>
			<th class="col-label" scope="row">Heading</th>
			<td id="heading" class="col-data">{{heading}}</td>
		</tr>
		<tr>
			<th class="col-label" scope="row">Pitch</th>
			<td id="heading" class="col-data">{{pitch}}</td>
		</tr>
		<tr>
			<th class="col-label" scope="row">Roll</th>
			<td id="heading" class="col-data">{{roll}}</td>
		</tr>
		<tr>
			<th class="col-label" scope="row">메타정보</th>
			<td id="metainfo" class="col-data">{{metainfo}}</td>
		</tr>
		<tr>
			<th class="col-label" scope="row">속성 존재 유무</th>
			<td id="attributeExist" class="col-data">{{attributeExist}}</td>
		</tr>
		<tr>
			<th class="col-label" scope="row">Object 속성 존재 유무</th>
			<td id="objectAttributeExist" class="col-data">{{objectAttributeExist}}</td>
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