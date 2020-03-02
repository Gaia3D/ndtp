package ndtp.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.slf4j.Slf4j;
import ndtp.domain.Key;
import ndtp.domain.LayerGroup;
import ndtp.domain.UserSession;
import ndtp.service.LayerGroupService;
import ndtp.service.UserPolicyService;
import ndtp.support.LayerDisplaySupport;

@Slf4j
@RestController
@RequestMapping("/layer")
public class LayerController {

	private final LayerGroupService layerGroupService;
	private final UserPolicyService userPolicyService;
	
	public LayerController(LayerGroupService layerGroupService, UserPolicyService userPolicyService) {
		this.layerGroupService = layerGroupService;
		this.userPolicyService = userPolicyService;
	}

	/**
	 * 레이어 그룹 목록
	 * @param request
	 * @param layerGroup
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/list")
	public Map<String, Object> list(HttpServletRequest request, Model model) {
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		String baseLayers = userPolicyService.getUserPolicy(userSession.getUserId()).getBaseLayers();
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		try {
			List<LayerGroup> layerGroupList = layerGroupService.getListLayerGroupAndLayer();
			result.put("layerGroupList", LayerDisplaySupport.getListDisplayLayer(layerGroupList, baseLayers));
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

}
