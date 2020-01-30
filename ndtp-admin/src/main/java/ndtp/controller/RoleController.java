package ndtp.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import ndtp.domain.Pagination;
import ndtp.domain.Role;
import ndtp.service.RoleService;
import ndtp.utils.DateUtils;

@Slf4j
@Controller
@RequestMapping("/role/")
public class RoleController {

	private final RoleService roleService;

	public  RoleController(RoleService roleService) {
		this.roleService = roleService;
	}

	/**
	 * Role 목록
	 * @param request
	 * @param pageNo
	 * @param role
	 * @param model
	 * @return
	 */
	@GetMapping(value = "list")
	public String list(HttpServletRequest request, @RequestParam(defaultValue="1") String pageNo, Role role, Model model) {

		if(!StringUtils.isEmpty(role.getStartDate())) {
			role.setStartDate(role.getStartDate().substring(0, 8) + DateUtils.START_TIME);
		}
		if(!StringUtils.isEmpty(role.getEndDate())) {
			role.setEndDate(role.getEndDate().substring(0, 8) + DateUtils.END_TIME);
		}

		long totalCount = roleService.getRoleTotalCount(role);
		Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(role), totalCount, Long.valueOf(pageNo).longValue());
		log.info("@@ pagination = {}", pagination);

		role.setOffset(pagination.getOffset());
		role.setLimit(pagination.getPageRows());
		List<Role> roleList = new ArrayList<>();
		if(totalCount > 0l) {
			roleList = roleService.getListRole(role);
		}

		model.addAttribute(pagination);
		model.addAttribute("role", role);
		model.addAttribute("roleList", roleList);

		return "/role/list";
	}

	/**
	 * Role 등록 화면
	 * @param model
	 * @return
	 */
	@GetMapping(value = "input")
	public String input(Model model) {
		Role role = new Role();
		role.setMethodMode("insert");

		model.addAttribute("role", role);
		return "/role/input";
	}

	/**
	 * Role 등록
	 * @param role
	 * @param bindingResult
	 * @return
	 */
	@PostMapping(value = "insert")
	@ResponseBody
	public Map<String, Object> insert(@Valid Role role, BindingResult bindingResult) {
		log.info("@@ role = {}", role);
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		try {

			if(bindingResult.hasErrors()) {
				message = bindingResult.getAllErrors().get(0).getDefaultMessage();
				log.info("@@@@@ message = {}", message);
				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
				result.put("errorCode", errorCode);
				result.put("message", message);
	            return result;
			}

			roleService.insertRole(role);
		} catch (Exception e) {
			e.printStackTrace();
            statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
            errorCode = "db.exception";
            message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
		}

		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * 수정 페이지로 이동
	 * @param request
	 * @param roleId
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "modify")
	public String modify(HttpServletRequest request, @RequestParam Integer roleId, Model model) {

		Role role = roleService.getRole(roleId);

		model.addAttribute(role);

		return "/role/modify";
	}

	/**
	 * Role 정보 수정
	 * @param role
	 * @param bindingResult
	 * @return
	 */
	@PostMapping(value = "update")
	@ResponseBody
	public Map<String, Object> update(HttpServletRequest request, @Valid Role role, BindingResult bindingResult) {
		log.info("@@ role = {}", role);
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;

		try {
			if(bindingResult.hasErrors()) {
				message = bindingResult.getAllErrors().get(0).getDefaultMessage();
				log.info("@@@@@ message = {}", message);
				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
				result.put("errorCode", errorCode);
				result.put("message", message);
	            return result;
			}

			roleService.updateRole(role);
		} catch (Exception e) {
			e.printStackTrace();
            statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
            errorCode = "db.exception";
            message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
		}

		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * Role 삭제
	 * @param roleId
	 * @return
	 */
	@DeleteMapping(value = "delete")
	@ResponseBody
	public Map<String, Object> delete(@RequestParam Integer roleId) {
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		try {
			roleService.deleteRole(roleId);
		} catch (Exception e) {
			e.printStackTrace();
            statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
            errorCode = "db.exception";
            message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
		}

		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * 검색 조건
	 * @param search
	 * @return
	 */
	private String getSearchParameters(Role role) {
		return role.getParameters();
	}
}