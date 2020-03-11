package ndtp.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import ndtp.domain.CacheManager;
import ndtp.domain.RoleKey;
import ndtp.domain.UserInfo;
import ndtp.domain.UserStatus;
import ndtp.persistence.UserMapper;
import ndtp.service.DataGroupService;
import ndtp.service.DataService;
import ndtp.service.UserService;
import ndtp.support.PasswordSupport;
import ndtp.support.RoleSupport;

/**
 * 사용자
 * @author jeongdae
 *
 */
@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserMapper userMapper;
	@Autowired
	private DataService dataService;
	@Autowired
	private DataGroupService dataGroupService;

	/**
	 * 사용자 수
	 * @param userInfo
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getUserTotalCount(UserInfo userInfo) {
		return userMapper.getUserTotalCount(userInfo);
	}

	/**
	 * 사용자 목록
	 * @param userInfo
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<UserInfo> getListUser(UserInfo userInfo) {
		return userMapper.getListUser(userInfo);
	}
	
	/**
	 * getListUserByGroupId
	 */
	@Transactional(readOnly=true)
	public List<String> getListUserByGroupId(Integer userGroupId) {
		return userMapper.getListUserByGroupId(userGroupId);
	}

	/**
	 * 사용자 정보 취득
	 * @param userId
	 * @return
	 */
	@Transactional(readOnly=true)
	public UserInfo getUser(String userId) {
		return userMapper.getUser(userId);
	}

    /**
     * 사용자 ID 중복 체크
     * @param userInfo
     * @return
     */
	@Transactional(readOnly = true)
	public Boolean isUserIdDuplication(UserInfo userInfo) {
		return userMapper.isUserIdDuplication(userInfo);
	}

	/**
	 * 사용자 등록
	 * @param userInfo
	 * @return
	 */
	@Transactional
	public int insertUser(UserInfo userInfo) {
		userInfo.setPassword(PasswordSupport.encodePassword(userInfo.getPassword()));
		return userMapper.insertUser(userInfo);
	}

	/**
	 * 사용자 수정
	 * @param userInfo
	 * @return
	 */
	@Transactional
	public int updateUser(UserInfo userInfo) {
		// TODO 환경 설정 값을 읽어 와서 update 할 건지, delete 할건지 분기를 타야 함
		userInfo.setPassword(PasswordSupport.encodePassword(userInfo.getPassword()));
		return userMapper.updateUser(userInfo);
	}

	/**
	 * 사용자 상태 수정
	 * @param status_value
	 * @param check_ids
	 * @return
	 */
	@Transactional
	public List<String> updateUserStatus(String statusValue, String checkIds) {

		List<String> result = new ArrayList<>();
		String[] userIds = checkIds.split(",");

		for(String userId : userIds) {
			if(StringUtils.isEmpty(userId)) continue;

			UserInfo userInfo = new UserInfo();
			userInfo.setUserId(userId);
			if("LOCK".equals(statusValue)) {
				userInfo.setStatus(UserStatus.FORBID.getValue());
			} else if("UNLOCK".equals(statusValue)) {
				userInfo.setFailSigninCount(0);
				userInfo.setStatus(UserStatus.USE.getValue());
			}
			userMapper.updateUserStatus(userInfo);
		}

		return result;
	}
	
	/**
	 * 사용자 비밀번호 수정
	 * @param userInfo
	 * @return
	 */
	@Transactional
	public int updatePassword(UserInfo userInfo) {
		userInfo.setPassword(PasswordSupport.encodePassword(userInfo.getPassword()));
		return userMapper.updatePassword(userInfo);
	}

	/**
	 * 사용자 삭제
	 * @param userId
	 * @return
	 */
	@Transactional
	public int deleteUser(String userId) {
		UserInfo userInfo = userMapper.getUser(userId);
//		userInfo.setStatus(UserStatus.LOGICAL_DELETE.getValue());
		List<String> userGroupRoleKeyList = CacheManager.getUserGroupRoleKeyList(userInfo.getUserGroupId());
		// 사용자 관리 권한이 없는 사용자일 경우 data, datagroup 삭제
		if(!RoleSupport.isUserGroupRoleValid(userGroupRoleKeyList, RoleKey.ADMIN_USER_MANAGE.name())) {
 			dataService.deleteDataByUserId(userId);
 			dataGroupService.deleteDataGroupByUserId(userId);
		} 
		// TODO user_id 참조하는 모든 테이블 삭제는 추후에..
		/*
		access_log 
		tn_civil_voice
		tn_civil_voice_comment
		converter_job
		converter_job_file
		data_adjust_log
		data_attribute_file_info
		data_object_attribute_file_info
		data_file_info
		data_info_log
		issue
		upload_data_file
		user_device
		user_policy
		user_info
		*/
 
//		Policy policy = policyService.getPolicy();
//		String userDeleteType = policy.getUser_delete_type();

//		int result = 0;
//		UserInfo userInfo = userMapper.getUser(userId);
//		if((Policy.LOGICAL_DELETE_USER).equals(userDeleteType)) {
//			// 논리적 정보 삭제
//			userInfo.setStatus(UserInfo.STATUS_LOGICAL_DELETE);
//			result = userMapper.updateUser(userInfo);
//		} else if((Policy.PHYSICAL_DELETE_USER).equals(userDeleteType)) {
//			// 물리적 정보 삭제
//			result = userMapper.deleteUser(user_id);
//		} else {
//			result = 0;
//		}
		// TODO 사용자는 삭제하지 않고 논리적인 삭제 상태로 변경
//		return userMapper.updateUser(userInfo);
		return userMapper.deleteUser(userId);
	}
}
