drop table if exists policy cascade;

-- 운영정책
create table policy(
	policy_id								integer,
	
	user_id_min_length						integer				default 5,
	user_fail_signin_count					integer				default 3,
	user_fail_lock_release					varchar(3)			default '30',
	user_last_signin_lock					varchar(3)			default '90',
	user_duplication_signin_yn				char(1)				default 'N',
	user_signin_type						char(1)				default '0',
	user_update_check						char(1)				default '0',
	user_delete_check						char(1)				default '0',
	user_delete_type						char(1)				default '0',
	
	password_change_term 					varchar(3)			default '30',
	password_min_length						integer				default 8,
	password_max_length						integer				default 32,
	password_eng_upper_count 				integer				default 1,
	password_eng_lower_count 				integer				default 1,
	password_number_count 					integer				default 1,
	password_special_char_count 			integer				default 1,
	password_continuous_char_count 			integer				default 3,
	password_create_type					char(1)				default '0',
	password_create_char					varchar(32)			default '!@#',
	password_exception_char					varchar(10)			default '<>&',
	
	geo_cesium_ion_token					varchar(256)		default '',
	geo_view_library						varchar(20)			default 'cesium',
	geo_data_path							varchar(100)		default '/f4d',
	geo_data_default_projects				varchar(30)[],
	geo_data_change_request_decision		char(1)				default '1',
	geo_cull_face_enable					varchar(5)			default 'false',
	geo_time_line_enable					varchar(5)			default 'false',
	
	geo_init_camera_enable					varchar(5)			default 'true',
	geo_init_latitude						varchar(30)			default '37.521168',
	geo_init_longitude						varchar(30)			default '126.924185',
	geo_init_height							varchar(30)			default '3000.0',
	geo_init_duration						integer				default 3,
	geo_init_default_terrain				varchar(64),
	geo_init_default_fov					integer				default 0,
	
	geo_lod0								varchar(20)			default '15',
	geo_lod1								varchar(20)			default '60',
	geo_lod2								varchar(20)			default '90',
	geo_lod3								varchar(20)			default '200',
	geo_lod4								varchar(20)			default '1000',
	geo_lod5								varchar(20)			default '50000',
	geo_ambient_reflection_coef				varchar(10)			default '0.5',
	geo_diffuse_reflection_coef				varchar(10)			default '1.0',
	geo_specular_reflection_coef			varchar(10)			default '1.0',
	geo_specular_color						varchar(11)			default '#d8d8d8',
	geo_ambient_color						varchar(11)			default '#d8d8d8',
	geo_ssao_radius							varchar(20)			default '0.15',
	
	geoserver_enable				varchar(1)					default 'Y',
	geoserver_wms_version			varchar(5)         			default '1.1.1',
	geoserver_data_url				varchar(256),
	geoserver_data_workspace		varchar(60),
	geoserver_data_store			varchar(60),
	geoserver_user					varchar(256),
	geoserver_password				varchar(256),
	
	geo_server_url							varchar(256),
	geo_server_layers						varchar(60),
	geo_server_parameters_service			varchar(30),
	geo_server_parameters_version			varchar(30),
	geo_server_parameters_request			varchar(30),
	geo_server_parameters_transparent		varchar(30),
	geo_server_parameters_format			varchar(30),
	geo_server_add_url						varchar(256),
	geo_server_add_layers					varchar(60),
	geo_server_add_parameters_service		varchar(30),
	geo_server_add_parameters_version		varchar(30),
	geo_server_add_parameters_request		varchar(30),
	geo_server_add_parameters_transparent	varchar(30),
	geo_server_add_parameters_format		varchar(30),
	
	layer_source_coordinate					varchar(100)				default 'EPSG:4326',
	layer_target_coordinate					varchar(100)				default 'EPSG:4326',
	
	geo_callback_enable 					varchar(5)					default 'false',
	geo_callback_apiresult					varchar(64),
	geo_callback_dataInfo					varchar(64),
	geo_callback_selectedobject				varchar(64),
	geo_callback_moveddata					varchar(64),
	geo_callback_insertIssue				varchar(64),
	geo_callback_listIssue					varchar(64),
	geo_callback_clickposition				varchar(64),
	
	notice_service_yn						char(1)				default 'Y',
	notice_service_send_type				char(1)				default '0',
	notice_approval_request_yn				char(1)				default 'N',
	notice_approval_sign_yn					char(1)				default 'N',
	notice_password_update_yn				char(1)				default 'N',
	notice_approval_delay_yn				char(1)				default 'N',
	notice_risk_yn							char(1)				default 'N',
	notice_risk_send_type					char(1)				default '0',
	notice_risk_grade						char(1)				default '0',
	
	security_session_timeout_yn				char(1)				default 'N',
	security_session_timeout				varchar(4)			default '30',
	security_user_ip_check_yn				char(1)				default 'N',
	security_session_hijacking				char(1)				default '0',
	security_log_save_type					char(1)				default '0',
	security_log_save_term					varchar(3)			default '2',
	security_dynamic_block_yn				char(1)				default 'N',
	security_api_result_secure_yn			char(1)				default 'N',
	security_masking_yn						char(1)				default 'Y',
	
	content_cache_version					integer				default 1,
	content_main_widget_count				integer				default 6,
	content_main_widget_interval			integer				default 65,
	content_monitoring_interval				integer				default 1,
	content_statistics_interval				char(1)				default '0',
	content_load_balancing_interval			integer				default 10,
	content_menu_group_root					varchar(60)			default 'NDTP',
	content_user_group_root					varchar(60)			default 'NDTP',
	content_layer_group_root				varchar(60)			default 'NDTP',
	content_data_group_root					varchar(60)			default 'NDTP',
	
	user_upload_type						varchar(256)		default '3ds,obj,dae,collada,ifc,las,citygml,indoorgml,jpg,jpeg,gif,png,bmp,zip',
	user_upload_max_filesize				integer				default 10000,
	user_upload_max_count					integer				default 500,
	
	insert_date								timestamp with time zone			default now(),
	constraint policy_pk primary key (policy_id)	
);

