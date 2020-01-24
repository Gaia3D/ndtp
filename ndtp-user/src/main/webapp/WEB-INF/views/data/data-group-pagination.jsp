<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<c:if test="${pagination.totalCount > 0}">			
		<ul class="pagination">
			<li class="ico first" onclick="pagingDataGroupList('${pagination.firstPage }', '${pagination.searchParameters}');">처음</li>
	<c:if test="${pagination.existPrePage == 'true' }">
			<li class="ico forward" onclick="pagingDataGroupList('${pagination.prePageNo }', '${pagination.searchParameters}');">앞으로</li>
	</c:if>
					
	<c:forEach var="pageIndex" begin="${pagination.startPage }" end="${pagination.endPage }" step="1">
		<c:if test="${pageIndex == pagination.pageNo }">
			<li class="on" >${pageIndex }</li>
		</c:if>
		<c:if test="${pageIndex != pagination.pageNo }">
			<li onclick="pagingDataGroupList('${pageIndex }', '${pagination.searchParameters}');">${pageIndex }</li>
		</c:if>
	</c:forEach>
	
	<c:if test="${pagination.existNextPage == 'true' }">
			<li class="ico back" onclick="pagingDataGroupList('${pagination.nextPageNo }', '${pagination.searchParameters}');">뒤로</li>
	</c:if>		
			<li class="ico end"  onclick="pagingDataGroupList('${pagination.lastPage }', '${pagination.searchParameters}');">마지막</li>
		</ul>
</c:if>