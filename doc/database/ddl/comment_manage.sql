drop table if exists comment_manage cascade;

CREATE TABLE public.comment_manage (
	comment_seq int4 NOT NULL,
	writer varchar(255) NULL,
	object_name varchar(255) NULL,
	comment_title varchar(255) NULL,
	comment_content varchar(255) NULL,
	latitude varchar(255) NULL,
	longitude varchar(255) NULL,
	height varchar(255) NULL,
	apply_date timestamp with time zone		default now(),
	perm_seq int4 NULL
);
