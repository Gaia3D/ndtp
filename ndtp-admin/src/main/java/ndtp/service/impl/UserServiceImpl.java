package ndtp.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ndtp.domain.UserInfo;
import ndtp.domain.UserStatus;
import ndtp.persistence.UserMapper;
import ndtp.service.UserService;

/**
 * 사용자
 * @author jeongdae
 *
 */
@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserMapper userMapper;

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
			if(userId == null || "".equals(userId)) continue;

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
	 * 사용자 삭제
	 * @param userId
	 * @return
	 */
	@Transactional
	public int deleteUser(String userId) {
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

		return userMapper.deleteUser(userId);
	}
}
