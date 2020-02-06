--foreign key 설정
alter table only tn_civil_voice add constraint user_info_fk foreign key (user_id) references user_info(user_id);
alter table only tn_civil_voice_comment add constraint tn_civil_voice_fk foreign key (civil_voice_id) references tn_civil_voice(civil_voice_id);

alter table only converter_job add constraint upload_data_fk foreign key (upload_data_id) references upload_data(upload_data_id);
alter table only converter_job_file add constraint converter_job_fk foreign key (converter_job_id) references converter_job(converter_job_id);

alter table only data_attribute_file_info add constraint data_info_fk foreign key (data_id) references data_info(data_id);
alter table only data_attribute_file_parse_log add constraint data_attribute_file_info_fk foreign key (data_attribute_file_info_id) references data_attribute_file_info(data_attribute_file_info_id);

alter table only upload_data add constraint data_group_fk foreign key (data_group_id) references data_group(data_group_id);
alter table only upload_data_file add constraint upload_data_fk foreign key (upload_data_id) references upload_data(upload_data_id);

alter table only data_info_origin add constraint data_info_fk foreign key (data_id) references data_info(data_id);
alter table only data_info_attribute add constraint data_info_fk foreign key (data_id) references data_info(data_id);
alter table only data_info_object_attribute add constraint data_info_fk foreign key (data_id) references data_info(data_id);

alter table only data_info add constraint user_info_fk foreign key (user_id) references user_info(user_id);

alter table only user_info add constraint user_group_fk foreign key (user_group_id) references user_group(user_group_id);
alter table only user_group_menu add constraint user_group_fk foreign key (user_group_id) references user_group(user_group_id);
alter table only user_group_role add constraint user_group_fk foreign key (user_group_id) references user_group(user_group_id);
alter table only user_group_role add constraint role_fk foreign key (role_id) references role(role_id);


alter table only user_device add constraint user_info_fk foreign key (user_id) references user_info(user_id);

alter table only layer_file_info add constraint user_info_fk foreign key (user_id) references user_info(user_id);
alter table only layer_file_info add constraint layer_fk foreign key (layer_id) references layer(layer_id);
alter table only layer add constraint layer_group_fk foreign key (layer_group_id) references layer_group(layer_group_id);

alter table only user_policy add constraint user_info_fk foreign key (user_id) references user_info(user_id);