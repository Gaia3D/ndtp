package nscp.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import nscp.domain.UserGroup;
import nscp.domain.UserGroupMenu;
import nscp.domain.UserGroupRole;

/**
 * 사용자 그룹
 * 
 * @author jeongdae
 *
 */
@Repository
public interface UserGroupMapper {

	/**
	 * 사용자 그룹 목록
	 * 
	 * @param userGroup
	 * @return
	 */
	List<UserGroup> getListUserGroup(UserGroup userGroup);

	/**
	 * 자식 사용자 그룹 개수
	 * 
	 * @param userGroupId
	 * @return
	 */
	int getChildUserGroupCount(Integer userGroupId);
	
	/**
	 * 사용자 그룹 정보 취득
	 * @param userGroupId
	 * @return
	 */
	UserGroup getUserGroup(Integer userGroupId);
	
	/**
	 * 사용자 그룹 정보 취득
	 * @param userId
	 * @return
	 */
	UserGroup getUserGroupByUserId(String userId);
	
	/**
	 * 사용자 그룹에 속한 자식 그룹 목록
	 * 
	 * @param parent
	 * @return
	 */
	List<Integer> getListUserGroupChild(Integer parent);
	
	/**
	 * 자식 사용자 그룹 중 순서가 최대인 사용자 그룹 검색
	 * @param userGroupId
	 * @return
	 */
	UserGroup getMaxViewOrderChildUserGroup(Integer userGroupId);
	
	/**
	 * 사용자 그룹 트리 부모와 순서로 그룹 정보 취득
	 * 
	 * @param userGroup
	 * @return
	 */
	UserGroup getUserGroupByParentAndViewOrder(UserGroup userGroup);
	
	/**
	 * 사용자 그룹 메뉴 권한 목록
	 * 
	 * @param userGroupMenu
	 * @return
	 */
	List<UserGroupMenu> getListUserGroupMenu(UserGroupMenu userGroupMenu);
	
	/**
	 * 사용자 그룹 Role 목록
	 * @param userGroupRole
	 * @return
	 */
	List<UserGroupRole> getListUserGroupRole(UserGroupRole userGroupRole);
	
	/**
	 * 사용자 그룹 Role Key 목록
	 * @param userGroupRole
	 * @return
	 */
	List<String> getListUserGroupRoleKey(UserGroupRole userGroupRole);
	
	/**
	 * 사용자 그룹 등록
	 * @param userGroup
	 * @return
	 */
	int insertUserGroup(UserGroup userGroup);
	
	/**
	 * 사용자 그룹 메뉴 등록
	 * @param userGroupMenu
	 * @return
	 */
	int insertUserGroupMenu(UserGroupMenu userGroupMenu);
	
	/**
	 * 사용자 그룹 Role 등록
	 * @param userGroupRole
	 * @return
	 */
	int insertUserGroupRole(UserGroupRole userGroupRole);
	
	/**
	 * 사용자 그룹 트리 정보 수정
	 * @param userGroup
	 * @return
	 */
	int updateUserGroup(UserGroup userGroup);
	
	/**
	 * 그룹 순서 수정
	 * 
	 * @param userGroup
	 * @return
	 */
	int updateViewOrderUserGroup(UserGroup userGroup);
	
	/**
	 * 사용자 그룹 메뉴 수정
	 * @param userGroupMenu
	 * @return
	 */
	int updateUserGroupMenu(UserGroupMenu userGroupMenu);
	
	/**
	 * 사용자 그룹 Role 수정
	 * @param userGroupRole
	 * @return
	 */
	int updateUserGroupRole(UserGroupRole userGroupRole);
	
	/**
	 * 사용자 그룹 삭제
	 * @param userGroupId
	 * @return
	 */
	int deleteUserGroup(Integer userGroupId);
	
	/**
	 * 사용자 그룹 메뉴 삭제
	 * @param userGroupId
	 * @return
	 */
	int deleteUserGroupMenu(Integer userGroupId);
	
	/**
	 * 사용자 그룹 Role 삭제
	 * @param userGroupId
	 * @return
	 */
	int deleteUserGroupRole(Integer userGroupId);
}
