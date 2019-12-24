package ndtp.config;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;
import ndtp.domain.CacheManager;
import ndtp.domain.CacheName;
import ndtp.domain.CacheParams;
import ndtp.domain.CacheType;
import ndtp.domain.Menu;
import ndtp.domain.MenuTarget;
import ndtp.domain.RoleTarget;
import ndtp.domain.UserGroup;
import ndtp.domain.UserGroupMenu;
import ndtp.domain.UserGroupRole;
import ndtp.domain.YOrN;
import ndtp.service.MenuService;
import ndtp.service.UserGroupService;

@Slf4j
@Component
public class CacheConfig {

	@Autowired
	private MenuService menuService;
    @Autowired
    private UserGroupService userGroupService;

    @PostConstruct
    public void init() {
    	log.info("*************************************************");
        log.info("************ Admin Cache Init Start *************");
        log.info("*************************************************");

        CacheParams cacheParams = new CacheParams();
		cacheParams.setCacheType(CacheType.SELF);
        
        // 사용자 그룹별 메뉴, Role
        userGroupMenuAndRole(cacheParams);
        
        log.info("*************************************************");
        log.info("************* Admin Cache Init End **************");
        log.info("*************************************************");
    }
    
    public void loadCache(CacheParams cacheParams) {
		CacheName cacheName = cacheParams.getCacheName();
		
		if(cacheName == CacheName.POLICY) policy(cacheParams);
		else if(cacheName == CacheName.MENU) menu(cacheParams);
		else if(cacheName == CacheName.USER_GROUP) userGroupMenuAndRole(cacheParams);
	}
    
    /**
     * policy
     * @param cacheParams
     */
    private void policy(CacheParams cacheParams) {
    	CacheType cacheType = cacheParams.getCacheType();
    	if(cacheType == CacheType.BROADCAST) {
    		callRemoteCache(cacheParams);
    	}
    }
    
    /**
     * menu
     * @param cacheParams
     */
    private void menu(CacheParams cacheParams) {
    	CacheType cacheType = cacheParams.getCacheType();
    	if(cacheType == CacheType.BROADCAST) {
    		callRemoteCache(cacheParams);
    	}
    }

    /**
     * 사용자 그룹, 메뉴, Role
     */
    private void userGroupMenuAndRole(CacheParams cacheParams) {
    	Map<Integer, Menu> menuMap = new HashMap<>();
		Map<String, Integer> menuUrlMap = new HashMap<>();
		Menu adminMenu = new Menu();
		adminMenu.setDefaultYn(null);
		adminMenu.setMenuTarget(MenuTarget.ADMIN.getValue());
		
		List<Menu> menuList = menuService.getListMenu(adminMenu);
		for(Menu menu : menuList) {
			menuMap.put(menu.getMenuId(), menu);
			menuUrlMap.put(menu.getUrl(), menu.getMenuId());
		}
    	
    	UserGroup inputUserGroup = new UserGroup();
    	inputUserGroup.setUseYn(YOrN.Y.name());
    	List<UserGroup> userGroupList = userGroupService.getListUserGroup(inputUserGroup);
    	
    	Map<Integer, List<UserGroupMenu>> userGroupMenuMap = new HashMap<>();
    	Map<Integer, List<String>> userGroupRoleMap = new HashMap<>();
    	
    	UserGroupMenu userGroupMenu = new UserGroupMenu();
    	userGroupMenu.setMenuTarget(MenuTarget.ADMIN.getValue());
    	
    	UserGroupRole userGroupRole = new UserGroupRole();
    	userGroupRole.setRoleTarget(RoleTarget.ADMIN.getValue());
    	for(UserGroup userGroup : userGroupList) {
    		Integer userGroupId = userGroup.getUserGroupId();
    		
    		userGroupMenu.setUserGroupId(userGroupId);
    		List<UserGroupMenu> userGroupMenuList = userGroupService.getListUserGroupMenu(userGroupMenu);
    		userGroupMenuMap.put(userGroupId, userGroupMenuList);
    		
    		userGroupRole.setUserGroupId(userGroupId);
    		List<String> userGroupRoleKeyList = userGroupService.getListUserGroupRoleKey(userGroupRole);
    		userGroupRoleMap.put(userGroupId, userGroupRoleKeyList);
    	}
    	
    	CacheManager.setMenuMap(menuMap);
		CacheManager.setMenuUrlMap(menuUrlMap);
    	CacheManager.setUserGroupMenuMap(userGroupMenuMap);
    	CacheManager.setUserGroupRoleMap(userGroupRoleMap);
    	
    	CacheType cacheType = cacheParams.getCacheType();
		if(cacheType == CacheType.BROADCAST) {
			callRemoteCache(cacheParams);
		}
    }
    
    /**
	 * Remote Cache 갱신 요청
	 * @param cacheName
	 */
	private void callRemoteCache(CacheParams cacheParams) {
		
		log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@ callRemoteCache start! ");
//		if(!propertiesConfig.isCallRemoteEnable()) {
//			log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@ isCallRemoteEnable = {}. skip callRemoteCache ", propertiesConfig.isCallRemoteEnable());
//			return;
//		}
//		
//		CacheName cacheName = cacheParams.getCacheName();
//		log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@ cacheName ={}", cacheName.toString());
//		
//		StringBuilder stringBuilder = new StringBuilder();
//		stringBuilder.append("api-key=" + Crypt.decrypt(propertiesConfig.getRestAuthKey()))
//		.append("&")
//		.append("cache_name=" + cacheName.toString())
//		.append("&");
//		if(cacheParams.getProject_id() != null) stringBuilder.append("project_id=" + cacheParams.getProject_id());
//		stringBuilder.append("&")
//		.append("time=" + System.nanoTime());
//		
//		String authData = Crypt.encrypt(stringBuilder.toString());
//		
//		// TODO 로컬, 이중화 등의 분기 처리가 생략되어 있음
//		List<ExternalService> remoteCacheServerList = CacheManager.getRemoteCacheServiceList();
//		for(ExternalService externalService : remoteCacheServerList) {
//			// TODO 환경 설정으로 빼서 로컬이거나 단독 서버인 경우 호출하지 않게 설계해야 함
//			try {
//				Map<String, Object> resultObject = HttpClientHelper.httpPost(externalService, authData);
//				if(resultObject != null && !resultObject.isEmpty() ) {
//					int statusCode = (Integer)resultObject.get("statusCode");
//					String statusCodeValue = (String)resultObject.get("statusCodeValue");
//					String result = (String)resultObject.get("result");
//					log.error("@@@ statusCode = {}.", statusCode);
//					log.error("@@@ statusCodeValue = {}.", statusCodeValue);
//					log.error("@@@ result = {}.", result);
//				}
//			} catch(Exception e) {
//				e.printStackTrace();
//			}
//		}
	}
}
