<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div id="simulSolarDialog" class="basicTable" style="display: none;" title="일조분석 리포트" >
	<table summary="일조분석 리포트 테이블">
	<caption class="hiddenTag">일조분석 리포트</caption>
		<col class="col-label" style="width: 100px;" />
		<col class="col-data" />
		<thead>
			<tr style="height: 30px;">
				<th class="col-label" scope="col">절기</th>
				<th class="col-label" scope="col">일조시간(시간)</th>
			</tr>
		</thead>
		<tbody>
			<tr style="height: 30px;">
				<th class="col-label" scope="row">춘분</th>
				<td id="aa" class="col-data ellipsis">
				</td>
			</tr>
			<tr>
				<th class="col-label" scope="row">하지</th>
				<td id="bb" class="col-data">
				</td>
			</tr>
			<tr>
				<th class="col-label" scope="row">추분</th>
				<td class="col-data">
				</td>
			</tr>
			<tr>
				<th class="col-label" scope="row">동지</th>
				<td class="col-data">
				</td>
			</tr>
		</tbody>
	</table>
</div>