package ndtp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.slf4j.Slf4j;
import ndtp.domain.Depth;
import ndtp.domain.Move;
import ndtp.domain.UserGroup;
import ndtp.domain.UserGroupMenu;
import ndtp.domain.UserGroupRole;
import ndtp.persistence.UserGroupMapper;
import ndtp.service.UserGroupService;

@Slf4j
@Service
public class UserGroupServiceImpl implements UserGroupService {

	@Autowired
	private UserGroupMapper userGroupMapper;

	/**
     * 사용자 그룹 목록
     * @return
     */
	@Transactional(readOnly = true)
	public List<UserGroup> getListUserGroup() {
		return userGroupMapper.getListUserGroup();
	}

	/**
     * 사용자 그룹 정보 조회
     * @return
     */
	@Transactional(readOnly = true)
	public UserGroup getUserGroup(UserGroup userGroup) {
		return userGroupMapper.getUserGroup(userGroup);
	}

	/**
     * 기본 사용자 그룹 정보 조회
     * @return
     */
	@Transactional(readOnly = true)
	public UserGroup getBasicUserGroup() {
		return userGroupMapper.getBasicUserGroup();
	}

    /**
	 * 사용자 그룹 메뉴 권한 목록
	 * @param userGroupMenu
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<UserGroupMenu> getListUserGroupMenu(UserGroupMenu userGroupMenu) {
		return userGroupMapper.getListUserGroupMenu(userGroupMenu);
	}

	/**
	 * 사용자 그룹 Role 목록
	 * @param userGroupRole
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<UserGroupRole> getListUserGroupRole(UserGroupRole userGroupRole) {
		return userGroupMapper.getListUserGroupRole(userGroupRole);
	}

	/**
	 * 사용자 그룹 Role Key 목록
	 * @param userGroupRole
	 * @return
	 */
	@Transactional(readOnly = true)
	public List<String> getListUserGroupRoleKey(UserGroupRole userGroupRole) {
		return userGroupMapper.getListUserGroupRoleKey(userGroupRole);
	}

    /**
     * 사용자 그룹 등록
     * @param userGroup
     * @return
     */
    @Transactional
	public int insertUserGroup(UserGroup userGroup) {
    	//GeoPolicy geoPolicy = geoPolicyService.getGeoPolicy();

    	UserGroup parentUserGroup = new UserGroup();
    	Integer depth = 0;
    	if(userGroup.getParent() > 0) {
	    	parentUserGroup.setUserGroupId(userGroup.getParent());
	    	parentUserGroup = userGroupMapper.getUserGroup(parentUserGroup);
	    	depth = parentUserGroup.getDepth() + 1;
    	}

    	int result = userGroupMapper.insertUserGroup(userGroup);

    	if(depth > 1) {
	    	// parent의 children update
    		Integer children = parentUserGroup.getChildren();
    		if(children == null) children = 0;
    		children += 1;
    		parentUserGroup.setChildren(children);
	    	return userGroupMapper.updateUserGroup(parentUserGroup);
    	}

    	return result;
    }

	/**
	 * 사용자 그룹 수정
	 * @param userGroup
	 * @return
	 */
    @Transactional
	public int updateUserGroup(UserGroup userGroup) {
    	return userGroupMapper.updateUserGroup(userGroup);
    }

