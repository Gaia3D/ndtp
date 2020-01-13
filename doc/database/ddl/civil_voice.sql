drop table if exists civil_voice cascade;
drop table if exists civil_voice_comment cascade;

-- 시민의 소리. 실 서비스에서는 파티션으로 전환해야 함
create table civil_voice (
	civil_voice_id 		bigint,
	user_id				varchar(32)						not null,
	title				varchar(1000)					not null,
	contents			text,
	location		 	GEOMETRY(POINT, 4326),
	altitude			numeric(7,3),
	available			boolean							default true,
	client_ip 			varchar(45),
	view_count			bigint							default 0,
	year				char(4)							default to_char(now(), 'YYYY'),
	month				varchar(2)						default to_char(now(), 'MM'),
	day					varchar(2)						default to_char(now(), 'DD'),
	year_week			varchar(2)						default to_char(now(), 'WW'),
	week				varchar(2)						default to_char(now(), 'W'),
	hour				varchar(2)						default to_char(now(), 'HH24'),
	minute				varchar(2)						default to_char(now(), 'MI'),
	insert_date			timestamp with time zone,
	constraint civil_voice_pk 	primary key (civil_voice_id)	
);

comment on table civil_voice is '공지사항';
comment on column civil_voice.civil_voice_id is '고유번호';
comment on column civil_voice.user_id is '사용자 아이디';
comment on column civil_voice.title is '제목';
comment on column civil_voice.contents is '내용';
comment on column civil_voice.location is '위치 Point. 분석에 용이';
comment on column civil_voice.altitude is '높이';
comment on column civil_voice.available is '사용유무, true : 사용, false : 사용안함';
comment on column civil_voice.client_ip is '사용자 IP';
comment on column civil_voice.view_count is '조회수';
comment on column civil_voice.year is '년';
comment on column civil_voice.month is '월';
comment on column civil_voice.day is '일';
comment on column civil_voice.year_week is '일년중 몇주';
comment on column civil_voice.week is '이번달 몇주';
comment on column civil_voice.hour is '시간';
comment on column civil_voice.minute is '분';
comment on column civil_voice.insert_date is '등록일';

-- 시민의 소리 Comment. 실 서비스에서는 파티션으로 전환해야 함
create table civil_voice_comment (
	civil_voice_comment_id		bigint,
	civil_voice_id 					bigint,
	user_id					varchar(32)						not null,
	title					varchar(1000)					not null,
	client_ip 				varchar(45),
	year					char(4)							default to_char(now(), 'YYYY'),
	month					varchar(2)						default to_char(now(), 'MM'),
	day						varchar(2)						default to_char(now(), 'DD'),
	year_week				varchar(2)						default to_char(now(), 'WW'),
	week					varchar(2)						default to_char(now(), 'W'),
	hour					varchar(2)						default to_char(now(), 'HH24'),
	minute					varchar(2)						default to_char(now(), 'MI'),
	insert_date				timestamp with time zone,
	constraint civil_voice_comment_pk 	primary key (civil_voice_comment_id)	
);

comment on table civil_voice_comment is '시민의 소리 Comment';
comment on column civil_voice_comment.civil_voice_comment_id is '고유번호';
comment on column civil_voice_comment.civil_voice_id is '시민의 소리 고유번호';
comment on column civil_voice_comment.user_id is 'comment 사용자 아이디';
comment on column civil_voice_comment.title is 'comment 제목';
comment on column civil_voice_comment.client_ip is 'comment 사용자 IP';
comment on column civil_voice_comment.year is '년';
comment on column civil_voice_comment.month is '월';
comment on column civil_voice_comment.day is '일';
comment on column civil_voice_comment.year_week is '일년중 몇주';
comment on column civil_voice_comment.week is '이번달 몇주';
comment on column civil_voice_comment.hour is '시간';
comment on column civil_voice_comment.minute is '분';
comment on column civil_voice_comment.insert_date is '등록일';


