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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import ndtp.domain.Key;
import ndtp.domain.LayerGroup;
import ndtp.domain.Policy;
import ndtp.domain.UserSession;
import ndtp.service.LayerGroupService;
import ndtp.service.PolicyService;

@Slf4j
@Controller
@RequestMapping("/layer/")
public class LayerGroupController {
	
	@Autowired
	private LayerGroupService layerGroupService;

	@Autowired
	private PolicyService policyService;
	
	/**
	 * 레이어 그룹 관리
	 */
	@GetMapping(value = "list-group")
	public String list(HttpServletRequest request, @ModelAttribute LayerGroup layerGroup, Model model) {
		List<LayerGroup> layerGroupList = layerGroupService.getListLayerGroup();
		
		model.addAttribute("layerGroupList", layerGroupList);
		
		return "/layer/list-group";
	}
	
	/**
	 * 레이어 그룹 등록
	 */
	@GetMapping(value = "input-group")
	public String input(Model model) {
		Policy policy = policyService.getPolicy();
		
		List<LayerGroup> layerGroupList = layerGroupService.getListLayerGroup();
		
		LayerGroup layerGroup = new LayerGroup();
		layerGroup.setParentName(policy.getContentLayerGroupRoot());
		layerGroup.setParent(0);
		
		model.addAttribute("policy", policy);
		model.addAttribute("layerGroup", layerGroup);
		model.addAttribute("layerGroupList", layerGroupList);
		
		return "/layer/input-group";
	}
	
