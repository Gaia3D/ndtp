package ndtp.restcontroller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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
public class LayerRestController {

	private final LayerGroupService layerGroupService;
	private final UserPolicyService userPolicyService;
	
	public LayerRestController(LayerGroupService layerGroupService, UserPolicyService userPolicyService) {
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
		String errorCode = null;
		String message = null;
		
		List<LayerGroup> layerGroupList = layerGroupService.getListLayerGroupAndLayer();
		int statusCode = HttpStatus.OK.value();
		
		result.put("layerGroupList", LayerDisplaySupport.getListDisplayLayer(layerGroupList, baseLayers));
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		
		return result;
	}
}
