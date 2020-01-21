<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<div id="userTab">
		<form:form id="policyUser" modelAttribute="policy" method="post" onsubmit="return false;">
			<table class="input-table scope-row">
				<col class="col-label l" />
				<col class="col-input" />
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="userIdMinLength">사용자 아이디 최소길이</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
					</th>
					<td class="col-input">
						<form:input path="userIdMinLength" maxlength="2" cssClass="s" />
						<span class="table-desc">5이상</span>
						<form:errors path="userIdMinLength" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="userFailSigninCount">로그인 실패 횟수</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
					</th>
					<td class="col-input">
						<form:input path="userFailSigninCount" maxlength="2" cssClass="s" />
						<span class="table-desc">회</span>
						<form:errors path="userFailSigninCount" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="userFailLockRelease">로그인 실패 잠금 해제 기간</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
					</th>
					<td class="col-input">
						<form:input path="userFailLockRelease" maxlength="3" cssClass="s" />
						<span class="table-desc">일</span>
						<form:errors path="userFailLockRelease" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="userLastSigninLock">마지막 로그인으로부터 잠금 기간</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
					</th>
					<td class="col-input">
						<form:input path="userLastSigninLock" maxlength="3" cssClass="s" />
						<span class="table-desc">일</span>
						<form:errors path="userLastSigninLock" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="userDuplicationSigninYn">중복 로그인 허용</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
					</th>
					<td class="col-input radio-set">
						<form:radiobutton path="userDuplicationSigninYn" value="Y" />
						<form:label path="userDuplicationSigninYn">사용</form:label>
						<form:radiobutton path="userDuplicationSigninYn" value="N" />
						<form:label path="userDuplicationSigninYn">미사용</form:label>
						<form:errors path="userDuplicationSigninYn" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="userSigninType">사용자 로그인 인증 방법</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
					</th>
					<td class="col-input">
						<form:input path="userSigninType" maxlength="2" cssClass="s" />
						<form:errors path="userSigninType" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="userDeleteType">사용자 정보 삭제 방법</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
					</th>
					<td class="col-input">
						<form:input path="userDeleteType" maxlength="2" cssClass="s" />
						<form:errors path="userDeleteType" cssClass="error" />
					</td>
				</tr>
			</table>
			<div class="button-group">
				<div class="center-buttons">
					<a href="#" onclick="updatePolicyUser();" class="button"><spring:message code='save'/></a>
				</div>
			</div>
		</form:form>
	</div>