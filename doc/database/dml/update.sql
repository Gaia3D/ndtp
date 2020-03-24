seleupdate geopolicy set 
	geoserver_data_url = 'http://localhost:8080/geoserver',
	geoserver_data_workspace = 'ndtp',
	geoserver_data_store ='ndtp',
	geoserver_user ='admin',
	geoserver_password = 'geoserver';


-- smart tiling 이후에 해 줘야 할 작업, 벌크 업로드 시 처리됨.
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
--한줄따리
update data_info set data_type ='citygml' where data_group_id < 10000;

update data_info set data_type ='citygml' where data_group_id = 2;--busan-edc
update data_info set data_type ='citygml' where data_group_id = 3;--busan-mj
update data_info set data_type ='citygml' where data_group_id = 4;--busan-sv
update data_info set data_type ='citygml' where data_group_id = 5;--sejong-apartment
update data_info set data_type ='citygml' where data_group_id = 6;--sejong-bus-sign
update data_info set data_type ='citygml' where data_group_id = 7;--sejong-complex
update data_info set data_type ='citygml' where data_group_id = 8;--sejong-curture
update data_info set data_type ='citygml' where data_group_id = 9;--sejong-etc
update data_info set data_type ='citygml' where data_group_id = 10;--sejong-industry
update data_info set data_type ='citygml' where data_group_id = 11;--sejong-jeonju
update data_info set data_type ='citygml' where data_group_id = 12;--sejong-pedestrian-light
update data_info set data_type ='citygml' where data_group_id = 13;--sejong-public
update data_info set data_type ='citygml' where data_group_id = 14;--sejong-road-sign
update data_info set data_type ='citygml' where data_group_id = 15;--sejong-safe-sign
update data_info set data_type ='citygml' where data_group_id = 16;--sejong-service
update data_info set data_type ='citygml' where data_group_id = 17;--sejong-street-lamp
update data_info set data_type ='citygml' where data_group_id = 18;--sejong-taxi-sign
update data_info set data_type ='citygml' where data_group_id = 19;--sejong-traffic-light
update data_info set data_type ='citygml' where data_group_id = 20;--sejong-tree
update data_info set data_type ='citygml' where data_group_id = 21;--busan-general-house
update data_info set data_type ='citygml' where data_group_id = 22;--busan-apartment
update data_info set data_type ='citygml' where data_group_id = 23;--busan-public
update data_info set data_type ='citygml' where data_group_id = 24;--busan-industry
update data_info set data_type ='citygml' where data_group_id = 25;--busan-curture
update data_info set data_type ='citygml' where data_group_id = 26;--busan-welfare
update data_info set data_type ='citygml' where data_group_id = 27;--busan-service
update data_info set data_type ='citygml' where data_group_id = 28;--busan-etc

3 데이터 속성 존재 유무 수정
update data_info set attribute_exist = true where data_group_id = 5;--sejong-apartment
update data_info set attribute_exist = true where data_group_id = 6;--sejong-bus-sign
update data_info set attribute_exist = true where data_group_id = 8;--sejong-curture
update data_info set attribute_exist = true where data_group_id = 9;--sejong-etc
update data_info set attribute_exist = true where data_group_id = 10;--sejong-industry
update data_info set attribute_exist = true where data_group_id = 11;--sejong-jeonju
update data_info set attribute_exist = true where data_group_id = 12;--sejong-pedestrian-light
update data_info set attribute_exist = true where data_group_id = 13;--sejong-public
update data_info set attribute_exist = true where data_group_id = 14;--sejong-road-sign
update data_info set attribute_exist = true where data_group_id = 15;--sejong-safe-sign
update data_info set attribute_exist = true where data_group_id = 16;--sejong-service
update data_info set attribute_exist = true where data_group_id = 17;--sejong-street-lamp
update data_info set attribute_exist = true where data_group_id = 18;--sejong-taxi-sign
update data_info set attribute_exist = true where data_group_id = 19;--sejong-traffic-light


4 그룹 기본 좌표 확인
update data_group set location = ST_GeomFromText('POINT(경도 위도)', 4326) where data_group_id = xxxx;
