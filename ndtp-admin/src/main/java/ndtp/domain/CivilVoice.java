package ndtp.domain;

import java.io.Serializable;
import java.sql.Timestamp;

import javax.validation.constraints.NotBlank;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 *
 * @author kimhj
 *
 */
@ToString(callSuper = true)
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class CivilVoice extends Search implements Serializable {

    /**
	 *
	 */
	private static final long serialVersionUID = -7636814381604940705L;

	/******** 화면 오류 표시용 ********/
	private String messageCode;
	private String errorCode;


	/********** DB 사용 *************/
    // 고유번호
	private Integer civilVoiceId;
    // 사용자 아이디
	private String userId;
	// 제목
	@NotBlank
	private String title;
	// 내용
	private String contents;
	// 위치
	private String location;
	// 높이
	private Float altitude;
	// 사용유무
	private Boolean available;
	// 사용자 IP
	private String clientIp;
	// 조회수
	private Integer viewCount;
	// 년
	private String year;
	// 월
	private String month;
	// 일
	private String day;
	// 일년 중 몇주
	private String yearWeek;
	// 이번 달 몇주
	private String week;
	// 시간
	private String hour;
	// 분
	private String minute;
	// 시도 코드
	private String sidoCd;
	// 시군구 코드
	private String sggCd;
	// 읍면동 코드
	private String emdCd;
	// 등록일
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Timestamp insertDate;
	// 수정일
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Timestamp updateDate;


}
