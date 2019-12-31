package ndtp.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import ndtp.domain.DataGroup;
import ndtp.domain.Key;
import ndtp.domain.LayerGroup;
import ndtp.domain.Policy;
import ndtp.domain.UserSession;
import ndtp.service.DataGroupService;
import ndtp.service.LayerGroupService;
import ndtp.service.PolicyService;

@Slf4j
@Controller
@RequestMapping("/data/")
public class DataGroupController {
	
	@Autowired
	private DataGroupService dataGroupService;

	@Autowired
	private PolicyService policyService;
	
	/**
	 * 데이터 그룹 관리
	 */
	@GetMapping(value = "list-group")
	public String list(HttpServletRequest request, @ModelAttribute DataGroup dataGroup, Model model) {
		List<DataGroup> dataGroupList = dataGroupService.getListDataGroup();
		
		model.addAttribute("dataGroupList", dataGroupList);
		
		return "/data/list-group";
	}
	
	/**
	 * 데이터 그룹 등록 화면
	 */
	@GetMapping(value = "input-group")
	public String input(Model model) {
		Policy policy = policyService.getPolicy();
		
		List<DataGroup> dataGroupList = dataGroupService.getListDataGroup();
		
		DataGroup dataGroup = new DataGroup();
		dataGroup.setParentName(policy.getContentDataGroupRoot());
		dataGroup.setParent(0);
		
		model.addAttribute("policy", policy);
		model.addAttribute("dataGroup", dataGroup);
		model.addAttribute("dataGroupList", dataGroupList);
		
		return "/data/input-group";
	}
	
	/**
	 * 데이터 그룹 등록
	 */
	@PostMapping(value = "insert-group")
	@ResponseBody
	public Map<String, Object> insert(HttpServletRequest request, @Valid @ModelAttribute DataGroup dataGroup, BindingResult bindingResult) {
		
		log.info("@@@@@ insert dataGroup = {}", dataGroup);
		
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		
		try {
			UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
			
			if(bindingResult.hasErrors()) {
				message = bindingResult.getAllErrors().get(0).getDefaultMessage();
				log.info("@@@@@ message = {}", message);
				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
				result.put("errorCode", errorCode);
				result.put("message", message);
	            return result;
			}
			
			dataGroup.setUserId(userSession.getUserId());
			
			dataGroupService.insertDataGroup(dataGroup);
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
}
