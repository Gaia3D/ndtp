<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<nav class="site-navigation">
	<div class="main-menu row">
		<div class="container">
			<ul>
<c:set var="menuDepthValue" value="0" />			
<c:forEach var="userGroupMenu" items="${cacheUserGroupMenuList }" varStatus="status">
	<c:if test="${userGroupMenu.depth eq 1 and userGroupMenu.displayYn eq 'Y'}">
		<c:if test="${menuDepthValue eq '1'}">
				</li>
		</c:if>
		<c:if test="${menuDepthValue eq '2'}">
					</ul>
				</li>
		</c:if>
		<c:if test="${userGroupMenu.menuId eq parentMenu.menuId}">
				<li id="main-menu-${userGroupMenu.menuId }" class="current-page">
		</c:if>
		<c:if test="${userGroupMenu.menuId ne parentMenu.menuId}">
				<li id="main-menu-${userGroupMenu.menuId }">
		</c:if>	
					<a href="${userGroupMenu.url }">
						<span class="icon-glyph ${userGroupMenu.cssClass }"></span>
						<span class="icon-text">${userGroupMenu.name }</span>
					</a>
	</c:if>
	<c:if test="${userGroupMenu.depth eq 2 and userGroupMenu.displayYn eq 'Y'}">
		<c:if test="${menuDepthValue eq '1'}">
					<ul id="sub-menu-${userGroupMenu.parent }">
		</c:if>
						<li><a href="${userGroupMenu.url }">${userGroupMenu.name }</a></li>
	</c:if>	
	
	<c:if test="${menuDepthValue eq '1' and status.last }">
				</li>
	</c:if>
	<c:if test="${menuDepthValue eq '2' and status.last }">
					</ul>
				</li>
	</c:if>
	
	<c:set var="menuDepthValue" value="${userGroupMenu.depth }" />
</c:forEach>
			</ul>
		</div>
	</div>
</nav>