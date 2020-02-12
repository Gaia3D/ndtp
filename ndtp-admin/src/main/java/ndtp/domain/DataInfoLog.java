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
 * Data 정보 이력
 * @author Cheon JeongDae
 *
 */
@ToString(callSuper = true)
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class DataInfoLog extends Search {
	
	// 사용자명
	private String userId;
	// 수정자 아이디
	private String updateUserId;
	private String userName;
	
	/****** validator ********/
	private String methodMode;

	// 고유번호
	private Long dataLogId;
	// Data group 고유번호
	private Integer dataGroupId;
	// Data project 이름
	private String dataGroupName;
	// Data 고유번호
	private Long dataId;
	// data 고유 식별번호
	private String dataKey;
	// data 이름
	private String dataName;	
	// 데이터 타입(중복). 3ds,obj,dae,collada,ifc,las,citygml,indoorgml,etc
	private String dataType;	// TODO enum DataType
	// converter job 고유번호 
	private Long converterJobId;
	// common : 공통, public : 공개, private : 비공개, group : 그룹
	private String sharing;		// TODO enum SharingType
	/*
	 * origin(기본값) : latitude, longitude, height를 origin에 맞춤. 
	 * boundingboxcenter : latitude, longitude, height를 boundingboxcenter 맞춤
	 */
	private String mappingType;
	// 위도, 경도 정보 geometry 타입
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
	// 데이터 메타 정보. 데이터  control을 위해 인위적으로 만든 속성
	private String metainfo;
	// 변경전 위도, 경도 정보 geometry 타입
	//private String beforeLocation;
	// 변경전 위도
	//private BigDecimal beforeLatitude;
	// 변경전 경도
	//private BigDecimal beforeLongitude;
	// 변경전 높이
	//private BigDecimal beforeAltitude;
	// 변경전 heading
	//private BigDecimal beforeHeading;
	// 변경전 pitch
	//private BigDecimal beforePitch;
	// 변경전 roll
	//private BigDecimal beforeRoll;
	// 상태. request : 요청, approval : 승인, reject : 기각, rollback : 원복
	//private String status;
	// status 의 ajax 처리 값
	//private String statusLevel;
	// 변경 타입
	private String changeType;
	// 설명
	private String description;
	// 수정일 
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Timestamp updateDate;
	// 등록일
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Timestamp insertDate;
	
	public String validate() {
		// TODO 구현해야 한다.
		return null;
	}
	
	public DataInfoLog(DataInfo dataInfo) {
		this.dataGroupId = dataInfo.getDataGroupId();
		this.dataId = dataInfo.getDataId();
		this.dataKey = dataInfo.getDataKey();
		this.dataName = dataInfo.getDataName();
		this.dataType = dataInfo.getDataType();
		this.converterJobId = dataInfo.getConverterJobId();
		this.sharing = dataInfo.getSharing();
		this.userId = dataInfo.getUserId();
		this.mappingType = dataInfo.getMappingType();
		this.longitude = dataInfo.getLongitude();
		this.latitude = dataInfo.getLatitude();
		this.altitude = dataInfo.getAltitude();
		if (longitude != null && latitude != null) {
			this.location = "POINT(" + longitude + " " + latitude + ")";
		}
		this.metainfo = dataInfo.getMetainfo();
	}
	
	public void convertDto() {
		this.sharing = SharingType.valueOf(this.sharing.toUpperCase()).getSharing();
		this.changeType = MethodType.valueOf(this.changeType.toUpperCase()).getMethod();
	}
	
}
