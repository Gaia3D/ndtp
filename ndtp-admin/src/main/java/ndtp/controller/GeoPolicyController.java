package ndtp.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;
import ndtp.domain.GeoPolicy;
import ndtp.service.GeoPolicyService;

@Slf4j
@Controller
@RequestMapping("/geopolicy")
public class GeoPolicyController {

	private final GeoPolicyService geoPolicyService;

	public GeoPolicyController(GeoPolicyService geoPolicyService) {
		this.geoPolicyService = geoPolicyService;
	}

	@GetMapping(value = "/modify")
	public String modify(HttpServletRequest reuqet, Model model) {
		GeoPolicy geoPolicy = geoPolicyService.getGeoPolicy();

		model.addAttribute("geoPolicy", geoPolicy);

		return "/geopolicy/modify";
	}

}
