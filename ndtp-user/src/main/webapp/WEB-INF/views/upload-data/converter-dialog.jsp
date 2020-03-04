<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class=dialogConverterJob title="F4D Converter Job 등록">
	<form:form id="converterJobForm" name="converterJobForm" action="" method="post">
		<input type="hidden" id="converterCheckIds" name="converterCheckIds" value="" />
		<input type="hidden" id="dataType" name=dataType value="" />
		<table class="inner-table scope-row" summary="F4D Converter Job 등록" style="width: 99%;">
		<caption class="hiddenTag">Job 등록</caption>
			<col class="col-sub-label xl" />
			<col class="col-data" />
			<tbody>
				<tr>
					<th class="col-sub-label x">변환 템플릿</th>
					<td class="col-input">
						<select id="converterTemplate" name="converterTemplate" class="select" style="height: 30px;">
	                		<option value="basic"> 기본 </option>
		                	<option value="building"> 빌딩 </option>
							<option value="extra-big-building"> 초대형 빌딩 </option>
							<option value="point-cloud"> Point Cloud </option>
							<!-- <option value="single-realistic-mesh"> 단일 Point Cloud </option> -->
							<!-- <option value="splitted-realistic-mesh"> 분할 Point Cloud </option> -->
						</select>
					</td>
				</tr>
				<tr>
					<th class="col-sub-label x">제목</th>
					<td>
						<div class="inner-data">
							<input type="text" id="title" name="title" class="l" />
						</div>
					</td>
				</tr>
				<tr>
					<th class="col-sub-label x">Original Unit</th>
					<td>
						<select id="usf" name="usf" class="select" style="height: 30px;">
	                		<option value="1"> 기본(1m) </option>
		                	<option value="0.1"> 10 cm </option>
							<option value="0.01"> 1 cm </option>
							<option value="0.001"> 1 mm </option>
							<option value="10"> 10 m </option>
						</select>
					</td>
				</tr>
				<tr>
					<th class="col-sub-label x">높이 방향</th>
					<td>
						<select id="yAxisUp" name="yAxisUp" class="select" style="height: 30px;">
							<option value="N">Z축</option>
							<option value="Y">Y축</option>
						</select>
						<span class="marL10">Z축이 건물의 천장을 향하는 경우</span>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="button-group">
			<a href="#" onclick="saveConverterJob(); return false;" class="button" style="color: white">저장</a>
		</div>
	</form:form>
</div>