package ndtp.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.slf4j.Slf4j;
import ndtp.domain.Issue;
import ndtp.domain.Key;
import ndtp.domain.PageType;
import ndtp.domain.Pagination;
import ndtp.domain.UserSession;
import ndtp.service.IssueService;
import ndtp.utils.WebUtils;

/**
 * 이슈
 * @author jeongdae
 *
 */
@Slf4j
@RestController
@RequestMapping("/issues")
public class IssueRestController {
	private static final long PAGE_ROWS = 5l;
	private static final long PAGE_LIST_COUNT = 5l;
	@Autowired
	private IssueService issueService;
	
	/**
	 * 이슈 정보
	 * @param request
	 * @param dataInfo
	 * @return
	 */
	@GetMapping(value = "/{issueId}")
	public Map<String, Object> detail(HttpServletRequest request, @PathVariable Long issueId) {
		log.info("@@ issueId = {}", issueId);
		
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		try {
			UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
			
			if(issueId == null) {
				statusCode = HttpStatus.BAD_REQUEST.value();
				result.put("statusCode", statusCode);
				result.put("errorCode", "input.invalid");
				result.put("message", message);
				return result;
            }
			
			Issue issue = issueService.getIssue(issueId);
			
			result.put("issue", issue);
		} catch(Exception e) {
			e.printStackTrace();
			statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
			errorCode = "db.exception";
			message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
		}
		
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		
		return result;
	}
	
	/**
	 * 이슈 등록
	 * @param request
	 * @param dataInfo
	 * @return
	 */
	@PostMapping
	public Map<String, Object> insert(HttpServletRequest request, @Valid Issue issue, Errors errors) {
		log.info("@@ issue = {}", issue);
		
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		try {
			UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
			
			if(errors.hasErrors()) {
				message = errors.getAllErrors().get(0).getDefaultMessage();
				statusCode = HttpStatus.BAD_REQUEST.value();
				
				result.put("statusCode", statusCode);
				result.put("errorCode", "validation.error");
				result.put("message", message);
				
				return result;
            }
			
			issue.setLocation("POINT(" + issue.getLongitude() + " " + issue.getLatitude() + ")");
			issue.setUserId(userSession.getUserId());
			issue.setClientIp(WebUtils.getClientIp(request));
			issue = issueService.insertIssue(issue);
			
			result.put("issueId", issue.getIssueId());
			// TODO cache 갱신 되어야 함
		} catch(Exception e) {
			e.printStackTrace();
			statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
			errorCode = "db.exception";
			message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
		}
		
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		
		return result;
	}
	
	/**
	 * 이슈 목록 조회
	 * @param request
	 * @param Issue
	 * @param pageNo
	 * @return
	 */
	@GetMapping
	public Map<String, Object> list(HttpServletRequest request, Issue issue, @RequestParam(defaultValue="1") String pageNo) {
		
		log.info("@@@@@@@@ issue = {}", issue);
		
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
	//	civilVoice.setUserId(userSession.getUserId());
	//	civilVoice.setClientIp(WebUtils.getClientIp(request));
		try {
			long totalCount = issueService.getIssueTotalCount(issue);
			Pagination pagination = new Pagination(	request.getRequestURI(),
													getSearchParameters(PageType.LIST, issue),
													totalCount,
													Long.valueOf(pageNo).longValue(),
													PAGE_ROWS,
													PAGE_LIST_COUNT);
			log.info("@@ pagination = {}", pagination);

			issue.setOffset(pagination.getOffset());
			issue.setLimit(pagination.getPageRows());
			List<Issue> issueList = new ArrayList<>();
			if(totalCount > 0l) {
				issueList = issueService.getListIssue(issue);
			}

			result.put("totalCount", totalCount);
			result.put("pagination", pagination);
			result.put("issueList", issueList);
		} catch(Exception e) {
			e.printStackTrace();
			statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
			errorCode = "db.exception";
			message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
		}

		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);

		return result;
	}
	
	/**
	 * 검색 조건
	 * @param search
	 * @return
	 */
	private String getSearchParameters(PageType pageType, Issue issue) {
		StringBuffer buffer = new StringBuffer(issue.getParameters());
//		buffer.append("&");
//		try {
//			buffer.append("dataName=" + URLEncoder.encode(getDefaultValue(dataInfo.getDataName()), "UTF-8"));
//		} catch(Exception e) {
//			e.printStackTrace();
//			buffer.append("dataName=");
//		}
		
		buffer.append("&");
		buffer.append("location=");
		buffer.append(issue.getLocation());
		return buffer.toString();
	}
}