package ndtp.controller;

import java.util.HashMap;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
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

    @PostMapping(value = "/user/{policyId}")
    public Map<String, Object> updateUser(@Valid Policy policy, @PathVariable Long policyId, BindingResult bindingResult) {
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
			policy.setPolicyId(policyId);
			policyService.updatePolicyUser(policy);

			reloadCache();
		} catch(DataAccessException e) {
			statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
			errorCode = "db.exception";
			message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
			log.info("@@ db.exception. message = {}", message);
		} catch(RuntimeException e) {
			statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
			errorCode = "runtime.exception";
			message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
			log.info("@@ runtime.exception. message = {}", message);
		} catch(Exception e) {
			statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
			errorCode = "unknown.exception";
			message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
			log.info("@@ exception. message = {}", message);
		}
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
    }

    @PostMapping(value = "/password/{policyId}")
    public Map<String, Object> updatePassword(@Valid Policy policy, @PathVariable Long policyId, BindingResult bindingResult) {
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
			policy.setPolicyId(policyId);
			policyService.updatePolicyPassword(policy);

			reloadCache();
		} catch(DataAccessException e) {
			statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
			errorCode = "db.exception";
			message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
			log.info("@@ db.exception. message = {}", message);
		} catch(RuntimeException e) {
			statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
			errorCode = "runtime.exception";
			message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
			log.info("@@ runtime.exception. message = {}", message);
		} catch(Exception e) {
			statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
			errorCode = "unknown.exception";
			message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
			log.info("@@ exception. message = {}", message);
		}
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
    }

    @PostMapping(value = "/notice/{policyId}")
    public Map<String, Object> updateNotice(@Valid Policy policy, @PathVariable Long policyId, BindingResult bindingResult) {
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
			policy.setPolicyId(policyId);
			policyService.updatePolicyNotice(policy);

			reloadCache();
		} catch(DataAccessException e) {
			statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
			errorCode = "db.exception";
			message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
			log.info("@@ db.exception. message = {}", message);
		} catch(RuntimeException e) {
			statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
			errorCode = "runtime.exception";
			message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
			log.info("@@ runtime.exception. message = {}", message);
		} catch(Exception e) {
			statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
			errorCode = "unknown.exception";
			message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
			log.info("@@ exception. message = {}", message);
		}
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
    }

    @PostMapping(value = "/security/{policyId}")
    public Map<String, Object> updateSecurity(@Valid Policy policy, @PathVariable Long policyId, BindingResult bindingResult) {
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
			policy.setPolicyId(policyId);
			policyService.updatePolicySecurity(policy);

			reloadCache();
		} catch(DataAccessException e) {
			statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
			errorCode = "db.exception";
			message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
			log.info("@@ db.exception. message = {}", message);
		} catch(RuntimeException e) {
			statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
			errorCode = "runtime.exception";
			message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
			log.info("@@ runtime.exception. message = {}", message);
		} catch(Exception e) {
			statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
			errorCode = "unknown.exception";
			message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
			log.info("@@ exception. message = {}", message);
		}
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
    }

    @PostMapping(value = "/content/{policyId}")
    public Map<String, Object> updateContent(@Valid Policy policy, @PathVariable Long policyId, BindingResult bindingResult) {
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
			policy.setPolicyId(policyId);
			policyService.updatePolicyContent(policy);

			reloadCache();
		} catch(DataAccessException e) {
			statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
			errorCode = "db.exception";
			message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
			log.info("@@ db.exception. message = {}", message);
		} catch(RuntimeException e) {
			statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
			errorCode = "runtime.exception";
			message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
			log.info("@@ runtime.exception. message = {}", message);
		} catch(Exception e) {
			statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
			errorCode = "unknown.exception";
			message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
			log.info("@@ exception. message = {}", message);
		}
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
    }

    @PostMapping(value = "/upload/{policyId}")
    public Map<String, Object> updateUserUpload(@Valid Policy policy, @PathVariable Long policyId, BindingResult bindingResult) {
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
			policy.setPolicyId(policyId);
			policyService.updatePolicyUserUpload(policy);

			reloadCache();
		} catch(DataAccessException e) {
			statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
			errorCode = "db.exception";
			message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
			log.info("@@ db.exception. message = {}", message);
		} catch(RuntimeException e) {
			statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
			errorCode = "runtime.exception";
			message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
			log.info("@@ runtime.exception. message = {}", message);
		} catch(Exception e) {
			statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
			errorCode = "unknown.exception";
			message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
			log.info("@@ exception. message = {}", message);
		}
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
