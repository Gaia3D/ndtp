package ndtp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.slf4j.Slf4j;
import ndtp.config.PropertiesConfig;
import ndtp.domain.Depth;
import ndtp.domain.Move;
import ndtp.domain.UserDataGroup;
import ndtp.persistence.UserDataGroupMapper;
import ndtp.service.GeoPolicyService;
import ndtp.service.UserDataGroupService;
import ndtp.utils.FileUtils;

@Slf4j
@Service
public class UserDataGroupServiceImpl implements UserDataGroupService {
	
	@Autowired
	private UserDataGroupMapper userDataGroupMapper;
	@Autowired
	private GeoPolicyService geoPolicyService;
	@Autowired
	private PropertiesConfig propertiesConfig;

	/**
	 * Data Group 총건수
	 * @param userDataGroup
	 * @return
	 */
	public Long getUserDataGroupTotalCount(UserDataGroup userDataGroup) {
		return userDataGroupMapper.getUserDataGroupTotalCount(userDataGroup);
	}
	
	/**
     * 전체 데이터 그룹 목록
     * @param userDataGroup
     */
	@Transactional(readOnly = true)
	public List<UserDataGroup> getAllListUserDataGroup(UserDataGroup userDataGroup) {
		return userDataGroupMapper.getAllListUserDataGroup(userDataGroup);
	}
	
	/**
	 * 데이터 그룹 목록
	 * @param userDataGroup
	 * @return
	 */
	public List<UserDataGroup> getListUserDataGroup(UserDataGroup userDataGroup) {
		return userDataGroupMapper.getListUserDataGroup(userDataGroup);
	}
	
	/**
     * 데이터 그룹 정보 조회
     * @param userDataGroup
	 * @return
	 */
	@Transactional(readOnly = true)
	public UserDataGroup getUserDataGroup(UserDataGroup userDataGroup) {
		return userDataGroupMapper.getUserDataGroup(userDataGroup);
	}
	
	/**
     * 기본 데이터 그룹 정보 조회
     *
	 */
	@Transactional
	public UserDataGroup getBasicUserDataGroup(UserDataGroup userDataGroup) {
		String userId = userDataGroup.getUserId();
		userDataGroup = userDataGroupMapper.getBasicUserDataGroup(userDataGroup);
		if(userDataGroup == null || userDataGroup.getDataGroupName() == null) {
			
			String dataGroupPath = userId + "/basic/";
			userDataGroup = new UserDataGroup();
			
			userDataGroup.setUserId(userId);;
			userDataGroup.setDataGroupKey("basic");
			userDataGroup.setDataGroupName("기본");
			userDataGroup.setDataGroupPath(dataGroupPath);
			userDataGroup.setSharing("public");
			
			FileUtils.makeDirectoryByPath(propertiesConfig.getDataServiceDir(), dataGroupPath);
			userDataGroupMapper.insertBasicUserDataGroup(userDataGroup);
		}
		return userDataGroup;
	}
	
	/**
     * 사용자 데이터 그룹 Key 중복 확인
     * @param userDataGroup
     * @return
     */
	@Transactional(readOnly = true)
	public Boolean isDataGroupKeyDuplication(UserDataGroup userDataGroup) {
		return userDataGroupMapper.isDataGroupKeyDuplication(userDataGroup);
	}

    /**
     * 데이터 그룹 등록
     * @param userDataGroup
     * @return
     */
    @Transactional
	public int insertUserDataGroup(UserDataGroup userDataGroup) {
    	String userId = userDataGroup.getUserId();
    	UserDataGroup parentUserDataGroup = new UserDataGroup();
    	parentUserDataGroup.setUserId(userId);
    	Integer depth = 0;
    	if(userDataGroup.getParent() > 0) {
    		parentUserDataGroup.setUserDataGroupId(userDataGroup.getParent());
    		parentUserDataGroup = userDataGroupMapper.getUserDataGroup(parentUserDataGroup);
	    	depth = parentUserDataGroup.getDepth() + 1;
    	}
	    
    	// 디렉토리 생성
    	String dataGroupPath = userDataGroup.getUserId() + "/" + userDataGroup.getDataGroupKey() + "/";
    	FileUtils.makeDirectoryByPath(propertiesConfig.getDataServiceDir(), dataGroupPath);
    	userDataGroup.setDataGroupPath(dataGroupPath);
    	int result = userDataGroupMapper.insertUserDataGroup(userDataGroup);
    	
    	if(depth > 1) {
	    	// parent 의 children update
    		Integer children = parentUserDataGroup.getChildren();
    		if(children == null) children = 0;
    		children += 1;
    		parentUserDataGroup.setChildren(children);
	    	return userDataGroupMapper.updateUserDataGroup(parentUserDataGroup);
    	}
    	
    	return result;
    }
    
	/**
	 * 데이터 그룹 수정
	 * @param userDataGroup
	 * @return
	 */
    @Transactional
	public int updateUserDataGroup(UserDataGroup userDataGroup) {
    	return userDataGroupMapper.updateUserDataGroup(userDataGroup);
    }
    
