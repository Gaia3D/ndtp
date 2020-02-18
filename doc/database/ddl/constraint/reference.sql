--foreign key 설정
alter table only tn_civil_voice add constraint tn_civil_voice_fk_user_id foreign key (user_id) references user_info(user_id);
alter table only tn_civil_voice_comment add constraint tn_civil_voice_comment_fk_civil_voice_id foreign key (civil_voice_id) references tn_civil_voice(civil_voice_id);

alter table only converter_job add constraint converter_job_fk_upload_data_id foreign key (upload_data_id) references upload_data(upload_data_id);
alter table only converter_job_file add constraint converter_job_file_fk_converter_job_id foreign key (converter_job_id) references converter_job(converter_job_id);

alter table only data_attribute_file_info add constraint data_attribute_file_info_fk_data_id foreign key (data_id) references data_info(data_id);
alter table only data_object_attribute_file_info add constraint data_object_attribute_file_info_fk_data_id foreign key (data_id) references data_info(data_id);

alter table only data_attribute add constraint data_attribute_fk_data_id foreign key (data_id) references data_info(data_id);
alter table only data_object_attribute add constraint data_object_attribute_fk_data_id foreign key (data_id) references data_info(data_id);

alter table only data_info_origin add constraint data_info_origin_fk_data_id foreign key (data_id) references data_info(data_id);

alter table only data_info add constraint data_info_fk_user_id foreign key (user_id) references user_info(user_id);

alter table only layer add constraint layer_fk_layer_group_id foreign key (layer_group_id) references layer_group(layer_group_id);
alter table only layer_file_info add constraint layer_file_info_fk_user_id foreign key (user_id) references user_info(user_id);
alter table only layer_file_info add constraint layer_file_info_fk_layer_id foreign key (layer_id) references layer(layer_id);

alter table only upload_data add constraint upload_data_fk_data_group_id foreign key (data_group_id) references data_group(data_group_id);
alter table only upload_data_file add constraint upload_data_file_fk_upload_data_id foreign key (upload_data_id) references upload_data(upload_data_id);

alter table only user_info add constraint user_info_fk_user_group_id foreign key (user_group_id) references user_group(user_group_id);
alter table only user_device add constraint user_device_fk_user_id foreign key (user_id) references user_info(user_id);
alter table only user_group_menu add constraint user_group_menu_fk_user_group_id foreign key (user_group_id) references user_group(user_group_id);
alter table only user_group_role add constraint user_group_role_fk_user_group_id foreign key (user_group_id) references user_group(user_group_id);
alter table only user_group_role add constraint user_group_role_fk_role_id foreign key (role_id) references role(role_id);

alter table only user_policy add constraint user_policy_fk_user_id foreign key (user_id) references user_info(user_id);

alter table only city_plan_result add constraint sim_file_master_fk_city_plan_result foreign key (sim_file_master_img_num) references sim_file_master(sim_file_seq);