	/**
	 * 레이어 그룹을 등록한다.
	 */
	@PostMapping(value = "insert-group")
	@ResponseBody
	public Map<String, Object> insert(HttpServletRequest request, @Valid @ModelAttribute LayerGroup layerGroup, BindingResult bindingResult) {
		
		log.info("@@@@@ insert layerGroup = {}", layerGroup);
		
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		
		try {
			UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
			
			if(bindingResult.hasErrors()) {
				message = bindingResult.getAllErrors().get(0).getDefaultMessage();
				log.info("@@@@@ message = {}", message);
				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
				result.put("errorCode", errorCode);
				result.put("message", message);
	            return result;
			}
			
			layerGroup.setUserId(userSession.getUserId());
			
			layerGroupService.insert(layerGroup);
		} catch (Exception e) {
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
	
	
//	/**
//	 * 레이어 그룹을 수정하기 위한 페이지로 이동한다.
//	 */
//	@GetMapping(value = "group/modify/{layerGroupId}")
//	public String modify(@ModelAttribute LayerGroupDto layerGroupDto, @PathVariable int layerGroupId, Model model) {
//		List<LayerGroupDto> layerGroupList = layerGroupService.getListByDepth(1);
//		layerGroupDto = layerGroupService.read(layerGroupId);
//		LayerGroupDto parentLayer = layerGroupService.readParent(layerGroupDto.getParent());
//		List<LayerDto> groupLayer = layerService.getLayerByGroup(layerGroupId);
//		
//		model.addAttribute("parentLayer", parentLayer);
//		model.addAttribute("groups", layerGroupList);
//		model.addAttribute("layerGroup", layerGroupDto);
//		model.addAttribute("groupLayer", groupLayer);
//		
//		return "/layer/layer-group-modify";
//	}
//	
//	/**
//	 * 레이어 그룹 정보를 조회하기 위한 페이지로 이동한다.
//	 */
//	@GetMapping(value = "group/detail/{layerGroupId}")
//	public String detail(@ModelAttribute LayerGroupDto layerGroupDto, @PathVariable int layerGroupId, Model model) {
//		layerGroupDto = layerGroupService.read(layerGroupId);
//		LayerGroupDto parentLayer = layerGroupService.readParent(layerGroupDto.getParent());
//		List<LayerDto> groupLayer = layerService.getLayerByGroup(layerGroupId);
//		
//		model.addAttribute("parentLayer", parentLayer);
//		model.addAttribute("layerGroup", layerGroupDto);
//		model.addAttribute("groupLayer", groupLayer);
//		
//		return "/layer/layer-group-detail";
//	}
//	
//	/**
//	 * 레이어 그룹 정보 한 건을 조회한다.
//	 */
//	@ResponseBody
//	@GetMapping(value = "group/{layerGroupId}")
//	public Map<String, Object> read(@PathVariable int layerGroupId) {
//		String result = "success";
//		Map<String, Object> map = new HashMap<>();
//		
//		try {
//			LayerGroupDto layerGroup = layerGroupService.read(layerGroupId);
//			map.put("layerGroup", layerGroup);
//		} catch (Exception e) {
//			e.printStackTrace();
//			result = "db.exception";
//		}
//		map.put("result", result);
//		return map;
//	}

//	/**
//	 * 레이어 그룹을 수정한다.
//	 */
//	@ResponseBody
//	@PutMapping(value = "group/{layerGroupId}")
//	public String update(@PathVariable int layerGroupId, @ModelAttribute LayerGroupDto layerGroupDto, BindingResult bindingResult, RedirectAttributes redirectAttributes) {
//		String result = "success";
//		
//		if(bindingResult.hasErrors()) {
//			String errorMessage = bindingResult.getAllErrors().get(0).getDefaultMessage();
//			log.info("@@@@@ errorMessage = {}", errorMessage);
//		}
//		
//		try {
//			layerGroupDto.setLayerGroupId(layerGroupId);
//			layerGroupService.update(layerGroupDto);
//		} catch (Exception e) {
//			e.printStackTrace();
//			result = "db.exception";
//		}
//			
//		redirectAttributes.addFlashAttribute("result", result);
//		
//		return "redirect:/layer/groups";
//	}
//	
//	/**
//	 * 레이어 그룹의 나열 순서를 위로 변경한다.
//	 */
//	@ResponseBody
//	@PutMapping(value = "group/move-up/{layerGroupId}")
//	public Map<String, Object> moveToUpper(@PathVariable int layerGroupId, LayerGroupDto layerGroupDto, BindingResult bindingResult, RedirectAttributes redirectAttributes) {
//		String result = "success";
//		Map<String, Object> map = new HashMap<>();
//		
//		if(bindingResult.hasErrors()) {
//			String errorMessage = bindingResult.getAllErrors().get(0).getDefaultMessage();
//			log.info("@@@@@ errorMessage = {}", errorMessage);
//		}
//		
//		try {
//			layerGroupDto = layerGroupService.moveToUpper(layerGroupId);
//			map.put("layerGroup", layerGroupDto);
//			
//		} catch (Exception e) {
//			e.printStackTrace();
//			result = "db.exception";
//		}
//			
//		map.put("result", result);
//		
//		return map;
//	}
//	
//	/**
//	 * 레이어 그룹의 나열 순서를 아래로 변경한다.
//	 */
//	@ResponseBody
//	@PutMapping(value = "group/move-low/{layerGroupId}")
//	public Map<String, Object> moveToLower(@PathVariable int layerGroupId, LayerGroupDto layerGroupDto, BindingResult bindingResult, RedirectAttributes redirectAttributes) {
//		String result = "success";
//		Map<String, Object> map = new HashMap<>();
//		
//		if(bindingResult.hasErrors()) {
//			String errorMessage = bindingResult.getAllErrors().get(0).getDefaultMessage();
//			log.info("@@@@@ errorMessage = {}", errorMessage);
//		}
//		
//		try {
//			layerGroupDto = layerGroupService.moveToLower(layerGroupId);
//			map.put("layerGroup", layerGroupDto);
//			
//		} catch (Exception e) {
//			e.printStackTrace();
//			result = "db.exception";
//		}
//			
//		map.put("result", result);
//		
//		return map;
//	}
//	
//	/**
//	 * 레이어 그룹을 삭제한다.
//	 */
//	@ResponseBody
//	@DeleteMapping(value = "group/{layerGroupId}")
//	public String delete(@PathVariable int layerGroupId, RedirectAttributes redirectAttributes) {
//		String result = "success";
//		
//		try {
//			// 하위 그룹 및 하위 레이어도 같이 삭제됨
//			layerGroupService.delete(layerGroupId);
//		} catch (Exception e) {
//			e.printStackTrace();
//			result = "db.exception";
//		}
//			
//		redirectAttributes.addFlashAttribute("result", result);
//		return "redirect:/layer/groups";
//	}
}
