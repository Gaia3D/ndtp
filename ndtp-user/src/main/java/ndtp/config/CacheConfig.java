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
import ndtp.domain.DataGroup;
import ndtp.domain.DataInfoSimple;
import ndtp.domain.GeoPolicy;
import ndtp.domain.Menu;
import ndtp.domain.MenuTarget;
import ndtp.domain.Policy;
import ndtp.domain.ProfileType;
import ndtp.domain.RoleTarget;
import ndtp.domain.ServerTarget;
import ndtp.domain.UserGroup;
import ndtp.domain.UserGroupMenu;
import ndtp.domain.UserGroupRole;
import ndtp.service.DataGroupService;
import ndtp.service.DataService;
import ndtp.service.GeoPolicyService;
import ndtp.service.MenuService;
import ndtp.service.PolicyService;
import ndtp.service.UserGroupService;
import ndtp.support.LogMessageSupport;

@Slf4j
@Component
public class CacheConfig {
	
	@Autowired
	private DataService dataService;
	@Autowired
	private DataGroupService dataGroupService;
	@Autowired
	private GeoPolicyService geoPolicyService;
	@Autowired
	private PolicyService policyService;
	@Autowired
	private PropertiesConfig propertiesConfig;
	@Autowired
	private MenuService menuService;
	@Autowired
    private UserGroupService userGroupService;

    @PostConstruct
    public void init() {
    	if(ProfileType.LOCAL  == ProfileType.valueOf(propertiesConfig.getProfile().toUpperCase())) {
        	LogMessageSupport.stackTraceEnable = true;
        }
        log.info("************ User Profile = {}, stackTraceEnable = {} *************", propertiesConfig.getProfile(), LogMessageSupport.stackTraceEnable);
        
    	log.info("*************************************************");
        log.info("************ User Cache Init Start *************");
        log.info("*************************************************");

        CacheParams cacheParams = new CacheParams();
		cacheParams.setCacheType(CacheType.SELF);
        
		// 운영 정책 캐시 갱신
		policy(cacheParams);
		// 2D, 3D 운영 정책
		geoPolicy(cacheParams);
		// 사용자 그룹별 메뉴, Menu
        menu(cacheParams);
        // 사용자 그룹별 메뉴, Role
        role(cacheParams);
        
        // Smart Tiling 데이터 그룹별 데이터 목록
//        smartTilingData(cacheParams);
        
        log.info("*************************************************");
        log.info("************* User Cache Init End **************");
        log.info("*************************************************");
    }
    
    public void loadCache(CacheParams cacheParams) {
		CacheName cacheName = cacheParams.getCacheName();
		
		if(cacheName == CacheName.POLICY) policy(cacheParams);
		else if(cacheName == CacheName.GEO_POLICY) geoPolicy(cacheParams);
		else if(cacheName == CacheName.MENU) menu(cacheParams);
		else if(cacheName == CacheName.ROLE) role(cacheParams);
		else if(cacheName == CacheName.USER_GROUP) userGroup(cacheParams);
		else if(cacheName == CacheName.SMART_TILING_DATA) smartTilingData(cacheParams);
	}
    
    /**
     * policy
     * @param cacheParams 
     */
    private void policy(CacheParams cacheParams) {
    	log.info("************ Cache Reload policy ************");
    	Policy policy = policyService.getPolicy();
    	CacheManager.setPolicy(policy);
    }
    
    /**
     * 2D, 3D 운영 정책
     * @param cacheParams
     */
    private void geoPolicy(CacheParams cacheParams) {
    	log.info("************ Cache Reload geoPolicy ************");
    	GeoPolicy geoPolicy = geoPolicyService.getGeoPolicy();
    	CacheManager.setGeoPolicy(geoPolicy);
    }
    
    /**
     * 사용자 그룹
     */
    private void userGroup(CacheParams cacheParams) {
    	log.info("************ Cache Reload userGroup ************");
    	menu(cacheParams);
    	role(cacheParams);
    }
    