    /**
	 * 데이터 그룹 표시 순서 수정. UP, DOWN
	 * @param userDataGroup
	 * @return
	 */
    @Transactional
	public int updateUserDataGroupViewOrder(UserDataGroup userDataGroup) {
    	
    	UserDataGroup dbUserDataGroup = userDataGroupMapper.getUserDataGroup(userDataGroup);
    	dbUserDataGroup.setUpdateType(userDataGroup.getUpdateType());
    	
    	Integer modifyViewOrder = dbUserDataGroup.getViewOrder();
    	UserDataGroup searchUserDataGroup = new UserDataGroup();
    	searchUserDataGroup.setUpdateType(dbUserDataGroup.getUpdateType());
    	searchUserDataGroup.setParent(dbUserDataGroup.getParent());
    	
    	if(Move.UP == Move.valueOf(dbUserDataGroup.getUpdateType())) {
    		// 바로 위 메뉴의 view_order 를 +1
    		searchUserDataGroup.setViewOrder(dbUserDataGroup.getViewOrder());
    		searchUserDataGroup = getUserDataGroupByParentAndViewOrder(searchUserDataGroup);
    		
    		if(searchUserDataGroup == null) return 0;
    		
	    	dbUserDataGroup.setViewOrder(searchUserDataGroup.getViewOrder());
	    	searchUserDataGroup.setViewOrder(modifyViewOrder);
    	} else {
    		// 바로 아래 메뉴의 view_order 를 -1 함
    		searchUserDataGroup.setViewOrder(dbUserDataGroup.getViewOrder());
    		searchUserDataGroup = getUserDataGroupByParentAndViewOrder(searchUserDataGroup);
    		
    		if(searchUserDataGroup == null) return 0;
    		
    		dbUserDataGroup.setViewOrder(searchUserDataGroup.getViewOrder());
    		searchUserDataGroup.setViewOrder(modifyViewOrder);
    	}
    	
    	updateUserDataGroupViewOrder(searchUserDataGroup);
		return updateUserDataGroupViewOrder(dbUserDataGroup);
    }
    
    /**
     * 부모와 표시 순서로 메뉴 조회
     * @param userDataGroup
     * @return
     */
    public UserDataGroup getUserDataGroupByParentAndViewOrder(UserDataGroup userDataGroup) {
    	return userDataGroupMapper.getUserDataGroupByParentAndViewOrder(userDataGroup);
    }
    
	/**
	 * 데이터 그룹 삭제
	 * @param userDataGroup
	 * @return
	 */
    @Transactional
	public int deleteUserDataGroup(UserDataGroup userDataGroup) {
    	// 삭제하고, children update
    	
    	userDataGroup = userDataGroupMapper.getUserDataGroup(userDataGroup);
    	
    	int result = 0;
    	if(Depth.ONE == Depth.findBy(userDataGroup.getDepth())) {
    		log.info("--- one ================");
    		result = userDataGroupMapper.deleteUserDataGroupByAncestor(userDataGroup);
    	} else if(Depth.TWO == Depth.findBy(userDataGroup.getDepth())) {
    		log.info("--- two ================");
    		result = userDataGroupMapper.deleteUserDataGroupByParent(userDataGroup);
    		
    		UserDataGroup ancestorUserDataGroup = new UserDataGroup();
    		ancestorUserDataGroup.setUserDataGroupId(userDataGroup.getAncestor());
    		ancestorUserDataGroup = userDataGroupMapper.getUserDataGroup(ancestorUserDataGroup);
    		ancestorUserDataGroup.setChildren(ancestorUserDataGroup.getChildren() + 1);
	    	
    		log.info("--- delete ancestorDataGroup = {}", ancestorUserDataGroup);
    		
    		userDataGroupMapper.updateUserDataGroup(ancestorUserDataGroup);
    		// ancestor - 1
    	} else if(Depth.THREE == Depth.findBy(userDataGroup.getDepth())) {
    		log.info("--- three ================");
    		result = userDataGroupMapper.deleteUserDataGroup(userDataGroup);
    		log.info("--- userDataGroup ================ {}", userDataGroup);
    		
    		UserDataGroup parentUserDataGroup = new UserDataGroup();
    		parentUserDataGroup.setUserDataGroupId(userDataGroup.getParent());
    		parentUserDataGroup = userDataGroupMapper.getUserDataGroup(parentUserDataGroup);
	    	log.info("--- parentUserDataGroup ================ {}", parentUserDataGroup);
	    	parentUserDataGroup.setChildren(parentUserDataGroup.getChildren() - 1);
	    	log.info("--- parentDataGroup children ================ {}", parentUserDataGroup);
	    	userDataGroupMapper.updateUserDataGroup(parentUserDataGroup);
    	} else {
    		
    	}
    	
    	return result;
    }

	public int deleteUserDataGroupByAncestor(UserDataGroup userDataGroup) {
		return userDataGroupMapper.deleteUserDataGroupByAncestor(userDataGroup);
	}

	public int deleteUserDataGroupByParent(UserDataGroup userDataGroup) {
		return userDataGroupMapper.deleteUserDataGroupByParent(userDataGroup);
	}
}
