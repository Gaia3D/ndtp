<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<div id="geopolicyTab">
		<form:form id="geoPolicy" modelAttribute="geoPolicy" method="post" onsubmit="return false;">
			<form:hidden path="geoPolicyId" />
			<table class="input-table scope-row">
				<col class="col-label l" />
				<col class="col-input" />
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="cesiumIonToken">Cesium ion token</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
					</th>
					<td class="col-input">
						<form:input path="cesiumIonToken" maxlength="2" cssClass="s" />
						<form:errors path="cesiumIonToken" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="dataServicePath">Data 폴더</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
					</th>
					<td class="col-input">
						<form:input path="dataServicePath" maxlength="2" cssClass="s" />
						<form:errors path="dataServicePath" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="dataChangeRequestDecision">Data 변경 요청 처리</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
					</th>
					<td class="col-input">
						<form:input path="dataChangeRequestDecision" maxlength="2" cssClass="s" />
						<form:errors path="dataChangeRequestDecision" cssClass="error" />
					</td>
				</tr>
			</table>
			<div class="button-group">
				<div class="center-buttons">
					<a href="#" onclick="updatePolicyGeoInfo();" class="button"><spring:message code='save'/></a>
				</div>
			</div>
		</form:form>
	</div>