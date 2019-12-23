package ndtp.domain;

import java.util.List;
import java.util.Map;

/**
 * TODO 귀찮고, 전부 select 성 데이터고 관리자가 혼자라서 getInstance를 사용하지 않았음. 바람직 하지는 않음
 * 환경 설정 관련 모든 요소를 캐시 처리
 *
 * @author jeongdae
 *
 */
public class CacheManager {

    private volatile static CacheManager cacheManager = new CacheManager();;

    private CacheManager() {
    }

    // 사용자 그룹별 메뉴 목록
    private Map<Integer, List<UserGroupMenu>> userGroupMenuMap = null;
    // 사용자 그룹별 Role 목록
    private Map<Integer, List<String>> userGroupRoleMap = null;

    public static Map<Integer, List<UserGroupMenu>> getUserGroupMenuMap() {
        return cacheManager.userGroupMenuMap;
    }
    public static List<UserGroupMenu> getUserGroupMenuList(Integer userGroupId) {
        return cacheManager.userGroupMenuMap.get(userGroupId);
    }
    public static void setUserGroupMenuMap(Map<Integer, List<UserGroupMenu>> userGroupMenuMap) {
        cacheManager.userGroupMenuMap = userGroupMenuMap;
    }
    public static List<String> getUserGroupRoleKeyList(Integer userGroupId) {
        return cacheManager.userGroupRoleMap.get(userGroupId);
    }
    public static Map<Integer, List<String>> getUserGroupRoleMap() {
        return cacheManager.userGroupRoleMap;
    }
    public static void setUserGroupRoleMap(Map<Integer, List<String>> userGroupRoleMap) {
        cacheManager.userGroupRoleMap = userGroupRoleMap;
    }
}
