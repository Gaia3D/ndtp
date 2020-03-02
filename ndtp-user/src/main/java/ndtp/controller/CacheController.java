package ndtp.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.JsonProcessingException;

import lombok.extern.slf4j.Slf4j;
import ndtp.config.CacheConfig;
import ndtp.config.PropertiesConfig;
import ndtp.domain.CacheName;
import ndtp.domain.CacheParams;

/**
 * 사용자 Cache 갱신
 * 분류 상으로는 api 에 가야 하지만 보안상 여기에 둠
 * @author jeongdae
 *
 */
@Slf4j
@RestController
@RequestMapping("/cache")
public class CacheController {

	@Autowired
	private CacheConfig cacheConfig;
	@Autowired
	private PropertiesConfig propertiesConfig;
	
	/**
	 * HttpClient 로 Cache 요청이 왔을때 실행되는 메서드
	 * @param request
	 * @param policy
	 * @return
	 * @throws JsonProcessingException 
	 */
	@PostMapping(value = "/reload")
	public Map<String, Object> reload(HttpServletRequest request, @RequestBody String authData) throws JsonProcessingException {
		
		log.info("@@@@@@@@@@@@@@@ user cache reload @@@@@@@@@@@@@@@@");

		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		
		HttpHeaders responseHeaders = new HttpHeaders(); 
		responseHeaders.add("Content-Type", "application/json;charset=UTF-8");
		try {
			log.info("@@@@@@@@@ auth_data = {}", authData);
			String[] keyValues = authData.split("&");
			
			CacheParams cacheParams = new CacheParams();
			// TODO validation
			for(String tempValue : keyValues) {
				String[] values = tempValue.split("=");
				cacheParams.setCacheName(CacheName.valueOf(values[1]));
			}
			
			cacheConfig.loadCache(cacheParams);
			
			statusCode = HttpStatus.OK.value();
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
