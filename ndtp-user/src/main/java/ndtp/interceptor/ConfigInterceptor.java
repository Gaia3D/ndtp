//package arirang.interceptor;
//
//import java.util.List;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//
//import org.springframework.stereotype.Component;
//import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
//
//import arirang.domain.APIAdminGroupMenu;
//import arirang.domain.APIAdminMenu;
//import arirang.domain.CacheManager;
//import arirang.domain.MemberSession;
//import arirang.domain.YOrN;
//import lombok.extern.slf4j.Slf4j;
//
///**
// * 사이트 전체 설정 관련 처리를 담당
// *  
// * @author jeongdae
// *
// */
//@Slf4j
//@Component
//public class ConfigInterceptor extends HandlerInterceptorAdapter {
//
//    @Override
//    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
//    	
//    	String contextPath = request.getContextPath();
//    	String uri = request.getRequestURI();
//    	if(contextPath != null && !"".equals(contextPath)) {
//    		if(uri != null && !"".equals(uri)) {
//    			uri = uri.replace(contextPath, "");
//    		}
//    	}
//    	
//    	if(uri.equals("/")) return true;
//    	HttpSession session = request.getSession();
//    	
//    	// TODO 너무 비 효율 적이다. 좋은 방법을 찾자.
//    	// 세션이 존재하지 않는 경우
//    	MemberSession memberSession = (MemberSession)session.getAttribute(MemberSession.KEY);
//    	if(memberSession != null && memberSession.getAdminId() != null && !"".equals(memberSession.getAdminId())) {
//	    	List<APIAdminGroupMenu> memberGroupMenuList = CacheManager.getMemberGroupMenuList(memberSession.getGroupId());
//	    	
//	    	Integer clickParentId = null;
//			Integer clickMenuId = null;
//			Integer clickDepth = null;
//			APIAdminMenu menu = null;
//			APIAdminMenu parentMenu = null;
//			
//			for(APIAdminGroupMenu memberGroupMenu : memberGroupMenuList) {
//				if(uri.equals(memberGroupMenu.getUrl())) {
//					clickMenuId = memberGroupMenu.getMenuId();
//					if(memberGroupMenu.getDepth() == 1) {
//						clickParentId = memberGroupMenu.getMenuId();
//					} else {
//						clickParentId = Integer.valueOf(memberGroupMenu.getParent().toString());
//					}
//					clickDepth = memberGroupMenu.getDepth();
//					
//					if( memberGroupMenu.getDepth() == 1 && (uri.indexOf("/main/index.do")>=0) ) {
//						break;
//					} else if( memberGroupMenu.getDepth() == 2) {
//						break;
//					} else {
//						continue;
//					}
//				}
//			}
//			
//			menu = CacheManager.getMenuMap().get(clickMenuId);
//			parentMenu = CacheManager.getMenuMap().get(clickParentId);
//			
//			if(menu != null) {
//				if(YOrN.Y.name().equals(menu.getDisplayYn())) {
//					menu.setAliasName(null);
//					parentMenu.setAliasName(null);
//				} else {
//					Integer aliasMenuId = CacheManager.getMenuUrlMap().get(menu.getUrlAlias());
//					APIAdminMenu aliasMenu = CacheManager.getMenuMap().get(aliasMenuId);
//					menu.setAliasName(aliasMenu.getName());
//					parentMenu.setAliasName(aliasMenu.getName());
//				}
//			}
//			
//			request.setAttribute("clickMenuId", clickMenuId);
//			request.setAttribute("menu", menu);
//			request.setAttribute("parentMenu", parentMenu);
//			request.setAttribute("cacheMemberGroupMenuList", memberGroupMenuList);
//			request.setAttribute("cacheMemberGroupMenuListSize", memberGroupMenuList.size());
//    	}
//    	
//        return true;
//    }
//}
