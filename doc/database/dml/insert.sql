-- 사용자 그룹 테이블 기본값 입력
insert into user_group(	user_group_id, user_group_key, user_group_name, ancestor, parent, depth, view_order, basic, available, description)
values
	(1, 'SUPER_ADMIN', '슈퍼 관리자', 1, 0, 1, 1, 'Y', 'Y', '기본값'),
	(2, 'USER', '사용자', 1, 0, 1, 2, 'Y', 'Y', '기본값'),
	(3, 'GUEST', 'GUEST', 1, 0, 1, 3, 'Y', 'Y', '기본값');

-- 슈퍼 관리자 등록
insert into user_info(
	user_id, user_group_id, user_name, password, user_role_check_yn, last_signin_date)
values
	 ('admin', 1, '슈퍼관리자', '$2a$10$raxA9.ppTStr4t.sG.OtDuGC5HEHqddGzFVp15FG1p1DLi1rsN006', 'N', now()),
	 ('supervisor', 1, '슈퍼관리자', '$2a$10$raxA9.ppTStr4t.sG.OtDuGC5HEHqddGzFVp15FG1p1DLi1rsN006', 'N', now()),
   ('ndtp', 2, '사용자', '$2a$10$raxA9.ppTStr4t.sG.OtDu4zS0yQDEP8D0OZfB0yvCzteCGjy256m', 'N', now());

