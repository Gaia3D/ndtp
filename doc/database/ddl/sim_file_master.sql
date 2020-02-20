drop table if exists sim_file_master cascade;

CREATE TABLE public.sim_file_master (
	sim_file_seq int4 NOT NULL,
	origin_file_name varchar(255) NULL,
	save_file_name varchar(255) NULL,
	save_file_path varchar(255) NULL,
	save_file_type varchar(255) NULL,
	create_dt date NULL DEFAULT now(),
	lon float4 NULL,
	lat float4 NULL,
	alt float4 NULL,
	cons_type varchar NULL,
	city_type varchar NULL,
	cons_ratio int4 NULL,
	objectid varchar NULL,
	CONSTRAINT sim_file_master_pk PRIMARY KEY (sim_file_seq)
);