comment on table policy is '운영정책';
comment on column policy.policy_id is '고유번호';

comment on column policy.user_id_min_length is '사용자 아이디 최소 길이. 기본값 5';
comment on column policy.user_fail_signin_count is '사용자 사인인 실패 횟수';
comment on column policy.user_fail_lock_release is '사용자 사인인 실패 잠금 해제 기간';
comment on column policy.user_last_signin_lock is '사용자 마지막 사인인으로 부터 잠금 기간';
comment on column policy.user_duplication_signin_yn is '중복 사인인 허용 여부. Y : 허용, N : 허용안함(기본값)';
comment on column policy.user_signin_type is '사용자 사인인 인증 방법. 0 : 일반(아이디/비밀번호(기본값)), 1 : 기업용(사번추가), 2 : 일반 + OTP, 3 : 일반 + 인증서, 4 : OTP + 인증서, 5 : 일반 + OTP + 인증서';
comment on column policy.user_update_check is '사용자 정보 수정시 확인';
comment on column policy.user_delete_check is '사용자 정보 삭제시 확인';
comment on column policy.user_delete_type is '사용자 정보 삭제 방법. 0 : 논리적(기본값), 1 : 물리적(DB 삭제)';

comment on column policy.password_change_term is '패스워드 변경 주기 기본 30일';
comment on column policy.password_min_length is '패스워드 최소 길이 기본 8';
comment on column policy.password_max_length is '패스워드 최대 길이 기본 32';
comment on column policy.password_eng_upper_count is '패스워드 영문 대문자 개수 기본 1';
comment on column policy.password_eng_lower_count is '패스워드 영문 소문자 개수 기본 1';
comment on column policy.password_number_count is '패스워드 숫자 개수 기본 1';
comment on column policy.password_special_char_count is '패스워드 특수 문자 개수 1';
comment on column policy.password_continuous_char_count is '패스워드 연속문자 제한 개수 3';
comment on column policy.password_create_type is '초기 패스워드 생성 방법. 0 : 사용자 아이디 + 초기문자(기본값), 1 : 초기문자';
comment on column policy.password_create_char is '초기 패스워드 생성 문자열. 엑셀 업로드 등';
comment on column policy.password_exception_char is '패스워드로 사용할수 없는 특수문자(XSS). <,>,&,작은따음표,큰따움표';

