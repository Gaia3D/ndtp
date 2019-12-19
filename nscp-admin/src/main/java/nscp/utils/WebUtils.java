package nscp.utils;

import javax.servlet.http.HttpServletRequest;

public class WebUtils {

	/**
	 * 사용자 IP 를 획득
	 * @param request
	 * @return
	 */
	public static String getClientIp(HttpServletRequest request) {
		
		String ip = request.getHeader("X-FORWARDED-FOR");
		
		if(ip == null || "".equals(ip) || "unknown".equals(ip.toLowerCase())) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if(ip == null || "".equals(ip) || "unknown".equals(ip.toLowerCase())) {
			ip = request.getHeader("HTTP_CLIENT_IP");
		}
		if(ip == null || "".equals(ip) || "unknown".equals(ip.toLowerCase())) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}
		if(ip == null || "".equals(ip) || "unknown".equals(ip.toLowerCase())) {
			ip = request.getRemoteAddr();
		}

//		if(ip != null && !"".equals(ip) && ip.length() > 15) {
//			log.error("@@ Client Ip = {}", ip);
//            if( ip.indexOf(",") > -1) {
//                StringTokenizer stringTokenizer = new StringTokenizer(ip, ",");
//                ip = stringTokenizer.nextToken();
//                log.error("@@ Client First Ip = {}", ip);
//            }
//        }
		
		// ipv6 (ipv4 127.0.0.1) localhost 접속시
		if("0:0:0:0:0:0:0:1".equals(ip)) {
			ip = "127.0.0.1";
		}
		
		return ip;
	}
}
