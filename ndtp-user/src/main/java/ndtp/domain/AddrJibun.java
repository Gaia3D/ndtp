package ndtp.domain;

import java.math.BigDecimal;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString(callSuper = true)
@Setter
@Getter
public class AddrJibun extends Search {
	
	private String fullTextSearch;
	
	// 지번 주소(화면 표시)
	private String jibunAddr;
	// 경도
    private BigDecimal longitude;
	// 위도
    private BigDecimal latitude;
	// 법정동코드
	private String codeLaw;
	// 시도명
	private String knameSido;
	// 시군구명
	private String knameSgg;
	// 읍면동명
	private String knameEmd;
	// 리명
	private String knameLi;
	// 산여부
	private String isMnt;
	// 지번본번
	private String jibunNo1;
	// 지번부번
	private String jibunNo2;
	// 도로명코드
	private String codeAddr;
	// 지하여부
	private String basement;
	// 건물본번
	private Integer buildingNo1;
	// 건물부번
	private Integer buildingNo2;
	// 지번일련번호
	private String jibunSeq;
	// 시도명(영문)
	private String enameSido;
	// 시군구명(영문)
	private String enameSgg;
	// 읍면동명(영문)
	private String enameEmd;
	// 리명(영문)
	private String enameLi;
	// 
	private String codeMv;
	// 건물관리 번호
	private String buildingMno;
	// 주소 관할 읍면동 코드
	private String codeEmd;
}
