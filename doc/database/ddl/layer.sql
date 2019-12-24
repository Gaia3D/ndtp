drop table if exists layer;
drop table if exists layer_file_info;

-- layer 관리
create table layer(
	layer_id					integer,
	layer_key					varchar(100)					not null,
	layer_name					varchar(256)					not null,
	view_type					varchar(30)						default 'wms',
	layer_style					varchar(100),
	geometry_type				varchar(30),
	ancestor					varchar(1000),
	parent						integer							default '0',
	depth						integer							default '1',
	view_order					integer							default '1',
	z_index						integer,
	shape_insert_yn				char(1)							default 'Y',
	use_yn						char(1)							default 'Y',
	label_display_yn			char(1)							default 'N',
	mobile_default_yn			char(1)							default 'N',
	status						char(1)							default '0',
	coordinate					varchar(100),
	description					varchar(4000),
	user_id						varchar(32),
	update_date					timestamp with time zone		default now(),
	insert_date					timestamp with time zone 		default now(),
	constraint layer_pk 		primary key (layer_id)
);

comment on table layer is '레이어';
comment on column layer.layer_id is '레이어 고유번호';
comment on column layer.layer_key is '레이어 고유키(API용)';
comment on column layer.layer_name is '레이어명';
comment on column layer.view_type is '레이어 표시 타입. wms(기본), wfs, canvas';
comment on column layer.layer_style is '레이어 스타일. 임시(현재는 색깔만)';
comment on column layer.geometry_type is 'shape 파일 geometry 타입';
comment on column layer.ancestor is '조상';
comment on column layer.parent is '부모';
comment on column layer.depth is '깊이';
comment on column layer.view_order is '순서';
comment on column layer.z_index is '지도위에 노출 순위(css z-index와 동일)';
comment on column layer.shape_insert_yn is 'Shape 파일 등록 가능 유무, Y : 등록, N : 등록 불가';
comment on column layer.use_yn is '사용유무, Y : 사용, N : 사용안함';
comment on column layer.label_display_yn is '레이블 표시 유무. Y : 표시, N : 비표시(기본값)';
comment on column layer.mobile_default_yn is '모바일 기본 레이어. Y : 사용, N : 미사용(기본값)';
comment on column layer.status is '정보 입력 상태. 0: 계층구조만 등록, 1: layer 정보 입력 완료';
comment on column layer.coordinate is '좌표계 정보';
comment on column layer.description is '설명';
comment on column layer.user_id is '업로딩 아이디';
comment on column layer.update_date is '수정일';
comment on column layer.insert_date is '등록일';


-- layer shape 파일 관리
create table layer_file_info (
	layer_file_info_id			integer,			  					
	layer_id					integer							not null,
	layer_file_info_group_id	integer,
	user_id						varchar(32)						not null,
	enable_yn					char(1)							default 'N',
	file_name					varchar(100)					not null,
	file_real_name				varchar(100)					not null,
	file_path					varchar(256)					not null,
	file_size					varchar(12)						not null,
	file_ext					varchar(10)						not null,
	shape_encoding				varchar(100),
	file_version				int								default 0,
	comment						varchar(4000),
	update_date					timestamp with time zone,
	insert_date					timestamp with time zone		default now(),
	constraint layer_file_info_pk primary key (layer_file_info_id)
);

comment on table layer_file_info is 'layer shape 파일 관리';
comment on column layer_file_info.layer_file_info_id is '파일 고유번호';
comment on column layer_file_info.layer_id is '파일 고유번호';
comment on column layer_file_info.layer_file_info_group_id is 'shape 파일 그룹 아이디. .shp 파일의 layer_file_info_id 를 group_id로 함';
comment on column layer_file_info.user_id is '사용자 id';
comment on column layer_file_info.enable_yn is 'layer 활성화 유무. Y: 활성화, N: 비활성화';
comment on column layer_file_info.file_name is '파일 이름';
comment on column layer_file_info.file_real_name is '파일 실제 이름';
comment on column layer_file_info.file_path is '파일 경로';
comment on column layer_file_info.file_size is '파일 용량';
comment on column layer_file_info.file_ext is '파일 확장자';
comment on column layer_file_info.shape_encoding is 'Shape 파일 인코딩';
comment on column layer_file_info.file_version is 'shape 파일 버전 정보';
comment on column layer_file_info.comment is '수정 사항';
comment on column layer_file_info.update_date is '갱신일';
comment on column layer_file_info.insert_date is '등록일';

