package ndtp.controller;

import java.util.HashMap;
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
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.slf4j.Slf4j;
import ndtp.domain.Issue;
import ndtp.domain.Key;
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
			
			issue.setUserId(userSession.getUserId());
			issue.setClientIp(WebUtils.getClientIp(request));
			issueService.insertIssue(issue);
			
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
}