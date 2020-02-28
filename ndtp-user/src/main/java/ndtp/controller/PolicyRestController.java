package ndtp.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.slf4j.Slf4j;
import ndtp.domain.CacheManager;
import ndtp.domain.GeoPolicy;
import ndtp.domain.Key;
import ndtp.domain.LayerGroup;
import ndtp.domain.UserPolicy;
import ndtp.domain.UserSession;
import ndtp.service.LayerGroupService;
import ndtp.service.UserPolicyService;
import ndtp.support.LayerDisplaySupport;

/**
 * 초기 로딩 policy init
 * @author PSH
 *
 */
@Slf4j
@RestController
@RequestMapping("/policy/")
public class PolicyRestController {
	
	private final UserPolicyService userPolicyService;
	private final LayerGroupService layerGroupService;
	
	public PolicyRestController(UserPolicyService userPolicyService, LayerGroupService layerGroupService) {
		this.userPolicyService = userPolicyService;
		this.layerGroupService = layerGroupService;
	}
	
	@GetMapping
	public Map<String, Object> init(HttpServletRequest request) {
		log.info("@@ Policy init");
		
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		try {
			UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
			GeoPolicy geoPolicy = CacheManager.getGeoPolicy();
			UserPolicy userPolicy = userPolicyService.getUserPolicy(userSession.getUserId());
			if(userPolicy.getUserId() != null) {
				geoPolicy.setInitLatitude(userPolicy.getInitLatitude());
				geoPolicy.setInitLongitude(userPolicy.getInitLongitude());
				geoPolicy.setInitAltitude(userPolicy.getInitAltitude());
				geoPolicy.setInitDuration(userPolicy.getInitDuration());
				geoPolicy.setInitDefaultFov(userPolicy.getInitDefaultFov());
				geoPolicy.setLod0(userPolicy.getLod0());
				geoPolicy.setLod1(userPolicy.getLod1());
				geoPolicy.setLod2(userPolicy.getLod2());
				geoPolicy.setLod3(userPolicy.getLod3());
				geoPolicy.setLod4(userPolicy.getLod4());
				geoPolicy.setLod5(userPolicy.getLod5());
				geoPolicy.setSsaoRadius(userPolicy.getSsaoRadius());
			}
			List<LayerGroup> baseLayers = LayerDisplaySupport.getListDisplayLayer(layerGroupService.getListLayerGroupAndLayer(), userPolicy.getBaseLayers());
			result.put("geoPolicy", geoPolicy);
			result.put("baseLayers", baseLayers);
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
}
