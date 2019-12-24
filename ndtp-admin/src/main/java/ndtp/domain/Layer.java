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
 * 레이어
 * @author Cheon JeongDae
 *
 */
@ToString
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Layer implements Serializable {

    /**
    * 레이어 목록 표시
    */
    private static final long serialVersionUID = -4668268071028609827L;

    // 경도
    private String longitude;
    // 위도
    private String latitude;
    // POINT
    private String point;
    
    // 리스트 펼치기
    @Builder.Default
    private String open = "open";
    // 계층 타입
    @Builder.Default
    private String nodeType = "folder";
    
    // 수정 유형
    private String updateType;
    // 쓰기 모드
    private String writeMode;

    // layer 아이디")
    private Integer layerId;
    // layer 키")
    private String layerKey;
    // layer 명
    private String layerName;
    // 레이어 표시 타입. wms(기본), wfs, canvas
    private String viewType;
    // layer 스타일. 임시(현재는 색깔만 넣고, 추후 확장 예정)
    private String layerStyle;
    // geometry type
    private String geometryType;
    
    // ui control 용
    private String ancestor;
    private Integer parent;
    private String parentName;
    private Integer depth;
    private Integer viewOrder;
    
    // 지도 레이어 표시 우선 순위
    private Integer zIndex;
    public Integer getViewZIndex() {
        return this.zIndex;
    }

    // shape 파일 등록 가능 유무
    private String shapeInsertYn;
    private String viewShapeInsertYn;
    private String useYn;
    private String viewUseYn;

    // 레이블 표시 유무. Y : 표시, N : 비표시(기본값)
    private String labelDisplayYn;
    // 모바일 기본 레이어 적용 유무. Y : 사용, N : 미사용
    private String mobileDefaultYn;

    // 정보 입력 상태. 0: 계층구조만 등록, 1: layer 정보 입력 완료
    private String status;

    // 좌표계
    private String coordinate;
    // 설명
    private String description;
    // 업로딩 아이디
    private String userId;
    
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Timestamp updateDate;

	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Timestamp insertDate;
}
