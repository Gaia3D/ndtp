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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.slf4j.Slf4j;
import ndtp.domain.ApprovalStatus;
import ndtp.domain.DataInfoLog;
import ndtp.service.DataGroupService;
import ndtp.service.DataLogService;

/**
 * Data
 * @author jeongdae
 *
 */
@Slf4j
@RestController
@RequestMapping("/data-logs")
public class DataLogRestController {
	
	@Autowired
	private DataGroupService dataGroupService;
	@Autowired
	private DataLogService dataLogService;
	
	/**
	 * Data Info Log 상태 수정
	 * @param request
	 * @param dataInfo
	 * @return
	 */
	@PostMapping(value = "update-data-log-status")
	public Map<String, Object> updateDataInfoLogStatus(HttpServletRequest request, @Valid DataInfoLog dataInfoLog, Errors errors) {
		log.info("@@ dataInfoLog = {}", dataInfoLog);
		
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		try {
			dataInfoLog.setMethodMode("update");
			if(errors.hasErrors()) {
				message = errors.getAllErrors().get(0).getDefaultMessage();
				statusCode = HttpStatus.BAD_REQUEST.value();
				
				result.put("statusCode", statusCode);
				result.put("errorCode", "validation.error");
				result.put("message", message);
				
				return result;
            }
			
			if(ApprovalStatus.APPROVAL == ApprovalStatus.valueOf(dataInfoLog.getStatusLevel().toUpperCase())) {
				dataInfoLog.setStatus(ApprovalStatus.APPROVAL.name().toLowerCase());
			} else if(ApprovalStatus.REJECT == ApprovalStatus.valueOf(dataInfoLog.getStatusLevel().toUpperCase())) {
				dataInfoLog.setStatus(ApprovalStatus.REJECT.name().toLowerCase());
			} else if(ApprovalStatus.ROLLBACK == ApprovalStatus.valueOf(dataInfoLog.getStatusLevel().toUpperCase())) {
				dataInfoLog.setStatus(ApprovalStatus.ROLLBACK.name().toLowerCase());
			}
			
			dataLogService.updateDataInfoLogStatus(dataInfoLog);
			
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