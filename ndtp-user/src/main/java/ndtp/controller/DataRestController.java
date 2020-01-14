package ndtp.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;
import ndtp.config.PropertiesConfig;
import ndtp.domain.DataGroup;
import ndtp.domain.DataInfo;
import ndtp.domain.Key;
import ndtp.domain.UserSession;
import ndtp.service.DataGroupService;
import ndtp.service.DataService;
import ndtp.service.GeoPolicyService;
import ndtp.service.PolicyService;

@Slf4j
@RestController
@RequestMapping("/datas")
public class DataRestController {
	
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
	@GetMapping
	public Map<String, Object> list(HttpServletRequest request, DataInfo dataInfo) {
		
		log.info("@@@@@ list dataInfo = {}", dataInfo);
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		try {
			// TODO @Valid 로 구현해야 함
			if(dataInfo.getDataGroupId() == null) {
				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
				result.put("errorCode", "input.invalid");
				result.put("message", message);
				return result;
			}
			
			//dataInfo.setUserId(userSession.getUserId());
			List<DataInfo> dataInfoList = dataService.getAllListData(dataInfo);
			result.put("dataInfoList", dataInfoList);
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
