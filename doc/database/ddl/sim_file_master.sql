drop table if exists sim_file_master cascade;

CREATE TABLE sim_file_master (
	sim_file_seq integer NOT NULL,
	origin_file_name varchar(255),
	save_file_name varchar(255),
	save_file_path varchar(255),
	save_file_type varchar(255),
	create_dt date DEFAULT now()
);

