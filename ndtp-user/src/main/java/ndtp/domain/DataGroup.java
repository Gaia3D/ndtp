package ndtp.domain;

import java.math.BigDecimal;
import java.sql.Timestamp;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * 데이터 그룹
 * @author Cheon JeongDae
 *
 */
@ToString
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class DataGroup {

	/****** 화면 표시용 *******/
	private String parentName;
	// up : 위로, down : 아래로
	private String updateType;
	// 위도
	private BigDecimal latitude;
	// 경도
	private BigDecimal longitude;
	
	/****** validator ********/
	private String methodMode;
	
	// 아이디 중복 확인 hidden 값
	private String duplicationValue;

	// 고유번호
	private Integer dataGroupId;
	// 링크 활용 등을 위한 확장 컬럼
	private String dataGroupKey;
	// old 고유 식별번호
	private String oldDataGroupKey;
	// 그룹명
	private String dataGroupName;
	// 서비스 경로
	private String dataGroupPath;
	// 공유 타입. common : 공통, public : 공개, private : 개인, group : 그룹
	private String sharing;
	// 사용자명
	private String userId;
	private String userName;
	
	// 조상
	private Integer ancestor;
	// 부모
	private Integer parent;
	// 깊이
	private Integer depth;
	// 순서
	private Integer viewOrder;
	// 자식 존재 유무
	private Integer children;
	
	// true : 기본, false : 선택
	private Boolean basic;
	// true : 사용, false : 사용안함
	private Boolean available;
	
	// 데이터 총 건수
	private Integer dataCount;
	
	// POINT(위도, 경도). 공간 검색 속도 때문에 altitude는 분리
	private String location;
	// 높이
	private BigDecimal altitude;
	
	// Map 이동시간
	private Integer duration;
	// 데이터 그룹 메타 정보. 그룹 control을 위해 인위적으로 만든 속성
	private String metainfo;
	// 설명
	private String description;
	// 수정일
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Timestamp updateDate;
	// 등록일
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Timestamp insertDate;
}
