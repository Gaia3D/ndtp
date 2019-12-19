-- 사용자 그룹 테이블 기본값 입력
insert into user_group(	user_group_id, group_key, group_name, parent, depth, view_order, default_yn, use_yn, description)
values
	(1, 'SUPER_ADMIN', '슈퍼 관리자', 0, 1, 1, 'Y', 'Y', '기본값'), 
	(2, 'USER', '사용자', 0, 1, 2, 'Y', 'Y', '기본값');

-- 슈퍼 관리자 등록
insert into user_info(
	user_id, user_group_id, user_name, password, user_role_check_yn, last_signin_date
) values (
	'admin', 1, '슈퍼관리자', '비밀번호', 'N', now()
);

-- 관리자 메뉴
insert into menu(menu_id, menu_type, menu_target, name, name_en, ancestor, parent, depth, view_order, url, url_alias, html_id, css_class, default_yn, use_yn, display_yn)
values
	(1, '0', '1', '홈', 'HOME', 0, 0, 1, 1, '/main/index.do', null, null, 'glyph-home', 'Y', 'Y', 'Y'),
	(2, '0', '1', '사용자', 'USER', 0, 0, 1, 2, '/user/list-user.do', null, null, 'glyph-users', 'Y', 'Y', 'Y'),
	(21, '0', '1', '사용자 그룹', 'USER', 0, 2, 2, 1, '/user/list-user-group.do', null, null, 'glyph-users', 'Y', 'Y', 'Y'),
	(22, '0', '1', '사용자 목록', 'USER', 0, 2, 2, 2, '/user/list-user.do', null, null, 'glyph-users', 'Y', 'Y', 'Y'),
	(23, '0', '1', '사용자 등록', 'USER', 0, 2, 2, 3, '/user/input-user.do', null, null, 'glyph-users', 'Y', 'Y', 'Y'),
	(24, '0', '1', '사용자 비밀번호 변경', 'USER', 0, 2, 2, 4, '/user/modify-password.do', '/user/list-user.do', null, 'glyph-users', 'N', 'Y', 'N'),
	(25, '0', '1', '사용자 비밀번호 변경', 'USER', 0, 2, 2, 5, '/user/update-password.do', '/user/list-user.do', null, 'glyph-users', 'N', 'Y', 'N'),
	(26, '0', '1', '사용자 정보 수정', 'USER', 0, 2, 2, 6, '/user/modify-user.do', '/user/list-user.do', null, 'glyph-users', 'N', 'Y', 'N'),
	(27, '0', '1', '사용자 상세 정보', 'USER', 0, 2, 2, 7, '/user/detail-user.do', '/user/list-user.do', null, 'glyph-users', 'N', 'Y', 'N'),
	(8, '0', '1', '환경설정', 'CONFIGURATION', 0, 0, 1, 8, '/config/modify-policy.do', null, null, 'glyph-settings', 'Y', 'Y', 'Y'),
	(81, '0', '1', '운영정책', 'CONFIGURATION', 0, 8, 2, 1, '/config/modify-policy.do', null, null, 'glyph-settings', 'Y', 'Y', 'Y'),
	(82, '0', '1', '메뉴설정', 'CONFIGURATION', 0, 8, 2, 2, '/config/list-menu.do', null, null, 'glyph-settings', 'Y', 'Y', 'Y'),
	(84, '0', '1', '위젯설정', 'CONFIGURATION', 0, 8, 2, 4, '/config/modify-widget.do', null, null, 'glyph-settings', 'Y', 'N', 'Y'),
	(85, '0', '1', '권한설정', 'CONFIGURATION', 0, 8, 2, 5, '/role/list-role.do', null, null, 'glyph-settings', 'Y', 'N', 'Y'),
	(87, '0', '1', '권한 설정 수정', 'CONFIGURATION', 0, 8, 2, 7, '/role/modify-role.do', '/role/list-role.do', null, 'glyph-settings', 'N', 'Y', 'N');
	

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
		(8, 1, 8),
		(81, 1, 81),
		(82, 1, 82),
		(84, 1, 84),
		(85, 1, 85),
		(87, 1, 87);


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

-- Role
insert into role(role_id, role_name, role_key, role_target, role_type, use_yn, default_yn)
values
    (NEXTVAL('role_seq'), '관리자 페이지 접근 권한', 'ADMIN_SIGNIN', '1', '0', 'Y', 'Y'),
    (NEXTVAL('role_seq'), '사용자 관리 권한', 'ADMIN_USER_MANAGE', '1', '0', 'Y', 'Y'),
    (NEXTVAL('role_seq'), '사용자 페이지 접근 권한', 'ADMIN_USER_SIGNIN', '0', '0', 'Y', 'Y');


commit;
