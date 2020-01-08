-- FK, Index 는 별도 파일로 분리. 맨 마지막에 작업 예정
drop table if exists converter_job cascade;
drop table if exists converter_job_file cascade;

-- 파일 변환 job
create table converter_job(
	converter_job_id				bigint,
	upload_data_id					bigint,
	user_id							varchar(32),
	title							varchar(256)						not null,
	converter_template				varchar(30)							default 'basic',
	file_count						integer								default 0,
	status							varchar(20)							default 'ready',
	error_code						varchar(4000),
	year							char(4)								default to_char(now(), 'yyyy'),
	month							varchar(2)							default to_char(now(), 'MM'),
	day								varchar(2)							default to_char(now(), 'DD'),
	year_week						varchar(2)							default to_char(now(), 'WW'),
	week							varchar(2)							default to_char(now(), 'W'),
	hour							varchar(2)							default to_char(now(), 'HH24'),
	minute							varchar(2)							default to_char(now(), 'MI'),
	update_date						timestamp with time zone,
	insert_date						timestamp with time zone			default now(),
	constraint converter_job_pk 	primary key (converter_job_id)	
);

comment on table converter_job is '파일 변환 job';
comment on column converter_job.converter_job_id is '고유번호';
comment on column converter_job.upload_data_id is '업로드 데이터 고유번호';
comment on column converter_job.user_id is '사용자 아이디';
comment on column converter_job.converter_template is '변환 유형. basic : 기본, building : 빌딩, extra-big-building : 초대형 빌딩, single-realistic-mesh : 단일 point cloud 데이터, splitted-realistic-mesh : 분할 point cloud 데이터';
comment on column converter_job.file_count is '대상 file 개수';
comment on column converter_job.status is '상태. ready : 준비, success : 성공, waiting : 승인대기, fail : 실패';
comment on column converter_job.error_code is '에러 코드';
comment on column converter_job.year is '년';
comment on column converter_job.month is '월';
comment on column converter_job.day is '일';
comment on column converter_job.year_week is '일년중 몇주';
comment on column converter_job.week is '이번달 몇주';
comment on column converter_job.hour is '시간';
comment on column converter_job.minute is '분';
comment on column converter_job.update_date is '수정일';
comment on column converter_job.insert_date is '등록일';


-- 사용자 f4d 변환 이력
create table converter_job_file(
	converter_job_file_id				bigint,
	converter_job_id					bigint,
	upload_data_id						bigint,
	upload_data_file_id					bigint,
	data_group_id						int,
	user_id								varchar(32),
	error_code							varchar(4000),
	year								char(4)								default to_char(now(), 'yyyy'),
	month								varchar(2)							default to_char(now(), 'MM'),
	day									varchar(2)							default to_char(now(), 'DD'),
	year_week							varchar(2)							default to_char(now(), 'WW'),
	week								varchar(2)							default to_char(now(), 'W'),
	hour								varchar(2)							default to_char(now(), 'HH24'),
	minute								varchar(2)							default to_char(now(), 'MI'),
	insert_date							timestamp with time zone			default now(),
	constraint converter_job_file_pk 	primary key (converter_job_file_id)	
);

comment on table converter_job_file is '변환 대상 파일 정보';
comment on column converter_job_file.converter_job_file_id is '고유번호';
comment on column converter_job_file.converter_job_id is '파일 변환 job 고유번호';
comment on column converter_job_file.upload_data_id is '데이터 업로드 고유번호';
comment on column converter_job_file.upload_data_file_id is '데이터 업로드 파일 고유번호';
comment on column converter_job_file.data_group_id is '데이터 그룹 고유번호(중복)';
comment on column converter_job_file.user_id is '사용자 아이디';
comment on column converter_job_file.error_code is '에러 코드';
comment on column converter_job_file.year is '년';
comment on column converter_job_file.month is '월';
comment on column converter_job_file.day is '일';
comment on column converter_job_file.year_week is '일년중 몇주';
comment on column converter_job_file.week is '이번달 몇주';
comment on column converter_job_file.hour is '시간';
comment on column converter_job_file.minute is '분';
comment on column converter_job_file.insert_date is '등록일';



