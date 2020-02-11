package ndtp.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.slf4j.Slf4j;
import ndtp.domain.Issue;
import ndtp.service.IssueService;

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
			if(errors.hasErrors()) {
				message = errors.getAllErrors().get(0).getDefaultMessage();
				statusCode = HttpStatus.BAD_REQUEST.value();
				
				result.put("statusCode", statusCode);
				result.put("errorCode", "validation.error");
				result.put("message", message);
				
				return result;
            }
			
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