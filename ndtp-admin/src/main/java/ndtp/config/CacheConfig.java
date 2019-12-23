package ndtp.config;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;
import ndtp.domain.CacheManager;
import ndtp.domain.MenuTarget;
import ndtp.domain.RoleTarget;
import ndtp.domain.UserGroup;
import ndtp.domain.UserGroupMenu;
import ndtp.domain.UserGroupRole;
import ndtp.domain.YOrN;
import ndtp.service.UserGroupService;

@Slf4j
@Component
public class CacheConfig {

    @Autowired
    private UserGroupService userGroupService;

    @PostConstruct
    public void init() {
    	log.info("*************************************************");
        log.info("************ Admin Cache Init Start *************");
        log.info("*************************************************");

        userGroupMenuAndRole();
        
        log.info("*************************************************");
        log.info("************* Admin Cache Init End **************");
        log.info("*************************************************");
    }

    /**
     * 사용자 그룹, 메뉴, Role
     */
    private void userGroupMenuAndRole() {
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
    	
    	CacheManager.setUserGroupMenuMap(userGroupMenuMap);
    	CacheManager.setUserGroupRoleMap(userGroupRoleMap);
    }
}
