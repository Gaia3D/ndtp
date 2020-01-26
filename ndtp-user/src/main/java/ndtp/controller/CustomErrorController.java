//package ndtp.controller;
//
//import java.util.Enumeration;
//
//import javax.servlet.RequestDispatcher;
//import javax.servlet.http.HttpServletRequest;
//
//import org.springframework.boot.web.servlet.error.ErrorController;
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.GetMapping;
//
//import lombok.extern.slf4j.Slf4j;
//
///**
// * spring boot 에서 제공하는 error 페이지를 사용하지 않고 제어하기 위함
// * @author Cheon JeongDae
// *
// */
//@Slf4j
//@Controller
//public class CustomErrorController implements ErrorController {
//
//	@Override
//    public String getErrorPath() {
//        return "/error";
//    }
//	
//	/**
//	 * 
//	 * @param model
//	 * @return
//	 */
//	@GetMapping(value = "/error")
//	public String handleError(HttpServletRequest request) {
//		log.info("@@@@@ ERROR_STATUS_CODE = {}", request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE));
//		log.info("@@@@@ ERROR_MESSAGE = {}", request.getAttribute(RequestDispatcher.ERROR_MESSAGE));
//		log.info("@@@@@ ERROR_EXCEPTION = {}", request.getAttribute(RequestDispatcher.ERROR_EXCEPTION));
//		log.info("@@@@@ ERROR_EXCEPTION_TYPE = {}", request.getAttribute(RequestDispatcher.ERROR_EXCEPTION_TYPE));
//		//log.info("@@@@@ ERROR_SERVLET_NAME = {}", request.getAttribute(RequestDispatcher.ERROR_SERVLET_NAME));
//		log.info("@@@@@ ERROR_REQUEST_URI = {}", request.getAttribute(RequestDispatcher.ERROR_REQUEST_URI));
//		
//		log.info("-------------- additional info --------------");
//		printHead(request);
//		return "/error/error";
//	}
//	
//	private void printHead(HttpServletRequest request) {
//    	Enumeration<String> headerNames = request.getHeaderNames();
//        while (headerNames.hasMoreElements()) {
//        	String headerName = headerNames.nextElement();
//        	log.info("headerName = {}", headerName);
//        	Enumeration<String> headers = request.getHeaders(headerName);
//        	while (headers.hasMoreElements()) {
//        		String headerValue = headers.nextElement();
//        		log.info(" ---> headerValue = {}", headerValue);
//        	}
//        }
//    }
//}
