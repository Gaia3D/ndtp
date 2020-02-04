package ndtp.domain;

import java.math.BigDecimal;
import java.sql.Timestamp;

import javax.validation.constraints.NotBlank;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString(callSuper = true)
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class CivilVoice extends Search {
	/**
	 * 화면 표시용
	 * 
	 */
	// 위도
	private String latitude;
	// 경도
	private String longitude;
	// 본인 게시글에 수정/삭제 표시 위해 사용 
	private Boolean editable;
	
	/**
	 * DB
	 */
	private Long civilVoiceId;
	private String userId;
	private String userIp;
	@NotBlank
	private String title;
	private String content;
	private String location;
	private BigDecimal heit;
	private Boolean useYn;
	private Long viewCount;
	private String year;
	private String month;
	private String day;
	private String yearWeek;
	private String week;
	private String hour;
	private String minute;
	private String sidoCd;
	private String sggCd;
	private String emdCd;
	
	@Getter(AccessLevel.NONE)
	@Setter(AccessLevel.NONE)
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	private Timestamp viewUpdateDt;
	
	@Getter(AccessLevel.NONE)
	@Setter(AccessLevel.NONE)
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	private Timestamp viewRegistDt;
	
	public Timestamp getViewUpdateDt() {
		return this.updateDt;
	}
	public Timestamp getViewRegistDt() {
		return this.registDt;
	}
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Timestamp updateDt;
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Timestamp registDt;
}
