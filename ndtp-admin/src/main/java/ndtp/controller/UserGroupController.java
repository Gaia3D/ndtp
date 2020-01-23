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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;
import ndtp.config.CacheConfig;
import ndtp.domain.CacheName;
import ndtp.domain.CacheParams;
import ndtp.domain.CacheType;
import ndtp.domain.Menu;
import ndtp.domain.MenuTarget;
import ndtp.domain.MenuType;
import ndtp.domain.Policy;
import ndtp.domain.Role;
import ndtp.domain.UserGroup;
import ndtp.domain.UserGroupMenu;
import ndtp.domain.UserGroupRole;
import ndtp.service.MenuService;
import ndtp.service.PolicyService;
import ndtp.service.RoleService;
import ndtp.service.UserGroupService;

@Slf4j
@Controller
@RequestMapping("/user-group")
public class UserGroupController implements AuthorizationController {

	@Autowired
	private UserGroupService userGroupService;

	@Autowired
	private MenuService menuService;

	@Autowired
	private RoleService roleService;

	@Autowired
	private PolicyService policyService;

	@Autowired
	private ObjectMapper objectMapper;

	@Autowired
	private CacheConfig cacheConfig;

	/**
	 * 사용자 그룹 목록
	 * @param request
	 * @param userGroup
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/list")
	public String list(HttpServletRequest request, @ModelAttribute UserGroup userGroup, Model model) {
		List<UserGroup> userGroupList = userGroupService.getListUserGroup();

		model.addAttribute("userGroupList", userGroupList);

		return "/user/list-group";
	}

	/**
	 * 사용자 그룹 정보
	 * @param userGroup
	 * @return
	 */
	@GetMapping(value = "detail")
	@ResponseBody
	public Map<String, Object> detail(UserGroup userGroup) {

		log.info("@@@@@ detail-group userGroup = {}", userGroup);

		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		try {
			if(userGroup.getUserGroupId() == null) {
				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
				result.put("errorCode", "input.invalid");
				result.put("message", message);

				return result;
			}

			userGroup = userGroupService.getUserGroup(userGroup);
			result.put("userGroup", userGroup);
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
	@GetMapping(value = "input")
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
	@PostMapping(value = "insert")
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
	 * 그룹Key 중복 체크
	 * @param model
	 * @return
	 */
	@PostMapping(value = "duplication-check")
	@ResponseBody
	public Map<String, Object> ajaxKeyDuplicationCheck(HttpServletRequest request, UserGroup userGroup) {
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		String duplicationValue = "";
		try {
			if(userGroup.getUserGroupKey() == null || "".equals(userGroup.getUserGroupKey())) {
				result = "group.key.empty";
				map.put("result", result);
				return map;
			}

			int count = userGroupService.getDuplicationKeyCount(userGroup.getUserGroupKey());
			log.info("@@ duplicationValue = {}", count);
			duplicationValue = String.valueOf(count);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}

		map.put("result", result);
		map.put("duplicationValue", duplicationValue);

		return map;
	}

	/**
	 * 사용자 그룹 수정 페이지 이동
	 * @param request
	 * @param userGroupId
	 * @param model
	 * @return
	 */
	@GetMapping(value = "modify")
	public String modify(HttpServletRequest request, @RequestParam Integer userGroupId, Model model) {
		UserGroup userGroup = new UserGroup();
		userGroup.setUserGroupId(userGroupId);
		userGroup = userGroupService.getUserGroup(userGroup);
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
	@PostMapping(value = "update")
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
	 * 사용자 그룹 트리 순서 수정 (up/down)
	 * @param request
	 * @param userGroupId
	 * @param userGroup
	 * @return
	 */
	@PostMapping(value = "view-order/{userGroupId}")
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
	 * 사용자 그룹 삭제
	 * @param userGroupId
	 * @param model
	 * @return
	 */
	@GetMapping(value = "delete")
	public String delete(@RequestParam("userGroupId") Integer userGroupId, Model model) {

		// TODO validation 체크 해야 함
		UserGroup userGroup = new UserGroup();
		userGroup.setUserGroupId(userGroupId);

		userGroupService.deleteUserGroup(userGroup);

		return "redirect:/user-group/list";
	}

	/**
	 * 사용자 그룹 메뉴 할당 페이지 이동
	 * @param request
	 * @param userGroupId
	 * @param model
	 * @return
	 */
	@GetMapping(value = "menu")
	public String menu(HttpServletRequest request, @RequestParam Integer userGroupId, Model model) {
		Menu menu = new Menu();
		menu.setMenuTarget(MenuTarget.ADMIN.getValue());
		menu.setMenuType(MenuType.URL.getValue());
		List<Menu> menuList = menuService.getListMenu(menu);
		menu.setMenuTarget(MenuTarget.USER.getValue());
		menu.setMenuType(MenuType.HTMLID.getValue());
		menuList.addAll(menuService.getListMenu(menu));

		UserGroup userGroup = new UserGroup();
		userGroup.setUserGroupId(userGroupId);
		userGroup = userGroupService.getUserGroup(userGroup);

		String userGroupMenuJson = "";

		try {
			UserGroupMenu userGroupMenu = new UserGroupMenu();
			userGroupMenu.setUserGroupId(userGroupId);
			List<UserGroupMenu> userGroupMenuList = userGroupService.getListUserGroupMenu(userGroupMenu);
			userGroupMenuJson = objectMapper.writeValueAsString(userGroupMenuList);
		} catch (Exception e) {
			e.printStackTrace();
		}

		model.addAttribute("userGroup", userGroup);
		model.addAttribute("menuList", menuList);
		model.addAttribute("userGroupMenuJson", userGroupMenuJson);

		return "/user/group-menu";
	}

	/**
	 * 사용자 그룹 메뉴 수정
	 * @param request
	 * @param userGroupId
	 * @param userGroupMenu
	 * @return
	 */
	@PostMapping(value = "menu")
	@ResponseBody
	public Map<String, Object> updateMenu(HttpServletRequest request, @ModelAttribute UserGroupMenu userGroupMenu) {
		log.info("@@ userGroupMenu = {}", userGroupMenu);

		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;

		try {
			userGroupService.updateUserGroupMenu(userGroupMenu);

	        CacheParams cacheParams = new CacheParams();
			cacheParams.setCacheType(CacheType.SELF);
			cacheParams.setCacheName(CacheName.USER_GROUP);
			cacheConfig.loadCache(cacheParams);

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
	 * 사용자 그룹 Role 할당 페이지 이동
	 * @param request
	 * @param userGroupId
	 * @param model
	 * @return
	 */
	@GetMapping(value = "role")
	public String role(HttpServletRequest request, @RequestParam Integer userGroupId, Model model) {
		Role role = new Role();
		role.setOffset(0l);
		role.setLimit(1000l);
		role.setOrderWord("role_id");
		role.setOrderValue("ASC");
		List<Role> roleList = roleService.getListRole(role);

		UserGroup userGroup = new UserGroup();
		userGroup.setUserGroupId(userGroupId);
		userGroup = userGroupService.getUserGroup(userGroup);

		String userGroupRoleJson = "";

		try {
			UserGroupRole userGroupRole = new UserGroupRole();
			userGroupRole.setUserGroupId(userGroupId);
			List<UserGroupRole> userGroupRoleList = userGroupService.getListUserGroupRole(userGroupRole);
			userGroupRoleJson = objectMapper.writeValueAsString(userGroupRoleList);
		} catch (Exception e) {
			e.printStackTrace();
		}

		model.addAttribute("userGroup", userGroup);
		model.addAttribute("roleList", roleList);
		model.addAttribute("userGroupRoleJson", userGroupRoleJson);

		return "/user/group-role";
	}

	/**
	 * 사용자 그룹 Role 수정
	 * @param request
	 * @param userGroupId
	 * @param userGroupRole
	 * @return
	 */
	@PostMapping(value = "role")
	@ResponseBody
	public Map<String, Object> updateMenu(HttpServletRequest request, @ModelAttribute UserGroupRole userGroupRole) {
		log.info("@@ userGroupRole = {}", userGroupRole);

		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;

		try {
			userGroupService.updateUserGroupRole(userGroupRole);

	        CacheParams cacheParams = new CacheParams();
			cacheParams.setCacheType(CacheType.SELF);
			cacheParams.setCacheName(CacheName.USER_GROUP);
			cacheConfig.loadCache(cacheParams);

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
