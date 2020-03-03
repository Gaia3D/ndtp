package ndtp.api;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.slf4j.Slf4j;
import ndtp.domain.ConverterJob;
import ndtp.service.ConverterService;

/**
 * Data Converter
 * @author jeongdae
 *
 */
@Slf4j
@RestController
@RequestMapping("/api/converters")
public class ConverterAPIController {
	
	@Autowired
	private ConverterService converterService;
	
	/**
	 * 데이터 변환 작업 상태를 갱신
	 * @param model
	 * @return
	 */
	@PostMapping(value = "/status")
	public Map<String, Object> status(HttpServletRequest request, @RequestBody ConverterJob converterJob) {
		log.info("@@@ converterJob = {}", converterJob);
		
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		try {
			if(converterJob.getConverterJobId() == null) {
				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
				result.put("errorCode", "converter.job.id.empty");
				result.put("message", message);
	            return result;
			}
			if(StringUtils.isEmpty(converterJob.getUserId())) {
				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
				result.put("errorCode", "converter.userId.empty");
				result.put("message", message);
	            return result;
			}
			
			converterService.updateConverterJob(converterJob);
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