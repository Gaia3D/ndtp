package ndtp.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;
import ndtp.domain.DataGroup;
import ndtp.domain.DataInfo;
import ndtp.domain.Key;
import ndtp.domain.Policy;
import ndtp.domain.UploadData;
import ndtp.domain.UserSession;
import ndtp.service.DataGroupService;
import ndtp.service.PolicyService;

@Slf4j
@Controller
@RequestMapping("/data/")
public class DataController {
	
//	@Autowired
//	private DataService dataService;

	@Autowired
	private ObjectMapper objectMapper;
	
	@Autowired
	private PolicyService policyService;
	
//	/**
//	 * 데이터 그룹 관리
//	 */
//	@GetMapping(value = "list")
//	public String list(HttpServletRequest request, @ModelAttribute DataGroup dataGroup, Model model) {
//		List<DataGroup> dataGroupList = dataGroupService.getListDataGroup();
//		
//		model.addAttribute("dataGroupList", dataGroupList);
//		
//		return "/data/list-group";
//	}
	
	/**
	 * 데이터 등록 화면
	 */
	@GetMapping(value = "input")
	public String input(Model model) {
		Policy policy = policyService.getPolicy();
		UploadData uploadData = new UploadData();
		
		model.addAttribute("policy", policy);
		model.addAttribute("uploadData", uploadData);
		
		return "/data/input";
	}
}
