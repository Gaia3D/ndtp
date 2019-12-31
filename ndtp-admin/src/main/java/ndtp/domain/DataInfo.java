package ndtp.domain;

import java.io.Serializable;
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
 * Data 정보
 * @author Cheon JeongDae
 *
 */
@ToString
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class DataInfo extends Search implements Serializable {
	
	private static final long serialVersionUID = 6267402319518438249L;
	
	/******** 화면 오류 표시용 ********/
	private String messageCode;
	private String errorCode;
	// 아이디 중복 확인 hidden 값
	private String duplicationValue;
	
	// 위도
	private BigDecimal latitude;
	// 경도
	private BigDecimal longitude;
	
	// 사용자명
	private String userId;
	private String userName;
	
	/****** validator ********/
	private String methodMode;

	// 고유번호
	private Long dataId;
	// Data Group 고유번호
	private Integer dataGroupId;
	// Data Group 이름
	private String dataGroupName;
	// data 고유 식별번호
	private String dataKey;
	// data 고유 식별번호
	private String oldDataKey;
	// data 이름
	private String dataName;
	// common : 공통, public : 공개, private : 개인, group : 그룹
	private String sharedType;
	// 부모 고유번호
	private Long parent;
	// 부모 이름(화면 표시용)
	private String parent_name;
	
	// origin : latitude, longitude, height 를 origin에 맟춤. boundingboxcenter : latitude, longitude, height 를 boundingboxcenter에 맟춤.
	private String mapping_type;

	// POINT(위도, 경도). 공간 검색 속도 때문에 altitude는 분리
	private String location;
	// 높이
	private BigDecimal altitude;
	// heading
	private BigDecimal heading;
	// pitch
	private BigDecimal pitch;
	// roll
	private BigDecimal roll;
	// Data Control 속성
	private String attributes;
	// data 상태. 0:사용중, 1:사용중지(관리자), 2:삭제(화면 비표시)
	private String status;
	// 설명
	private String description;
	// 수정일 
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Timestamp update_date;
	// 등록일
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Timestamp insert_date;
	
	public String getViewAttributes() {
		if(this.attributes == null || "".equals( attributes) || attributes.length() < 20) {
			return attributes;
		}
		return attributes.substring(0, 20) + "...";
	}
}
