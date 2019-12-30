package ndtp.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;
import ndtp.domain.APIError;
import ndtp.domain.Menu;
import ndtp.domain.MenuTarget;
import ndtp.domain.MenuType;
import ndtp.service.MenuService;
import ndtp.utils.StringUtil;

@Slf4j
@Controller
@RequestMapping("/menu/")
public class MenuController {
	
	private final MenuService menuService;
	
	public MenuController(MenuService menuService) {
		this.menuService = menuService;
	}
	
	@GetMapping(value = "admin-menu")
	public String adminMenu(HttpServletRequest request, Model model) {
		
		return "/menu/admin-menu";
	}
	
	@GetMapping(value = "user-menu")
	public String userMenu (HttpServletRequest request, Model model) {
		
		return "/menu/user-menu";
	}
	
	/**
	 * 메뉴 트리
	 * @param request
	 * @return
	 */
	@GetMapping(value = "admin-tree", produces = "application/json;charset=UTF-8")
	public ResponseEntity<?> adminTree(HttpServletRequest request) {
		String menuTree = null;
		try {
			menuTree = getMenuTree(getAllListMenu(MenuTarget.ADMIN.getValue()));
			log.info("@@ menuTree = {} ", menuTree);
			
			return new ResponseEntity<>(menuTree, HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			
			Map<String, Object> result = new HashMap<>();
			result.put("statusCode", HttpStatus.INTERNAL_SERVER_ERROR.value());
			result.put("error", new APIError(e.getCause() != null ? e.getCause().getMessage() : e.getMessage()));
			return new ResponseEntity<>(result, HttpStatus.INTERNAL_SERVER_ERROR);
		} 
	}
	
	/**
	 * 메뉴 트리
	 * @param request
	 * @return
	 */
	@GetMapping(value = "user-tree", produces = "application/json;charset=UTF-8")
	public ResponseEntity<?> userTree(HttpServletRequest request) {
		String menuTree = null;
		try {
			menuTree = getMenuTree(getAllListMenu(MenuTarget.USER.getValue()));
			log.info("@@ menuTree = {} ", menuTree);
			
			return new ResponseEntity<>(menuTree, HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			
			Map<String, Object> result = new HashMap<>();
			result.put("statusCode", HttpStatus.INTERNAL_SERVER_ERROR.value());
			result.put("error", new APIError(e.getCause() != null ? e.getCause().getMessage() : e.getMessage()));
			return new ResponseEntity<>(result, HttpStatus.INTERNAL_SERVER_ERROR);
		} 
	}
	
	/**
	 * 메뉴 추가
	 * @param request
	 * @param menu
	 * @return
	 */
	@PostMapping(produces = "application/json;charset=UTF-8")
	public ResponseEntity<?> insert(HttpServletRequest request, Menu menu) {
		
		log.info("@@ menu = {} ", menu);
		
		String menuTree = null;
		try {
			if(menu.getName() == null || "".equals(menu.getName())
					|| menu.getNameEn() == null || "".equals(menu.getNameEn())	
					|| menu.getParent() == null
					|| menu.getUseYn() == null || "".equals(menu.getUseYn())) {
				
				menuTree = getMenuTree(getAllListMenu(menu.getMenuTarget()));
				
				Map<String, Object> result = new HashMap<>();
				result.put("menuTree", menuTree);
				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
				result.put("error", new APIError("입력값이 유효하지 않습니다.", "input.invalid"));
				return new ResponseEntity<>(result, HttpStatus.BAD_REQUEST);
			}
			
			Menu childMenu = menuService.getMaxViewOrderChildMenu(menu.getParent());
			if(childMenu == null) {
				menu.setViewOrder(1);
			} else {
				menu.setViewOrder(childMenu.getViewOrder() + 1);
			}
			
			if("\"null\"".equals(menu.getNameEn()) || "null".equals(menu.getNameEn())) menu.setNameEn("");
			if("\"null\"".equals(menu.getUrl()) || "null".equals(menu.getUrl())) menu.setUrl("");
			if("\"null\"".equals(menu.getUrlAlias()) || "null".equals(menu.getUrlAlias())) menu.setUrlAlias("");
			if("\"null\"".equals(menu.getHtmlId()) || "null".equals(menu.getHtmlId())) menu.setHtmlId("");
			if("\"null\"".equals(menu.getHtmlContentId()) || "null".equals(menu.getHtmlContentId())) menu.setHtmlContentId("");
			if("\"null\"".equals(menu.getImage()) || "null".equals(menu.getImage())) menu.setImage("");
			if("\"null\"".equals(menu.getImageAlt()) || "null".equals(menu.getImageAlt())) menu.setImageAlt("");
			if("\"null\"".equals(menu.getCssClass()) || "null".equals(menu.getCssClass())) menu.setCssClass("");
			if("\"null\"".equals(menu.getDisplayYn()) || "null".equals(menu.getDisplayYn())) menu.setDisplayYn("");
			if("\"null\"".equals(menu.getDescription()) || "null".equals(menu.getDescription())) menu.setDescription("");
			
			menuService.insertMenu(menu);
			menuTree = getMenuTree(getAllListMenu(menu.getMenuTarget()));
			log.info("@@ menuTree = {} ", menuTree);
			
//			cacheRefreshManager.refresh(CacheType.SELF, CacheName.USER_GROUP);
			
			return new ResponseEntity<>(menuTree, HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			Map<String, Object> result = new HashMap<>();
			result.put("statusCode", HttpStatus.INTERNAL_SERVER_ERROR.value());
			result.put("error", new APIError(e.getCause() != null ? e.getCause().getMessage() : e.getMessage()));
			return new ResponseEntity<>(result, HttpStatus.INTERNAL_SERVER_ERROR);
		} 
	}
	
	/**
	 * 사용자 그룹 트리 수정
	 * @param request
	 * @param menuId
	 * @param menu
	 * @return
	 */
	@PostMapping(value = "{menuId}", produces = "application/json;charset=UTF-8")
	public ResponseEntity<?> update(HttpServletRequest request, @PathVariable Integer menuId, @ModelAttribute Menu menu) {
		
		log.info("@@ menu = {}", menu);
		
		String menuTree = null;
		try {
			if(menu.getName() == null || "".equals(menu.getName())
					|| menu.getNameEn() == null || "".equals(menu.getNameEn())	
					|| menu.getParent() == null
					|| menu.getUseYn() == null || "".equals(menu.getUseYn())) {
				
				menuTree = getMenuTree(getAllListMenu(menu.getMenuTarget()));
				
				Map<String, Object> result = new HashMap<>();
				result.put("menuTree", menuTree);
				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
				result.put("error", new APIError("입력값이 유효하지 않습니다.", "input.invalid"));
				return new ResponseEntity<>(result, HttpStatus.BAD_REQUEST);
			}
			
			if("\"null\"".equals(menu.getNameEn()) || "null".equals(menu.getNameEn())) menu.setNameEn("");
			if("\"null\"".equals(menu.getUrl()) || "null".equals(menu.getUrl())) menu.setUrl("");
			if("\"null\"".equals(menu.getUrlAlias()) || "null".equals(menu.getUrlAlias())) menu.setUrlAlias("");
			if("\"null\"".equals(menu.getHtmlId()) || "null".equals(menu.getHtmlId())) menu.setHtmlId("");
			if("\"null\"".equals(menu.getHtmlContentId()) || "null".equals(menu.getHtmlContentId())) menu.setHtmlContentId("");
			if("\"null\"".equals(menu.getImage()) || "null".equals(menu.getImage())) menu.setImage("");
			if("\"null\"".equals(menu.getImageAlt()) || "null".equals(menu.getImageAlt())) menu.setImageAlt("");
			if("\"null\"".equals(menu.getCssClass()) || "null".equals(menu.getCssClass())) menu.setCssClass("");
			if("\"null\"".equals(menu.getDisplayYn()) || "null".equals(menu.getDisplayYn())) menu.setDisplayYn("");
			if("\"null\"".equals(menu.getDescription()) || "null".equals(menu.getDescription())) menu.setDescription("");
			
			menu.setMenuId(menuId);
			menuService.updateMenu(menu);
			menuTree = getMenuTree(getAllListMenu(menu.getMenuTarget()));
			log.info("@@ menuTree = {} ", menuTree);
			
//			cacheRefreshManager.refresh(CacheType.SELF, CacheName.USER_GROUP);
			
			return new ResponseEntity<>(menuTree, HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			
			Map<String, Object> result = new HashMap<>();
			result.put("statusCode", HttpStatus.INTERNAL_SERVER_ERROR.value());
			result.put("error", new APIError(e.getCause() != null ? e.getCause().getMessage() : e.getMessage()));
			return new ResponseEntity<>(result, HttpStatus.INTERNAL_SERVER_ERROR);
		} 
	}
	
	/**
	 * 사용자 그룹 트리 순서 수정, up, down
	 * @param request
	 * @param menuId
	 * @param menu
	 * @return
	 */
	@PostMapping(value = "{menuId}/move", produces = "application/json;charset=UTF-8")
	public ResponseEntity<?> move(HttpServletRequest request, @PathVariable Integer menuId, @ModelAttribute Menu menu) {
		log.info("@@ menu = {}", menu);
		
		String menuTree = null;
		try {
			if(	menu.getViewOrder() == null || menu.getViewOrder().intValue() == 0
				|| menu.getUpdateType() == null || "".equals(menu.getUpdateType())) {
				
				menuTree = getMenuTree(getAllListMenu(menu.getMenuTarget()));
				
				Map<String, Object> result = new HashMap<>();
				result.put("menuTree", menuTree);
				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
				result.put("error", new APIError("입력값이 유효하지 않습니다.", "input.invalid"));
				return new ResponseEntity<>(result, HttpStatus.BAD_REQUEST);
			}
			
			menuService.updateMoveMenu(menu);
			menuTree = getMenuTree(getAllListMenu(menu.getMenuTarget()));
			log.info("@@ menuTree = {} ", menuTree);
			
//			cacheRefreshManager.refresh(CacheType.SELF, CacheName.USER_GROUP);
			
			return new ResponseEntity<>(menuTree, HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();

			Map<String, Object> result = new HashMap<>();
			result.put("statusCode", HttpStatus.INTERNAL_SERVER_ERROR.value());
			result.put("error", new APIError(e.getCause() != null ? e.getCause().getMessage() : e.getMessage()));
			return new ResponseEntity<>(result, HttpStatus.INTERNAL_SERVER_ERROR);
		} 
	}
	
	/**
	 * 메뉴 삭제
	 * @param request
	 * @param menuId
	 * @return
	 */
	@DeleteMapping(value = "admin/{menuId}", produces = "application/json;charset=UTF-8")
	public ResponseEntity<?> adminMenudelete(HttpServletRequest request, @PathVariable Integer menuId) {
		
		log.info("@@ menuId = {} ", menuId);
		
		String menuTree = null;
		try {
			menuService.deleteMenu(menuId);
			menuTree = getMenuTree(getAllListMenu(MenuTarget.ADMIN.getValue()));
			log.info("@@ menuTree = {} ", menuTree);
			
//			cacheRefreshManager.refresh(CacheType.SELF, CacheName.USER_GROUP);
			
			return new ResponseEntity<>(menuTree, HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();

			Map<String, Object> result = new HashMap<>();
			result.put("statusCode", HttpStatus.INTERNAL_SERVER_ERROR.value());
			result.put("error", new APIError(e.getCause() != null ? e.getCause().getMessage() : e.getMessage()));
			return new ResponseEntity<>(result, HttpStatus.INTERNAL_SERVER_ERROR);
		} 
	}
	
	/**
	 * 메뉴 삭제
	 * @param request
	 * @param menuId
	 * @return
	 */
	@DeleteMapping(value = "user/{menuId}", produces = "application/json;charset=UTF-8")
	public ResponseEntity<?> userMenudelete(HttpServletRequest request, @PathVariable Integer menuId) {
		
		log.info("@@ menuId = {} ", menuId);
		
		String menuTree = null;
		try {
			menuService.deleteMenu(menuId);
			menuTree = getMenuTree(getAllListMenu(MenuTarget.USER.getValue()));
			log.info("@@ menuTree = {} ", menuTree);
			
//			cacheRefreshManager.refresh(CacheType.SELF, CacheName.USER_GROUP);
			
			return new ResponseEntity<>(menuTree, HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();

			Map<String, Object> result = new HashMap<>();
			result.put("statusCode", HttpStatus.INTERNAL_SERVER_ERROR.value());
			result.put("error", new APIError(e.getCause() != null ? e.getCause().getMessage() : e.getMessage()));
			return new ResponseEntity<>(result, HttpStatus.INTERNAL_SERVER_ERROR);
		} 
	}
	
	private String getMenuTree(List<Menu> menuList) {
		if(menuList.isEmpty()) return "{}";
		
		StringBuffer buffer = new StringBuffer();
		
		int count = menuList.size();
		Menu menu = menuList.get(0);
		
		buffer.append("[")
		.append("{")
		.append("\"menuId\"").append(":").append("\"" + menu.getMenuId() + "\"").append(",")
		.append("\"menuType\"").append(":").append("\"" + menu.getMenuType() + "\"").append(",")
		.append("\"menuTarget\"").append(":").append("\"" + menu.getMenuTarget() + "\"").append(",")
		.append("\"name\"").append(":").append("\"" + menu.getName() + "\"").append(",")
		.append("\"nameEn\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getNameEn()) + "\"").append(",")
		.append("\"open\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getOpen()) + "\"").append(",")
		.append("\"nodeType\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getNodeType()) + "\"").append(",")
		.append("\"ancestor\"").append(":").append("\"" + menu.getAncestor() + "\"").append(",")
		.append("\"parent\"").append(":").append("\"" + menu.getParent() + "\"").append(",")
		.append("\"parentName\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getParentName()) + "\"").append(",")
		.append("\"depth\"").append(":").append("\"" + menu.getDepth() + "\"").append(",")
		.append("\"viewOrder\"").append(":").append("\"" + menu.getViewOrder() + "\"").append(",")
		.append("\"url\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getUrl()) + "\"").append(",")
		.append("\"urlAlias\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getUrlAlias()) + "\"").append(",")
		.append("\"htmlId\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getHtmlId()) + "\"").append(",")
		.append("\"htmlContentId\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getHtmlContentId()) + "\"").append(",")
		.append("\"image\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getImage()) + "\"").append(",")
		.append("\"imageAlt\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getImageAlt()) + "\"").append(",")
		.append("\"cssClass\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getCssClass()) + "\"").append(",")
		.append("\"defaultYn\"").append(":").append("\"" + menu.getDefaultYn() + "\"").append(",")
		.append("\"useYn\"").append(":").append("\"" + menu.getUseYn() + "\"").append(",")
		.append("\"displayYn\"").append(":").append("\"" + menu.getDisplayYn() + "\"").append(",")
		.append("\"description\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getDescription()) + "\"");
		
		if(count > 1) {
			long preParent = menu.getParent();
			int preDepth = menu.getDepth();
			int bigParentheses = 0;
			for(int i=1; i<count; i++) {
				menu = menuList.get(i);
				
				if(preParent == menu.getParent()) {
					// 부모가 같은 경우
					buffer.append("}");
					buffer.append(",");
				} else {
					if(preDepth > menu.getDepth()) {
						// 닫힐때
						int closeCount = preDepth - menu.getDepth();
						for(int j=0; j<closeCount; j++) {
							buffer.append("}");
							buffer.append("]");
							bigParentheses--;
						}
						buffer.append("}");
						buffer.append(",");
					} else {
						// 열릴때
						buffer.append(",");
						buffer.append("\"subTree\"").append(":").append("[");
						bigParentheses++;
					}
				} 
				
				buffer.append("{")
				.append("\"menuId\"").append(":").append("\"" + menu.getMenuId() + "\"").append(",")
				.append("\"menuType\"").append(":").append("\"" + menu.getMenuType() + "\"").append(",")
				.append("\"menuTarget\"").append(":").append("\"" + menu.getMenuTarget() + "\"").append(",")
				.append("\"name\"").append(":").append("\"" + menu.getName() + "\"").append(",")
				.append("\"nameEn\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getNameEn()) + "\"").append(",")
				.append("\"open\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getOpen()) + "\"").append(",")
				.append("\"nodeType\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getNodeType()) + "\"").append(",")
				.append("\"ancestor\"").append(":").append("\"" + menu.getAncestor() + "\"").append(",")
				.append("\"parent\"").append(":").append("\"" + menu.getParent() + "\"").append(",")
				.append("\"parentName\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getParentName()) + "\"").append(",")
				.append("\"depth\"").append(":").append("\"" + menu.getDepth() + "\"").append(",")
				.append("\"viewOrder\"").append(":").append("\"" + menu.getViewOrder() + "\"").append(",")
				.append("\"url\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getUrl()) + "\"").append(",")
				.append("\"urlAlias\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getUrlAlias()) + "\"").append(",")
				.append("\"htmlId\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getHtmlId()) + "\"").append(",")
				.append("\"htmlContentId\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getHtmlContentId()) + "\"").append(",")
				.append("\"image\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getImage()) + "\"").append(",")
				.append("\"imageAlt\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getImageAlt()) + "\"").append(",")
				.append("\"cssClass\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getCssClass()) + "\"").append(",")
				.append("\"defaultYn\"").append(":").append("\"" + menu.getDefaultYn() + "\"").append(",")
				.append("\"useYn\"").append(":").append("\"" + menu.getUseYn() + "\"").append(",")
				.append("\"displayYn\"").append(":").append("\"" + menu.getDisplayYn() + "\"").append(",")
				.append("\"description\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getDescription()) + "\"");
				
				if(i == (count-1)) {
					// 맨 마지막의 경우 괄호를 닫음
					if(bigParentheses == 0) {
						buffer.append("}");
					} else {
						for(int k=0; k<bigParentheses; k++) {
							buffer.append("}");
							buffer.append("]");
						}
					}
				}
				
				preParent = menu.getParent();
				preDepth = menu.getDepth();
			}
		}
		
		buffer.append("}");
		buffer.append("]");
		
		return buffer.toString();
	}
	
	private List<Menu> getAllListMenu(String target) {
		List<Menu> menuList = new ArrayList<>();
		Menu menu = new Menu();
		
		if (target.equals(MenuTarget.ADMIN.getValue())) {
			menu.setMenuType(MenuType.URL.getValue());
			menu.setMenuTarget(MenuTarget.ADMIN.getValue());
			menuList.addAll(menuService.getListMenu(menu));
		} else if (target.equals(MenuTarget.ADMIN.getValue())) {
			menu.setMenuType(MenuType.HTMLID.getValue());
			menu.setMenuTarget(MenuTarget.USER.getValue());
			menuList.addAll(menuService.getListMenu(menu));
		} 
		
		return menuList;
	}
}
