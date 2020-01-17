drop table if exists user_policy cascade;

create table user_policy (
	user_policy_id				integer,
	user_id						varchar(32)						not null,
	datainfo_display			boolean							default false,
	origin_display				boolean							default false,
	bbox_display				boolean							default false,
	lod0						varchar(20)			default '15',
	lod1						varchar(20)			default '60',
	lod2						varchar(20)			default '90',
	lod3						varchar(20)			default '200',
	lod4						varchar(20)			default '1000',
	lod5						varchar(20)			default '50000',
	ssao_radius					varchar(20)			default '0.15',
	update_date					timestamp with time zone,
	insert_date					timestamp with time zone		default now(),
	constraint user_policy_pk	primary key (user_policy_id)
);

comment on table user_policy is '사용자 설정';
comment on column user_policy.user_policy_id is '고유번호';
comment on column user_policy.datainfo_display is '객체 정보 표시 여부';
comment on column user_policy.origin_display is 'Origin 정보 표시 여부';
comment on column user_policy.bbox_display is 'bbox 표시 여부';
comment on column user_policy.lod0 is 'lod0';
comment on column user_policy.lod1 is 'lod1';
comment on column user_policy.lod2 is 'lod2';
comment on column user_policy.lod3 is 'lod3';
comment on column user_policy.lod4 is 'lod4';
comment on column user_policy.lod5 is 'lod5';
comment on column user_policy.ssao_radius '그림자 반경';
comment on column user_policy.update_date is '수정일';
comment on column user_policy.insert_date is '등록일';


