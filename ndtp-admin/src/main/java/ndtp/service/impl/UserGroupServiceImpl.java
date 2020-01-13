package ndtp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ndtp.domain.UserGroup;
import ndtp.domain.UserGroupMenu;
import ndtp.domain.UserGroupRole;
import ndtp.domain.YOrN;
import ndtp.persistence.UserGroupMapper;
import ndtp.service.UserGroupService;

/**
 * 사용자 그룹
 * @author jeongdae
 *
 */
@Service
public class UserGroupServiceImpl implements UserGroupService {

	@Autowired
	private UserGroupMapper userGroupMapper;
	
	/**
	 * 사용자 그룹 목록
	 * @param userGroup
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<UserGroup> getListUserGroup(UserGroup userGroup) {
		return userGroupMapper.getListUserGroup(userGroup);
	}
	
	/**
	 * 자식 사용자 그룹 개수
	 * 
	 * @param userGroupId
	 * @return
	 */
	@Transactional(readOnly=true)
	public int getChildUserGroupCount(Integer userGroupId) {
		return userGroupMapper.getChildUserGroupCount(userGroupId);
	}
	
	/**
	 * 사용자 그룹 정보 취득
	 * @param userGroupId
	 * @return
	 */
	@Transactional(readOnly=true)
	public UserGroup getUserGroup(Integer userGroupId) {
		return userGroupMapper.getUserGroup(userGroupId);
	}
	
	/**
	 * 사용자 그룹 정보 취득
	 * @param userId
	 * @return
	 */
	@Transactional(readOnly=true)
	public UserGroup getUserGroupByUserId(String userId) {
		return userGroupMapper.getUserGroupByUserId(userId);
	}
	
	/**
	 * 자식 사용자 그룹 중 순서가 최대인 사용자 그룹 검색
	 * @param userGroupId
	 * @return
	 */
	@Transactional(readOnly=true)
	public UserGroup getMaxViewOrderChildUserGroup(Integer userGroupId) {
		return userGroupMapper.getMaxViewOrderChildUserGroup(userGroupId);
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
		return userGroupMapper.insertUserGroup(userGroup);
	}
	
	/**
	 * 사용자 그룹 트리 정보 수정
	 * @param userGroup
	 * @return
	 */
	@Transactional
	public int updateUserGroup(UserGroup userGroup) {
		return userGroupMapper.updateUserGroup(userGroup);
	}
	
