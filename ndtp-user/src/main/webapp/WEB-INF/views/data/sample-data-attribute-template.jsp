<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="sampleDataAttributeDialog" class="basicTable" title="3차원 데이터 상세 속성" style="display: none;">
</div>
<script id="templateSampleDataAttribute" type="text/x-handlebars-template">
	<table class="inner-table scope-row" summary="데이터 속성 다이얼로그">
	<caption class="hiddenTag">데이터 속성 다이얼로그</caption>
		<col class="col-label" />
		<col class="col-data" />
		<tr>
			<th class="col-label" scope="row" style="text-align: center; min-width: 100px;">Molit Ufid</th>
			<td class="col-data">{{molitUfid}}</td>
		</tr>
		<tr>
			<th class="col-label" scope="row" style="text-align: center; min-width: 100px;">건물용도 구분</th>
			<td class="col-data">{{bprpSe}}</td>
		</tr>
		<tr>
			<th class="col-label" scope="row" style="text-align: center; min-width: 100px;">건물명</th>
			<td class="col-data">{{건물명}}</td>
		</tr>	
		<tr>
			<th class="col-label" scope="row" style="text-align: center; min-width: 100px;">건물 명칭</th>
			<td class="col-data">{{buldNm}}</td>
		</tr>
		<tr>
			<th class="col-label" scope="row" style="text-align: center; min-width: 100px;">건물부 명칭</th>
			<td class="col-data">{{batcNm}}</td>
		</tr>
		<tr>
			<th class="col-label" scope="row" style="text-align: center; min-width: 100px;">건물 구분</th>
			<td class="col-data">{{buldSe}}</td>
		</tr>
		<tr>
			<th class="col-label" scope="row" style="text-align: center; min-width: 100px;">PNU 번호</th>
			<td class="col-data">{{pnuNo}}</td>
		</tr>
		<tr>
			<th class="col-label" scope="row" style="text-align: center; min-width: 100px;">대지위치</th>
			<td class="col-data">{{대지위치}}</td>
		</tr>
		<tr>
			<th class="col-label" scope="row" style="text-align: center; min-width: 100px;">관리건축물</th>
			<td class="col-data">{{관리건축물}}</td>
		</tr>
		<tr>
			<th class="col-label" scope="row" style="text-align: center; min-width: 100px;">도로명대지</th>
			<td class="col-data">{{도로명대지}}</td>
		</tr>
		<tr>
			<th class="col-label" scope="row" style="text-align: center; min-width: 100px;">새주소도로</th>
			<td class="col-data">{{새주소도로}}</td>
		</tr>
		<tr>
			<th class="col-label" scope="row" style="text-align: center; min-width: 100px;">기타용도</th>
			<td class="col-data">{{기타용도}}</td>
		</tr>
		<tr>
			<th class="col-label" scope="row" style="text-align: center; min-width: 100px;">주건축물수</th>
			<td class="col-data">{{주건축물수}}</td>
		</tr>
		<tr>
			<th class="col-label" scope="row" style="text-align: center; min-width: 100px;">부속건축물</th>
			<td class="col-data">{{부속건축물}}</td>
		</tr>
		<tr>
			<th class="col-label" scope="row" style="text-align: center; min-width: 100px;">mvmn_resn</th>
			<td class="col-data">{{mvmn_resn}}</td>
		</tr>
		<tr>
			<th class="col-label" scope="row" style="text-align: center; min-width: 100px;">용도</th>
			<td class="col-data">{{용도}}</td>
		</tr>
	</table>
</script>
