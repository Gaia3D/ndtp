package ndtp.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;
import ndtp.domain.Key;
import ndtp.domain.PageType;
import ndtp.domain.Policy;
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
@Controller
@RequestMapping("/user-data-group")
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
	@GetMapping(value = "/list")
	public String list(	HttpServletRequest request, 
						Model model) throws Exception {
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		
		UserDataGroup userDataGroup = new UserDataGroup();
		userDataGroup.setUserId(userSession.getUserId());
		List<UserDataGroup> userDataGroupList = userDataGroupService.getAllListUserDataGroup(userDataGroup);
		
		model.addAttribute("userDataGroupList", userDataGroupList);
		return "/user-data-group/list";
	}
	
	/**
	 * 사용자 데이터 그룹 등록 화면
	 * @param request
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/input")
	public String input(HttpServletRequest request, Model model) {
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
				
		Policy policy = policyService.getPolicy();
		
		UserDataGroup userDataGroup = new UserDataGroup();
		userDataGroup.setUserId(userSession.getUserId());
		List<UserDataGroup> userDataGroupList = userDataGroupService.getAllListUserDataGroup(userDataGroup);
		
		userDataGroup.setParentName(policy.getContentDataGroupRoot());
		userDataGroup.setParent(0);
		userDataGroup.setParentDepth(0);
		
		model.addAttribute("policy", policy);
		model.addAttribute("userDataGroup", userDataGroup);
		model.addAttribute("userDataGroupList", userDataGroupList);
		
		return "/user-data-group/input";
	}
	
	/**
	 * 사용자 데이터 그룹 삭제
	 * @param userDataGroupId
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/delete")
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
