<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="fileInfoDetailDialog" class="fileInfoDetailDialog" title="파일 정보 상세">
</div>
<script id="templateFileInfoDetail" type="text/x-handlebars-template">
	<table style="width: 100%;">
		<colgroup>
			<col style="width: 25%; min-width: 150px; background: #eae8e8;">
			<col style="width: 75%" >
		</colgroup>
		<tr style="height: 40px;">	
			<th scope="row" nowrap="nowrap" style="padding: 10px; border: 1px solid #f7f4f4;">파일명</th>
			<td style="padding-left: 10px; padding-top: 10px;">{{fileName}}</td>
		</tr>
		<tr style="height: 40px;">	
			<th scope="row" nowrap="nowrap" style="padding: 10px; border: 1px solid #f7f4f4;">파일 용량</th>
			<td style="padding-left: 10px; padding-top: 10px;">{{multiply fileSize 0.001}} KB</td>
		</tr>
		<tr style="height: 40px;">	
			<th scope="row" nowrap="nowrap" style="padding: 10px; border: 1px solid #f7f4f4;">인코딩</th>
			<td style="padding-left: 10px; padding-top: 10px;">
				{{ifEquals shapeEncoding "null"}}
			</td>
		</tr>
		<tr style="height: 40px;">	
			<th scope="row" nowrap="nowrap" style="padding: 10px; border: 1px solid #f7f4f4;">최종 수정자</th>
			<td style="padding-left: 10px; padding-top: 10px;">{{userId}}</td>
		</tr>
		<tr style="height: 40px;">	
			<th scope="row" nowrap="nowrap" style="padding: 10px; border: 1px solid #f7f4f4;">수정사항</th>
			<td style="padding-left: 10px; padding-top: 10px;">{{comment}}</td>
		</tr>
		<tr style="height: 40px;">	
			<th scope="row" nowrap="nowrap" style="padding: 10px; border: 1px solid #f7f4f4;">최종 수정일</th>
			<td style="padding-left: 10px; padding-top: 10px;">{{viewUpdateDate}}</td>
		</tr>
	</table>
</script>