    /**
	 * 사용자 그룹 표시 순서 수정 (up/down)
	 * @param userGroup
	 * @return
	 */
    @Transactional
	public int updateUserGroupViewOrder(UserGroup userGroup) {

    	UserGroup dbUserGroup = userGroupMapper.getUserGroup(userGroup);
    	dbUserGroup.setUpdateType(userGroup.getUpdateType());

    	Integer modifyViewOrder = dbUserGroup.getViewOrder();
    	UserGroup searchUserGroup = new UserGroup();
    	searchUserGroup.setUpdateType(dbUserGroup.getUpdateType());
    	searchUserGroup.setParent(dbUserGroup.getParent());

    	if(Move.UP == Move.valueOf(dbUserGroup.getUpdateType())) {
    		// 바로 위 메뉴의 view_order 를 +1
    		searchUserGroup.setViewOrder(dbUserGroup.getViewOrder());
    		searchUserGroup = getUserGroupByParentAndViewOrder(searchUserGroup);

    		if(searchUserGroup == null) return 0;

	    	dbUserGroup.setViewOrder(searchUserGroup.getViewOrder());
	    	searchUserGroup.setViewOrder(modifyViewOrder);
    	} else {
    		// 바로 아래 메뉴의 view_order 를 -1 함
    		searchUserGroup.setViewOrder(dbUserGroup.getViewOrder());
    		searchUserGroup = getUserGroupByParentAndViewOrder(searchUserGroup);

    		if(searchUserGroup == null) return 0;

    		dbUserGroup.setViewOrder(searchUserGroup.getViewOrder());
    		searchUserGroup.setViewOrder(modifyViewOrder);
    	}

    	updateViewOrderUserGroup(searchUserGroup);
		return updateViewOrderUserGroup(dbUserGroup);
    }

    /**
     * 부모와 표시 순서로 메뉴 조회
     * @param userGroup
     * @return
     */
    private UserGroup getUserGroupByParentAndViewOrder(UserGroup userGroup) {
    	return userGroupMapper.getUserGroupByParentAndViewOrder(userGroup);
    }

    /**
	 * 사용자 그룹 표시 순서 수정 (up/down)
	 * @param userGroup
	 * @return
	 */
	private int updateViewOrderUserGroup(UserGroup userGroup) {
		return userGroupMapper.updateUserGroupViewOrder(userGroup);
	}

	/**
	 * 사용자 그룹 삭제
	 * @param userGroup
	 * @return
	 */
    @Transactional
	public int deleteUserGroup(UserGroup userGroup) {
    	// 삭제하고, children update

    	userGroup = userGroupMapper.getUserGroup(userGroup);
    	log.info("--- 111111111 delete userGroup = {}", userGroup);

    	int result = 0;
    	if(Depth.ONE == Depth.findBy(userGroup.getDepth())) {
    		log.info("--- one ================");
    		result = userGroupMapper.deleteUserGroupByAncestor(userGroup);
    	} else if(Depth.TWO == Depth.findBy(userGroup.getDepth())) {
    		log.info("--- two ================");
    		result = userGroupMapper.deleteUserGroupByParent(userGroup);

    		UserGroup ancestorUserGroup = new UserGroup();
    		ancestorUserGroup.setUserGroupId(userGroup.getAncestor());
    		ancestorUserGroup = userGroupMapper.getUserGroup(ancestorUserGroup);
    		ancestorUserGroup.setChildren(ancestorUserGroup.getChildren() + 1);

    		log.info("--- delete ancestorUserGroup = {}", ancestorUserGroup);

	    	userGroupMapper.updateUserGroup(ancestorUserGroup);
    		// ancestor - 1
    	} else if(Depth.THREE == Depth.findBy(userGroup.getDepth())) {
    		log.info("--- three ================");
    		result = userGroupMapper.deleteUserGroup(userGroup);
    		log.info("--- userGroup ================ {}", userGroup);

    		UserGroup parentUserGroup = new UserGroup();
    		parentUserGroup.setUserGroupId(userGroup.getParent());
    		parentUserGroup = userGroupMapper.getUserGroup(parentUserGroup);
	    	log.info("--- parentUserGroup ================ {}", parentUserGroup);
	    	parentUserGroup.setChildren(parentUserGroup.getChildren() - 1);
	    	log.info("--- parentUserGroup children ================ {}", parentUserGroup);
	    	userGroupMapper.updateUserGroup(parentUserGroup);
    	} else {

    	}

    	return result;
    }

}
