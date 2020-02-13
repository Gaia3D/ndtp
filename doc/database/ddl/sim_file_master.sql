drop table if exists sim_file_master cascade;

CREATE TABLE sim_file_master (
	sim_file_seq int4 NOT NULL,
	origin_file_name varchar(50) NOT NULL,
	save_file_name varchar(50) NOT NULL,
	save_file_path varchar(255) NOT NULL,
	create_dt date NULL DEFAULT now()
);

