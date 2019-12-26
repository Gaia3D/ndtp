package ndtp.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.databind.ObjectMapper;

import ndtp.service.MenuService;
import lombok.extern.slf4j.Slf4j;
import ndtp.config.CacheConfig;
import ndtp.domain.Key;
import ndtp.domain.RoleKey;
import ndtp.domain.UserGroup;
import ndtp.domain.UserSession;
import ndtp.service.PolicyService;
import ndtp.service.RoleService;
import ndtp.service.UserGroupService;

@Slf4j
@Controller
@RequestMapping("/user")
public class UserGroupController implements AuthorizationController {
	
	@Autowired
	private CacheConfig cacheConfig;
	
	@Autowired
	private MenuService menuService;
	
	@Autowired
	private ObjectMapper objectMapper;
	
	@Autowired
	private PolicyService policyService;
	
	@Autowired
	private RoleService roleService;
	
	@Autowired
	private UserGroupService userGroupService;
	
	/**
	 * 그룹 목록
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/list-group")
	public String list(HttpServletRequest request, Model model) {
		String roleCheckResult = roleValidate(request);
    	if(roleValidate(request) != null) return roleCheckResult;
		
		List<UserGroup> userGroupList = userGroupService.getListUserGroup(new UserGroup());
		model.addAttribute("userGroupList", userGroupList);
		return "/user/list-group";
	}

//	@GetMapping(value = "/groups")
//	public String tree(HttpServletRequest request, Model model) {
//		Policy policy = policyService.getPolicy();
//		
//		model.addAttribute("policy", policy);
//		
//		return "/user/group-tree";
//	}
//	
//	/**
//	 * 사용자 그룹 트리
//	 * @param model
//	 * @return
//	 */
//	@GetMapping(value = "/groups/tree", produces = "application/json;charset=UTF-8")
//	public ResponseEntity<?> tree(HttpServletRequest request) {
//		String userGroupTree = null;
//		List<UserGroup> userGroupList = new ArrayList<>();
//		try {
//			userGroupList.addAll(userGroupService.getListUserGroup(new UserGroup()));
//			userGroupTree = getUserGroupTree(userGroupList);
//			log.info("@@ userGroupTree = {} ", userGroupTree);
//			
//			return new ResponseEntity<>(userGroupTree, HttpStatus.OK);
//		} catch(Exception e) {
//			e.printStackTrace();
//			
//			Map<String, Object> result = new HashMap<>();
//			result.put("statusCode", HttpStatus.INTERNAL_SERVER_ERROR.value());
//			result.put("error", new APIError(e.getCause() != null ? e.getCause().getMessage() : e.getMessage()));
//			return new ResponseEntity<>(result, HttpStatus.INTERNAL_SERVER_ERROR);
//		} 
//	}
//	
//	/**
//	 * 사용자 그룹 트리 추가
//	 * @param model
//	 * @return
//	 */
//	@PostMapping(value = "/groups/tree", produces = "application/json;charset=UTF-8")
//	public ResponseEntity<?> insertUserGroup(HttpServletRequest request, UserGroup userGroup) {
//		
//		log.info("@@ userGroup = {} ", userGroup);
//		
//		String userGroupTree = null;
//		List<UserGroup> userGroupList = new ArrayList<>();
//		try {
//			if(userGroup.getGroupName() == null || "".equals(userGroup.getGroupName())
//					|| userGroup.getGroupKey() == null || "".equals(userGroup.getGroupKey())) {
//				
//				userGroupList.addAll(userGroupService.getListUserGroup(new UserGroup()));
//				userGroupTree = getUserGroupTree(userGroupList);
//				
//				Map<String, Object> result = new HashMap<>();
//				result.put("userGroupTree", userGroupTree);
//				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
//				result.put("error", new APIError("입력값이 유효하지 않습니다.", "input.invalid"));
//				return new ResponseEntity<>(result, HttpStatus.BAD_REQUEST);
//			}
//			
//			UserGroup childUserGroup = userGroupService.getMaxViewOrderChildUserGroup(userGroup.getParent());
//			if(childUserGroup == null) {
//				userGroup.setViewOrder(1);
//			} else {
//				userGroup.setViewOrder(childUserGroup.getViewOrder() + 1);
//			}
//			if(userGroup.getDepth() == 1) {
//				userGroup.setAncestor(userGroup.getGroupKey());
//			}
//			
//			userGroupService.insertUserGroup(userGroup);
//			cacheRefreshManager.refresh(CacheType.SELF, CacheName.USER_GROUP);
//			
//			userGroupList.addAll(userGroupService.getListUserGroup(new UserGroup()));
//			userGroupTree = getUserGroupTree(userGroupList);
//			log.info("@@ userGroupTree = {} ", userGroupTree);
//			
//			return new ResponseEntity<>(userGroupTree, HttpStatus.OK);
//		} catch(Exception e) {
//			e.printStackTrace();
//			Map<String, Object> result = new HashMap<>();
//			result.put("statusCode", HttpStatus.INTERNAL_SERVER_ERROR.value());
//			result.put("error", new APIError(e.getCause() != null ? e.getCause().getMessage() : e.getMessage()));
//			return new ResponseEntity<>(result, HttpStatus.INTERNAL_SERVER_ERROR);
//		} 
//	}
//	
//	/**
//	 * 사용자 그룹 트리 수정
//	 * @param model
//	 * @return
//	 */
//	@PostMapping(value = "/groups/tree/{userGroupId}", produces = "application/json;charset=UTF-8")
//	public ResponseEntity<?> updateUserGroup(HttpServletRequest request, @PathVariable Integer userGroupId, @ModelAttribute UserGroup userGroup) {
//		
//		log.info("@@ userGroup = {}", userGroup);
//		
//		String userGroupTree = null;
//		List<UserGroup> userGroupList = new ArrayList<>();
//		try {
//			userGroupService.updateUserGroup(userGroup);
//			cacheRefreshManager.refresh(CacheType.SELF, CacheName.USER_GROUP);
//			
//			userGroupList.addAll(userGroupService.getListUserGroup(new UserGroup()));
//			userGroupTree = getUserGroupTree(userGroupList);
//			log.info("@@ userGroupTree = {} ", userGroupTree);
//			
//			return new ResponseEntity<>(userGroupTree, HttpStatus.OK);
//		} catch(Exception e) {
//			e.printStackTrace();
//			
//			Map<String, Object> result = new HashMap<>();
//			result.put("statusCode", HttpStatus.INTERNAL_SERVER_ERROR.value());
//			result.put("error", new APIError(e.getCause() != null ? e.getCause().getMessage() : e.getMessage()));
//			return new ResponseEntity<>(result, HttpStatus.INTERNAL_SERVER_ERROR);
//		} 
//	}
//	
//	/**
//	 * 사용자 그룹 트리 순서 수정, up, down
//	 * @param model
//	 * @return
//	 */
//	@PostMapping(value = "/groups/tree/{userGroupId}/move", produces = "application/json;charset=UTF-8")
//	public ResponseEntity<?> moveUserGroup(HttpServletRequest request, @PathVariable Integer userGroupId, @ModelAttribute UserGroup userGroup) {
//		log.info("@@ userGroup = {}", userGroup);
//		
//		String userGroupTree = null;
//		List<UserGroup> userGroupList = new ArrayList<>();
//		try {
//			userGroupService.updateMoveTreeUserGroup(userGroup);
//			cacheRefreshManager.refresh(CacheType.SELF, CacheName.USER_GROUP);
//			
//			userGroupList.addAll(userGroupService.getListUserGroup(new UserGroup()));
//			userGroupTree = getUserGroupTree(userGroupList);
//			log.info("@@ userGroupTree = {} ", userGroupTree);
//			
//			return new ResponseEntity<>(userGroupTree, HttpStatus.OK);
//		} catch(Exception e) {
//			e.printStackTrace();
//
//			Map<String, Object> result = new HashMap<>();
//			result.put("statusCode", HttpStatus.INTERNAL_SERVER_ERROR.value());
//			result.put("error", new APIError(e.getCause() != null ? e.getCause().getMessage() : e.getMessage()));
//			return new ResponseEntity<>(result, HttpStatus.INTERNAL_SERVER_ERROR);
//		} 
//	}
//	
//	/**
//	 * 사용자 그룹 트리 삭제
//	 * @param model
//	 * @return
//	 */
//	@DeleteMapping(value = "/groups/tree/{userGroupId}", produces = "application/json;charset=UTF-8")
//	public ResponseEntity<?> deleteUserGroup(HttpServletRequest request, @PathVariable Integer userGroupId) {
//		
//		log.info("@@ userGroupId = {} ", userGroupId);
//		
//		String userGroupTree = null;
//		List<UserGroup> userGroupList = new ArrayList<>();
//		try {
//			int childUserGroupCount = userGroupService.getChildUserGroupCount(userGroupId);
//			if(childUserGroupCount > 0) {
//				userGroupList.addAll(userGroupService.getListUserGroup(new UserGroup()));
//				userGroupTree = getUserGroupTree(userGroupList);
//				
//				Map<String, Object> result = new HashMap<>();
//				result.put("userGroupTree", userGroupTree);
//				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
//				result.put("error", new APIError("하위 그룹이 존재 합니다. 하위 그룹을 삭제 후 삭제 가능 합니다.", "user.group.child.exist"));
//				return new ResponseEntity<>(result, HttpStatus.BAD_REQUEST);
//			}
//			
//			userGroupService.deleteUserGroup(userGroupId);
//			cacheRefreshManager.refresh(CacheType.SELF, CacheName.USER_GROUP);
//			
//			userGroupList.addAll(userGroupService.getListUserGroup(new UserGroup()));
//			userGroupTree = getUserGroupTree(userGroupList);
//			log.info("@@ userGroupTree = {} ", userGroupTree);
//			
//			return new ResponseEntity<>(userGroupTree, HttpStatus.OK);
//		} catch(Exception e) {
//			e.printStackTrace();
//
//			Map<String, Object> result = new HashMap<>();
//			result.put("statusCode", HttpStatus.INTERNAL_SERVER_ERROR.value());
//			result.put("error", new APIError(e.getCause() != null ? e.getCause().getMessage() : e.getMessage()));
//			return new ResponseEntity<>(result, HttpStatus.INTERNAL_SERVER_ERROR);
//		} 
//	}
//	
//	/**
//	 * 그룹 메뉴 관리
//	 * @param request
//	 * @param userGroupId
//	 * @param model
//	 * @return
//	 */
//	@RequestMapping(value = "/group/{userGroupId}/menu")
//	public String groupMenu(HttpServletRequest request, @PathVariable Integer userGroupId, Model model) {		
//		
//		Menu menu = new Menu();
//		menu.setMenuTarget(MenuTarget.ADMIN.getValue());
//		menu.setMenuType(MenuType.URL.getValue());
//		List<Menu> menuList = menuService.getListMenu(menu);
//		menu.setMenuTarget(MenuTarget.USER.getValue());
//		menu.setMenuType(MenuType.HTMLID.getValue());
//		menuList.addAll(menuService.getListMenu(menu));
//		
//		UserGroup userGroup = userGroupService.getUserGroup(userGroupId);
//		
//		String userGroupMenuJson = "";
//		try {
//			UserGroupMenu userGroupMenu = new UserGroupMenu();
//			userGroupMenu.setUserGroupId(userGroupId);
//			List<UserGroupMenu> userGroupMenuList = userGroupService.getListUserGroupMenu(userGroupMenu);
//			userGroupMenuJson = objectMapper.writeValueAsString(userGroupMenuList);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		
//		model.addAttribute("userGroup", userGroup);
//		model.addAttribute("menuList", menuList);
//		model.addAttribute("userGroupMenuJson", userGroupMenuJson);
//		
//		return "/user/group-menu";
//	}
//	
//	/**
//	 * 사용자 그룹 메뉴 수정
//	 * @param request
//	 * @param userGroupId
//	 * @param userGroupMenu
//	 * @return
//	 */
//	@PostMapping(value = "/group/{userGroupId}/menu", produces = "application/json;charset=UTF-8")
//	public ResponseEntity<?> updateUserGroupMenu(HttpServletRequest request, @PathVariable Integer userGroupId, UserGroupMenu userGroupMenu) {
//		
//		log.info("@@ userGroupMenu = {} ", userGroupMenu);
//		
//		try {
//			userGroupMenu.setUserGroupId(userGroupId);
//			userGroupService.updateUserGroupMenu(userGroupMenu);
//			cacheRefreshManager.refresh(CacheType.SELF, CacheName.USER_GROUP);
//			
//			return new ResponseEntity<>(HttpStatus.OK.value(), HttpStatus.OK);
//		} catch(Exception e) {
//			e.printStackTrace();
//			Map<String, Object> result = new HashMap<>();
//			result.put("statusCode", HttpStatus.INTERNAL_SERVER_ERROR.value());
//			result.put("error", new APIError(e.getCause() != null ? e.getCause().getMessage() : e.getMessage()));
//			return new ResponseEntity<>(result, HttpStatus.INTERNAL_SERVER_ERROR);
//		} 
//	}
//	
//	/**
//	 * 사용자 그룹 Role 관리
//	 * @param request
//	 * @param roleId
//	 * @param model
//	 * @return
//	 */
//	@RequestMapping(value = "/group/{userGroupId}/role")
//	public String groupRole(HttpServletRequest request, @PathVariable Integer userGroupId, Model model) {		
//		
//		Role role = new Role();
//		Search search = new Search();
//		search.setOffset(0l);
//		search.setLimit(1000l);
//		role.setSearch(search);
//		List<Role> roleList = roleService.getListRole(role);
//		UserGroup userGroup = userGroupService.getUserGroup(userGroupId);
//		
//		String userGroupRoleJson = "";
//		try {
//			UserGroupRole userGroupRole = new UserGroupRole();
//			userGroupRole.setUserGroupId(userGroupId);
//			List<UserGroupRole> userGroupRoleList = userGroupService.getListUserGroupRole(userGroupRole);
//			userGroupRoleJson = objectMapper.writeValueAsString(userGroupRoleList);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		
//		model.addAttribute("userGroup", userGroup);
//		model.addAttribute("roleList", roleList);
//		model.addAttribute("userGroupRoleJson", userGroupRoleJson);
//		
//		return "/user/group-role";
//	}
//	
//	/**
//	 * 사용자 그룹 Role 수정
//	 * @param request
//	 * @param userGroupId
//	 * @param userGroupRole
//	 * @return
//	 */
//	@PostMapping(value = "/group/{userGroupId}/role", produces = "application/json;charset=UTF-8")
//	public ResponseEntity<?> updateUserGroupRole(HttpServletRequest request, @PathVariable Integer userGroupId, UserGroupRole userGroupRole) {
//		
//		log.info("@@ userGroupRole = {} ", userGroupRole);
//		
//		try {
//			userGroupRole.setUserGroupId(userGroupId);
//			userGroupService.updateUserGroupRole(userGroupRole);
//			cacheRefreshManager.refresh(CacheType.SELF, CacheName.USER_GROUP);
//			
//			return new ResponseEntity<>(HttpStatus.OK.value(), HttpStatus.OK);
//		} catch(Exception e) {
//			e.printStackTrace();
//			Map<String, Object> result = new HashMap<>();
//			result.put("statusCode", HttpStatus.INTERNAL_SERVER_ERROR.value());
//			result.put("error", new APIError(e.getCause() != null ? e.getCause().getMessage() : e.getMessage()));
//			return new ResponseEntity<>(result, HttpStatus.INTERNAL_SERVER_ERROR);
//		} 
//	}
	
//	private String getUserGroupTree(List<UserGroup> userGroupList) {
//		if(userGroupList.isEmpty()) return "{}";
//		
//		StringBuffer buffer = new StringBuffer();
//		int count = userGroupList.size();
//		UserGroup userGroup = userGroupList.get(0);
//		
//		buffer.append("[")
//		.append("{")
//		.append("\"userGroupId\"").append(":").append("\"" + userGroup.getUserGroupId() + "\"").append(",")
//		.append("\"groupKey\"").append(":").append("\"" + StringUtil.getDefaultValue(userGroup.getGroupKey()) + "\"").append(",")
//		.append("\"groupName\"").append(":").append("\"" + StringUtil.getDefaultValue(userGroup.getGroupName()) + "\"").append(",")
//		.append("\"ancestor\"").append(":").append("\"" + StringUtil.getDefaultValue(userGroup.getAncestor()) + "\"").append(",")
//		.append("\"open\"").append(":").append("\"" + StringUtil.getDefaultValue(userGroup.getOpen()) + "\"").append(",")
//		.append("\"nodeType\"").append(":").append("\"" + StringUtil.getDefaultValue(userGroup.getNodeType()) + "\"").append(",")
//		.append("\"parent\"").append(":").append("\"" + userGroup.getParent() + "\"").append(",")
//		.append("\"parentName\"").append(":").append("\"" + StringUtil.getDefaultValue(userGroup.getParentName()) + "\"").append(",")
//		.append("\"depth\"").append(":").append("\"" + userGroup.getDepth() + "\"").append(",")
//		.append("\"viewOrder\"").append(":").append("\"" + userGroup.getViewOrder() + "\"").append(",")
//		.append("\"defaultYn\"").append(":").append("\"" + StringUtil.getDefaultValue(userGroup.getDefaultYn()) + "\"").append(",")
//		.append("\"useYn\"").append(":").append("\"" + StringUtil.getDefaultValue(userGroup.getUseYn()) + "\"").append(",")
//		.append("\"childYn\"").append(":").append("\"" + StringUtil.getDefaultValue(userGroup.getChildYn()) + "\"").append(",")
//		.append("\"deptNo\"").append(":").append("\"" + StringUtil.getDefaultValue(userGroup.getDeptNo()) + "\"").append(",")
//		.append("\"description\"").append(":").append("\"" + StringUtil.getDefaultValue(userGroup.getDescription()) + "\"").append(",")
//		.append("\"insertDate\"").append(":").append("\"" + StringUtil.getDefaultValue(userGroup.getViewInsertDate()) + "\"");
//		
//		if(count > 1) {
//			long preParent = userGroup.getParent();
//			int preDepth = userGroup.getDepth();
//			int bigParentheses = 1;
//			for(int i=1; i<count; i++) {
//				userGroup = userGroupList.get(i);
//				
//				if(preParent == userGroup.getParent()) {
//					// 부모가 같은 경우
//					buffer.append("}");
//					buffer.append(",");
//				} else {
//					if(preDepth > userGroup.getDepth()) {
//						// 닫힐때
//						int closeCount = preDepth - userGroup.getDepth();
//						for(int j=0; j<closeCount; j++) {
//							buffer.append("}");
//							buffer.append("]");
//							bigParentheses--;
//						}
//						buffer.append("}");
//						buffer.append(",");
//					} else {
//						// 열릴때
//						buffer.append(",");
//						buffer.append("\"subTree\"").append(":").append("[");
//						bigParentheses++;
//					}
//				} 
//				
//				buffer.append("{")
//				.append("\"userGroupId\"").append(":").append("\"" + userGroup.getUserGroupId() + "\"").append(",")
//				.append("\"groupKey\"").append(":").append("\"" + StringUtil.getDefaultValue(userGroup.getGroupKey()) + "\"").append(",")
//				.append("\"groupName\"").append(":").append("\"" + StringUtil.getDefaultValue(userGroup.getGroupName()) + "\"").append(",")
//				.append("\"ancestor\"").append(":").append("\"" + StringUtil.getDefaultValue(userGroup.getAncestor()) + "\"").append(",")
//				.append("\"open\"").append(":").append("\"" + StringUtil.getDefaultValue(userGroup.getOpen()) + "\"").append(",")
//				.append("\"nodeType\"").append(":").append("\"" + StringUtil.getDefaultValue(userGroup.getNodeType()) + "\"").append(",")
//				.append("\"parent\"").append(":").append("\"" + userGroup.getParent() + "\"").append(",")
//				.append("\"parentName\"").append(":").append("\"" + StringUtil.getDefaultValue(userGroup.getParentName()) + "\"").append(",")
//				.append("\"depth\"").append(":").append("\"" + userGroup.getDepth() + "\"").append(",")
//				.append("\"viewOrder\"").append(":").append("\"" + userGroup.getViewOrder() + "\"").append(",")
//				.append("\"defaultYn\"").append(":").append("\"" + StringUtil.getDefaultValue(userGroup.getDefaultYn()) + "\"").append(",")
//				.append("\"useYn\"").append(":").append("\"" + StringUtil.getDefaultValue(userGroup.getUseYn()) + "\"").append(",")
//				.append("\"childYn\"").append(":").append("\"" + StringUtil.getDefaultValue(userGroup.getChildYn()) + "\"").append(",")
//				.append("\"deptNo\"").append(":").append("\"" + StringUtil.getDefaultValue(userGroup.getDeptNo()) + "\"").append(",")
//				.append("\"description\"").append(":").append("\"" + StringUtil.getDefaultValue(userGroup.getDescription()) + "\"").append(",")
//				.append("\"insertDate\"").append(":").append("\"" + StringUtil.getDefaultValue(userGroup.getViewInsertDate()) + "\"");
//				
//				if(i == (count-1)) {
//					// 맨 마지막의 경우 괄호를 닫음
//					if(bigParentheses == 0) {
//						buffer.append("}");
//					} else {
//						for(int k=0; k<bigParentheses; k++) {
//							buffer.append("}");
//							buffer.append("]");
//						}
//					}
//				}
//				
//				preParent = userGroup.getParent();
//				preDepth = userGroup.getDepth();
//			}
//		}
//		
////		buffer.append("}");
////		buffer.append("]");
//		
//		return buffer.toString();
//	}
	
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
