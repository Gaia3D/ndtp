package ndtp.controller.rest;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import ndtp.domain.MjBuild;
import ndtp.service.MjBuildService;

@RestController
@RequestMapping("/mj-build")
public class MjBuildController {
	
	private final MjBuildService mjBuildService;
	
	public MjBuildController(MjBuildService mjBuildService) {
		this.mjBuildService = mjBuildService;
	}

	@GetMapping
	public Map<String, Object> list(HttpServletRequest request, MjBuild mjBuild) {
		
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		int statusCode = HttpStatus.OK.value();
		
		result.put("mjBuildInfo", mjBuildService.getDataInfo(mjBuild));
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

}
