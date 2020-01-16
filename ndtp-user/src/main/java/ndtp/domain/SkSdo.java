package ndtp.domain;

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
public class SkSdo {

	// 시도 1, 시군구 2, 읍면동 3
	private Integer layerType;
	// 고유번호
	private Integer ogcFid;
	// PK
	private String ufid;
	// 법정동 코드
	private String bjcd;
	// 시도 코드
	private String sdoCode;
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