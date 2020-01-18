-- FK, Index 는 별도 파일로 분리. 맨 마지막에 작업 예정
drop table if exists user_data_group cascade;

-- 사용자 데이터 그룹
create table user_data_group (
	user_data_group_id			integer,
	data_group_key				varchar(60)							not null,
	data_group_name				varchar(100)						not null,
	data_group_path				varchar(256),
	sharing						varchar(30)							default 'public',
	user_id						varchar(32),
	ancestor					integer								default 0,
	parent						integer								default 1,
	depth						integer								default 1,
	view_order					integer								default 1,
	children					integer								default 0,
	basic						boolean								default false,
	available					boolean								default true,
	data_count					integer								default 0,
	location		 			GEOMETRY(POINT, 4326),
	altitude					numeric(13,7),
	duration					integer,
	location_update_type		varchar(20)							default 'auto',
	metainfo					jsonb,
	description					varchar(256),
	update_date					timestamp with time zone,
	insert_date					timestamp with time zone			default now(),
	constraint user_data_group_pk 	primary key (user_data_group_id)	
);

comment on table user_data_group is '사용자 데이터 그룹';
comment on column user_data_group.user_data_group_id is '사용자 데이터 그룹 고유번호';
comment on column user_data_group.data_group_key is '링크 활용 등을 위한 확장 컬럼';
comment on column user_data_group.data_group_name is '그룹명';
comment on column user_data_group.data_group_path is '서비스 경로';
comment on column user_data_group.sharing is 'common : 공통, public : 공개, private : 개인, group : 그룹';
comment on column user_data_group.user_id is '사용자 아이디';
comment on column user_data_group.data_count is '데이터 총 건수';
comment on column user_data_group.view_order is '순서';
comment on column user_data_group.children is '자식 존재 개수';
comment on column user_data_group.basic is 'true : 기본, false : 선택';
comment on column user_data_group.available is 'true : 사용, false : 사용안함';
comment on column user_data_group.location is 'POINT(위도, 경도). 공간 검색 속도 때문에 altitude는 분리';
comment on column user_data_group.altitude is '높이';
comment on column user_data_group.duration is 'Map 이동시간';
comment on column user_data_group.location_update_type is 'location 업데이트 방법. auto : data 입력시 자동, user : 사용자가 직접 입력';
comment on column user_data_group.metainfo is '데이터 그룹 메타 정보. 그룹 control을 위해 인위적으로 만든 속성';
comment on column user_data_group.description is '설명';
comment on column user_data_group.update_date is '수정일';
comment on column user_data_group.insert_date is '등록일';

