package ndtp.domain;

import java.sql.Timestamp;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * 사용자 그룹별 Role
 * @author jeongdae
 *
 */
@ToString
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class UserGroupRole {
	
	/****** validator ********/
	private String methodMode;
	
	// 사용자ID
	private String userId;
	// check role_id
	private String checkIds;
	
	// 고유번호
	private Integer userGroupRoleId;
	// 사용자 그룹 고유키
	private Integer userGroupId;
	// Role 고유키
	private Integer roleId;
	// Role 명
	private String roleName;
	// Role KEY
	private String roleKey;
	// Role 타켓. 0 : 사용자 페이지, 1 : 관리자  페이지, 2 : 서버
	private String roleTarget;
	// Role 업무 유형. 0 : 사용자, 1 : 서버, 3 : api
	private String roleType;
	// 사용유무. Y : 사용, N : 사용안함
	private String useYn;
	// 기본사용 유무. Y : 사용, N : 사용안함
	private String defaultYn;
	// 설명
	private String description;
	// 등록일
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Timestamp insertDate;
	
//	public String getViewInsertDate() {
//		if(getInsertDate() == null) {
//			return "";
//		}
//		
//		String tempDate = FormatUtil.getViewDateyyyyMMddHHmmss(getInsertDate());
//		return tempDate.substring(0, 19);
//	}
}
