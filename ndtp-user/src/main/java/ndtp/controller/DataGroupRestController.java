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
import ndtp.domain.DataGroup;
import ndtp.domain.Key;
import ndtp.domain.UserSession;
import ndtp.service.DataGroupService;
import ndtp.service.PolicyService;

@Slf4j
@RestController
@RequestMapping("/data-groups")
public class DataGroupRestController {
	
	@Autowired
	private DataGroupService dataGroupService;

	@Autowired
	private ObjectMapper objectMapper;
	
	@Autowired
	private PolicyService policyService;
	
	/**
	 * 데이터 그룹 정보
	 * @param projectId
	 * @return
	 */
	@GetMapping
	public Map<String, Object> list(HttpServletRequest request, DataGroup dataGroup) {
		
		log.info("@@@@@ list dataGroup = {}", dataGroup);
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		try {
			List<DataGroup> dataGroupList = dataGroupService.getListDataGroup(new DataGroup());
			
			//dataGroup.set
			//List<DataGroup> dataGroupList = dataGroupService.getListDataGroup();
			
			result.put("dataGroupList", dataGroupList);
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
