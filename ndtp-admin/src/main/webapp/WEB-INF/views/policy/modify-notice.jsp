<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<div id="noticeTab">
		<form:form id="policyNotice" modelAttribute="policy" method="post" onsubmit="return false;">
			<table class="input-table scope-row">
				<col class="col-label l" />
				<col class="col-input" />
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="noticeServiceYn">알림 서비스 사용 유무</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
					</th>
					<td class="col-input radio-set">
						<form:radiobutton path="noticeServiceYn" value="Y" />
						<form:label path="noticeServiceYn">사용</form:label>
						<form:radiobutton path="noticeServiceYn" value="N" />
						<form:label path="noticeServiceYn">미사용</form:label>
						<form:errors path="noticeServiceYn" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="noticeServiceSendType">알림 발송 매체</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
					</th>
					<td class="col-input">
						<form:input path="noticeServiceSendType" maxlength="2" cssClass="s" />
						<form:errors path="noticeServiceSendType" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="noticeRiskYn">알림 장애 발생시</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
					</th>
					<td class="col-input radio-set">
						<form:radiobutton path="noticeRiskYn" value="Y" />
						<form:label path="noticeRiskYn">사용</form:label>
						<form:radiobutton path="noticeRiskYn" value="N" />
						<form:label path="noticeRiskYn">미사용</form:label>
						<form:errors path="noticeRiskYn" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="noticeRiskSendType">알림 장애 발송 매체</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
					</th>
					<td class="col-input">
						<form:input path="noticeRiskSendType" maxlength="2" cssClass="s" />
						<form:errors path="noticeRiskSendType" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="noticeRiskGrade">알림 발송 장애 등급</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
					</th>
					<td class="col-input">
						<form:input path="noticeRiskGrade" maxlength="2" cssClass="s" />
						<form:errors path="noticeRiskGrade" cssClass="error" />
					</td>
				</tr>
			</table>
			<div class="button-group">
				<div class="center-buttons">
					<a href="#" onclick="updatePolicyNotice();" class="button"><spring:message code='save'/></a>
				</div>
			</div>
		</form:form>
	</div>