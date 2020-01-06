drop table if exists geopolicy cascade;

-- 2D, 3D 운영 정책
create table geopolicy(
	geopolicy_id							integer,
	
	view_library							varchar(20)			default 'cesium',
	cesium_ion_token						varchar(256)		default '',
	
	geoserver_enable						boolean						default true,
	geoserver_wms_version					varchar(5)         			default '1.1.1',
	geoserver_data_url						varchar(256),
	geoserver_data_workspace				varchar(60),
	geoserver_data_store					varchar(60),
	geoserver_user							varchar(256),
	geoserver_password						varchar(256),
	
	-- 배책임님 url, layers 는 다른 이름으로 추가해 주세요. 이름도 geoserver 다음에 prefix 고민해 주세요.
	geoserver_parameters_service			varchar(30),
	geoserver_parameters_version			varchar(30),
	geoserver_parameters_request			varchar(30),
	geoserver_parameters_transparent		varchar(30),
	geoserver_parameters_format				varchar(30),
	-- 배책임님 url, layers 는 다른 이름으로 추가해 주세요. 이름도 geoserver 다음에 prefix 고민해 주세요.
	geoserver_add_parameters_service		varchar(30),
	geoserver_add_parameters_version		varchar(30),
	geoserver_add_parameters_request		varchar(30),
	geoserver_add_parameters_transparent	varchar(30),
	geoserver_add_parameters_format			varchar(30),
	
	data_change_request_decision		char(1)				default '1',
	
	cull_face_enable					boolean				default false,
	time_line_enable					boolean				default false,
	
	init_camera_enable					boolean				default true,
	init_latitude						varchar(30)			default '37.521168',
	init_longitude						varchar(30)			default '126.924185',
	init_height							varchar(30)			default '3000.0',
	init_duration						integer				default 3,
	init_default_terrain				varchar(64),
	init_default_fov					integer				default 0,
	
	lod0								varchar(20)			default '15',
	lod1								varchar(20)			default '60',
	lod2								varchar(20)			default '90',
	lod3								varchar(20)			default '200',
	lod4								varchar(20)			default '1000',
	lod5								varchar(20)			default '50000',
	
	ambient_reflection_coef				varchar(10)			default '0.5',
	diffuse_reflection_coef				varchar(10)			default '1.0',
	specular_reflection_coef			varchar(10)			default '1.0',
	specular_color						varchar(11)			default '#d8d8d8',
	ambient_color						varchar(11)			default '#d8d8d8',
	ssao_radius							varchar(20)			default '0.15',
	
	insert_date							timestamp with time zone			default now(),
	
	max_partitions_lod0 						integer			default 4,
	max_partitions_lod1 						integer			default 2,
	max_partitions_lod2_or_less 					integer			default 1,
	max_ratio_points_dist_0m 					integer			default 10,
	max_ratio_points_dist_100m 					integer			default 120,
	max_ratio_points_dist_200m 					integer			default 240,
	max_ratio_points_dist_400m 					integer			default 480,
	max_ratio_points_dist_800m 					integer			default 960,
	max_ratio_points_dist_1600m 					integer			default 1920,
	max_ratio_points_dist_over_1600m 				integer			default 3840,
	max_point_size_for_pc						numeric(4,1)		default 40.0,
	min_point_size_for_pc						numeric(4,1)		default 3.0,
	pendent_point_size_for_pc					numeric(4,1)		default 60.0,
	
	constraint geopolicy_pk primary key (geopolicy_id)	
);

comment on table geopolicy is '2D, 3D 운영정책';
comment on column geopolicy.geopolicy_id is '고유번호';

comment on column geopolicy.view_library is 'view library. 기본 cesium';
comment on column geopolicy.cesium_ion_token is 'Cesium ion token 발급. 기본 mago3D';

comment on column geopolicy.geoserver_enable is 'geoserver 사용유무. true : 사용, false : 미사용';
comment on column geopolicy.geoserver_wms_version is 'geoserver wms 버전';
comment on column geopolicy.geoserver_data_url is 'geoserver 데이터 URL';
comment on column geopolicy.geoserver_data_workspace is 'geoserver 데이터 작업공간';
comment on column geopolicy.geoserver_data_store is 'geoserver 데이터 저장소';
comment on column geopolicy.geoserver_user is 'geoserver 사용자 계정';
comment on column geopolicy.geoserver_password is 'geoserver 비밀번호';

