package nscp.domain;

import java.io.Serializable;
import java.time.LocalDateTime;

import javax.validation.constraints.NotBlank;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class UserInfo implements Serializable {

    private static final long serialVersionUID = 8349597082356588759L;

    // 로그인 타입
    private String authenticationType;
    
    // 고유번호(사번)
    @NotBlank
    private String userId;
    @NotBlank
    private String password;

    private String mfgInd;
    // 사용자 그룹 고유번호
    private Integer userGroupId;
    // 이름
    private String userName;
    // 부서번호
    private String deptNo;
    // 부서명
    private String deptName;
    // 직급
    private String position;
    // 사용자 상태. 0:사용중, 1:사용중지(관리자), 2:잠금(비밀번호 실패횟수 초과), 3:휴면(로그인 기간), 4:만료(사용기간 종료), 5:삭제(화면 비표시, policy.user_delete_type=0), 6:임시비밀번호
    private String status;
    // 로그인 횟수
    private Integer loginCount;
    // 로그인 실패 횟수
    private Integer failLoginCount;
    // 마지막 로그인 날짜
    @JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd HH:mm:ss", timezone="Asia/Seoul")
    private LocalDateTime lastLoginDate;
    // 등록일
    @JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd HH:mm:ss", timezone="Asia/Seoul")
    private LocalDateTime insertDate;
}
