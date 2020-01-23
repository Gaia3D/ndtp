package ndtp.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.slf4j.Slf4j;
import ndtp.domain.DataGroup;
import ndtp.domain.Key;
import ndtp.domain.LocationUdateType;
import ndtp.domain.UserSession;
import ndtp.service.DataGroupService;

/**
 * 사용자 데이터 그룹 관리
 * @author Jeongdae
 *
 */
@Slf4j
@RestController
@RequestMapping("/data-groups")
public class DataGroupRestController {
	
//	private static final long PAGE_ROWS = 5l;
//	private static final long PAGE_LIST_COUNT = 5l;
	
	@Autowired
	private DataGroupService dataGroupService;
//	@Autowired
//	private GeoPolicyService geoPolicyService;
//	@Autowired
//	private ObjectMapper objectMapper;
//	@Autowired
//	private PolicyService policyService;
	
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
			List<DataGroup> dataGroupList = dataGroupService.getAllListDataGroup(new DataGroup());
			
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
	
	/**
	 * 사용자 데이터 그룹 정보
	 * @param dataGroup
	 * @return
	 */
	@GetMapping(value = "/duplication")
	public Map<String, Object> dataGroupKeyDuplicationCheck(	HttpServletRequest request, DataGroup dataGroup ) {
		
		log.info("@@@@@ detail dataGroup = {}", dataGroup);
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		Boolean duplication = Boolean.TRUE;
		try {
			// TODO @Valid 로 구현해야 함
			if(StringUtils.isEmpty(dataGroup.getDataGroupKey())) {
				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
				result.put("errorCode", "data.group.key.empty");
				result.put("message", message);
				
				return result;
			}
			
			dataGroup.setUserId(userSession.getUserId());
			duplication = dataGroupService.isDataGroupKeyDuplication(dataGroup);
			log.info("@@ duplication = {}", duplication);
		} catch(Exception e) {
			e.printStackTrace();
			statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
			errorCode = "db.exception";
			message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
		}
		
		result.put("duplication", duplication);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		
		return result;
	}
	
//	/**
//	 * 사용자 데이터 그룹 정보
//	 * @param dataGroup
//	 * @return
//	 */
//	@GetMapping(value = "/detail")
//	public Map<String, Object> detail(	HttpServletRequest request, DataGroup dataGroup ) {
//		
//		log.info("@@@@@ detail dataGroup = {}", dataGroup);
//		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
//		
//		Map<String, Object> result = new HashMap<>();
//		int statusCode = 0;
//		String errorCode = null;
//		String message = null;
//		try {
//			// TODO @Valid 로 구현해야 함
//			if(dataGroup.getDataGroupId() == null) {
//				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
//				result.put("errorCode", "input.invalid");
//				result.put("message", message);
//				
//				return result;
//			}
//			
//			dataGroup.setUserId(userSession.getUserId());
//			dataGroup = dataGroupService.getDataGroup(dataGroup);
//			result.put("dataGroup", dataGroup);
//		} catch(Exception e) {
//			e.printStackTrace();
//			statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
//			errorCode = "db.exception";
//			message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
//		}
//		
//		result.put("statusCode", statusCode);
//		result.put("errorCode", errorCode);
//		result.put("message", message);
//		
//		return result;
//	}
	
	/**
	 * 사용자 데이터 그룹 등록
	 * @param request
	 * @param dataGroup
	 * @param bindingResult
	 * @return
	 */
	@PostMapping
	public Map<String, Object> insert(HttpServletRequest request, @Valid @ModelAttribute DataGroup dataGroup, BindingResult bindingResult) {
		
		log.info("@@@@@ insert dataGroup = {}", dataGroup);
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		
		try {
			if(bindingResult.hasErrors()) {
				message = bindingResult.getAllErrors().get(0).getDefaultMessage();
				log.info("@@@@@ message = {}", message);
				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
				result.put("errorCode", errorCode);
				result.put("message", message);
	            return result;
			}
			
			dataGroup.setUserId(userSession.getUserId());
			if(dataGroup.getLongitude() != null && dataGroup.getLatitude() != null) {
				dataGroup.setLocationUpdateType(LocationUdateType.USER.name().toLowerCase());
				dataGroup.setLocation("POINT(" + dataGroup.getLongitude() + " " + dataGroup.getLatitude() + ")");
			}
			dataGroupService.insertDataGroup(dataGroup);
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
	
	/**
	 * 사용자 데이터 그룹 등록
	 * @param request
	 * @param dataGroup
	 * @param bindingResult
	 * @return
	 */
	@PostMapping("/{dataGroupId}")
	public Map<String, Object> update(HttpServletRequest request, @PathVariable Integer dataGroupId, @ModelAttribute DataGroup dataGroup) {
		
		log.info("@@@@@ update dataGroup = {}", dataGroup);
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		
		try {
			// @Valid 로 dataGroupKey를 걸어 뒀더니 수정화면에서는 수정 불가라서 hidden으로는 보내고 싶지 않고~
			if(dataGroup.getDataGroupId() == null) {
				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
				result.put("errorCode", "input.invalid");
				result.put("message", message);
				
				return result;
			}
			
			dataGroup.setUserId(userSession.getUserId());
			if(dataGroup.getLongitude() != null && dataGroup.getLatitude() != null) {
				dataGroup.setLocationUpdateType(LocationUdateType.USER.name().toLowerCase());
				dataGroup.setLocation("POINT(" + dataGroup.getLongitude() + " " + dataGroup.getLatitude() + ")");
			}
			dataGroupService.updateDataGroup(dataGroup);
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
	
	/**
	 * 사용자 데이터 그룹 순서 수정
	 * @param request
	 * @param dataGroupId
	 * @param dataGroup
	 * @return
	 */
	@PostMapping(value = "/view-order/{dataGroupId}")
	public Map<String, Object> moveUserGroup(HttpServletRequest request, @PathVariable Integer dataGroupId, @ModelAttribute DataGroup dataGroup) {
		log.info("@@ dataGroupId = {}, dataGroup = {}", dataGroupId, dataGroup);
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		try {
			dataGroup.setUserId(userSession.getUserId());
			dataGroup.setDataGroupId(dataGroupId);
			
			int updateCount = dataGroupService.updateDataGroupViewOrder(dataGroup);
			if(updateCount == 0) {
				statusCode = HttpStatus.BAD_REQUEST.value();
				errorCode = "data.group.view-order.invalid";
			}
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
