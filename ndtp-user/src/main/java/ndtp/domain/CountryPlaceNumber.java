package ndtp.domain;

import java.math.BigDecimal;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
public class CountryPlaceNumber extends Search {

	private String fullTextSearch;

	// 국가지점번호(화면 표시)
	private String countryPlaceNumber;
	// 경도
	private BigDecimal longitude;
	// 위도
	private BigDecimal latitude;
	// 고유번호
	private long gid;
	// 지점 번호 위치
	private String geom;
	// 시군구 코드
	private String sggCd;
	// 읍면동 코드
	private String emdCd;
	// 리 코드
	private String liCd;
	// 지점 순번
	private Long spoFclCd;
	// 지점 번호 코드(통합검색 키워드)
	private String spoNoCd;
	// 지점명 코드 순번
	private String insFclSn;
	// 지점명(통합검색 키워드)
	private String fcltylcNm;
	// GRS80 X
	private Double grs80X;
	// GRS80 Y
	private Double grs80Y;
	// 경도
	private Double lon;
	// 위도
	private Double lat;
	// 갱신일
	private String spoInsDate;
}