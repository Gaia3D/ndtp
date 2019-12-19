package nscp.domain;

import java.time.LocalDateTime;

import javax.validation.constraints.NotBlank;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * Role
 * @author jeongdae
 *
 */
@ToString
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Role {
	
	private Search search;

	/****** validator ********/
	private String methodMode;
	
	// 고유번호
	private Integer roleId;
	// Role 명
	@NotBlank
	private String roleName;
	// Role KEY
	@NotBlank
	private String roleKey;
	// Role 타켓. 0 : 사용자 사이트, 1 : 관리자  사이트, 2 : 서버
	private String roleTarget;
	// 업무 유형. 0 : 사용자, 1 : 서버, 3 : api
	private String roleType;
	// 사용유무. Y : 사용, N : 사용안함
	private String useYn;
	// 기본 사용유무. Y : 사용, N : 사용안함
	private String defaultYn;
	// 설명
	private String description;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd HH:mm:ss", timezone="Asia/Seoul")
	private LocalDateTime insertDate;
	
//	public String getViewInsertDate() {
//		if(getInsertDate() == null) {
//			return "";
//		}
//		
//		String tempDate = FormatUtil.getViewDateyyyyMMddHHmmss(getInsertDate());
//		return tempDate.substring(0, 19);
//	}
}
