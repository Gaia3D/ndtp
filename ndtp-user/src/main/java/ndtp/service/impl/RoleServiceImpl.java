package ndtp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ndtp.domain.Role;
import ndtp.persistence.RoleMapper;
import ndtp.service.RoleService;

/**
 * Role
 * @author jeongdae
 *
 */
@Service
public class RoleServiceImpl implements RoleService {
	
	@Autowired
	private RoleMapper roleMapper;
	
	/**
	 * role 수
	 * @param role
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getRoleTotalCount(Role role) {
		return roleMapper.getRoleTotalCount(role);
	}
	
	/**
	 * Role 목록
	 * @param role
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<Role> getListRole(Role role) {
		return roleMapper.getListRole(role);
	}
	
	/**
	 * Role 정보
	 * @param roleId
	 * @return
	 */
	@Transactional(readOnly=true)
	public Role getRole(Integer roleId) {
		return roleMapper.getRole(roleId);
	}
}
