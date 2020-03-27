-- 부산 명지 아파트
data_group_id = 3
data_group_key = 'busan-mj';

-- 118 건
select count(*)
from data_info where data_group_id = 3;

-- mj_build 전체 4793건, 건물명이 null 이 아닌 건수 384건
select count(*) 
from mj_build
where buld_nm is not null;

-- data_key를 mj_build 와 join 하기 위해 분리
select data_key, split_part(data_key, '_', 1) AS first_name, substring(split_part(data_key, '_', 4), 3, 3) AS second_name
from data_info 
where data_group_id = 3

select split_part(data_key, '_', 1) || substring(split_part(data_key, '_', 4), 3, 3) 
from data_info 
where data_group_id = 3

-- 속성 shape 파일에 속성이 없거나 있어도 같은 이름 중복이 너무 많음
select x.data_id, x.data_key, y.buld_nm
from (
	select A.*, split_part(data_key, '_', 1) || '_' ||substring(split_part(data_key, '_', 4), 3, 3) AS temp_key
	from data_info A
	where A.data_group_id = 3
) x, mj_build y
where x.temp_key = y.build_name

-- 속성이 없는 경우는 data_name 을 사용함
select x.data_id, 
	CASE WHEN y.buld_nm is null THEN x.data_name
		ELSE y.buld_nm
	END AS temp_data_name
from (
	select A.*, split_part(data_key, '_', 1) || '_' ||substring(split_part(data_key, '_', 4), 3, 3) AS temp_key
	from data_info A
	where A.data_group_id = 3
) x, mj_build y
where x.temp_key = y.build_name


update data_info
	set data_name = Z.temp_data_name
	from (
			select x.data_id, 
				CASE WHEN y.buld_nm is null THEN x.data_name
					ELSE y.buld_nm
				END AS temp_data_name
			from (
				select A.*, split_part(data_key, '_', 1) || '_' ||substring(split_part(data_key, '_', 4), 3, 3) AS temp_key
				from data_info A
				where A.data_group_id = 3
			) x, mj_build y
			where x.temp_key = y.build_name
	) AS Z
	where data_info.data_id = Z.data_id;
	