//package arirang.interceptor;
//
//import java.util.HashMap;
//import java.util.Map;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.HttpStatus;
//import org.springframework.stereotype.Component;
//import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
//
//import com.fasterxml.jackson.databind.ObjectMapper;
//
//import arirang.domain.APIError;
//import arirang.domain.MemberSession;
//import arirang.support.URLSupport;
//import arirang.utils.WebUtils;
//import lombok.extern.slf4j.Slf4j;
//
///**
// * 보안 관련 체크 인터셉터
// * @author jeongdae
// *
// */
//@Slf4j
//@Component
//public class SecurityInterceptor extends HandlerInterceptorAdapter {
//	
//	@Autowired
//	private ObjectMapper objectMapper;
//
//	@Override
//	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
//
//		String contextPath = request.getContextPath();
//		String uri = request.getRequestURI();
//		String requestIp = WebUtils.getClientIp(request);
//		
////		log.info("## Requst URI = {}, Method = {}, Request Ip = {}, referer={}", uri, request.getMethod(), requestIp, request.getHeader("referer"));
//    	
//		if(uri.indexOf("/error") >= 0) {
//			log.info("error pass!!!");
////			printHead(request);
//			return true;
//		}
//    	
//		boolean isExceptionURI = false;
//		int exceptionURICount = URLSupport.EXCEPTION_URI.length;
//		for(int i=0 ; i<exceptionURICount; i++) {
//			if(uri.indexOf(URLSupport.EXCEPTION_URI[i]) >= 0) {
//				isExceptionURI = true;
//				break;
//			}
//		}
//    	
//		// 예외 URL 은 통과 처리
//		if(isExceptionURI) {
////			log.info("################################### exception uri");
//			return true;
//		}
//	
//		String loginUrl = URLSupport.LOGIN_URL;
//		if(contextPath != null && !"".equals(contextPath)) {
//			loginUrl = contextPath + URLSupport.LOGIN_URL;
//		}
//    	
//		// 세션이 존재하지 않는 경우
//		MemberSession memberSession = (MemberSession)request.getSession().getAttribute(MemberSession.KEY);
//		if(memberSession == null || memberSession.getAdminId() == null || "".equals(memberSession.getAdminId())) {
//			log.info("Session is Null. memberSession = {}", memberSession);
//			if(isAjax(request)) {
//				Map<String, Object> unauthorizedResult = new HashMap<>();
//				unauthorizedResult.put("statusCode", HttpStatus.UNAUTHORIZED.value());
//				unauthorizedResult.put("error", new APIError("로그인 후 사용 가능 합니다."));
//				
//				response.setContentType("application/json");       
//				response.setCharacterEncoding("UTF-8");
//				response.setStatus(HttpStatus.UNAUTHORIZED.value());
//				response.getWriter().write(objectMapper.writeValueAsString(unauthorizedResult));
//				return false;
//			} else {
//				response.sendRedirect(loginUrl);
//				return false;
//			}
//		}
//		
//		return true;
//	}
//	
//	private boolean isAjax(HttpServletRequest request) {
//		return "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
//	}
//}
