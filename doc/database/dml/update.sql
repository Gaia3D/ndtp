seleupdate geopolicy set 
	geoserver_data_url = 'http://localhost:8080/geoserver',
	geoserver_data_workspace = 'ndtp',
	geoserver_data_store ='ndtp',
	geoserver_user ='admin',
	geoserver_password = 'geoserver';


-- smart tiling 이후에 해 줘야 할 작업, 벌크 업로드 시 처리됨.
-- 1 데이터 건수 수정	

-- 2 데이터 타입 수정
-- 한줄짜리는 위험
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

-- 3 데이터 속성 존재 유무 수정
-- 이건 확인 하고 update 처야 함
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


--4 그룹 기본 좌표 확인
update data_group set location = ST_GeomFromText('POINT(128.913222 35.132222)', 4326), altitude = 200 where data_group_id = 2;
update data_group set location = ST_GeomFromText('POINT(128.924469 35.094392)', 4326), altitude = 200 where data_group_id = 3;
update data_group set location = ST_GeomFromText('POINT(128.914637 35.132759)', 4326), altitude = 200 where data_group_id = 4;
update data_group set location = ST_GeomFromText('POINT(127.314284 36.500948)', 4326), altitude = 200 where data_group_id = 5;
update data_group set location = ST_GeomFromText('POINT(127.249026 36.495437)', 4326), altitude = 200 where data_group_id = 6;
update data_group set location = ST_GeomFromText('POINT(127.234491 36.508647)', 4326), altitude = 200 where data_group_id = 7;
update data_group set location = ST_GeomFromText('POINT(127.267305 36.542138)', 4326), altitude = 200 where data_group_id = 8;
update data_group set location = ST_GeomFromText('POINT(127.267808 36.542016)', 4326), altitude = 200 where data_group_id = 9;
update data_group set location = ST_GeomFromText('POINT(127.336222 36.498823)', 4326), altitude = 200 where data_group_id = 10;
update data_group set location = ST_GeomFromText('POINT(127.302718 36.489253)', 4326), altitude = 200 where data_group_id = 11;
update data_group set location = ST_GeomFromText('POINT(127.31419 36.49884)', 4326), altitude = 200 where data_group_id = 12;
update data_group set location = ST_GeomFromText('POINT(127.329044 36.499336)', 4326), altitude = 200 where data_group_id = 13;
update data_group set location = ST_GeomFromText('POINT(127.248947 36.495546)', 4326), altitude = 200 where data_group_id = 14;
update data_group set location = ST_GeomFromText('POINT(127.328689 36.499155)', 4326), altitude = 200 where data_group_id = 15;
update data_group set location = ST_GeomFromText('POINT(127.306932 36.483646)', 4326), altitude = 200 where data_group_id = 16;
update data_group set location = ST_GeomFromText('POINT(127.301493 36.490432)', 4326), altitude = 200 where data_group_id = 17;
update data_group set location = ST_GeomFromText('POINT(127.262727 36.486141)', 4326), altitude = 200 where data_group_id = 18;
update data_group set location = ST_GeomFromText('POINT(127.318752 36.494212)', 4326), altitude = 200 where data_group_id = 19;
update data_group set location = ST_GeomFromText('POINT(127.251516 36.49059)', 4326), altitude = 200 where data_group_id = 20;
update data_group set location = ST_GeomFromText('POINT(128.831754 35.055247)', 4326), altitude = 200 where data_group_id = 21;
update data_group set location = ST_GeomFromText('POINT(128.879006 35.109215)', 4326), altitude = 200 where data_group_id = 22;
update data_group set location = ST_GeomFromText('POINT(128.957043 35.213075)', 4326), altitude = 200 where data_group_id = 23;
update data_group set location = ST_GeomFromText('POINT(128.982004 35.223185)', 4326), altitude = 200 where data_group_id = 24;
update data_group set location = ST_GeomFromText('POINT(128.846825 35.102841)', 4326), altitude = 200 where data_group_id = 25;
update data_group set location = ST_GeomFromText('POINT(128.829149 35.056249)', 4326), altitude = 200 where data_group_id = 26;
update data_group set location = ST_GeomFromText('POINT(128.877867 35.154352)', 4326), altitude = 200 where data_group_id = 27;
update data_group set location = ST_GeomFromText('POINT(128.907857 35.208326)', 4326), altitude = 200 where data_group_id = 28;

