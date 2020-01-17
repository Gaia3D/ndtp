package ndtp.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;
import ndtp.domain.GeoPolicy;
import ndtp.domain.Key;
import ndtp.domain.PageType;
import ndtp.domain.Pagination;
import ndtp.domain.Policy;
import ndtp.domain.UserDataGroup;
import ndtp.domain.UserSession;
import ndtp.service.GeoPolicyService;
import ndtp.service.PolicyService;
import ndtp.service.UserDataGroupService;
import ndtp.utils.DateUtils;
import ndtp.utils.FormatUtils;

/**
 * 사용자 데이터 그룹 관리
 * @author Jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/user-data-group/")
public class UserDataGroupController {
	
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
	 * 사용자 데이터 그룹 관리
	 */
	@GetMapping(value = "list")
	public String list(	HttpServletRequest request, 
						UserDataGroup userDataGroup, 
						@RequestParam(defaultValue="1") String pageNo, 
						Model model) throws Exception {
		
		log.info("@@ userDataGroup = {}", userDataGroup);
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		GeoPolicy geoPolicy = geoPolicyService.getGeoPolicy();
		
		String today = DateUtils.getToday(FormatUtils.YEAR_MONTH_DAY);
		if(StringUtils.isEmpty(userDataGroup.getStartDate())) {
			userDataGroup.setStartDate(today.substring(0,4) + DateUtils.START_DAY_TIME);
		} else {
			userDataGroup.setStartDate(userDataGroup.getStartDate().substring(0, 8) + DateUtils.START_TIME);
		}
		if(StringUtils.isEmpty(userDataGroup.getEndDate())) {
			userDataGroup.setEndDate(today + DateUtils.END_TIME);
		} else {
			userDataGroup.setEndDate(userDataGroup.getEndDate().substring(0, 8) + DateUtils.END_TIME);
		}
		
		long totalCount = userDataGroupService.getUserDataGroupTotalCount(userDataGroup);
		
		Pagination pagination = new Pagination(	request.getRequestURI(), 
												getSearchParameters(PageType.LIST, userDataGroup), 
												totalCount, 
												Long.valueOf(pageNo).longValue(),
												PAGE_ROWS,
												PAGE_LIST_COUNT);
		log.info("@@ pagination = {}", pagination);
		
		userDataGroup.setOffset(pagination.getOffset());
		userDataGroup.setLimit(pagination.getPageRows());
		List<UserDataGroup> userDataGroupList = new ArrayList<>();
		if(totalCount > 0l) {
			userDataGroupList = userDataGroupService.getListUserDataGroup(userDataGroup);
		}
		
		model.addAttribute(pagination);
		model.addAttribute("userDataGroupList", userDataGroupList);
		model.addAttribute("geoPolicyJson", objectMapper.writeValueAsString(geoPolicy));
		return "/user-data-group/list";
	}
	
	/**
	 * 사용자 데이터 그룹 정보
	 * @param userDataGroup
	 * @return
	 */
	@GetMapping(value = "detail")
	@ResponseBody
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
	 * 사용자 데이터 그룹 등록 화면
	 * @param request
	 * @param model
	 * @return
	 */
	@GetMapping(value = "input")
	public String input(HttpServletRequest request, Model model) {
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
				
		Policy policy = policyService.getPolicy();
		
		UserDataGroup userDataGroup = new UserDataGroup();
		userDataGroup.setUserId(userSession.getUserId());
		List<UserDataGroup> userDataGroupList = userDataGroupService.getListUserDataGroup(userDataGroup);
		
		userDataGroup.setParentName(policy.getContentDataGroupRoot());
		userDataGroup.setParent(0);
		
		model.addAttribute("policy", policy);
		model.addAttribute("userDataGroup", userDataGroup);
		model.addAttribute("userDataGroupList", userDataGroupList);
		
		return "/user-data-group/input";
	}
	
	/**
	 * 사용자 데이터 그룹 등록
	 * @param request
	 * @param userDataGroup
	 * @param bindingResult
	 * @return
	 */
	@PostMapping(value = "insert")
	@ResponseBody
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
	@PostMapping(value = "view-order/{userDataGroupId}")
	@ResponseBody
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
	 * 사용자 데이터 그룹 삭제
	 * @param userDataGroupId
	 * @param model
	 * @return
	 */
	@GetMapping(value = "delete")
	public String deleteData(@RequestParam("userDataGroupId") Integer userDataGroupId, Model model) {
		
		// TODO validation 체크 해야 함
		UserDataGroup userDataGroup = new UserDataGroup();
		userDataGroup.setUserDataGroupId(userDataGroupId);
		
		userDataGroupService.deleteUserDataGroup(userDataGroup);
		
		return "redirect:/user-data-group/list";
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
