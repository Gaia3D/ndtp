package nscp.domain;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * 세션에 저장될 사용자 정보
 * @author jeongdae
 *
 */
@ToString
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class UserSession implements Serializable {

    /**
	 * 
	 */
	private static final long serialVersionUID = -9092603237488892716L;

	// 고유번호
	private String userId;
	// 사용자 그룹 고유번호
	private Long userGroupId;
	// 사용자 그룹명(화면용)
	private String userGroupName;
	// 이름
	private String userName;
	// 비밀번호
	private String password;
	// SALT(spring5부터 사용 안함)
	private String salt;
	
	// 사용자 상태. 0:사용중, 1:사용중지(관리자), 2:잠금(비밀번호 실패횟수 초과), 3:휴면(로그인 기간), 4:만료(사용기간 종료), 5:삭제(화면 비표시, policy.user_delete_method=0), 6:임시비밀번호
	private String status;
}