	/**
	 * 사용자 그룹 트리 순서 수정, up, down
	 * @param userGroup
	 * @return
	 */
	@Transactional
	public int updateMoveTreeUserGroup(UserGroup userGroup) {
		Integer modifyViewOrder = userGroup.getViewOrder();
		UserGroup searchUserGroup = new UserGroup();
		searchUserGroup.setUpdateType(userGroup.getUpdateType());
		searchUserGroup.setParent(userGroup.getParent());
		
		if ("up".equals(userGroup.getUpdateType())) {
			// 바로 위 메뉴의 view_order 를 +1
			searchUserGroup.setViewOrder(userGroup.getViewOrder());
			searchUserGroup = getUserGroupByParentAndViewOrder(searchUserGroup);
			userGroup.setViewOrder(searchUserGroup.getViewOrder());
			searchUserGroup.setViewOrder(modifyViewOrder);
		} else {
			// 바로 아래 메뉴의 view_order 를 -1 함
			searchUserGroup.setViewOrder(userGroup.getViewOrder());
			searchUserGroup = getUserGroupByParentAndViewOrder(searchUserGroup);
			userGroup.setViewOrder(searchUserGroup.getViewOrder());
			searchUserGroup.setViewOrder(modifyViewOrder);
		}
		updateViewOrderUserGroup(searchUserGroup);
		
		return updateViewOrderUserGroup(userGroup);
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
	 * 
	 * @param userGroup
	 * @return
	 */
	private int updateViewOrderUserGroup(UserGroup userGroup) {
		return userGroupMapper.updateViewOrderUserGroup(userGroup);
	}
	
	/**
	 * 사용자 그룹 메뉴 수정
	 * @param userGroupMenu
	 * @return
	 */
	@Transactional
	public int updateUserGroupMenu(UserGroupMenu userGroupMenu) {
		Integer userGroupId = userGroupMenu.getUserGroupId();
		
		userGroupMapper.deleteUserGroupMenu(userGroupId);
		
		String[] allYnValues = userGroupMenu.getAllYn().split(",");
		String[] readYnValues = userGroupMenu.getReadYn().split(",");
		String[] writeYnValues = userGroupMenu.getWriteYn().split(",");
		String[] updateYnValues = userGroupMenu.getUpdateYn().split(",");
		String[] deleteYnValues = userGroupMenu.getDeleteYn().split(",");
		
		int totalCount = allYnValues.length;
		for(int i=0; i<totalCount; i++) {
			boolean insertFlag = false;
			String[] allValues = allYnValues[i].split("_");
			String[] readValues = readYnValues[i].split("_");
			String[] writeValues = writeYnValues[i].split("_");
			String[] updateValues = updateYnValues[i].split("_");
			String[] deleteValues = deleteYnValues[i].split("_");
			
			
			UserGroupMenu tempUserGroupMenu = new UserGroupMenu();
			tempUserGroupMenu.setUserGroupId(userGroupId);
			tempUserGroupMenu.setMenuId(Integer.valueOf(allValues[0]));
			
			if(allValues.length == 2 && YOrN.Y.name().equals(allValues[1])) {
				tempUserGroupMenu.setAllYn(allValues[1]);
				insertFlag = true;
			}
			if(readValues.length == 2 && YOrN.Y.name().equals(readValues[1])) {
				tempUserGroupMenu.setReadYn(readValues[1]);
				insertFlag = true;
			}
			if(writeValues.length == 2 && YOrN.Y.name().equals(writeValues[1])) {
				tempUserGroupMenu.setWriteYn(writeValues[1]);
				insertFlag = true;
			}
			if(updateValues.length == 2 && YOrN.Y.name().equals(updateValues[1])) {
				tempUserGroupMenu.setUpdateYn(updateValues[1]);
				insertFlag = true;
			}
			if(deleteValues.length == 2 && YOrN.Y.name().equals(deleteValues[1])) {
				tempUserGroupMenu.setDeleteYn(deleteValues[1]);
				insertFlag = true;
			}
			
			if(insertFlag) userGroupMapper.insertUserGroupMenu(tempUserGroupMenu);
		}
		
		return totalCount;
	}
	
	/**
	 * 사용자 그룹 Role 수정
	 * @param userGroupRole
	 * @return
	 */
	@Transactional
	public int updateUserGroupRole(UserGroupRole userGroupRole) {
		Integer userGroupId = userGroupRole.getUserGroupId();
		
		userGroupMapper.deleteUserGroupRole(userGroupId);
		
		String[] roleIds = userGroupRole.getCheckIds().split(",");
		for(String roleId : roleIds) {
			UserGroupRole tempUserGroupRole = new UserGroupRole();
			tempUserGroupRole.setUserGroupId(userGroupId);
			tempUserGroupRole.setRoleId(Integer.valueOf(roleId));
			userGroupMapper.insertUserGroupRole(tempUserGroupRole);
		}
		
		return roleIds.length;
	}
	
	/**
	 * 사용자 그룹 삭제
	 * @param userGroupId
	 * @return
	 */
	@Transactional
	public int deleteUserGroup(Integer userGroupId) {
		return deleteUserGroupList(userGroupId);
	}
	
	/**
	 * 사용자 그룹 삭제 메소드
	 * @param userGroupId
	 * @return
	 */
	@Transactional
	public int deleteUserGroupList(Integer userGroupId) {
		// 자식 목록 리스트
		List<Integer> childUserGroupIdList = userGroupMapper.getListUserGroupChild(userGroupId);
		
		if(childUserGroupIdList != null && !childUserGroupIdList.isEmpty()) {
			for(Integer childUserGroupId : childUserGroupIdList) {
				deleteUserGroup(childUserGroupId);
			}
		}
		
		userGroupMapper.deleteUserGroupMenu(userGroupId);
		userGroupMapper.deleteUserGroupRole(userGroupId);
		return userGroupMapper.deleteUserGroup(userGroupId);
	}
}
