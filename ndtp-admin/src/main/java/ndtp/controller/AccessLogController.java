package ndtp.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import ndtp.domain.AccessLog;
import ndtp.domain.Pagination;
import ndtp.service.AccessLogService;
import ndtp.utils.DateUtils;
import ndtp.utils.FormatUtils;

@Slf4j
@RequestMapping("/access/")
@Controller
public class AccessLogController {
	
	@Autowired
	private AccessLogService accessLogService;
	
	/**
	 * Access Log 목록
	 */
	@GetMapping(value = "list")
	public String list(HttpServletRequest request, @RequestParam(defaultValue="1") String pageNo, AccessLog accessLog, Model model) {
		log.info("@@ accessLog = {}", accessLog);
		
		String today = DateUtils.getToday(FormatUtils.YEAR_MONTH_DAY);
		if(StringUtils.isEmpty(accessLog.getStartDate())) {
			accessLog.setStartDate(today.substring(0,4) + DateUtils.START_DAY_TIME);
		} else {
			accessLog.setStartDate(accessLog.getStartDate().substring(0, 8) + DateUtils.START_TIME);
		}
		if(StringUtils.isEmpty(accessLog.getEndDate())) {
			accessLog.setEndDate(today + DateUtils.END_TIME);
		} else {
			accessLog.setEndDate(accessLog.getEndDate().substring(0, 8) + DateUtils.END_TIME);
		}
		
		Long totalCount = accessLogService.getAccessLogTotalCount(accessLog);
		Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(accessLog), totalCount, Long.valueOf(pageNo).longValue());
		log.info("@@ pagination = {}", pagination);
		
		accessLog.setOffset(pagination.getOffset());
		accessLog.setLimit(pagination.getPageRows());
		List<AccessLog> accessLogList = new ArrayList<>();
		if(totalCount > 0l) {
			//accessLogList = logService.getListAccessLog(accessLog);
		}
		
		model.addAttribute(pagination);
		model.addAttribute("accessLog", accessLog);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("accessLogList", accessLogList);
		
		return "/access/list";
	}
	
	/**
	 * 모든 서비스 요청에 대한 이력
	 * @param model
	 * @return
	 */
	@GetMapping(value = "accesses")
	@ResponseBody
	public Map<String, Object> listAccessLog(HttpServletRequest request, AccessLog accessLog, @RequestParam(defaultValue="1") String pageNo) {
		
		log.info("@@ accessLog = {}", accessLog);
		
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		List<AccessLog> accessLogList = new ArrayList<>();
		try {
			String today = DateUtils.getToday(FormatUtils.YEAR_MONTH_DAY);
			if(StringUtils.isEmpty(accessLog.getStartDate())) {
				accessLog.setStartDate(today.substring(0,4) + DateUtils.START_DAY_TIME);
			} else {
				accessLog.setStartDate(accessLog.getStartDate().substring(0, 8) + DateUtils.START_TIME);
			}
			if(StringUtils.isEmpty(accessLog.getEndDate())) {
				accessLog.setEndDate(today + DateUtils.END_TIME);
			} else {
				accessLog.setEndDate(accessLog.getEndDate().substring(0, 8) + DateUtils.END_TIME);
			}
			
			if(accessLog.getTotalCount() == null) accessLog.setTotalCount(0l);
			Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(accessLog), accessLog.getTotalCount().longValue(), Long.valueOf(pageNo).longValue());
			log.info("@@ pagination = {}", pagination);
			
			accessLog.setOffset(pagination.getOffset());
			accessLog.setLimit(pagination.getPageRows());
			if(accessLog.getTotalCount().longValue() > 0l) {
				accessLogList = accessLogService.getListAccessLog(accessLog);
			}
			
			statusCode = HttpStatus.OK.value();
		} catch(Exception e) {
			e.printStackTrace();
			statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
			errorCode = "db.exception";
			message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
		}
		
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		result.put("accessLogList", accessLogList);
		
		return result;
	}
	
	/**
	 *  Access Log 상세
	 */
	@GetMapping(value = "accesses/{accessLogId}")
	@ResponseBody
	public Map<String, Object>  detail(@PathVariable Long accessLogId) {
		
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		AccessLog accessLog = null;
		try {
			accessLog = accessLogService.getAccessLog(accessLogId);
			
			statusCode = HttpStatus.OK.value();
		} catch(Exception e) {
			e.printStackTrace();
			statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
			errorCode = "db.exception";
			message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
		}
		
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		result.put("accessLog", accessLog);
		
		return result;
	}
	
//	private String roleValidate(HttpServletRequest request) {
//    	UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
//		int httpStatusCode = getRoleStatusCode(userSession.getUserGroupId(), RoleKey.ADMIN_LAYER_MANAGE.name());
//		if(httpStatusCode > 200) {
//			log.info("@@ httpStatusCode = {}", httpStatusCode);
//			request.setAttribute("httpStatusCode", httpStatusCode);
//			return "/error/error";
//		}
//		
//		return null;
//    }
	
	/**
	 * 검색 조건
	 * @param search
	 * @return
	 */
	private String getSearchParameters(AccessLog accessLog) {
		return accessLog.getParameters();
	}
}
