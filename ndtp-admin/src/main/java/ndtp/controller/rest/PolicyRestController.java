package ndtp.controller.rest;

import java.util.HashMap;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.slf4j.Slf4j;
import ndtp.config.CacheConfig;
import ndtp.domain.CacheName;
import ndtp.domain.CacheParams;
import ndtp.domain.CacheType;
import ndtp.domain.Policy;
import ndtp.service.PolicyService;

@Slf4j
@RestController
@RequestMapping("/policies")
public class PolicyRestController {

	@Autowired
	private CacheConfig cacheConfig;
	@Autowired
	private PolicyService policyService;

    @PostMapping(value = "/user/{policyId:[0-9]+}")
    public Map<String, Object> updateUser(@Valid Policy policy, @PathVariable Long policyId, BindingResult bindingResult) {
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		if(bindingResult.hasErrors()) {
			message = bindingResult.getAllErrors().get(0).getDefaultMessage();
			log.info("@@@@@ message = {}", message);
			result.put("statusCode", HttpStatus.BAD_REQUEST.value());
			result.put("errorCode", errorCode);
			result.put("message", message);
            return result;
		}
		
		policy.setPolicyId(policyId);
		policyService.updatePolicyUser(policy);
		int statusCode = HttpStatus.OK.value();
		
		reloadCache();
		
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
    }

    @PostMapping(value = "/password/{policyId:[0-9]+}")
    public Map<String, Object> updatePassword(@Valid Policy policy, @PathVariable Long policyId, BindingResult bindingResult) {
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		if(bindingResult.hasErrors()) {
			message = bindingResult.getAllErrors().get(0).getDefaultMessage();
			log.info("@@@@@ message = {}", message);
			result.put("statusCode", HttpStatus.BAD_REQUEST.value());
			result.put("errorCode", errorCode);
			result.put("message", message);
            return result;
		}
		
		policy.setPolicyId(policyId);
		policyService.updatePolicyPassword(policy);
		int statusCode = HttpStatus.OK.value();
		
		reloadCache();
		
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
    }

    @PostMapping(value = "/notice/{policyId:[0-9]+}")
    public Map<String, Object> updateNotice(@Valid Policy policy, @PathVariable Long policyId, BindingResult bindingResult) {
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		if(bindingResult.hasErrors()) {
			message = bindingResult.getAllErrors().get(0).getDefaultMessage();
			log.info("@@@@@ message = {}", message);
			result.put("statusCode", HttpStatus.BAD_REQUEST.value());
			result.put("errorCode", errorCode);
			result.put("message", message);
            return result;
		}
		
		policy.setPolicyId(policyId);
		policyService.updatePolicyNotice(policy);
		int statusCode = HttpStatus.OK.value();
		
		reloadCache();
		
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
    }

    @PostMapping(value = "/security/{policyId:[0-9]+}")
    public Map<String, Object> updateSecurity(@Valid Policy policy, @PathVariable Long policyId, BindingResult bindingResult) {
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		if(bindingResult.hasErrors()) {
			message = bindingResult.getAllErrors().get(0).getDefaultMessage();
			log.info("@@@@@ message = {}", message);
			result.put("statusCode", HttpStatus.BAD_REQUEST.value());
			result.put("errorCode", errorCode);
			result.put("message", message);
            return result;
		}
		
		policy.setPolicyId(policyId);
		policyService.updatePolicySecurity(policy);
		int statusCode = HttpStatus.OK.value();
		
		reloadCache();
		
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
    }

    @PostMapping(value = "/content/{policyId:[0-9]+}")
    public Map<String, Object> updateContent(@Valid Policy policy, @PathVariable Long policyId, BindingResult bindingResult) {
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		if(bindingResult.hasErrors()) {
			message = bindingResult.getAllErrors().get(0).getDefaultMessage();
			log.info("@@@@@ message = {}", message);
			result.put("statusCode", HttpStatus.BAD_REQUEST.value());
			result.put("errorCode", errorCode);
			result.put("message", message);
            return result;
		}
		
		policy.setPolicyId(policyId);
		policyService.updatePolicyContent(policy);
		int statusCode = HttpStatus.OK.value();
		
		reloadCache();
		
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
    }

    @PostMapping(value = "/upload/{policyId:[0-9]+}")
    public Map<String, Object> updateUserUpload(@Valid Policy policy, @PathVariable Long policyId, BindingResult bindingResult) {
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		if(bindingResult.hasErrors()) {
			message = bindingResult.getAllErrors().get(0).getDefaultMessage();
			log.info("@@@@@ message = {}", message);
			result.put("statusCode", HttpStatus.BAD_REQUEST.value());
			result.put("errorCode", errorCode);
			result.put("message", message);
            return result;
		}
		
		policy.setPolicyId(policyId);
		policyService.updatePolicyUserUpload(policy);
		int statusCode = HttpStatus.OK.value();
		
		reloadCache();
		
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
    }

    private void reloadCache() {
		CacheParams cacheParams = new CacheParams();
		cacheParams.setCacheName(CacheName.POLICY);
		cacheParams.setCacheType(CacheType.BROADCAST);
		cacheConfig.loadCache(cacheParams);
	}
}