comment on column policy.geo_cesium_ion_token is 'Cesium ion token 발급. 기본 mago3D';
comment on column policy.geo_view_library is 'view library. 기본 cesium';
comment on column policy.geo_data_path is 'data 폴더. 기본 /data';
comment on column policy.geo_data_default_projects is '시작시 로딩 프로젝트. 배열로 저장';
comment on column policy.geo_data_change_request_decision is '데이터 정보 변경 요청에 대한 처리. 0 : 자동승인, 1 : 결재(초기값)';
comment on column policy.geo_cull_face_enable is 'cullFace 사용유무. 기본 false';
comment on column policy.geo_time_line_enable is 'timeLine 사용유무. 기본 false';
	
comment on column policy.geo_init_camera_enable is '초기 카메라 이동 유무. 기본 true';
comment on column policy.geo_init_latitude is '초기 카메라 이동 위도';
comment on column policy.geo_init_longitude is '초기 카메라 이동 경도';
comment on column policy.geo_init_height is '초기 카메라 이동 높이';
comment on column policy.geo_init_duration is '초기 카메라 이동 시간. 초 단위';
comment on column policy.geo_init_default_terrain is '기본 Terrain';
comment on column policy.geo_init_default_fov is 'field of view. 기본값 0(1.8 적용)';
comment on column policy.geo_lod0 is 'LOD0. 기본값 15M';
comment on column policy.geo_lod1 is 'LOD1. 기본값 60M';
comment on column policy.geo_lod2 is 'LOD2. 기본값 90M';
comment on column policy.geo_lod3 is 'LOD3. 기본값 200M';
comment on column policy.geo_lod4 is 'LOD4. 기본값 1000M';
comment on column policy.geo_lod5 is 'LOD5. 기본값 50000M';
comment on column policy.geo_ambient_reflection_coef is '다이렉트 빛이 아닌 반사율 범위. 기본값 0.5';
comment on column policy.geo_diffuse_reflection_coef is '자기 색깔의 반사율 범위. 기본값 1.0';
comment on column policy.geo_specular_reflection_coef is '표면의 반질거림 범위. 기본값 1.0';
comment on column policy.geo_ambient_color is '다이렉트 빛이 아닌 반사율 RGB, 콤마로 연결';
comment on column policy.geo_specular_color is '표면의 반질거림 색깔. RGB, 콤마로 연결';
comment on column policy.geo_ssao_radius is '그림자 반경';

comment on column policy.geoserver_enable is 'geoserver 사용유무';
comment on column policy.geoserver_wms_version is 'geoserver wms 버전';
comment on column policy.geoserver_data_url is 'geoserver 데이터 URL';
comment on column policy.geoserver_data_workspace is 'geoserver 데이터 작업공간';
comment on column policy.geoserver_data_store is 'geoserver 데이터 저장소';
comment on column policy.geoserver_user is 'geoserver 사용자 계정';
comment on column policy.geoserver_password is 'geoserver 비밀번호';
	
comment on column policy.geo_server_url is 'geo server 기본 Layers url';
comment on column policy.geo_server_layers is 'geo server 기본 layers';
comment on column policy.geo_server_parameters_service is 'geo server 기본 Layers service 변수값';
comment on column policy.geo_server_parameters_version is 'geo server 기본 Layers version 변수값';
comment on column policy.geo_server_parameters_request is 'geo server 기본 Layers request 변수값';
comment on column policy.geo_server_parameters_transparent is 'geo server 기본 Layers transparent 변수값';
comment on column policy.geo_server_parameters_format is 'geo server 기본 Layers format 변수값';
comment on column policy.geo_server_add_url is 'geo server 추가 Layers url';
comment on column policy.geo_server_add_layers is 'geo server 추가 Layers';
comment on column policy.geo_server_add_parameters_service is 'geo server 추가 Layers service 변수값';
comment on column policy.geo_server_add_parameters_version is 'geo server 추가 Layers version 변수값';
comment on column policy.geo_server_add_parameters_request is 'geo server 추가 Layers request 변수값';
comment on column policy.geo_server_add_parameters_transparent is 'geo server 추가 Layers transparent 변수값';
comment on column policy.geo_server_add_parameters_format is 'geo server 추가 Layers format 변수값';

