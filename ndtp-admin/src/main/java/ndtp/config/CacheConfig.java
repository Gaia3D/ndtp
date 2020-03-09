package ndtp.config;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import lombok.extern.slf4j.Slf4j;
import ndtp.domain.CacheManager;
import ndtp.domain.CacheName;
import ndtp.domain.CacheParams;
import ndtp.domain.CacheType;
import ndtp.domain.Menu;
import ndtp.domain.MenuTarget;
import ndtp.domain.ProfileType;
import ndtp.domain.RoleTarget;
import ndtp.domain.UserGroup;
import ndtp.domain.UserGroupMenu;
import ndtp.domain.UserGroupRole;
import ndtp.domain.YOrN;
import ndtp.service.MenuService;
import ndtp.service.UserGroupService;
import ndtp.support.LogMessageSupport;

@Slf4j
@Component
public class CacheConfig {

	@Autowired
	private MenuService menuService;
	@Autowired
	private PropertiesConfig propertiesConfig;
	@Autowired
	private RestTemplate restTemplate;
    @Autowired
    private UserGroupService userGroupService;

    @PostConstruct
    public void init() {
    	if(ProfileType.LOCAL  == ProfileType.valueOf(propertiesConfig.getProfile().toUpperCase())) {
        	LogMessageSupport.stackTraceEnable = true;
        }
    	log.info("************ Admin Profile = {}, stackTraceEnable = {} *************", propertiesConfig.getProfile(), LogMessageSupport.stackTraceEnable);
        
    	log.info("*************************************************");
        log.info("************ Admin Cache Init Start *************");
        log.info("*************************************************");

        CacheParams cacheParams = new CacheParams();
		cacheParams.setCacheType(CacheType.SELF);
        // 사용자 그룹
		userGroup(cacheParams);
        // 사용자 그룹별 메뉴, Menu
        menu(cacheParams);
        // 사용자 그룹별 메뉴, Role
        role(cacheParams);
        
        log.info("*************************************************");
        log.info("************* Admin Cache Init End **************");
        log.info("*************************************************");
    }
    
    public void loadCache(CacheParams cacheParams) {
		CacheName cacheName = cacheParams.getCacheName();
		
		if(cacheName == CacheName.POLICY) policy(cacheParams);
		else if(cacheName == CacheName.GEO_POLICY) geoPolicy(cacheParams);
		else if(cacheName == CacheName.MENU) menu(cacheParams);
		else if(cacheName == CacheName.ROLE) role(cacheParams);
		else if(cacheName == CacheName.USER_GROUP) userGroup(cacheParams);
	}
    
    /**
     * policy
     * @param cacheParams
     */
    private void policy(CacheParams cacheParams) {
    	log.info("************ Cache Reload Policy ************");
    	CacheType cacheType = cacheParams.getCacheType();
    	if(cacheType == CacheType.BROADCAST) {
    		callRemoteCache(cacheParams);
    	}
    }
    
    /**
     * 2D, 3D 운영 정책
     * @param cacheParams
     */
    private void geoPolicy(CacheParams cacheParams) {
    	log.info("************ Cache Reload Policy ************");
    	CacheType cacheType = cacheParams.getCacheType();
    	if(cacheType == CacheType.BROADCAST) {
    		callRemoteCache(cacheParams);
    	}
    }
    
    /**
     * 사용자 그룹
     */
    private void userGroup(CacheParams cacheParams) {
    	log.info("************ Cache Reload userGroup ************");
    	CacheParams selfParams = new CacheParams();
    	selfParams.setCacheType(CacheType.SELF);
    	menu(selfParams);
    	role(selfParams);
    	
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
    	log.info("************ Cache Reload menu ************");
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
    	inputUserGroup.setAvailable(true);
    	List<UserGroup> userGroupList = userGroupService.getListUserGroup();

    	Map<Integer, List<UserGroupMenu>> userGroupMenuMap = new HashMap<>();
    	
    	UserGroupMenu userGroupMenu = new UserGroupMenu();
    	userGroupMenu.setMenuTarget(MenuTarget.ADMIN.getValue());

    	for(UserGroup userGroup : userGroupList) {
    		Integer userGroupId = userGroup.getUserGroupId();

    		userGroupMenu.setUserGroupId(userGroupId);
    		userGroupMenu.setUseYn(YOrN.Y.toString());
    		List<UserGroupMenu> userGroupMenuList = userGroupService.getListUserGroupMenu(userGroupMenu);
    		userGroupMenuMap.put(userGroupId, userGroupMenuList);
    	}

    	CacheManager.setMenuMap(menuMap);
		CacheManager.setMenuUrlMap(menuUrlMap);
    	CacheManager.setUserGroupMenuMap(userGroupMenuMap);

    	CacheType cacheType = cacheParams.getCacheType();
		if(cacheType == CacheType.BROADCAST) {
			callRemoteCache(cacheParams);
		}
    }
    
    /**
     * 사용자 그룹, 메뉴, Role
     */
    private void role(CacheParams cacheParams) {
    	log.info("************ Cache Reload role ************");
    	UserGroup inputUserGroup = new UserGroup();
    	inputUserGroup.setAvailable(true);
    	List<UserGroup> userGroupList = userGroupService.getListUserGroup();

    	Map<Integer, List<String>> userGroupRoleMap = new HashMap<>();

    	UserGroupRole userGroupRole = new UserGroupRole();
    	userGroupRole.setRoleTarget(RoleTarget.ADMIN.getValue());
    	for(UserGroup userGroup : userGroupList) {
    		Integer userGroupId = userGroup.getUserGroupId();

    		userGroupRole.setUserGroupId(userGroupId);
    		List<String> userGroupRoleKeyList = userGroupService.getListUserGroupRoleKey(userGroupRole);
    		userGroupRoleMap.put(userGroupId, userGroupRoleKeyList);
    	}

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
		if(!propertiesConfig.isCallRemoteEnable()) {
			log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@ isCallRemoteEnable = {}. skip callRemoteCache ", propertiesConfig.isCallRemoteEnable());
			return;
		}

		CacheName cacheName = cacheParams.getCacheName();
		log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@ cacheName ={}", cacheName.toString());
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.append("cache_name=" + cacheName.toString());
		
		String authData = stringBuilder.toString();

		// TODO 암호화 해야 하는데 임시 처리
//		HttpHeaders headers = new HttpHeaders();
//		headers.setContentType(MediaType.APPLICATION_JSON);
//		MultiValueMap<String, String> params= new LinkedMultiValueMap<String, String>();
//		params.add("cacheName", cacheName.toString());
//		HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<MultiValueMap<String, String>>(params, headers);

		// TODO 임시. external_service table로 옮겨야 함
		try {
			URI uri = new URI(propertiesConfig.getCacheClientUrl() + "cache/reload");
			@SuppressWarnings("unchecked")
			Map<String, Object> result = restTemplate.postForObject(uri, authData, Map.class);

            //ResponseEntity<APIResult> responseEntity = restTemplate.exchange(url, HttpMethod.POST, request, APIResult.class);
            log.info("----------------------- result = {}", result);
		} catch (URISyntaxException e) {
			log.info("데이터 converter 상태 변경 api 호출 실패 = {}", e.getMessage());
		}
	}
}
