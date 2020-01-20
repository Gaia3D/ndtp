package ndtp.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.extern.slf4j.Slf4j;
import ndtp.domain.Policy;
import ndtp.service.PolicyService;

@Slf4j
@Controller
@RequestMapping("/policy")
public class PolicyController {

	private final PolicyService policyService;

	public PolicyController(PolicyService policyService) {
		this.policyService = policyService;
	}

	@GetMapping(value = "/modify")
	public String modify(HttpServletRequest reuqet, Model model) {
		Policy policy = policyService.getPolicy();

		model.addAttribute("policy", policy);

		return "/policy/modify";
	}

    @PostMapping(value = "/modify-user")
    public Map<String, Object> updateUser(@Valid Policy policy, BindingResult bindingResult) {
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
			policyService.updatePolicyUser(policy);
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
