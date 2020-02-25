package ndtp.controller;

import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;
import ndtp.domain.GeoPolicy;
import ndtp.service.GeoPolicyService;

/**
 * @author hansangkim
 *
 */
@Controller
@RequestMapping("/guide")
public class GuideController {

	@Autowired
	private GeoPolicyService geoPolicyService;
	@Autowired
	private ObjectMapper objectMapper;

	/**
	 * @param request
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/help")
	public String gotoApiHelp(HttpServletRequest request, Model model) {

		GeoPolicy geoPolicy = geoPolicyService.getGeoPolicy();
		try {
			model.addAttribute("geoPolicyJson", objectMapper.writeValueAsString(geoPolicy));
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "/guide/layout";
	}
	
	@GetMapping(value = "/loadPage")
	public String gotoApiToggle(HttpServletRequest request, @RequestParam(value = "str")String str) {
		System.out.println("Ssssssssss");
		return "/guide/"+str;
	}
}