comment on column geopolicy.geoserver_parameters_service is 'geo server 기본 Layers service 변수값';
comment on column geopolicy.geoserver_parameters_version is 'geo server 기본 Layers version 변수값';
comment on column geopolicy.geoserver_parameters_request is 'geo server 기본 Layers request 변수값';
comment on column geopolicy.geoserver_parameters_transparent is 'geo server 기본 Layers transparent 변수값';
comment on column geopolicy.geoserver_parameters_format is 'geo server 기본 Layers format 변수값';
comment on column geopolicy.geoserver_add_parameters_service is 'geo server 추가 Layers service 변수값';
comment on column geopolicy.geoserver_add_parameters_version is 'geo server 추가 Layers version 변수값';
comment on column geopolicy.geoserver_add_parameters_request is 'geo server 추가 Layers request 변수값';
comment on column geopolicy.geoserver_add_parameters_transparent is 'geo server 추가 Layers transparent 변수값';
comment on column geopolicy.geoserver_add_parameters_format is 'geo server 추가 Layers format 변수값';

comment on column geopolicy.data_change_request_decision is '데이터 정보 변경 요청에 대한 처리. 0 : 자동승인, 1 : 결재(초기값)';

comment on column geopolicy.cull_face_enable is 'cullFace 사용유무. 기본 false';
comment on column geopolicy.time_line_enable is 'timeLine 사용유무. 기본 false';
	
comment on column geopolicy.init_camera_enable is '초기 카메라 이동 유무. true : 기본, false : 없음';
comment on column geopolicy.init_latitude is '초기 카메라 이동 위도';
comment on column geopolicy.init_longitude is '초기 카메라 이동 경도';
comment on column geopolicy.init_height is '초기 카메라 이동 높이';
comment on column geopolicy.init_duration is '초기 카메라 이동 시간. 초 단위';
comment on column geopolicy.init_default_terrain is '기본 Terrain';
comment on column geopolicy.init_default_fov is 'field of view. 기본값 0(1.8 적용)';

comment on column geopolicy.lod0 is 'LOD0. 기본값 15M';
comment on column geopolicy.lod1 is 'LOD1. 기본값 60M';
comment on column geopolicy.lod2 is 'LOD2. 기본값 90M';
comment on column geopolicy.lod3 is 'LOD3. 기본값 200M';
comment on column geopolicy.lod4 is 'LOD4. 기본값 1000M';
comment on column geopolicy.lod5 is 'LOD5. 기본값 50000M';

comment on column geopolicy.ambient_reflection_coef is '다이렉트 빛이 아닌 반사율 범위. 기본값 0.5';
comment on column geopolicy.diffuse_reflection_coef is '자기 색깔의 반사율 범위. 기본값 1.0';
comment on column geopolicy.specular_reflection_coef is '표면의 반질거림 범위. 기본값 1.0';
comment on column geopolicy.ambient_color is '다이렉트 빛이 아닌 반사율 RGB, 콤마로 연결';
comment on column geopolicy.specular_color is '표면의 반질거림 색깔. RGB, 콤마로 연결';
comment on column geopolicy.ssao_radius is '그림자 반경';

comment on column geopolicy.max_partitions_lod0 is 'LOD0일시 PointCloud 데이터 파티션 개수. 기본값 4';
comment on column geopolicy.max_partitions_lod1 is 'LOD1일시 PointCloud 데이터 파티션 개수. 기본값 2';
comment on column geopolicy.max_partitions_lod2_or_less is 'LOD2 이상 일시 PointCloud 데이터 파티션 개수. 기본값 1';
comment on column geopolicy.max_ratio_points_dist_0m is '카메라와의 거리가 10미터 미만일때, PointCloud 점의 갯수의 비율의 분모, 기본값 10';
comment on column geopolicy.max_ratio_points_dist_100m is '카메라와의 거리가 100미터 미만일때, PointCloud 점의 갯수의 비율의 분모, 기본값 120';
comment on column geopolicy.max_ratio_points_dist_200m is '카메라와의 거리가 200미터 미만일때, PointCloud 점의 갯수의 비율의 분모, 기본값 240';
comment on column geopolicy.max_ratio_points_dist_400m is '카메라와의 거리가 400미터 미만일때, PointCloud 점의 갯수의 비율의 분모, 기본값 480';
comment on column geopolicy.max_ratio_points_dist_800m is '카메라와의 거리가 800미터 미만일때, PointCloud 점의 갯수의 비율의 분모, 기본값 960';
comment on column geopolicy.max_ratio_points_dist_1600m is '카메라와의 거리가 1600미터 미만일때, PointCloud 점의 갯수의 비율의 분모, 기본값 1920';
comment on column geopolicy.max_ratio_points_dist_over_1600m is '카메라와의 거리가 1600미터 이상일때, PointCloud 점의 갯수의 비율의 분모, 기본값 3840';
comment on column geopolicy.max_point_size_for_pc is 'PointCloud 점의 최대 크기. 기본값 40.0';
comment on column geopolicy.min_point_size_for_pc is 'PointCloud 점의 최소 크기. 기본값 3.0';
comment on column geopolicy.pendent_point_size_for_pc is 'PointCloud 점의 크기 보정치. 높아질수록 점이 커짐. 기본값 60.0';

comment on column geopolicy.insert_date is '등록일';

