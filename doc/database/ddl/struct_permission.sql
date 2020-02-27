drop table if exists struct_permission cascade;

CREATE TABLE public.struct_permission (
	perm_seq int4 NOT NULL,
	"constructor" varchar(50) NULL,
	constructor_type varchar(50) NULL,
	perm_officer varchar(50) NULL,
	birthday varchar(50) NULL,
	license_num varchar(50) NULL,
	phone_number varchar(50) NULL,
	is_complete varchar(1) NULL DEFAULT 'N'::character varying,
	latitude float4 NULL,
	longitude float4 NULL,
	save_file_path varchar(255) NULL,
	save_file_name varchar(255) NULL,
	origin_file_name varchar(255) NULL,
	apply_date date NULL DEFAULT now(),
	save_model_file_path varchar NULL,
	save_model_file_name varchar NULL,
	altitude float4 NULL,
	heading float4 NULL,
	pitch float4 NULL,
	roll float4 NULL
);
