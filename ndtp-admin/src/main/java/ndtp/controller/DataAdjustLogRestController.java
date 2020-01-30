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
import ndtp.domain.DataInfoAdjustLog;
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
	 * Data Info Log 상태 수정
	 * @param request
	 * @param dataInfoAdjustLog
	 * @return
	 */
	@PostMapping(value = "/status/{dataAdjustLogId}")
	public Map<String, Object> update(HttpServletRequest request, @Valid DataInfoAdjustLog dataInfoAdjustLog, Errors errors) {
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
			
			dataAdjustLogService.updateDataAdjustLogStatus(dataInfoAdjustLog);
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