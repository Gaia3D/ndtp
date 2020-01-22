package ndtp.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import ndtp.domain.LayerGroup;
import ndtp.service.LayerGroupService;

@RestController
@RequestMapping("/layer")
public class LayerController {

	private final LayerGroupService layerGroupService;
	
	public LayerController(LayerGroupService layerGroupService) {
		this.layerGroupService = layerGroupService;
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
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		try {
			List<LayerGroup> layerGroupList = layerGroupService.getListLayerGroupAndLayer();
			result.put("layerGroupList", layerGroupList);
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
