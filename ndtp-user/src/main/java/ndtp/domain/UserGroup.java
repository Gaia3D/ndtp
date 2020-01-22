package ndtp.domain;

import java.sql.Timestamp;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import ndtp.utils.FormatUtils;

/**
 * 사용자 그룹
 * @author jeongdae
 *
 */
@ToString
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class UserGroup {
	
	// 임시 그룹
	public static final Integer GUEST = 6;
	public static final Integer TEMP = 7;
	
	/****** 화면 표시용 *******/
	private String open;
	private String nodeType;
	private String parentName;
	private Integer userCount;
	// up : 위로, down : 아래로
	private String updateType;

	/****** validator ********/
	private String methodMode;

	// 고유번호
	private Integer userGroupId;
	// 링크 활용 등을 위한 확장 컬럼
	private String userGroupKey;
	// 그룹명
	private String userGroupName;
	// 부서번호
	private String deptNo;
	// 부서명
	private String deptName;
	// 조상 고유번호
	private String ancestor;
	// 부모 고유번호
	private Integer parent;
	// 깊이
	private Integer depth;
	// 나열 순서
	private Integer viewOrder;
	// 기본 사용 삭제불가, Y : 기본, N : 선택
	private String defaultYn;
	// 사용유무, Y : 사용, N : 사용안함
	private String useYn;
	private String viewUseYn;
	// 자식 존재 유무, Y : 존재, N : 존재안함(기본)
	private String childYn;
	// 설명
	private String description;
	
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Timestamp updateDate;
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Timestamp insertDate;
	
	public String getViewInsertDate() {
		if(getInsertDate() == null) {
			return "";
		}
		
		String tempDate = FormatUtils.getViewDateyyyyMMddHHmmss(getInsertDate());
		return tempDate.substring(0, 19);
	}
}
