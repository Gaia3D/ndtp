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
 * 사용자 업로드 정보
 * @author Cheon JeongDae
 *
 */
@ToString(callSuper = true)
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class UploadData extends Search implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 4372534009365949984L;

	public static final String ZIP_EXTENSION = "zip";
	
	// converter 대상 파일 유무. true : 대상, false : 대상아님(기본값)
	private Boolean converterTarget;
	
	/****** validator ********/
	private String methodMode;
	
	// 고유번호
	private Long uploadDataId;
	// 데이터 그룹 고유키
	private Integer dataGroupId;
	// 데이트 그룹명
	private String dataGroupName;
	// common : 공통, public : 공개, private : 개인, group : 그룹
	private String sharing;
	// 데이터 타입. 3ds,obj, dae, collada, ifc, las, citygml, indoorgml
	private String dataType;
	// 데이터명
	private String dataName;	
	// 사용자 아이디
	private String userId;
	// 사용자명
	private String userName;
	// 기본값 origin : latitude, longitude, height를 origin에 맞춤. boundingboxcenter : latitude, longitude, height를 boundingboxcenter 맞춤
	private String mappingType;
	// POINT(위도, 경도). 공간 검색 속도 때문에 altitude는 분리
	private String location;
	// 위도
	private BigDecimal latitude;
	// 경도
	private BigDecimal longitude;
	// 높이
	private BigDecimal altitude;
	// heading
	private BigDecimal heading;
	// pitch
	private BigDecimal pitch;
	// roll
	private BigDecimal roll;
	
	
	// 상태. upload : 업로딩 완료, converter : 변환
	private String status;
	// 파일 개수
	private Integer fileCount;
	// converter 변환 대상 파일 수
	private Integer converterTargetCount;
	// converter 횟수
	private Integer converterCount;
	
	// 년도
	private String year;
	// 월
	private String month;
	// 일
	private String day;
	// 일년중 몇주
	private String year_week;
	// 이번달 몇주
	private String week;
	// 시간
	private String hour;
	// 분
	private String minute;

	// 설명
	private String description;
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private String updateDate;
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Timestamp insertDate;
}
