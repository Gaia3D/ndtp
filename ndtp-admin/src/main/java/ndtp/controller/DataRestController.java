package ndtp.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;
import ndtp.config.PropertiesConfig;
import ndtp.domain.DataInfo;
import ndtp.domain.Key;
import ndtp.domain.PageType;
import ndtp.domain.UserSession;
import ndtp.service.DataGroupService;
import ndtp.service.DataService;
import ndtp.service.GeoPolicyService;
import ndtp.service.PolicyService;

@Slf4j
@RestController
@RequestMapping("/datas")
public class DataRestController {
	private static final long PAGE_ROWS = 5l;
	private static final long PAGE_LIST_COUNT = 5l;
	
	@Autowired
	private DataGroupService dataGroupService;
	@Autowired
	private DataService dataService;

	@Autowired
	private GeoPolicyService geoPolicyService;
	
	@Autowired
	private ObjectMapper objectMapper;
	@Autowired
	private PolicyService policyService;
	
	@Autowired
	private PropertiesConfig propertiesConfig;
	
	/**
	 * 데이터 그룹 정보
	 * @param projectId
	 * @return
	 */
	@GetMapping("/{dataId}")
	public Map<String, Object> detail(HttpServletRequest request, @PathVariable Long dataId) {
		
		log.info("@@@@@ dataId = {}", dataId);
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		try {
			if(dataId == null || dataId.longValue() <=0l) {
				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
				result.put("errorCode", "input.invalid");
				result.put("message", message);
				return result;
			}
			
			DataInfo dataInfo = new DataInfo();
			//dataInfo.setUserId(userSession.getUserId());
			dataInfo.setDataId(dataId);
			
			dataInfo = dataService.getData(dataInfo);
			
			result.put("dataInfo", dataInfo);
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
	 * 사용자 데이터 수정
	 * @param request
	 * @param dataGroup
	 * @param bindingResult
	 * @return
	 */
	@PostMapping("/{dataId}")
	public Map<String, Object> update(HttpServletRequest request, @PathVariable Integer dataId, @ModelAttribute DataInfo dataInfo) {
		
		log.info("@@@@@ update dataInfo = {}, dataId = {}", dataInfo, dataId);
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		
		try {
			// @Valid 로
			if(dataId == null) {
				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
				result.put("errorCode", "input.invalid");
				result.put("message", message);
				
				return result;
			}
			
//			dataInfo.setUserId(userSession.getUserId());
			if(dataInfo.getLongitude() != null && dataInfo.getLatitude() != null) {
				dataInfo.setLocation("POINT(" + dataInfo.getLongitude() + " " + dataInfo.getLatitude() + ")");
			}
			dataService.updateData(dataInfo);
		} catch (Exception e) {
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
