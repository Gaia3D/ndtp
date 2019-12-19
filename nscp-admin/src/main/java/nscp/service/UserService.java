package nscp.service;

import java.util.List;

import nscp.domain.UserInfo;

/**
 * 사용자
 * @author jeongdae
 *
 */
public interface UserService {
	
	/**
	 * 사용자 수
	 * @param userInfo
	 * @return
	 */
	Long getUserTotalCount(UserInfo userInfo);
	
	/**
	 * 사용자 목록
	 * @param userInfo
	 * @return
	 */
	List<UserInfo> getListUser(UserInfo userInfo);
	
	
	/**
	 * 사용자 정보 취득
	 * @param userId
	 * @return
	 */
	UserInfo getUser(String userId);
	
	/**
	 * 사용자 등록
	 * @param userInfo
	 * @return
	 */
	int insertUser(UserInfo userInfo);
	
	/**
	 * 사용자 수정
	 * @param userInfo
	 * @return
	 */
	int updateUser(UserInfo userInfo);
	
	/**
	 * 사용자 상태 수정
	 * @param statusValue
	 * @param checkIds
	 * @return
	 */
	List<String> updateUserStatus(String statusValue, String checkIds);
	
	/**
	 * 사용자 삭제
	 * @param userId
	 * @return
	 */
	int deleteUser(String userId);
	
}
