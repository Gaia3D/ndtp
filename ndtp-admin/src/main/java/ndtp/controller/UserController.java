package ndtp.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.extern.slf4j.Slf4j;
import ndtp.domain.Key;
import ndtp.domain.PageType;
import ndtp.domain.Pagination;
import ndtp.domain.Policy;
import ndtp.domain.RoleKey;
import ndtp.domain.UserGroup;
import ndtp.domain.UserInfo;
import ndtp.domain.UserSession;
import ndtp.service.PolicyService;
import ndtp.service.UserGroupService;
import ndtp.service.UserService;
import ndtp.utils.DateUtils;
import ndtp.utils.FormatUtils;

/**
 * 사용자
 * @author kimhj
 *
 */
@Slf4j
@Controller
@RequestMapping("/user")
public class UserController implements AuthorizationController {

	@Autowired
	private UserService userService;

	@Autowired
	private UserGroupService userGroupService;

	@Autowired
	private PolicyService policyService;

	/**
	 * 사용자 목록
	 * @param request
	 * @param userInfo
	 * @param pageNo
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/list")
	public String list(HttpServletRequest request, @RequestParam(defaultValue="1") String pageNo, UserInfo userInfo, Model model) {
		String roleCheckResult = roleValidate(request);
    	if(roleValidate(request) != null) return roleCheckResult;

    	String today = DateUtils.getToday(FormatUtils.YEAR_MONTH_DAY);
		if(StringUtils.isEmpty(userInfo.getStartDate())) {
			userInfo.setStartDate(today.substring(0,4) + DateUtils.START_DAY_TIME);
		} else {
			userInfo.setStartDate(userInfo.getStartDate().substring(0, 8) + DateUtils.START_TIME);
		}
		if(StringUtils.isEmpty(userInfo.getEndDate())) {
			userInfo.setEndDate(today + DateUtils.END_TIME);
		} else {
			userInfo.setEndDate(userInfo.getEndDate().substring(0, 8) + DateUtils.END_TIME);
		}

    	long totalCount = userService.getUserTotalCount(userInfo);
    	Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(PageType.LIST, userInfo), totalCount, Long.valueOf(pageNo).longValue());
		userInfo.setOffset(pagination.getOffset());
		userInfo.setLimit(pagination.getPageRows());

		List<UserInfo> userList = new ArrayList<>();
		if(totalCount > 0l) {
			userList = userService.getListUser(userInfo);
		}

		model.addAttribute(pagination);
		model.addAttribute("userList", userList);
		return "/user/list";
	}

	/**
	 * 사용자 상세 정보
	 * @param request
	 * @param userInfo
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/detail")
	public String detail(HttpServletRequest request, UserInfo userInfo, Model model) {
		String listParameters = getSearchParameters(PageType.DETAIL, userInfo);

		userInfo =  userService.getUser(userInfo.getUserId());
		Policy policy = policyService.getPolicy();

		model.addAttribute("policy", policy);
		model.addAttribute("listParameters", listParameters);
		model.addAttribute("userInfo", userInfo);
		return "/user/detail";
	}

	/**
	 * 사용자 등록  페이지 이동
	 */
	@GetMapping(value = "/input")
	public String input(Model model) {
		Policy policy = policyService.getPolicy();
		List<UserGroup> userGroupList = userGroupService.getListUserGroup();

		model.addAttribute("policy", policy);
		model.addAttribute("userGroupList", userGroupList);
		model.addAttribute("userInfo", new UserInfo());
		return "/user/input";
	}

	/**
	 * 사용자 수정  페이지 이동
	 * @param request
	 * @param userId
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/modify")
	public String modify(HttpServletRequest request, @RequestParam String userId, Model model) {
		String roleCheckResult = roleValidate(request);
    	if(roleValidate(request) != null) return roleCheckResult;

        Policy policy = policyService.getPolicy();
        UserInfo userInfo = userService.getUser(userId);
		List<UserGroup> userGroupList = userGroupService.getListUserGroup();

        model.addAttribute("policy", policy);
        model.addAttribute("userInfo", userInfo);
        model.addAttribute("userGroupList", userGroupList);

        return "/user/modify";
	}

    /**
	 * 사용자 삭제
	 * @param userId
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/delete")
	public String delete(@RequestParam("userId") String userId, Model model) {
		// TODO validation 체크 해야 함
		userService.deleteUser(userId);

		return "redirect:/user/list";
	}

	/**
	 * 검색 조건
	 * @param search
	 * @return
	 */
	private String getSearchParameters(PageType pageType, UserInfo userInfo) {
		StringBuffer buffer = new StringBuffer(userInfo.getParameters());
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

	private String roleValidate(HttpServletRequest request) {
    	UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		int httpStatusCode = getRoleStatusCode(userSession.getUserGroupId(), RoleKey.ADMIN_USER_MANAGE.name());
		if(httpStatusCode > 200) {
			log.info("@@ httpStatusCode = {}", httpStatusCode);
			request.setAttribute("httpStatusCode", httpStatusCode);
			return "/error/error";
		}

		return null;
    }
}
