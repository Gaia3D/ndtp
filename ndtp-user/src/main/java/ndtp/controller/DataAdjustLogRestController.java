package ndtp.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.slf4j.Slf4j;
import ndtp.domain.DataAdjustLog;
import ndtp.service.DataAdjustLogService;

/**
 * 데이터 geometry 변경 이력
 * @author jeongdae
 *
 */
@Slf4j
@RestController
@RequestMapping("/data-adjust-logs")
public class DataAdjustLogRestController {
	
	@Autowired
	private DataAdjustLogService dataAdjustLogService;
	
	/**
	 * 데이터 geometry 변경 이력 상태 수정
	 * @param request
	 * @param dataInfo
	 * @return
	 */
	@PostMapping
	public Map<String, Object> insert(HttpServletRequest request, @Valid DataAdjustLog dataInfoAdjustLog, Errors errors) {
		log.info("@@ dataInfoAdjustLog = {}", dataInfoAdjustLog);
		
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
			
			dataAdjustLogService.insertDataAdjustLog(dataInfoAdjustLog);
			
			// TODO cache 갱신 되어야 함
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