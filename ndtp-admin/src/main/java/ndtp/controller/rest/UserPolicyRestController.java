package ndtp.controller.rest;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.slf4j.Slf4j;
import ndtp.domain.Key;
import ndtp.domain.UserPolicy;
import ndtp.domain.UserSession;
import ndtp.service.UserPolicyService;

@Slf4j
@RestController
@RequestMapping("/user-policy")
public class UserPolicyRestController {

    @Autowired
    UserPolicyService userPolicyService;

    @PostMapping("/update")
    public Map<String, Object> updateUserPolicy(HttpServletRequest request, @Valid UserPolicy userPolicy, BindingResult bindingResult) {
    	
    	Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		if(bindingResult.hasErrors()) {
			message = bindingResult.getAllErrors().get(0).getDefaultMessage();
			result.put("statusCode", HttpStatus.BAD_REQUEST.value());
			result.put("errorCode", errorCode);
			result.put("message", message);
            return result;
		}

		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
        String userId = userSession.getUserId();
        userPolicy.setUserId(userId);
        userPolicyService.updateUserPolicy(userPolicy);
        int statusCode = HttpStatus.OK.value();
    	
    	result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
    }
    
    @PostMapping("/update/{baseLayers}")
    public Map<String, Object> updateBaseLayers(HttpServletRequest request, @PathVariable String baseLayers) {
    	Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
        
		String userId = userSession.getUserId();
        UserPolicy userPolicy = UserPolicy.builder()
        						.baseLayers(baseLayers)
        						.userId(userId)
        						.build();
        userPolicyService.updateUserPolicy(userPolicy);
        int statusCode = HttpStatus.OK.value();
    	
    	result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
    }


//    private String roleValidator(HttpServletRequest request) {
//		UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
//		List<String> userGroupRoleKeyList = CacheManager.getUserGroupRoleKeyList(userSession.getUserGroupId());
//        if(!RoleSupport.isUserGroupRoleValid(userGroupRoleKeyList, RoleKey.USER_POLICY_ALL.name())) {
//			return "403";
//		}
//		return null;
//	}
}