-- 관리자 메뉴
insert into menu(menu_id, menu_type, menu_target, name, name_en, ancestor, parent, depth, view_order, url, url_alias, html_id, css_class, default_yn, use_yn, display_yn)
values
	(1, '0', '1', '홈', 'HOME', 0, 0, 1, 1, '/main/index', null, null, 'glyph-home', 'N', 'N', 'N'),
	(2, '0', '1', '사용자', 'USER', 2, 0, 1, 2, '/user/list', null, null, 'glyph-users', 'Y', 'Y', 'Y'),
	(21, '0', '1', '사용자 그룹', 'USER', 2, 2, 2, 1, '/user-group/list', null, null, 'glyph-users', 'Y', 'Y', 'Y'),
	(22, '0', '1', '사용자 그룹 등록', 'USER', 2, 2, 2, 2, '/user-group/input', null, null, 'glyph-users', 'Y', 'Y', 'Y'),
	(23, '0', '1', '사용자 그룹 수정', 'USER', 2, 2, 2, 3, '/user-group/modify', '/user-group/list', null, 'glyph-users', 'N', 'Y', 'N'),
	(24, '0', '1', '사용자 그룹 메뉴', 'USER', 2, 2, 2, 4, '/user-group/menu', '/user-group/list', null, 'glyph-users', 'N', 'Y', 'N'),
	(25, '0', '1', '사용자 그룹 Role', 'USER', 2, 2, 2, 5, '/user-group/role', '/user-group/list', null, 'glyph-users', 'N', 'Y', 'N'),
	(26, '0', '1', '사용자 목록', 'USER', 2, 2, 2, 6, '/user/list', null, null, 'glyph-users', 'Y', 'Y', 'Y'),
	(27, '0', '1', '사용자 등록', 'USER', 2, 2, 2, 7, '/user/input', null, null, 'glyph-users', 'Y', 'Y', 'Y'),
	(28, '0', '1', '사용자 정보 수정', 'USER', 2, 2, 2, 8, '/user/modify', '/user/list', null, 'glyph-users', 'N', 'Y', 'N'),
	(29, '0', '1', '사용자 상세 정보', 'USER', 2, 2, 2, 9, '/user/detail', '/user/list', null, 'glyph-users', 'N', 'Y', 'N'),
	(3, '0', '1', '데이터', 'DATA', 3, 0, 1, 3, '/data-group/list', null, null, 'glyph-monitor', 'Y', 'Y', 'Y'),
	(31, '0', '1', '데이터 그룹', 'DATA', 3, 3, 2, 1, '/data-group/list', null, null, 'glyph-monitor', 'Y', 'Y', 'Y'),
	(32, '0', '1', '데이터 그룹 등록', 'DATA', 3, 3, 2, 2, '/data-group/input', null, null, 'glyph-monitor', 'Y', 'Y', 'Y'),
	(33, '0', '1', '데이터 그룹 수정', 'DATA', 3, 3, 2, 3, '/data-group/modify', '/data-group/list', null, 'glyph-monitor', 'N', 'Y', 'N'),
	(34, '0', '1', '사용자 데이터 그룹', 'DATA', 3, 3, 2, 4, '/data-group/list-user', null, null, 'glyph-monitor', 'Y', 'N', 'Y'),
	(35, '0', '1', '데이터 목록', 'DATA', 3, 3, 2, 5, '/data/list', null, null, 'glyph-monitor', 'Y', 'Y', 'Y'),
	(36, '0', '1', '데이터 상세 정보', 'DATA', 3, 3, 2, 6, '/data/detail', '/data/list', null, 'glyph-monitor', 'N', 'Y', 'N'),
	(37, '0', '1', '데이터 수정', 'DATA', 3, 3, 2, 7, '/data/modify', '/data/list', null, 'glyph-monitor', 'N', 'Y', 'N'),
	(40, '0', '1', '업로드', 'DATA', 3, 3, 2, 8, '/upload-data/input', null, null, 'glyph-monitor', 'Y', 'Y', 'Y'),
	(41, '0', '1', '업로드 목록', 'DATA', 3, 3, 2, 9, '/upload-data/list', null, null, 'glyph-monitor', 'Y', 'Y', 'Y'),
	(42, '0', '1', '업로드 수정', 'DATA', 3, 3, 2, 10, '/upload-data/modify', '/upload-data/list', null, 'glyph-monitor', 'N', 'Y', 'N'),
	(43, '0', '1', '데이터 변환 결과', 'DATA', 3, 3, 2, 11, '/converter/list', null, null, 'glyph-monitor', 'Y', 'Y', 'Y'),
	(44, '0', '1', '데이터 위치 변경 요청 이력', 'DATA', 3, 3, 2, 12, '/data-adjust-log/list', null, null, 'glyph-monitor', 'Y', 'Y', 'Y'),
	(45, '0', '1', '데이터 변경 이력', 'DATA', 3, 3, 2, 13, '/data-log/list', null, null, 'glyph-monitor', 'Y', 'Y', 'Y'),
	(5, '0', '1', '레이어', 'LAYER', 5, 0, 1, 5, '/layer-group/list', null, null, 'glyph-check', 'Y', 'Y', 'Y'),
	(51, '0', '1', '2D 레이어 그룹', 'LAYER', 5, 5, 2, 1, '/layer-group/list', null, null, 'glyph-check', 'Y', 'Y', 'Y'),
	(52, '0', '1', '2D 레이어 그룹 등록', 'LAYER', 5, 5, 2, 2, '/layer-group/input', null, null, 'glyph-check', 'Y', 'Y', 'Y'),
	(53, '0', '1', '2D 레이어 그룹 수정', 'LAYER', 5, 5, 2, 3, '/layer-group/modify', '/layer-group/list', null, 'glyph-check', 'N', 'Y', 'N'),
	(54, '0', '1', '2D 레이어 목록', 'LAYER', 5, 5, 2, 4, '/layer/list', null, null, 'glyph-check', 'Y', 'Y', 'Y'),
	(55, '0', '1', '2D 레이어 등록', 'LAYER', 5, 5, 2, 5, '/layer/input', null, null, 'glyph-check', 'Y', 'Y', 'Y'),
	(56, '0', '1', '2D 레이어 수정', 'LAYER', 5, 5, 2, 6, '/layer/modify', '/layer/list', null, 'glyph-check', 'N', 'Y', 'N'),
	(7, '0', '1', '시민참여', 'CIVIL VOICE', 7, 0, 1, 7, '/civil-voice/list', null, null, 'glyph-dashboard', 'Y', 'Y', 'Y'),
	(71, '0', '1', '시민참여 목록', 'CIVIL VOICE', 7, 7, 2, 1, '/civil-voice/list', null, null, 'glyph-dashboard', 'Y', 'Y', 'Y'),
	(72, '0', '1', '시민참여 상세 정보', 'CIVIL VOICE', 7, 7, 2, 2, '/civil-voice/detail', '/civil-voice/list', null, 'glyph-dashboard', 'N', 'Y', 'N'),
	(73, '0', '1', '시민참여 등록', 'CIVIL VOICE', 7, 7, 2, 3, '/civil-voice/input', null, null, 'glyph-dashboard', 'Y', 'Y', 'Y'),
	(74, '0', '1', '시민참여 수정', 'CIVIL VOICE', 7, 7, 2, 4, '/civil-voice/modify', '/civil-voice/list', null, 'glyph-dashboard', 'N', 'Y', 'N'),
	(8, '0', '1', '환경설정', 'CONFIGURATION', 8, 0, 1, 8, '/policy/modify', null, null, 'glyph-settings', 'Y', 'Y', 'Y'),
	(81, '0', '1', '일반 운영정책', 'CONFIGURATION', 8, 8, 2, 1, '/policy/modify', null, null, 'glyph-settings', 'Y', 'Y', 'Y'),
	(82, '0', '1', '공간정보 운영정책', 'CONFIGURATION', 8, 8, 2, 2, '/geopolicy/modify', null, null, 'glyph-settings', 'Y', 'Y', 'Y'),
	(83, '0', '1', '관리자 메뉴', 'ADMIN MENU', 8, 8, 2, 3, '/menu/admin-menu', null, null, 'glyph-settings', 'Y', 'Y', 'Y'),
	(84, '0', '1', '사용자 메뉴', 'USER MENU', 8, 8, 2, 4, '/menu/user-menu', null, null, 'glyph-settings', 'Y', 'Y', 'Y'),
	(85, '0', '1', '위젯', 'WIDGET', 8, 8, 2, 5, '/widget/modify', null, null, 'glyph-settings', 'N', 'N', 'N'),
	(86, '0', '1', '권한', 'ROLE', 8, 8, 2, 6, '/role/list', null, null, 'glyph-settings', 'Y', 'Y', 'Y'),
	(87, '0', '1', '권한 등록', 'ROLE', 8, 8, 2, 7, '/role/input', '/role/list', null, 'glyph-settings', 'N', 'Y', 'N'),
	(88, '0', '1', '권한 수정', 'ROLE', 8, 8, 2, 8, '/role/modify', '/role/list', null, 'glyph-settings', 'N', 'Y', 'N');


