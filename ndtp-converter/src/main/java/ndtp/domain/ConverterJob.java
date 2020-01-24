package ndtp.domain;

import java.io.Serializable;
import java.sql.Timestamp;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * f4d converter 변환 job
 * @author jeongdae
 *
 */
@ToString
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ConverterJob implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 3901358416749962840L;
	
	/**
	 * F4D 변환 대상 업로딩 목록. uploadDataId 를 ,로 연결
	 */
	private String converterCheckIds;
	
	// job에 포함된 변환 파일 갯수
	private Integer converterFileCount;
	private Long converterJobFileId;
	
	/****** validator ********/
	private String methodMode;
	
	// Primary Key
	private Long converterJobId;
	// 업로드 고유키
	private Long uploadDataId;
	// 사용자 고유번호
	private String userId;
	// title
	private String title;
	// 변환 유형. basic : 기본, building : 빌딩, extra-big-building : 초대형 빌딩, single-realistic-mesh : 단일 point cloud 데이터, splitted-realistic-mesh : 분할 point cloud 데이터
	private String converterTemplate;
	// 대상 file 개수
	private Integer fileCount;
	// 상태. ready : 준비, success : 성공, waiting : 승인대기, fail : 실패
	private String status;
	// 에러 코드
	private String errorCode;
	
	// 년도
	private String year;
	// 월
	private String month;
	// 일
	private String day;
	// 일년중 몇주
	private String yearWeek;
	// 이번달 몇주
	private String week;
	// 시간
	private String hour;
	// 분
	private String minute;
	
	// 수정일 
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private String updateDate;
	// 등록일
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Timestamp insertDate;
}
