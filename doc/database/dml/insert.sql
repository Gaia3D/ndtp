-- 사용자 그룹 테이블 기본값 입력
insert into user_group(	user_group_id, user_group_key, user_group_name, parent, depth, view_order, default_yn, use_yn, description)
values
	(1, 'SUPER_ADMIN', '슈퍼 관리자', 0, 1, 1, 'Y', 'Y', '기본값'), 
	(2, 'USER', '사용자', 0, 1, 2, 'Y', 'Y', '기본값');

-- 슈퍼 관리자 등록
insert into user_info(
	user_id, user_group_id, user_name, password, user_role_check_yn, last_signin_date
) values (
	('admin', 1, '슈퍼관리자', '비밀번호', 'N', now()),
	('ndtp', 2, '스마트시티', '비밀번호', 'N', now());

-- 관리자 메뉴
insert into menu(menu_id, menu_type, menu_target, name, name_en, ancestor, parent, depth, view_order, url, url_alias, html_id, css_class, default_yn, use_yn, display_yn)
values
	(1, '0', '1', '홈', 'HOME', 0, 0, 1, 1, '/main/index', null, null, 'glyph-home', 'N', 'N', 'N'),
	(2, '0', '1', '사용자', 'USER', 2, 0, 1, 2, '/user/list', null, null, 'glyph-users', 'Y', 'Y', 'Y'),
	(21, '0', '1', '사용자 그룹', 'USER', 2, 2, 2, 1, '/user/list-group', null, null, 'glyph-users', 'Y', 'Y', 'Y'),
	(22, '0', '1', '사용자 목록', 'USER', 2, 2, 2, 2, '/user/list', null, null, 'glyph-users', 'Y', 'Y', 'Y'),
	(23, '0', '1', '사용자 등록', 'USER', 2, 2, 2, 3, '/user/input', null, null, 'glyph-users', 'Y', 'Y', 'Y'),
	(24, '0', '1', '사용자 비밀번호 변경', 'USER', 2, 2, 2, 4, '/user/modify-password', '/user/list-user', null, 'glyph-users', 'N', 'Y', 'N'),
	(25, '0', '1', '사용자 비밀번호 변경', 'USER', 2, 2, 2, 5, '/user/update-password', '/user/list-user', null, 'glyph-users', 'N', 'Y', 'N'),
	(26, '0', '1', '사용자 정보 수정', 'USER', 2, 2, 2, 6, '/user/modify', '/user/list-user', null, 'glyph-users', 'N', 'Y', 'N'),
	(27, '0', '1', '사용자 상세 정보', 'USER', 2, 2, 2, 7, '/user/detail', '/user/list-user', null, 'glyph-users', 'N', 'Y', 'N'),
	(3, '0', '1', '데이터', 'DATA', 3, 0, 1, 3, '/data/list-group', null, null, 'glyph-monitor', 'Y', 'Y', 'Y'),
	(31, '0', '1', '데이터 그룹', 'DATA', 3, 3, 2, 1, '/data/list-group', null, null, 'glyph-monitor', 'Y', 'Y', 'Y'),
	(32, '0', '1', '데이터 그룹 등록', 'DATA', 3, 3, 2, 2, '/data/input-group', null, null, 'glyph-monitor', 'Y', 'Y', 'Y'),
	(33, '0', '1', '사용자 데이터 그룹', 'DATA', 3, 3, 2, 3, '/data/list-user-group', null, null, 'glyph-monitor', 'Y', 'N', 'Y'),
	(34, '0', '1', '데이터 목록', 'DATA', 3, 3, 2, 4, '/data/list', null, null, 'glyph-monitor', 'Y', 'Y', 'Y'),
	(35, '0', '1', '데이터 상세 정보', 'DATA', 3, 3, 2, 5, '/data/detail', '/data/list', null, 'glyph-monitor', 'N', 'Y', 'N'),
	(36, '0', '1', '데이터 수정', 'DATA', 3, 3, 2, 6, '/data/modify', '/data/list', null, 'glyph-monitor', 'N', 'Y', 'N'),
	(40, '0', '1', '업로드', 'DATA', 3, 3, 2, 7, '/upload-data/input', null, null, 'glyph-monitor', 'Y', 'Y', 'Y'),
	(41, '0', '1', '업로드 목록', 'DATA', 3, 3, 2, 8, '/upload-data/list', null, null, 'glyph-monitor', 'Y', 'Y', 'Y'),
	(42, '0', '1', '업로드 수정', 'DATA', 3, 3, 2, 9, '/upload-data/modify', '/upload-data/list', null, 'glyph-monitor', 'N', 'Y', 'N'),
	(43, '0', '1', '데이터 변환 결과', 'DATA', 3, 3, 2, 12, '/converter/list', null, null, 'glyph-monitor', 'Y', 'Y', 'Y'),
	(44, '0', '1', '데이터 위치 변경 이력', 'DATA', 3, 3, 2, 13, '/data/list-data-log', null, null, 'glyph-monitor', 'Y', 'Y', 'Y'),
	(5, '0', '1', '레이어', 'LAYER', 5, 0, 1, 5, '/layer/list-group', null, null, 'glyph-check', 'Y', 'Y', 'Y'),
	(51, '0', '1', '2D 레이어 그룹', 'LAYER', 5, 5, 2, 1, '/layer/list-group', null, null, 'glyph-check', 'Y', 'Y', 'Y'),
	(52, '0', '1', '2D 레이어 그룹 등록', 'LAYER', 5, 5, 2, 2, '/layer/input-group', null, null, 'glyph-check', 'Y', 'Y', 'Y'),
	(53, '0', '1', '2D 레이어 그룹 수정', 'LAYER', 5, 5, 2, 3, '/layer/modify-group', '/layer/list-group', null, 'glyph-check', 'N', 'Y', 'N'),
	(54, '0', '1', '2D 레이어 목록', 'LAYER', 5, 5, 2, 4, '/layer/list', null, null, 'glyph-check', 'Y', 'Y', 'Y'),
	(55, '0', '1', '2D 레이어 등록', 'LAYER', 5, 5, 2, 5, '/layer/input', null, null, 'glyph-check', 'Y', 'Y', 'Y'),
	(56, '0', '1', '2D 레이어 수정', 'LAYER', 5, 5, 2, 6, '/layer/modify', '/layer/list', null, 'glyph-check', 'N', 'Y', 'N'),
	(7, '0', '1', '시민참여', 'CIVIL VOICE', 7, 0, 1, 7, '/civil-voice/list', null, null, 'glyph-dashboard', 'Y', 'Y', 'Y'),
	(71, '0', '1', '시민참여', 'CIVIL VOICE', 7, 7, 2, 1, '/civil-voice/list', null, null, 'glyph-dashboard', 'Y', 'Y', 'Y'),
	(8, '0', '1', '환경설정', 'CONFIGURATION', 8, 0, 1, 8, '/policy/modify', null, null, 'glyph-settings', 'Y', 'Y', 'Y'),
	(81, '0', '1', '운영정책', 'CONFIGURATION', 8, 8, 2, 1, '/policy/modify', null, null, 'glyph-settings', 'Y', 'Y', 'Y'),
	(82, '0', '1', '관리자 메뉴', 'ADMIN MENU', 8, 8, 2, 2, '/menu/admin-menu', null, null, 'glyph-settings', 'Y', 'Y', 'Y'),
	(83, '0', '1', '사용자 메뉴', 'USER MENU', 8, 8, 2, 3, '/menu/user-menu', null, null, 'glyph-settings', 'Y', 'Y', 'Y'),
	(84, '0', '1', '위젯', 'WIDGET', 8, 8, 2, 4, '/widget/modify', null, null, 'glyph-settings', 'Y', 'Y', 'Y'),
	(85, '0', '1', '권한', 'ROLE', 8, 8, 2, 5, '/role/list', null, null, 'glyph-settings', 'Y', 'Y', 'Y'),
	(86, '0', '1', '권한 등록', 'ROLE', 8, 8, 2, 6, '/role/input', '/role/list', null, 'glyph-settings', 'N', 'Y', 'N'),
	(87, '0', '1', '권한 수정', 'ROLE', 8, 8, 2, 7, '/role/modify', '/role/list', null, 'glyph-settings', 'N', 'Y', 'N');
	

-- 사용자 메뉴
insert into menu(menu_id, menu_type, menu_target, name, name_en, ancestor, parent, depth, view_order, url, url_alias, html_id, html_content_id,
    css_class, default_yn, use_yn, display_yn)
values
    (1001, '1', '0', '검색', 'SEARCH', 1001, 0, 1, 1, '/search', null, 'searchMenu', 'searchContent', 'search', 'Y', 'Y', 'Y'),
    (1002, '1', '0', '데이터', 'DATA', 1002, 0, 1, 2, '/data/list', null, 'dataMenu', 'dataContent', 'data', 'Y', 'Y', 'Y'),
    (1003, '1', '0', '자동 변환', 'CONVERTER', 1003, 0, 1, 3, '/upload-data/input', null, 'converterMenu', 'converterContent', 'converter', 'Y', 'Y', 'Y'),
    (1004, '1', '0', '공간분석', 'ANALYTICS', 1004, 0, 1, 4, '/analytics', null, 'analyticsMenu', 'analyticsContent', 'analytics', 'Y', 'Y', 'Y'),
    (1005, '1', '0', '시뮬레이션', 'SIMULATION', 1005, 0, 1, 5, '/simulation', null, 'simulationMenu', 'simulationContent', 'simulation', 'Y', 'Y', 'Y'),
    (1006, '1', '0', '시민의 소리', 'CIVIL VOICE', 1006, 0, 1, 6, '/civil-voice/list', null, 'civilVoiceMenu', 'civilVoiceContent', 'civilVoice', 'Y', 'Y', 'Y'),
    (1007, '1', '0', '환경설정', 'CONFIGURATION', 1007, 0, 1, 7, '/user-config/policy', null, 'configurationMenu', 'configurationContent', 'configuration', 'Y', 'Y', 'Y');
    

-- 사용자 그룹별 메뉴
insert into user_group_menu(user_group_menu_id, user_group_id, menu_id) 
	values
		(1, 1, 1),
		(2, 1, 2),
		(21, 1, 21),
		(22, 1, 22),
		(23, 1, 23),
		(24, 1, 24),
		(25, 1, 25),
		(26, 1, 26),
		(27, 1, 27),
		(3, 1, 3),
		(31, 1, 31),
		(32, 1, 32),
		(33, 1, 33),
		(34, 1, 34),
		(35, 1, 35),
		(36, 1, 36),
		(40, 1, 40),
		(41, 1, 41),
		(42, 1, 42),
		(43, 1, 43),
		(44, 1, 44),
		(5, 1, 5),
		(51, 1, 51),
		(52, 1, 52),
		(53, 1, 53),
		(54, 1, 54),
		(55, 1, 55),
		(56, 1, 56),
		(7, 1, 7),
		(71, 1, 71),
		(8, 1, 8),
		(81, 1, 81),
		(82, 1, 82),
		(83, 1, 83),
		(84, 1, 84),
		(85, 1, 85),
		(86, 1, 86),
		(87, 1, 87),
		(NEXTVAL('user_group_menu_seq'), 1, 1001),
		(NEXTVAL('user_group_menu_seq'), 1, 1002),
		(NEXTVAL('user_group_menu_seq'), 1, 1003),
		(NEXTVAL('user_group_menu_seq'), 1, 1004),
		(NEXTVAL('user_group_menu_seq'), 1, 1005),
		(NEXTVAL('user_group_menu_seq'), 1, 1006),
		(NEXTVAL('user_group_menu_seq'), 1, 1007),
		
		(NEXTVAL('user_group_menu_seq'), 2, 1001),
		(NEXTVAL('user_group_menu_seq'), 2, 1002),
		(NEXTVAL('user_group_menu_seq'), 2, 1003),
		(NEXTVAL('user_group_menu_seq'), 2, 1004),
		(NEXTVAL('user_group_menu_seq'), 2, 1005),
		(NEXTVAL('user_group_menu_seq'), 2, 1006),
		(NEXTVAL('user_group_menu_seq'), 2, 1007);
		
insert into user_group_role(user_group_role_id, user_group_id, role_id)
	values
		(1, 1, 1),
		(2, 1, 2),
		(3, 1, 3),		
		(4, 1, 4);		


-- 메인 화면 위젯
insert into widget(	widget_id, name, view_order, user_id) 
values
	(NEXTVAL('widget_seq'), 'projectWidget', 1, 'admin' ),
	(NEXTVAL('widget_seq'), 'dataInfoWidget', 2, 'admin' ),
	(NEXTVAL('widget_seq'), 'dataInfoLogListWidget', 3, 'admin' ),
	(NEXTVAL('widget_seq'), 'issueWidget', 4, 'admin' ),
	(NEXTVAL('widget_seq'), 'userWidget', 5, 'admin' ),
	(NEXTVAL('widget_seq'), 'scheduleLogListWidget', 6, 'admin' ),
	(NEXTVAL('widget_seq'), 'accessLogWidget', 7, 'admin' ),
	(NEXTVAL('widget_seq'), 'dbcpWidget', 8, 'admin' ),
	(NEXTVAL('widget_seq'), 'dbSessionWidget', 9, 'admin' );

-- 운영 정책
insert into policy(	policy_id, password_exception_char) 
			values( 1, '<>&''"');

-- 2D, 3D 운영 정책
insert into geopolicy(	geopolicy_id) 
			values( 1 );			
			
-- Role
insert into role(role_id, role_name, role_key, role_target, role_type, use_yn, default_yn)
values
    (1, '[ADMIN] 관리자 페이지 SIGN IN 권한', 'ADMIN_SIGNIN', '1', '0', 'Y', 'Y'),
    (2, '[ADMIN] 관리자 페이지 사용자 관리 권한', 'ADMIN_USER_MANAGE', '1', '0', 'Y', 'Y'),
    (3, '[ADMIN] 관리자 페이지 Layer 관리 권한', 'ADMIN_LAYER_MANAGE', '1', '0', 'Y', 'Y'),
    
    (4, '[ADMIN] 사용자 페이지 SIGN IN 권한', 'USER_SIGNIN', '0', '0', 'Y', 'Y'),
    (5, '[사용자] 사용자 페이지 SIGN IN 권한', 'USER_SIGNIN', '0', '0', 'Y', 'Y');
	
insert into data_group (data_group_id, data_group_name, data_group_key, 
		data_group_path, sharing, ancestor, parent, depth, view_order, basic, available)
	values
		(1, '기본', 'BASIC', 'basic', 'common', 1, 0, 1, 1, true, true);

insert into user_data_group (user_data_group_id, data_group_name, data_group_key, data_group_path, sharing,
		user_id,ancestor, parent, depth, view_order, basic, available)
	values
		(NEXTVAL('user_data_group_seq'), '기본', 'BASIC', 'basic', 'common', 'ndtp', 1, 0, 1, 1, true, true);
    
commit;












