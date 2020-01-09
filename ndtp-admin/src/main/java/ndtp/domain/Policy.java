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
public class Policy {
    
	@NotNull
    private Long policyId;	// 고유번호

	// 사용자 아이디 최소 길이. 기본값 5
 	private Integer userIdMinLength;
 	// 사용자 로그인 실패 횟수
 	private Integer userFailSigninCount;
 	// 사용자 로그인 실패 잠금 해제 기간
 	private String userFailLockRelease;
 	// 사용자 마지막 로그인으로 부터 잠금 기간
 	private String userLastSigninLock;
 	// 사용자 중복 로그인 허용 여부. Y : 허용, N : 허용안함(기본값)
 	private String userDuplicationSigninYn;
 	// 사용자 로그인 인증 방법. 0 : 일반(아이디/비밀번호(기본값)), 1 : 기업용(사번추가), 2 : 일반 + OTP, 3 : 일반 + 인증서, 4 : OTP + 인증서, 5 : 일반 + OTP + 인증서
 	private String userSigninType;
 	// 사용자 정보 수정시 확인
 	private String userUpdateCheck;
 	// 사용자 정보 삭제시 확인
 	private String userDeleteCheck;
 	// 사용자 정보 삭제 방법. 0 : 논리적(기본값), 1 : 물리적(DB 삭제)
 	private String userDeleteType;
 	
 	// 패스워드 변경 주기 기본 30일
 	private String passwordChangeTerm;
 	// 패스워드 최소 길이 기본 8
 	private Integer passwordMinLength;
 	// 패스워드 최대 길이 기본 32
 	private Integer passwordMaxLength;
 	// 패스워드 영문 대문자 개수 기본 1
 	private Integer passwordEngUpperCount;
 	// 패스워드 영문 소문자 개수 기본 1
 	private Integer passwordEngLowerCount;
 	// 패스워드 숫자 개수 기본 1
 	private Integer passwordNumberCount;
 	// 패스워드 특수 문자 개수 1
 	private Integer passwordSpecialCharCount;
 	// 패스워드 연속문자 제한 개수 3
 	private Integer passwordContinuousCharCount;
 	// 초기 패스워드 생성 방법. 0 : 사용자 아이디 + 초기문자(기본값), 1 : 초기문자
 	private String passwordCreateType;
 	// 초기 패스워드 생성 문자열. 엑셀 업로드 등
 	private String passwordCreateChar;
 	// 패스워드로 사용할수 없는 특수문자(XSS). <,>,&,작은따음표,큰따움표
 	private String passwordExceptionChar;
 	
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
 	
 	// 레이어 원본 좌표계
 	private String layerSourceCoordinate;
 	// 레이어 좌표계 정의
 	private String layerTargetCoordinate;
 	
 	// 콜백 function 사용유무. 기본값 false
 	private String geoCallbackEnable;
 	
 	@Builder.Default
 	private String geo_callback_enable = "true";
 	
 	// api 처리 결과 callback function 이름
 	private String geoCallbackApiresult;
 	// data info 표시 callback function 이름
 	private String geoCallbackDataInfo;
 	// moved data callback function 이름
 	private String geoCallbackMoveddata;
 	// object 선택 callback function 이름
 	private String geoCallbackSelectedobject;
 	// issue 등록 callback function 이름
 	private String geoCallbackInsertissue;
 	// issue list callback function 이름
 	private String geoCallbackListissue;
 	// mouse click 시 위치 정보 callback function 이름
 	private String geoCallbackClickposition;
 	
 	@Getter(AccessLevel.NONE)
 	@Setter(AccessLevel.NONE)
 	@Builder.Default
 	private String geo_callback_clickposition = "showClickPosition";
 	
 	public String getGeo_callback_clickposition() {
		return geo_callback_clickposition;
	}

	public void setGeo_callback_clickposition(String geo_callback_clickposition) {
		this.geo_callback_clickposition = geo_callback_clickposition;
	}

