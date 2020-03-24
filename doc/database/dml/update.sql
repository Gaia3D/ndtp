update geopolicy set 
	geoserver_data_url = 'http://localhost:8080/geoserver',
	geoserver_data_workspace = 'ndtp',
	geoserver_data_store ='ndtp',
	geoserver_user ='admin',
	geoserver_password = 'geoserver';


-- smart tiling 이후에 해 줘야 할 작업
1 데이터 건수 수정	
update data_group set data_count = xxxx where data_group_key = '';
update data_group set data_count = xxxx where data_group_key = '';
update data_group set data_count = xxxx where data_group_key = '';
update data_group set data_count = xxxx where data_group_key = '';
update data_group set data_count = xxxx where data_group_key = '';
update data_group set data_count = xxxx where data_group_key = '';
update data_group set data_count = xxxx where data_group_key = '';
update data_group set data_count = xxxx where data_group_key = '';
update data_group set data_count = xxxx where data_group_key = '';
update data_group set data_count = xxxx where data_group_key = '';
update data_group set data_count = xxxx where data_group_key = '';
	
2 데이터 타입 수정
update data_info set data_type = 'xxxx' where data_group_id = xxxxx;

3 데이터 속성 존재 유무 수정
update data_info set attribute_exist = true where data_group_id = xxxx

4 그룹 기본 좌표 확인
update data_group set location = ST_GeomFromText('POINT(경도 위도)', 4326) where data_group_id = xxxx;
