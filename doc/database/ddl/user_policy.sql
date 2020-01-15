drop table if exists user_policy cascade;

create table user_policy (
	user_policy_id				integer,
	user_id						varchar(32)						not null,
	label_yn					char(1)							default 'Y',
	base_layers					varchar(1000),
	update_date					timestamp with time zone,
	insert_date					timestamp with time zone		default now(),
	constraint user_policy_pk	primary key (user_policy_id)
);

comment on table user_policy is '사용자 설정';
comment on column user_policy.user_policy_id is '고유번호';
comment on column user_policy.user_id is '사용자 아이디';
comment on column user_policy.label_yn is '지번라벨 On/OFf';
comment on column user_policy.base_layers is '레이어 설정';
comment on column user_policy.update_date is '수정일';
comment on column user_policy.insert_date is '등록일';


