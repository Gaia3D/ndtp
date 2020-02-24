<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<div id="noticeTab">
		<form:form id="policyNotice" modelAttribute="policy" method="post" onsubmit="return false;">
			<table class="input-table scope-row" summary="환경설정 공지사항 테이블">
			<caption class="hiddenTag">환경설정 공시사항</caption>
				<col class="col-label l" />
				<col class="col-input" />
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="noticeServiceYn">알림 서비스 사용 유무</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
					</th>
					<td class="col-input radio-set">
						<form:radiobutton label="${use }" path="noticeServiceYn" value="Y" />
						<form:radiobutton label="${notuse }(기본값)" path="noticeServiceYn" value="N" />
						<form:errors path="noticeServiceYn" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="noticeServiceSendType">알림 발송 매체</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
					</th>
					<td class="col-input radio-set">
						<form:radiobutton label="SMS(기본값)" path="noticeServiceSendType" value="0" />
						<form:radiobutton label="이메일" path="noticeServiceSendType" value="1" />
						<form:radiobutton label="메신저" path="noticeServiceSendType" value="2" />
						<form:errors path="noticeServiceSendType" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="noticeRiskYn">알림 장애 발생시</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
					</th>
					<td class="col-input radio-set">
						<form:radiobutton label="${use }" path="noticeRiskYn" value="Y" />
						<form:radiobutton label="${notuse }(기본값)" path="noticeRiskYn" value="N" />
						<form:errors path="noticeRiskYn" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="noticeRiskSendType">알림 장애 발송 매체</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
					</th>
					<td class="col-input radio-set">
						<form:radiobutton label="SMS(기본값)" path="noticeRiskSendType" value="0" />
						<form:radiobutton label="이메일" path="noticeRiskSendType" value="1" />
						<form:radiobutton label="메신저" path="noticeRiskSendType" value="2" />
						<form:errors path="noticeRiskSendType" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="noticeRiskGrade">알림 발송 장애 등급</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
					</th>
					<td class="col-input radio-set">
						<form:radiobutton label="1등급(기본값)" path="noticeRiskGrade" value="1" />
						<form:radiobutton label="2등급" path="noticeRiskGrade" value="2" />
						<form:radiobutton label="3등급" path="noticeRiskGrade" value="3" />
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