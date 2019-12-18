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

	public static final String KEY = "userSession";

    public static final String MOBILE = "MOBILE";
    public static final String TABLET = "TABLET";
    public static final String PC = "PC";

    private String userPw;
    private String mfgInd;
    private String userAgent;

    private UserPolicy userPolicy;

    /******** 화면 오류 표시용 ********/
    private String errorCode;
    /******* 세션 하이재킹 체크 *******/
    private String loginIp;

    private String userId;
    private String empNo;
    private String korNm;
    private String engNm;
    private String asgnCd;
    private String deptCd;
    private String jotTitNm;
    private String offNm;
    private String deptNm;
    private String respCd;
    private String respNm;
    private String userPwd;
    private String offiTel;
    private String deptname;

    // 사용자 그룹명
    private String userGroupName;


    /********** DB 사용 *************/
    // 고유번호
    // 사용자 그룹 고유번호
    private Integer userGroupId;
    // 이름
    private String userName;
    // 비밀번호
    private String password;
}
