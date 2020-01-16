package ndtp.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import ndtp.domain.Key;
import ndtp.domain.UserPolicy;
import ndtp.domain.UserSession;
import ndtp.service.UserPolicyService;

@RequestMapping("/user-policy/")
@Controller
public class UserPolicyController {

    @Autowired
    UserPolicyService userPolicyService;

    @PostMapping("update")
    @ResponseBody
    public Map<String, Object> updateUserPolicy(HttpServletRequest request, UserPolicy userPolicy) {
    	Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
    	try {
//        	String roleCheckResult = roleValidator(request);
//    		if(roleCheckResult != null) {
//    			Map<String, Object> result = new HashMap<>();
//    	        result.put("statusCode", HttpStatus.FORBIDDEN.value());
//    	        result.put("error", new APIError("권한이 존재하지 않습니다."));
//    	        return new ResponseEntity<>(result, HttpStatus.FORBIDDEN);
//    		}

    		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
            String userId = userSession.getUserId();
            userPolicy.setUserId(userId);
            userPolicyService.updateUserPolicy(userPolicy);

        } catch(Exception e) {
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


//    private String roleValidator(HttpServletRequest request) {
//		UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
//		List<String> userGroupRoleKeyList = CacheManager.getUserGroupRoleKeyList(userSession.getUserGroupId());
//        if(!RoleSupport.isUserGroupRoleValid(userGroupRoleKeyList, RoleKey.USER_POLICY_ALL.name())) {
//			return "403";
//		}
//		return null;
//	}
}