-- 사용자 메뉴
insert into menu(menu_id, menu_type, menu_target, name, name_en, ancestor, parent, depth, view_order, url, url_alias, html_id, html_content_id,
    css_class, default_yn, use_yn, display_yn)
values
    (1001, '1', '0', '검색', 'SEARCH', 1001, 0, 1, 1, '/search', null, 'searchMenu', 'searchContent', 'search', 'Y', 'Y', 'Y'),
    (1002, '1', '0', '데이터', 'DATA', 1002, 0, 1, 2, '/data/map', null, 'dataMenu', 'dataContent', 'data', 'Y', 'Y', 'Y'),
    (1003, '1', '0', '변환', 'CONVERTER', 1003, 0, 1, 3, '/upload-data/list', null, 'converterMenu', 'converterContent', 'converter', 'Y', 'Y', 'Y'),
    (1004, '1', '0', '공간분석', 'SPATIAL', 1004, 0, 1, 4, '/spatial', null, 'spatialMenu', 'spatialContent', 'spatial', 'Y', 'Y', 'Y'),
    (1005, '1', '0', '시뮬레이션', 'SIMULATION', 1005, 0, 1, 5, '/simulation', null, 'simulationMenu', 'simulationContent', 'simulation', 'Y', 'Y', 'Y'),
    (1006, '1', '0', '시민참여', 'CIVIL VOICE', 1006, 0, 1, 6, '/civil-voice/list', null, 'civilVoiceMenu', 'civilVoiceContent', 'civilVoice', 'Y', 'Y', 'Y'),
    (1007, '1', '0', '레이어', 'LAYER', 1007, 0, 1, 7, '/layer/list', null, 'layerMenu', 'layerContent', 'layer', 'Y', 'Y', 'Y'),
    (1008, '1', '0', '환경설정', 'USER POLICY', 1008, 0, 1, 8, '/user-policy/modify', null, 'userPolicyMenu', 'userPolicyContent', 'userPolicy', 'Y', 'Y', 'Y');