comment on column policy.layer_source_coordinate is 'Layer 원본 좌표계';
comment on column policy.layer_target_coordinate is 'Layer 좌표계 정의';
	
comment on column policy.geo_callback_enable is '콜백 function 사용유무. 기본값 false';
comment on column policy.geo_callback_apiresult is 'api 처리 결과 callback function 이름';
comment on column policy.geo_callback_datainfo is 'data info 표시 callback function 이름';
comment on column policy.geo_callback_moveddata is 'moved data callback function 이름';
comment on column policy.geo_callback_selectedobject is 'object 선택 callback function 이름';
comment on column policy.geo_callback_insertissue is 'issue 등록 callback function 이름';
comment on column policy.geo_callback_listissue is 'issue 목록 callback function 이름';
comment on column policy.geo_callback_clickposition is 'mouse click 시 위치 정보 callback function 이름';

comment on column policy.notice_service_yn is '알림 서비스 사용 유무. Y : 사용, N : 사용안함(기본값)';
comment on column policy.notice_service_send_type is '알림 발송 매체. 0 : SMS(기본값), 1 : 이메일, 2 : 메신저';
comment on column policy.notice_risk_yn is '알림 장애 발생시. Y : 사용, N 사용안함(기본값)';
comment on column policy.notice_risk_send_type is '알림 장애 발송 매체. 0 : SMS(기본값), 1 : 이메일, 2 : 메신저';
comment on column policy.notice_risk_grade is '알림 발송 장애 등급. 1 : 1등급(기본값), 2 : 2등급, 3 : 3등급';

comment on column policy.security_session_timeout_yn is '보안 세션 타임아웃. Y : 사용, N 사용안함(기본값)';
comment on column policy.security_session_timeout is '보안 세션 타임아웃 시간. 기본값 30분';
comment on column policy.security_user_ip_check_yn is '로그인 사용자 IP 체크 유무. Y : 사용, N 사용안함(기본값)';
comment on column policy.security_session_hijacking is '보안 세션 하이재킹 처리. 0 : 사용안함, 1 : 사용(기본값), 2 : OTP 추가 인증 ';
comment on column policy.security_log_save_type is '보안 로그 저장 방법. 0 : DB(기본값), 1 : 파일';
comment on column policy.security_log_save_term is '보안 로그 보존 기간. 2년 기본값';
comment on column policy.security_dynamic_block_yn is '보안 동적 차단. Y : 사용, N 사용안함(기본값)';
comment on column policy.security_api_result_secure_yn is 'API 결과 암호화 사용. Y : 사용, N 사용안함(기본값)';
comment on column policy.security_masking_yn is '개인정보 마스킹 처리. Y : 사용(기본값), N 사용안함';

comment on column policy.content_cache_version is 'css, js 갱신용 cache version.';
comment on column policy.content_main_widget_count is '메인 화면 위젯 표시 갯수. 기본 6개';
comment on column policy.content_main_widget_interval is '메인 화면 위젯 Refresh 간격. 기본 65초(모니터링 간격 60초에 대한 시간 간격 고려)';
comment on column policy.content_statistics_interval is '통계 기본 검색 기간. 0 : 1년 단위, 1 : 상/하반기, 2 : 분기 단위, 3 : 월 단위';
comment on column policy.content_menu_group_root is '메뉴 그룹 최상위 그룹명';
comment on column policy.content_user_group_root is '사용자 그룹 최상위 그룹명';
comment on column policy.content_data_group_root is '데이터 그룹 최상위 그룹명';

comment on column policy.user_upload_type is '업로딩 가능 확장자. ZIP,3DS,OBJ,DAE,COLLADA,IFC,LAS,CITYGML,INDOORGML';
comment on column policy.user_upload_max_filesize is '최대 업로딩 사이즈(단위M). 500M';
comment on column policy.user_upload_max_count is '1회, 최대 업로딩 파일 수. 50개';
	
comment on column policy.insert_date is '등록일';
