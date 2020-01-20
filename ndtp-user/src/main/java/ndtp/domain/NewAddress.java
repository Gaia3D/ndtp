package ndtp.domain;


import java.math.BigDecimal;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString(callSuper = true)
@Setter
@Getter
public class NewAddress extends Search {

	private String fullTextSearch;

	private String newAddr;
	// 경도
	private BigDecimal longitude;
	// 위도
	private BigDecimal latitude;
	// 주소관할 읍면동 코드
	private String codeEmd;
	// 시도명
	private String knameSido;
	// 시군구명
	private String knameSgg;
	// 읍면동명
	private String knameEmd;
	// 도로명 코드
	private String nameAddr;
	// 지하여부
	private String basement;
	// 건물본번
	private Integer buildingNo1;
	// 건물부번
	private Integer buildingNo2;
	// 우편번호
	private String zipcode;
	// 건물 관리 번호
	private String buildingMno;
	// 시군구용건물명
	private String nameSggBuilding;
	// 건출물용도분류
	private String catBuilding;
	// 행정동코드
	private String codeAdm;
	// 행정동명
	private String nameAdm;
	// 지상층수
	private Integer groundFloor;
	// 지하층수
	private Integer basementFloor;
	// 공동주택구분
	private String apartment;
	// 건물수
	private Integer countBuilding;
	// 상세건물명
	private String detailBname;
	// 건물명 변경이력
	private String histBname;
	// 상세 건물명 변경이력
	private String histDetailBname;
	// 거주여부
	private String residence;
	// 건물중심점_x좌표
	private Double centerX;
	// 건물중심점_y좌표
	private Double centerY;
	// 출입구_x좌표
	private Double enteranceX;
	// 출입구_y좌표
	private Double enteranceY;
	// 시도명(영문)
	private String enameSido;
	// 시군구명(영문)
	private String enameSgg;
	// 읍면동명(영문)
	private String enameEmd;
	// 도로명(영문)
	private String enameRoad;
	// 읍면동구분
	private String isEmd;
	// 이동사유코드
	private String codeMv;
	// 기하정보
	private String geom;
}