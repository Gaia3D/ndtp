<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="uploadDataAttributeDialog" title="Data Origin Attribute">
	<form id="dataAttributeInfo" name="dataAttributeInfo" action="/data/insert-data-attribute-file" method="post" enctype="multipart/form-data">
		<input type="hidden" id="attributeFileDataId" name="attributeFileDataId" value="" />
		<table class="inner-table scope-row" style="width: 95%;">
			<col class="col-sub-label xl" />
			<col class="col-data" />
			<tbody>
				<tr>
					<th class="col-sub-label">데이터명</th>
					<td id="attributeDataName"></td>
				</tr>
				
				<tr>
					<th class="col-sub-label">업로딩 파일</th>
					<td>
						<div class="inner-data">
							<input type="file" id="attributeFileName" name="attributeFileName" class="col-data" />
						</div>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="button-group">
			<input type="button" onclick="dataAttributeFileUpload();" class="button" value="<spring:message code='data.file.save'/>"/>
		</div>
		<table id="dataAttributeUploadLog" class="inner-table scope-row" style="width: 95%;">
			<col class="col-sub-label xl" />
			<col class="col-data" />
			<tbody>
			</tbody>
		</table>
	</form>
</div>