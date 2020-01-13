package ndtp.service;

import java.util.List;

import ndtp.domain.Menu;

/**
 * 메뉴 관리
 * @author jeongdae
 *
 */
public interface MenuService {
	
	/**
	 * 메뉴 목록
	 * @param menu
	 * @return
	 */
	public List<Menu> getListMenu(Menu menu);
	
	/**
	 * 메뉴 조회
	 * @param menuId
	 * @return
	 */
	Menu getMenu(Integer menuId);
}
