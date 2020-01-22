<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="dataInfoContent" style="display:none;">
<div class="listSearch">
	<input type="text" placeholder="데이터명을 입력하세요">
	<button type="button" title="검색">검색</button>
</div>

<h3>데이터 목록</h3>
<div class="bothSide">
	<div>
		전체
		<span>55</span>
		/ <span>23</span>건
	</div>
</div>
<div class="dataBtns"></div>
<div class="tableList">
	<table>
		<thead>
			<tr>
				<th rowspan="2">No</th>
				<th colspan="3">데이터명</th>
			</tr>
			<tr>
				<th>상태</th>
				<th>속성</th>
				<th>위치</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td rowspan="2">1</td>
				<td colspan="3">데이터 이름 1</td>
			</tr>
			<tr>
				<td>사용중</td>
				<td><a href="">보기</a></td>
				<td><button type="button" title="바로가기" class="goto">바로가기</button></td>
			</tr>
			<tr>
				<td rowspan="2">2</td>
				<td colspan="3">데이터 이름 2</td>
			</tr>
			<tr>
				<td>사용중</td>
				<td><a href="">보기</a></td>
				<td><button type="button" title="바로가기" class="goto">바로가기</button></td>
			</tr>
			<tr>
				<td rowspan="2">3</td>
				<td colspan="3">데이터 이름 3</td>
			</tr>
			<tr>
				<td>사용중</td>
				<td><a href="">보기</a></td>
				<td><button type="button" title="바로가기" class="goto">바로가기</button></td>
			</tr>
		</tbody>
	</table>
</div>

<ul class="pagination">
	<li class="ico first" title="맨앞으로">처음</li>
	<li class="ico forward" title="앞으로">앞으로</li>
	<li>1</li>
	<li>2</li>
	<li>3</li>
	<li class="on">4</li>
	<li>5</li>
	<li>6</li>
	<li class="ico back" title="뒤로">뒤로</li>
	<li class="ico end" title="맨뒤로">마지막</li>
</ul>
</div>