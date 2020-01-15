package ndtp.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import ndtp.domain.Key;
import ndtp.domain.Policy;
import ndtp.domain.RoleKey;
import ndtp.domain.UserGroup;
import ndtp.domain.UserSession;
import ndtp.service.PolicyService;
import ndtp.service.UserGroupService;

@Slf4j
@Controller
@RequestMapping("/user")
public class UserGroupController implements AuthorizationController {

	@Autowired
	private UserGroupService userGroupService;

	@Autowired
	private PolicyService policyService;

	/**
	 * 사용자 그룹 목록
	 * @param request
	 * @param userGroup
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/list-group")
	public String list(HttpServletRequest request, @ModelAttribute UserGroup userGroup, Model model) {
		String roleCheckResult = roleValidate(request);
    	if(roleValidate(request) != null) return roleCheckResult;

		List<UserGroup> userGroupList = userGroupService.getListUserGroup(new UserGroup());
		model.addAttribute("userGroupList", userGroupList);
		return "/user/list-group";
	}

	/**
	 * 사용자 그룹 트리 순서 수정 (up/down)
	 * @param request
	 * @param userGroupId
	 * @param userGroup
	 * @return
	 */
	@PostMapping(value = "group/view-order/{userGroupId}")
	@ResponseBody
	public Map<String, Object> moveUserGroup(HttpServletRequest request, @PathVariable Integer userGroupId, @ModelAttribute UserGroup userGroup) {
		log.info("@@ userGroup = {}", userGroup);

		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		try {
			userGroup.setUserGroupId(userGroupId);

			int updateCount = userGroupService.updateUserGroupViewOrder(userGroup);
			if(updateCount == 0) {
				statusCode = HttpStatus.BAD_REQUEST.value();
				errorCode = "user.group.view-order.invalid";
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
	 * 사용자 그룹 등록 페이지 이동
	 * @param model
	 * @return
	 */
	@GetMapping(value = "input-group")
	public String input(Model model) {
		Policy policy = policyService.getPolicy();

		List<UserGroup> userGroupList = userGroupService.getListUserGroup();

		UserGroup userGroup = new UserGroup();
		userGroup.setParentName(policy.getContentUserGroupRoot());
		userGroup.setParent(0);

		model.addAttribute("policy", policy);
		model.addAttribute("userGroup", userGroup);
		model.addAttribute("userGroupList", userGroupList);

		return "/user/input-group";
	}

	/**
	 * 사용자 그룹 등록
	 * @param request
	 * @param userGroup
	 * @param bindingResult
	 * @return
	 */
	@PostMapping(value = "insert-group")
	@ResponseBody
	public Map<String, Object> insert(HttpServletRequest request, @Valid @ModelAttribute UserGroup userGroup, BindingResult bindingResult) {

		log.info("@@@@@ insert userGroup = {}", userGroup);

		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;

		try {
			//UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());

			if(bindingResult.hasErrors()) {
				message = bindingResult.getAllErrors().get(0).getDefaultMessage();
				log.info("@@@@@ message = {}", message);
				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
				result.put("errorCode", errorCode);
				result.put("message", message);
	            return result;
			}

			//userGroup.setUserId(userSession.getUserId());

			userGroupService.insertUserGroup(userGroup);
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
	 * 사용자 그룹 수정 페이지 이동
	 * @param request
	 * @param userGroupId
	 * @param model
	 * @return
	 */
	@GetMapping(value = "modify-group")
	public String modify(HttpServletRequest request, @RequestParam Integer userGroupId, Model model) {
		UserGroup userGroup = userGroupService.getUserGroup(userGroupId);
		Policy policy = policyService.getPolicy();

		model.addAttribute("policy", policy);
		model.addAttribute("userGroup", userGroup);

		return "/user/modify-group";
	}

	/**
	 * 사용자 그룹 수정
	 * @param request
	 * @param userGroup
	 * @param bindingResult
	 * @return
	 */
	@PostMapping(value = "update-group")
	@ResponseBody
	public Map<String, Object> update(HttpServletRequest request, @Valid UserGroup userGroup, BindingResult bindingResult) {
		log.info("@@ userGroup = {}", userGroup);
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

			userGroupService.updateUserGroup(userGroup);
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
	 * 사용자 그룹 삭제
	 * @param request
	 * @param userGroupId
	 * @return
	 */
	@DeleteMapping(value = "delete-group/{userGroupId}")
	@ResponseBody
	public Map<String, Object> delete(HttpServletRequest request, @PathVariable Integer userGroupId) {
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;

		try {
			userGroupService.deleteUserGroup(userGroupId);
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
