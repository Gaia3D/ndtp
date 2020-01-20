<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<div id="securityTab">
		<form:form id="policySecurity" modelAttribute="policy" method="post" onsubmit="return false;">
			<table class="input-table scope-row">
				<col class="col-label l" />
				<col class="col-input" />
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="securitySessionTimeoutYn">보안 세션 타임아웃</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
					</th>
					<td class="col-input radio-set">
						<form:radiobutton path="securitySessionTimeoutYn" value="Y" />
						<form:label path="securitySessionTimeoutYn">사용</form:label>
						<form:radiobutton path="securitySessionTimeoutYn" value="N" />
						<form:label path="securitySessionTimeoutYn">미사용</form:label>
						<form:errors path="securitySessionTimeoutYn" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="securitySessionTimeout">보안 세션 타임아웃 시간</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
					</th>
					<td class="col-input">
						<form:input path="securitySessionTimeout" maxlength="2" cssClass="s" />
						<span class="table-desc">분</span>
						<form:errors path="securitySessionTimeout" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="securityUserIpCheckYn">로그인 사용자 IP 체크 유무</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
					</th>
					<td class="col-input radio-set">
						<form:radiobutton path="securityUserIpCheckYn" value="Y" />
						<form:label path="securityUserIpCheckYn">사용</form:label>
						<form:radiobutton path="securityUserIpCheckYn" value="N" />
						<form:label path="securityUserIpCheckYn">미사용</form:label>
						<form:errors path="securityUserIpCheckYn" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="securitySessionHijacking">보안 세션 하이재킹 처리</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
					</th>
					<td class="col-input">
						<form:input path="securitySessionHijacking" maxlength="2" cssClass="s" />
						<form:errors path="securitySessionHijacking" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="securityLogSaveType">보안 로그 저장 방법</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
					</th>
					<td class="col-input">
						<form:input path="securityLogSaveType" maxlength="2" cssClass="s" />
						<form:errors path="securityLogSaveType" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="securityLogSaveTerm">보안 로그 보존 기간</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
					</th>
					<td class="col-input">
						<form:input path="securityLogSaveTerm" maxlength="2" cssClass="s" />
						<form:errors path="securityLogSaveTerm" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="securityDynamicBlockYn">보안 동적 차단</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
					</th>
					<td class="col-input radio-set">
						<form:radiobutton path="securityDynamicBlockYn" value="Y" />
						<form:label path="securityDynamicBlockYn">사용</form:label>
						<form:radiobutton path="securityDynamicBlockYn" value="N" />
						<form:label path="securityDynamicBlockYn">미사용</form:label>
						<form:errors path="securityDynamicBlockYn" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="securityApiResultSecureYn">API 결과 암호화 사용</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
					</th>
					<td class="col-input radio-set">
						<form:radiobutton path="securityApiResultSecureYn" value="Y" />
						<form:label path="securityApiResultSecureYn">사용</form:label>
						<form:radiobutton path="securityApiResultSecureYn" value="N" />
						<form:label path="securityApiResultSecureYn">미사용</form:label>
						<form:errors path="securityApiResultSecureYn" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="securityMaskingYn">개인정보 마스킹 처리</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
					</th>
					<td class="col-input radio-set">
						<form:radiobutton path="securityMaskingYn" value="Y" />
						<form:label path="securityMaskingYn">사용</form:label>
						<form:radiobutton path="securityMaskingYn" value="N" />
						<form:label path="securityMaskingYn">미사용</form:label>
						<form:errors path="securityMaskingYn" cssClass="error" />
					</td>
				</tr>
			</table>
			<div class="button-group">
				<div class="center-buttons">
					<a href="#" onclick="updatePolicySecurity();" class="button"><spring:message code='save'/></a>
				</div>
			</div>
		</form:form>
	</div>