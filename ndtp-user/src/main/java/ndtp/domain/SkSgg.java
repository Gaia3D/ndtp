package ndtp.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SkSgg {

	// 시도 1, 시군구 2, 읍면동 3
	private Integer layerType;
	// 고유번호
	private Long gid;
	// PK
	private String ufid;
	// 법정동 코드
	private String bjcd;
	// 시도 코드
	private String sdoCode;
	// 시군구 코드
	private String sggCode;
	// 명칭
	private String name;
	// 구분
	private String divi;
	// 통합코드
	private String scls;
	// 제작정보
	private String fmta;
	// 기하정보
	private String geom;
	// 등록일
	private String insertDate;
}