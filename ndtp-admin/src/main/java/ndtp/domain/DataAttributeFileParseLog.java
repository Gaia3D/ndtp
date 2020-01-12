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
 * 파일 파싱 이력
 * @author jeongdae
 *
 */
@ToString
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class DataAttributeFileParseLog {
	
	// 데이터 파싱 로그
	public static final String FILE_PARSE_LOG = "0";
	// 데이터 파싱 후 DB Insert 로그
	public static final String DB_INSERT_LOG = "1";
	// 한 row 파싱 성공
	public static final String EXCEL_PARSE_SUCCESS = "0";
	// 한 row 파싱 실패
	public static final String EXCEL_PARSE_FAIL = "1";
	
	// 고유번호
	private Long fileParseLogId;
	// 파일 정보 고유번호
	private Long fileInfoId;
	// 식별자 값
	private String identifierValue;
	// validation
	private String errorCode;
	// 로그 타입 0: 파일, 1: insert
	private String logType;
	// 상태. 0: success, 1: error
	private String status; 
	
	// 등록일
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Timestamp insertDate;
}