	// 알림 서비스 사용 유무. Y : 사용, N : 미사용(기본값)
 	private String noticeServiceYn;
 	// 알림 발송 매체. 0 : SMS(기본값), 1 : 이메일, 2 : 메신저
 	private String noticeServiceSendType;
 	// 알림 결재 요청/대기시. Y : 사용, N 미사용(기본값)
 	private String noticeApprovalRequestYn;
 	// 알림 결재 완료시. Y : 사용, N 미사용(기본값)
 	private String noticeApprovalSignYn;
 	// 알림 관리 계정 패스워드 변경시. Y : 사용, N 미사용(기본값)
 	private String noticePasswordUpdateYn;
 	// 알림 결재 대기시. Y : 사용, N 미사용(기본값)
 	private String noticeApprovalDelayYn;
 	// 알림 장애 발생시. Y : 사용, N 미사용(기본값)
 	private String noticeRiskYn;
 	// 알림 장애 발송 매체. 0 : SMS(기본값), 1 : 이메일, 2 : 메신저
 	private String noticeRiskSendType;
 	// 알림 발송 장애 등급. 1 : 1등급(기본값), 2 : 2등급, 3 : 3등급
 	private String noticeRiskGrade;
 	
 	// 보안 세션 타임아웃. Y : 사용, N 미사용(기본값)
 	private String securitySessionTimeoutYn;
 	// 보안 세션 타임아웃 시간. 30분
 	private String securitySessionTimeout;
 	// 로그인 시 사용자 등록 IP 체크 유무. Y : 사용, N 미사용(기본값)
 	private String securityUserIpCheckYn;
 	// 보안 세션 하이재킹 처리. 0 : 미사용, 1 : 사용(기본값), 2 : OTP 추가 인증
 	private String securitySessionHijacking;
 	// 보안 로그 보존 방법. 1 : DB(기본값), 2 : 파일
 	private String securityLogSaveType;
 	// 보안 로그 보존 기간. 2년 기본값
 	private String securityLogSaveTerm;
 	// 보안 동적 차단. Y : 사용, N 미사용(기본값)
 	private String securityDynamicBlockYn;
 	// API 결과 암호화 사용. Y : 사용, N 사용안함(기본값)
 	private String securityApiResultSecureYn;
 	// 개인정보 마스킹 처리. Y : 사용(기본값), N 사용안함
 	private String securityMaskingYn;
 	
 	// css, js 갱신용 cache version.
 	private Integer contentCacheVersion;
 	// 메인 화면 위젯 표시 갯수. 기본 6개
 	private Integer contentMainWidgetCount;
 	// 메인 화면 위젯 Refresh 간격. 기본 65초(모니터링 간격 60초에 대한 시간 간격 고려)
 	private Integer contentMainWidgetInterval;
 	// 대몬에서 WAS 모니터링 감시 간격(분단위). 기본 1분
 	private Integer contentMonitoringInterval;
 	// 통계 기본 검색 기간. 0 : 1년단위, 1 : 상/하반기, 2 : 분기별, 3 : 월별
 	private String contentStatisticsInterval;
 	// 현재 서버가 Active, Standby 인지 상태를 표시하는 주기
 	private Integer contentLoadBalancingInterval;
 	// 메뉴 그룹 최상위 그룹명
 	private String contentMenuGroupRoot;
 	// 사용자 그룹 최상위 그룹명
 	private String contentUserGroupRoot;
 	// Layer 그룹 최상위 그룹명
 	private String contentLayerGroupRoot;
 	// data 그룹 최상위 그룹명
 	private String contentDataGroupRoot;
 	
 	// 업로딩 가능 확장자. 3ds,obj,ifc,dae 등
 	private String userUploadType;
 	// user_converter_type is '변환 가능 확장자. 3ds,obj,dae,collada,ifc,las,citygml,indoorgml';
  	private String userConverterType;
 	// 최대 업로딩 사이즈(단위M). 기본값 10000M
 	private Long userUploadMaxFilesize;
 	// 1회, 최대 업로딩 파일 수. 기본값 500개
 	private Integer userUploadMaxCount;	
 	
 	// 등록일
 	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Timestamp insertDate;
}
