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
import ndtp.domain.DataGroup;
import ndtp.domain.GeoPolicy;
import ndtp.domain.Key;
import ndtp.domain.PageType;
import ndtp.domain.Pagination;
import ndtp.domain.Policy;
import ndtp.domain.UserSession;
import ndtp.service.DataGroupService;
import ndtp.service.GeoPolicyService;
import ndtp.service.PolicyService;
import ndtp.utils.DateUtils;
import ndtp.utils.FormatUtils;

@Slf4j
@Controller
@RequestMapping("/user-data-group/")
public class UserGroupController {
	
	private static final long PAGE_ROWS = 5l;
	private static final long PAGE_LIST_COUNT = 5l;
	
	@Autowired
	private DataGroupService dataGroupService;
	@Autowired
	private GeoPolicyService geoPolicyService;
	@Autowired
	private ObjectMapper objectMapper;
	@Autowired
	private PolicyService policyService;
	
	/**
	 * 데이터 그룹 관리
	 */
	@GetMapping(value = "list")
	public String list(	HttpServletRequest request, 
						DataGroup dataGroup, 
						@RequestParam(defaultValue="1") String pageNo, 
						Model model) throws Exception {
		
		log.info("@@ dataGroup = {}", dataGroup);
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		GeoPolicy geoPolicy = geoPolicyService.getGeoPolicy();
		
		String today = DateUtils.getToday(FormatUtils.YEAR_MONTH_DAY);
		if(StringUtils.isEmpty(dataGroup.getStartDate())) {
			dataGroup.setStartDate(today.substring(0,4) + DateUtils.START_DAY_TIME);
		} else {
			dataGroup.setStartDate(dataGroup.getStartDate().substring(0, 8) + DateUtils.START_TIME);
		}
		if(StringUtils.isEmpty(dataGroup.getEndDate())) {
			dataGroup.setEndDate(today + DateUtils.END_TIME);
		} else {
			dataGroup.setEndDate(dataGroup.getEndDate().substring(0, 8) + DateUtils.END_TIME);
		}
		
		long totalCount = dataGroupService.getDataGroupTotalCount(dataGroup);
		
		Pagination pagination = new Pagination(	request.getRequestURI(), 
												getSearchParameters(PageType.LIST, dataGroup), 
												totalCount, 
												Long.valueOf(pageNo).longValue(),
												PAGE_ROWS,
												PAGE_LIST_COUNT);
		log.info("@@ pagination = {}", pagination);
		
		dataGroup.setOffset(pagination.getOffset());
		dataGroup.setLimit(pagination.getPageRows());
		List<DataGroup> dataGroupList = new ArrayList<>();
		if(totalCount > 0l) {
			dataGroupList = dataGroupService.getListDataGroup(dataGroup);
		}
		
		model.addAttribute(pagination);
		model.addAttribute("dataGroupList", dataGroupList);
		model.addAttribute("geoPolicyJson", objectMapper.writeValueAsString(geoPolicy));
		return "/user-data-group/list";
	}
	
	/**
	 * 데이터 그룹 정보
	 * @param projectId
	 * @return
	 */
	@GetMapping(value = "detail")
	@ResponseBody
	public Map<String, Object> detailGroup(DataGroup dataGroup) {
		
		log.info("@@@@@ detail-group dataGroup = {}", dataGroup);
		
		//UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		try {
			// TODO @Valid 로 구현해야 함
			if(dataGroup.getDataGroupId() == null) {
				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
				result.put("errorCode", "input.invalid");
				result.put("message", message);
				
				return result;
			}
			
			dataGroup = dataGroupService.getDataGroup(dataGroup);
			result.put("dataGroup", dataGroup);
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
	 * 데이터 그룹 등록 화면
	 */
	@GetMapping(value = "input")
	public String input(Model model) {
		//UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
				
		Policy policy = policyService.getPolicy();
		
		List<DataGroup> dataGroupList = dataGroupService.getListDataGroup(new DataGroup());
		
		DataGroup dataGroup = new DataGroup();
		dataGroup.setParentName(policy.getContentDataGroupRoot());
		dataGroup.setParent(0);
		
		model.addAttribute("policy", policy);
		model.addAttribute("dataGroup", dataGroup);
		model.addAttribute("dataGroupList", dataGroupList);
		
		return "/user-data-group/input";
	}
	
	/**
	 * 데이터 그룹 등록
	 */
	@PostMapping(value = "insert")
	@ResponseBody
	public Map<String, Object> insert(HttpServletRequest request, @Valid @ModelAttribute DataGroup dataGroup, BindingResult bindingResult) {
		
		log.info("@@@@@ insert-group dataGroup = {}", dataGroup);
		//UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		
		try {
			UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
			
			if(bindingResult.hasErrors()) {
				message = bindingResult.getAllErrors().get(0).getDefaultMessage();
				log.info("@@@@@ message = {}", message);
				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
				result.put("errorCode", errorCode);
				result.put("message", message);
	            return result;
			}
			
			dataGroup.setUserId(userSession.getUserId());
			
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
	 * 사용자 그룹 트리 순서 수정, up, down
	 * @param model
	 * @return
	 */
	@PostMapping(value = "view-order/{dataGroupId}")
	@ResponseBody
	public Map<String, Object> moveUserGroup(HttpServletRequest request, @PathVariable Integer dataGroupId, @ModelAttribute DataGroup dataGroup) {
		log.info("@@ dataGroup = {}", dataGroup);
		//UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
				
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		try {
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
	
	/**
    * 지도에서 위치 찾기
    * @param model
    * @return
    */
    @GetMapping(value = "location-map")
    public String locationMap(HttpServletRequest request, Model model) {

        log.info("@@ locationMap");
        //UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		
        Policy policy = policyService.getPolicy();
        String policyJson = "";

        try {
            policyJson = objectMapper.writeValueAsString(policy);
        } catch (Exception e) {
            e.printStackTrace();
        }

        model.addAttribute("policy", policy);
        model.addAttribute("policyJson", policyJson);

        return "/user-data-group/location-map";
    }
    
    /**
	 * 데이터 그룹 삭제
	 * @param dataGroupId
	 * @param model
	 * @return
	 */
	@GetMapping(value = "delete")
	public String deleteData(@RequestParam("dataGroupId") Integer dataGroupId, Model model) {
		
		// TODO validation 체크 해야 함
		DataGroup dataGroup = new DataGroup();
		dataGroup.setDataGroupId(dataGroupId);
		
		dataGroupService.deleteDataGroup(dataGroup);
		
		return "redirect:/user-data-group/list";
	}
	
	/**
	 * 검색 조건
	 * @param dataGroup
	 * @return
	 */
	private String getSearchParameters(PageType pageType, DataGroup dataGroup) {
		StringBuffer buffer = new StringBuffer(dataGroup.getParameters());
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
