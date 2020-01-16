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

@ToString
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class UserPolicy implements Serializable {

	private static final long serialVersionUID = -6548874769672071277L;

	// 고유 번호
	private Integer userPolicyId;
	// 사용자 아이디
	private String userId;
	// 객체 정보 표시 여부
	private Boolean datainfoDisplay;
	// Origin 정보 표시 여부
	private Boolean originDisplay;
	// bbox 표시 여부
	private Boolean bboxDisplay;
	private String lod0;
	private String lod1;
	private String lod2;
	private String lod3;
	private String lod4;
	private String lod5;
	// 그림자 반경 
	private String ssaoRadius;
	
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Timestamp updateDate;

	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Timestamp insertDate;

}
