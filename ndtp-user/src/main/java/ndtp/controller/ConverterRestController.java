package ndtp.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.slf4j.Slf4j;
import ndtp.domain.ConverterJob;
import ndtp.domain.Key;
import ndtp.domain.UserSession;
import ndtp.service.ConverterService;

/**
 * Data Converter
 * @author jeongdae
 *
 */
@Slf4j
@RestController
@RequestMapping("/converters")
public class ConverterRestController {
	
	@Autowired
	private ConverterService converterService;
	
	/**
	 * TODO 우선은 여기서 적당히 구현해 두고... 나중에 좀 깊이 생각해 보자. converter에 어디까지 넘겨야 할지
	 * converter job insert
	 * @param model
	 * @return
	 */
	@PostMapping
	public Map<String, Object> insert(HttpServletRequest request, ConverterJob converterJob) {
		log.info("@@@ converterJob = {}", converterJob);
		
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		try {
			if(converterJob.getConverterCheckIds().length() <= 0) {
				log.info("@@@@@ message = {}", message);
				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
				result.put("errorCode", "check.value.required");
				result.put("message", message);
	            return result;
			}
			if(StringUtils.isEmpty(converterJob.getTitle())) {
				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
				result.put("errorCode", "converter.title.empty");
				result.put("message", message);
	            return result;
			}
			if(converterJob.getUsf() == null) {
				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
				result.put("errorCode", "converter.usf.empty");
				result.put("message", message);
	            return result;
			}
			
			UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
			converterJob.setUserId(userSession.getUserId());
			
			converterService.insertConverter(converterJob);
		} catch(DataAccessException e) {
			statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
			errorCode = "db.exception";
			message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
			log.info("@@ db.exception. message = {}", message);
		} catch(RuntimeException e) {
			statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
			errorCode = "runtime.exception";
			message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
			log.info("@@ runtime.exception. message = {}", message);
		} catch(Exception e) {
			statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
			errorCode = "unknown.exception";
			message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
			log.info("@@ exception. message = {}", message);
		}
		
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		
		return result;
	}
}