package ndtp.service;

import java.util.List;

import ndtp.domain.UserDataGroup;

public interface UserDataGroupService {
	
	/**
	 * 사용자 Data Group 총건수
	 * @param userDataGroup
	 * @return
	 */
	Long getUserDataGroupTotalCount(UserDataGroup userDataGroup);

	/**
     * 사용자 데이터 그룹 전체 목록
     * @return
     */
    List<UserDataGroup> getAllListUserDataGroup(UserDataGroup userDataGroup);
    
    /**
     * 사용자 데이터 그룹 목록
     * @return
     */
    List<UserDataGroup> getListUserDataGroup(UserDataGroup userDataGroup);
    
    /**
     * 사용자 데이터 정보 조회
     * @param userDataGroup
     * @return
     */
    UserDataGroup getUserDataGroup(UserDataGroup userDataGroup);
    
    /**
     * 기본 사용자  데이터 그룹 정보 조회
     * @param userDataGroup
     * @return
     */
    UserDataGroup getBasicUserDataGroup(UserDataGroup userDataGroup);
    
    /**
     * 부모와 표시 순서로 메뉴 조회
     * @param userDataGroup
     * @return
     */
    UserDataGroup getUserDataGroupByParentAndViewOrder(UserDataGroup userDataGroup);
    
    /**
     * 사용자 데이터 그룹 Key 중복 확인
     * @param userDataGroup
     * @return
     */
    Boolean isDataGroupKeyDuplication(UserDataGroup userDataGroup);

    /**
     * 사용자 데이터 그룹 등록
     * @param userDataGroup
     * @return
     */
    int insertUserDataGroup(UserDataGroup userDataGroup);
    
	/**
	 * 사용자 데이터 그룹 수정
	 * @param userDataGroup
	 * @return
	 */
	int updateUserDataGroup(UserDataGroup userDataGroup);
	
	/**
	 * 사용자 데이터 그룹 표시 순서 수정. UP, DOWN
	 * @param userDataGroup
	 * @return
	 */
	int updateUserDataGroupViewOrder(UserDataGroup userDataGroup);
    
	/**
	 * 사용자 데이터 그룹 삭제
	 * @param userDataGroup
	 * @return
	 */
	int deleteUserDataGroup(UserDataGroup userDataGroup);
	
	/**
	 * ancestor를 이용하여 사용자 데이터 그룹 삭제
	 * @param userDataGroup
	 * @return
	 */
	int deleteUserDataGroupByAncestor(UserDataGroup userDataGroup);
	
	/**
	 * parent를 이용하여 사용자 데이터 그룹 삭제
	 * @param userDataGroup
	 * @return
	 */
	int deleteUserDataGroupByParent(UserDataGroup userDataGroup);
}
