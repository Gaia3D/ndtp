<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<c:if test="${pagination.totalCount > 0}">
		<div class="pagination">
	<c:if test="${pagination.existPrePage == 'true'}">
			<a href="${pagination.uri }?pageNo=${pagination.firstPage}${pagination.searchParameters}" class="ico first"><span></span></a>
			<a href="${pagination.uri }?pageNo=${pagination.prePageNo}${pagination.searchParameters}" class="ico forward"><span></span></a>
	</c:if>

	<c:forEach var="pageIndex" begin="${pagination.startPage}" end="${pagination.endPage}" step="1">
		<c:if test="${pageIndex == pagination.pageNo}">
			<a href="#" class="on">${pageIndex}</a>
		</c:if>
		<c:if test="${pageIndex != pagination.pageNo}">
			<a href="${pagination.uri}?pageNo=${pageIndex}${pagination.searchParameters}">${pageIndex}</a>
		</c:if>
	</c:forEach>

	<c:if test="${pagination.existNextPage == 'true' }">
			<a href="${pagination.uri}?pageNo=${pagination.nextPageNo}${pagination.searchParameters}" class="ico back"><span></span></a>
			<a href="${pagination.uri}?pageNo=${pagination.lastPage}${pagination.searchParameters}" class="ico end"><span></span></a>
	</c:if>
		</div>
</c:if>