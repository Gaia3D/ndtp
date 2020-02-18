drop table if exists city_plan_result cascade;

CREATE TABLE city_plan_result (
	city_plan_result_seq int4 NOT NULL,
	city_plan_target_area float8 NULL,
	city_plan_std_floor_cov int4 NULL,
	floor_coverate_ratio int4 NULL,
	city_plan_std_build_cov int4 NULL,
	build_coverate_ratio int4 NULL,
	sim_file_master_img_num int4 NULL,
	create_dt timestamptz NULL DEFAULT now()
);