-- 메인 화면 위젯
insert into widget(	widget_id, name, view_order, user_id)
values
	(NEXTVAL('widget_seq'), 'dataGroupWidget', 1, 'admin' ),
	(NEXTVAL('widget_seq'), 'dataInfoWidget', 2, 'admin' ),
	(NEXTVAL('widget_seq'), 'dataInfoLogListWidget', 3, 'admin' ),
	(NEXTVAL('widget_seq'), 'accessLogWidget', 4, 'admin' ),
	(NEXTVAL('widget_seq'), 'userWidget', 5, 'admin' ),
	(NEXTVAL('widget_seq'), 'civilVoiceWidget', 6, 'admin' ),
	(NEXTVAL('widget_seq'), 'issueWidget', 7, 'admin' ),
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
    (1, '[관리자 전용] 관리자 페이지 SIGN IN 권한', 'ADMIN_SIGNIN', '1', '0', 'Y', 'Y'),
    (2, '[관리자 전용] 관리자 페이지 사용자 관리 권한', 'ADMIN_USER_MANAGE', '1', '0', 'Y', 'Y'),
    (3, '[관리자 전용] 관리자 페이지 Layer 관리 권한', 'ADMIN_LAYER_MANAGE', '1', '0', 'Y', 'Y'),

	(4, '[사용자 전용] 사용자 페이지 SIGN IN 권한', 'USER_SIGNIN', '0', '0', 'Y', 'Y'),
	(5, '[사용자 전용] 사용자 페이지 DATA 등록 권한', 'USER_DATA_CREATE', '0', '0', 'Y', 'Y'),
	(6, '[사용자 전용] 사용자 페이지 DATA 조회 권한', 'USER_DATA_READ', '0', '0', 'Y', 'Y');



-- 사용자 그룹별 메뉴
insert into user_group_menu(user_group_menu_id, user_group_id, menu_id, all_yn)
values
	(1, 1, 1, 'Y'),
	(2, 1, 2, 'Y'),
	(21, 1, 21, 'Y'),
	(22, 1, 22, 'Y'),
	(23, 1, 23, 'Y'),
	(24, 1, 24, 'Y'),
	(25, 1, 25, 'Y'),
	(26, 1, 26, 'Y'),
	(27, 1, 27, 'Y'),
	(28, 1, 28, 'Y'),
	(29, 1, 29, 'Y'),
	(3, 1, 3, 'Y'),
	(31, 1, 31, 'Y'),
	(32, 1, 32, 'Y'),
	(33, 1, 33, 'Y'),
	(34, 1, 34, 'Y'),
	(35, 1, 35, 'Y'),
	(36, 1, 36, 'Y'),
	(37, 1, 37, 'Y'),
	(40, 1, 40, 'Y'),
	(41, 1, 41, 'Y'),
	(42, 1, 42, 'Y'),
	(43, 1, 43, 'Y'),
	(44, 1, 44, 'Y'),
	(45, 1, 45, 'Y'),
	(5, 1, 5, 'Y'),
	(51, 1, 51, 'Y'),
	(52, 1, 52, 'Y'),
	(53, 1, 53, 'Y'),
	(54, 1, 54, 'Y'),
	(55, 1, 55, 'Y'),
	(56, 1, 56, 'Y'),
	(7, 1, 7, 'Y'),
	(71, 1, 71, 'Y'),
	(72, 1, 72, 'Y'),
	(73, 1, 73, 'Y'),
	(74, 1, 74, 'Y'),
	(8, 1, 8, 'Y'),
	(81, 1, 81, 'Y'),
	(82, 1, 82, 'Y'),
	(83, 1, 83, 'Y'),
	(84, 1, 84, 'Y'),
	(85, 1, 85, 'Y'),
	(86, 1, 86, 'Y'),
	(87, 1, 87, 'Y'),
	(88, 1, 88, 'Y'),
	(NEXTVAL('user_group_menu_seq'), 1, 1001, 'Y'),
	(NEXTVAL('user_group_menu_seq'), 1, 1002, 'Y'),
	(NEXTVAL('user_group_menu_seq'), 1, 1003, 'Y'),
	(NEXTVAL('user_group_menu_seq'), 1, 1004, 'Y'),
	(NEXTVAL('user_group_menu_seq'), 1, 1005, 'Y'),
	(NEXTVAL('user_group_menu_seq'), 1, 1006, 'Y'),
	(NEXTVAL('user_group_menu_seq'), 1, 1007, 'Y'),
	(NEXTVAL('user_group_menu_seq'), 1, 1008, 'Y'),

	(NEXTVAL('user_group_menu_seq'), 2, 1001, 'Y'),
	(NEXTVAL('user_group_menu_seq'), 2, 1002, 'Y'),
	(NEXTVAL('user_group_menu_seq'), 2, 1003, 'Y'),
	(NEXTVAL('user_group_menu_seq'), 2, 1004, 'Y'),
	(NEXTVAL('user_group_menu_seq'), 2, 1005, 'Y'),
	(NEXTVAL('user_group_menu_seq'), 2, 1006, 'Y'),
	(NEXTVAL('user_group_menu_seq'), 2, 1007, 'Y'),
	(NEXTVAL('user_group_menu_seq'), 2, 1008, 'Y');