    /**
     * menu
     * @param cacheParams
     */
    private void menu(CacheParams cacheParams) {
    	log.info("************ Cache Reload menu ************");
    	
    	Map<Integer, Menu> menuMap = new HashMap<>();
		Map<String, Integer> menuUrlMap = new HashMap<>();
		Menu userMenu = new Menu();
		userMenu.setDefaultYn(null);
		userMenu.setMenuTarget(MenuTarget.USER.getValue());
		
		List<Menu> menuList = menuService.getListMenu(userMenu);
		for(Menu menu : menuList) {
			menuMap.put(menu.getMenuId(), menu);
			menuUrlMap.put(menu.getUrl(), menu.getMenuId());
		}
    	
    	UserGroup inputUserGroup = new UserGroup();
    	inputUserGroup.setAvailable(Boolean.TRUE);
    	List<UserGroup> userGroupList = userGroupService.getListUserGroup(inputUserGroup);
    	
    	Map<Integer, List<UserGroupMenu>> userGroupMenuMap = new HashMap<>();
    	
    	UserGroupMenu userGroupMenu = new UserGroupMenu();
    	userGroupMenu.setMenuTarget(MenuTarget.USER.getValue());
    	
    	for(UserGroup userGroup : userGroupList) {
    		Integer userGroupId = userGroup.getUserGroupId();
    		
    		userGroupMenu.setUserGroupId(userGroupId);
    		List<UserGroupMenu> userGroupMenuList = userGroupService.getListUserGroupMenu(userGroupMenu);
    		userGroupMenuMap.put(userGroupId, userGroupMenuList);
    	}
    	
    	CacheManager.setMenuMap(menuMap);
		CacheManager.setMenuUrlMap(menuUrlMap);
    	CacheManager.setUserGroupMenuMap(userGroupMenuMap);
    }
    
    /**
     * role
     * @param cacheParams
     */
    private void role(CacheParams cacheParams) {
    	log.info("************ Cache Reload role ************");
    	
    	UserGroup inputUserGroup = new UserGroup();
    	inputUserGroup.setAvailable(Boolean.TRUE);
    	List<UserGroup> userGroupList = userGroupService.getListUserGroup(inputUserGroup);
    	
    	Map<Integer, List<String>> userGroupRoleMap = new HashMap<>();
    	
    	UserGroupRole userGroupRole = new UserGroupRole();
    	userGroupRole.setRoleTarget(RoleTarget.USER.getValue());
    	for(UserGroup userGroup : userGroupList) {
    		Integer userGroupId = userGroup.getUserGroupId();
    		
    		userGroupRole.setUserGroupId(userGroupId);
    		List<String> userGroupRoleKeyList = userGroupService.getListUserGroupRoleKey(userGroupRole);
    		userGroupRoleMap.put(userGroupId, userGroupRoleKeyList);
    	}
    	
    	CacheManager.setUserGroupRoleMap(userGroupRoleMap);
    	
//    	CacheType cacheType = cacheParams.getCacheType();
		
    }
    
    /**
     * Smart Tiling 데이터
     * @param cacheParams
     */
    private void smartTilingData(CacheParams cacheParams) {
    	Map<Integer, List<DataInfoSimple>> smartTilingDataMap = new HashMap<>();
    	
    	DataGroup smartTilingDataGroup = DataGroup.builder().tiling(true).dataGroupTarget(ServerTarget.ADMIN.name().toLowerCase()).build();
    	List<DataGroup> smartTilingDataGroupList = dataGroupService.getAllListDataGroup(smartTilingDataGroup);
    	for(DataGroup dataGroup : smartTilingDataGroupList) {
    		List<DataInfoSimple> dataList = dataService.getListAllDataByDataGroupId(dataGroup.getDataGroupId());
    		smartTilingDataMap.put(dataGroup.getDataGroupId(), dataList);
    	}
    	
    	CacheManager.setSmartTilingDataMap(smartTilingDataMap);
    	
//    	CacheType cacheType = cacheParams.getCacheType();
//    	if(cacheType == CacheType.BROADCAST) {
//    		callRemoteCache(cacheParams);
//    	}
    }
    
    /**
	 * Remote Cache 갱신 요청
	 * @param cacheName
	 */
	private void callRemoteCache(CacheParams cacheParams) {
		log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@ callRemoteCache start! ");
	}
}
