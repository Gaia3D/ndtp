package ndtp.domain;

import java.sql.Timestamp;

import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * 운영 정책
 * TODO 도메인 답게 나누자.
 * @author jeongdae
 *
 */
@ToString
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Mago3DPolicy {
    
	@NotNull
    private Long policyId;	// 고유번호

	// Cesium ion token 발급. 기본 mago3D
 	private String geoCesiumIonToken;
 	
 	// 
 	@Builder.Default
 	private String geo_cesium_ion_token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiIyNmNjOWZkOC03NjdlLTRiZTktYWQ3NS1hNmQ0YjA1ZjIzYWEiLCJpZCI6Mzk5Miwic2NvcGVzIjpbImFzciIsImdjIl0sImlhdCI6MTU0NDYwNDQ3M30.AwvoVAuMRwjcMMJ9lEG2v4CPUp8gfltJqZARHgxGv_k";
 	
 	// view library. 기본 cesium
 	private String geoViewLibrary;
 	
 	@Getter(AccessLevel.NONE)
 	@Setter(AccessLevel.NONE)
 	private String geo_view_library;
 	
 	public String getGeo_view_library() {
		return geoViewLibrary;
	}

	public void setGeo_view_library(String geo_view_library) {
		this.geo_view_library = geoViewLibrary;
	}

	// data 폴더. 기본 /data
 	private String geoDataPath;
 	// 초기 로딩 프로젝트
 	@Getter(AccessLevel.NONE)
 	@Setter(AccessLevel.NONE)
 	private String geoDataDefaultProjects;
 	private String geoDataDefaultProjectsView;
 	// 데이터 정보 변경 요청에 대한 처리. 0 : 자동승인, 1 : 결재(초기값)
 	private String geoDataChangeRequestDecision;
 	// cullFace 사용유무. 기본 false
 	private String geoCullFaceEnable;
 	// timeLine 사용유무. 기본 false
 	private String geoTimeLineEnable;
 	
 	// 초기 카메라 이동 유무. 기본 true
 	private String geoInitCameraEnable;
 	// 초기 카메라 이동 위도
 	private String geoInitLatitude;
 	// 초기 카메라 이동 경도
 	private String geoInitLongitude;
 	// 초기 카메라 이동 높이
 	private String geoInitHeight;
 	// 초기 카메라 이동 시간. 초 단위
 	private Long geoInitDuration;
 	// 기본 Terrain
 	private String geoInitDefaultTerrain;
 	// field of view. 기본값 0(1.8 적용)
 	private Long geoInitDefaultFov;
 	
 	// LOD0. 기본값 15M
 	private String geoLod0;
 	// LOD1. 기본값 60M
 	private String geoLod1;
 	// LOD2. 기본값 900M
 	private String geoLod2;
 	// LOD3. 기본값 200M
 	private String geoLod3;
 	// LOD3. 기본값 1000M
 	private String geoLod4;
 	// LOD3. 기본값 50000M
 	private String geoLod5;
 	
 	// 다이렉트 빛이 아닌 반사율 범위. 기본값 0.5
 	private String geoAmbientReflectionCoef;
 	// 자기 색깔의 반사율 범위. 기본값 1.0
 	private String geoDiffuseReflectionCoef;
 	// 표면의 반질거림 범위. 기본값 1.0
 	private String geoSpecularReflectionCoef;
 	// 다이렉트 빛이 아닌 반사율 RGB, 콤마로 연결
 	private String geoAmbientColor;
 	private String geoAmbientColorR;
 	private String geoAmbientColorG;
 	private String geoAmbientColorB;
 	// 표면의 반질거림 색깔. RGB, 콤마로 연결
 	private String geoSpecularColor;
 	private String geoSpecularColorR;
 	private String geoSpecularColorG;
 	private String geoSpecularColorB;
 	// 그림자 반경
 	private String geoSsaoRadius;
 	
 // geoserver 사용유무. Y : 사용(기본값), N : 미사용
 	private String geoserverEnable;
 	// geoserver wms 버전. 기본 1.1.1
 	private String geoserverWmsVersion;
 	// geoserver 데이터 URL
 	private String geoserverDataUrl;
 	// geoserver 데이터 작업공간
 	private String geoserverDataWorkspace;
 	// geoserver 데이터 저장소
 	private String geoserverDataStore;
 	// geoserver 계정
 	private String geoserverUser;
 	// geoserver 비밀번호
 	private String geoserverPassword;
 	
 	// geo server 기본 layers url
 	private String geoServerUrl;
 	// geo server 기본 layers
 	private String geoServerLayers;
 	// geo server 기본 layers service 변수값
 	private String geoServerParametersService;
 	// geo server 기본 layers version 변수값
 	private String geoServerParametersVersion;
 	// geo server 기본 layers request 변수값
 	private String geoServerParametersRequest;
 	// geo server 기본 layers transparent 변수값
 	private String geoServerParametersTransparent;
 	// geo server 기본 layers format 변수값
 	private String geoServerParametersFormat;
 	// geo server 추가 layers url
 	private String geoServerAddUrl;
 	// geo server 추가 layers layers
 	private String geoServerAddLayers;
 	// geo server 추가 layers service 변수값
 	private String geoServerAddParametersService;
 	// geo server 추가 layers version 변수값
 	private String geoServerAddParametersVersion;
 	// geo server 추가 layers request 변수값
 	private String geoServerAddParametersRequest;
 	// geo server 추가 layers transparent 변수값
 	private String geoServerAddParametersTransparent;
 	// geo server 추가 layers format 변수값
 	private String geoServerAddParametersFormat;
 	
 	
 	// 등록일
 	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Timestamp insertDate;
}
