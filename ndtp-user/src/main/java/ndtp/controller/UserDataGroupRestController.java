package ndtp.controller;

import java.math.BigDecimal;
import java.util.HashMap;
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

import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;
import ndtp.domain.Key;
import ndtp.domain.LocationUdateType;
import ndtp.domain.PageType;
import ndtp.domain.UserDataGroup;
import ndtp.domain.UserSession;
import ndtp.service.GeoPolicyService;
import ndtp.service.PolicyService;
import ndtp.service.UserDataGroupService;

/**
 * 사용자 데이터 그룹 관리
 * @author Jeongdae
 *
 */
@Slf4j
@RestController
@RequestMapping("/user-data-groups")
public class UserDataGroupRestController {
	
	private static final long PAGE_ROWS = 5l;
	private static final long PAGE_LIST_COUNT = 5l;
	
	@Autowired
	private UserDataGroupService userDataGroupService;
	@Autowired
	private GeoPolicyService geoPolicyService;
	@Autowired
	private ObjectMapper objectMapper;
	@Autowired
	private PolicyService policyService;
	
	/**
	 * 사용자 데이터 그룹 정보
	 * @param userDataGroup
	 * @return
	 */
	@GetMapping(value = "/duplication")
	public Map<String, Object> dataGroupKeyDuplicationCheck(	HttpServletRequest request, UserDataGroup userDataGroup ) {
		
		log.info("@@@@@ detail userDataGroup = {}", userDataGroup);
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		Boolean duplication = Boolean.TRUE;
		try {
			// TODO @Valid 로 구현해야 함
			if(StringUtils.isEmpty(userDataGroup.getDataGroupKey())) {
				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
				result.put("errorCode", "data.group.key.empty");
				result.put("message", message);
				
				return result;
			}
			
			userDataGroup.setUserId(userSession.getUserId());
			duplication = userDataGroupService.isDataGroupKeyDuplication(userDataGroup);
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
	
	/**
	 * 사용자 데이터 그룹 정보
	 * @param userDataGroup
	 * @return
	 */
	@GetMapping(value = "/detail")
	public Map<String, Object> detail(	HttpServletRequest request, UserDataGroup userDataGroup ) {
		
		log.info("@@@@@ detail userDataGroup = {}", userDataGroup);
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		try {
			// TODO @Valid 로 구현해야 함
			if(userDataGroup.getUserDataGroupId() == null) {
				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
				result.put("errorCode", "input.invalid");
				result.put("message", message);
				
				return result;
			}
			
			userDataGroup.setUserId(userSession.getUserId());
			userDataGroup = userDataGroupService.getUserDataGroup(userDataGroup);
			result.put("userDataGroup", userDataGroup);
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
	 * 사용자 데이터 그룹 등록
	 * @param request
	 * @param userDataGroup
	 * @param bindingResult
	 * @return
	 */
	@PostMapping
	public Map<String, Object> insert(HttpServletRequest request, @Valid @ModelAttribute UserDataGroup userDataGroup, BindingResult bindingResult) {
		
		log.info("@@@@@ insert userDataGroup = {}", userDataGroup);
		
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
			
			userDataGroup.setUserId(userSession.getUserId());
			if(userDataGroup.getLongitude() != null && userDataGroup.getLatitude() != null) {
				userDataGroup.setLocationUpdateType(LocationUdateType.USER.name().toLowerCase());
				userDataGroup.setLocation("POINT(" + userDataGroup.getLongitude() + " " + userDataGroup.getLatitude() + ")");
			}
			userDataGroupService.insertUserDataGroup(userDataGroup);
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
	 * @param userDataGroupId
	 * @param userDataGroup
	 * @return
	 */
	@PostMapping(value = "/view-order/{userDataGroupId}")
	public Map<String, Object> moveUserGroup(HttpServletRequest request, @PathVariable Integer userDataGroupId, @ModelAttribute UserDataGroup userDataGroup) {
		log.info("@@ userDataGroupId = {}, userDataGroup = {}", userDataGroupId, userDataGroup);
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		try {
			userDataGroup.setUserId(userSession.getUserId());
			userDataGroup.setUserDataGroupId(userDataGroupId);
			
			int updateCount = userDataGroupService.updateUserDataGroupViewOrder(userDataGroup);
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
	
	/**
	 * 검색 조건
	 * @param dataGroup
	 * @return
	 */
	private String getSearchParameters(PageType pageType, UserDataGroup userDataGroup) {
		StringBuffer buffer = new StringBuffer(userDataGroup.getParameters());
		boolean isListPage = true;
		if(pageType == PageType.MODIFY || pageType == PageType.DETAIL) {
			isListPage = false;
		}
		
//		if(!isListPage) {
//			buffer.append("pageNo=" + request.getParameter("pageNo"));
//			buffer.append("&");
//			buffer.append("list_count=" + uploadData.getList_counter());
//		}
		
		return buffer.toString();
	}
}