insert into user_group_role(user_group_role_id, user_group_id, role_id)
values
	(NEXTVAL('user_group_role_seq'), 1, 1),
	(NEXTVAL('user_group_role_seq'), 1, 2),
	(NEXTVAL('user_group_role_seq'), 1, 3),
	(NEXTVAL('user_group_role_seq'), 1, 4),
	(NEXTVAL('user_group_role_seq'), 1, 5),
	(NEXTVAL('user_group_role_seq'), 1, 6),
	(NEXTVAL('user_group_role_seq'), 1, 7),
	(NEXTVAL('user_group_role_seq'), 2, 4),
	(NEXTVAL('user_group_role_seq'), 2, 5),
	(NEXTVAL('user_group_role_seq'), 2, 6);

-- 메인 화면 위젯
insert into widget(widget_id, name, view_order, user_id)
values
	(NEXTVAL('widget_seq'), 'dataGroupWidget', 1, 'admin' ),
	(NEXTVAL('widget_seq'), 'dataStatusWidget', 2, 'admin' ),
	(NEXTVAL('widget_seq'), 'dataAdjustLogWidget', 3, 'admin' ),
	(NEXTVAL('widget_seq'), 'userStatusWidget', 4, 'admin' ),
	(NEXTVAL('widget_seq'), 'systemUsageWidget', 5, 'admin' ),
	(NEXTVAL('widget_seq'), 'civilVoiceWidget', 6, 'admin' ),
	(NEXTVAL('widget_seq'), 'userAccessLogWidget', 7, 'admin' ),
	(NEXTVAL('widget_seq'), 'dbcpStatusWidget', 8, 'admin' );


-- 운영 정책
insert into policy(	policy_id, password_exception_char)
			values( 1, '<>&''"');

-- 2D, 3D 운영 정책
insert into geopolicy(	geopolicy_id)
			values( 1 );

-- Role
insert into role(role_id, role_name, role_key, role_target, role_type, use_yn, default_yn)
values
    (1, '[관리자 전용] 관리자 페이지 SIGN IN 권한', 'ADMIN_SIGNIN', '1', '0', 'Y', 'Y'),
    (2, '[관리자 전용] 관리자 페이지 사용자 관리 권한', 'ADMIN_USER_MANAGE', '1', '0', 'Y', 'Y'),
    (3, '[관리자 전용] 관리자 페이지 Layer 관리 권한', 'ADMIN_LAYER_MANAGE', '1', '0', 'Y', 'Y'),

	(4, '[사용자 전용] 사용자 페이지 SIGN IN 권한', 'USER_SIGNIN', '0', '0', 'Y', 'Y'),
	(5, '[사용자 전용] 사용자 페이지 DATA 등록 권한', 'USER_DATA_CREATE', '0', '0', 'Y', 'Y'),
	(6, '[사용자 전용] 사용자 페이지 DATA 조회 권한', 'USER_DATA_READ', '0', '0', 'Y', 'Y'),
	(7, '[사용자 전용] 사용자 페이지 시민참여 관리 권한', 'USER_CIVIL_VOICE_MANAGE', '0', '0', 'Y', 'Y');

	
INSERT INTO data_group (
  data_group_id, data_group_name, data_group_key, data_group_path, data_group_target, sharing, user_id, 
	ancestor, parent, depth, view_order, children, basic, available,  
	metainfo)
values (
  1, '기본', 'basic', 'infra/basic/', 'admin', 'public', 'admin',
  1, 0, 1, 1, 0, true, true,
  '{"isPhysical": false}'
);	
	
commit;
