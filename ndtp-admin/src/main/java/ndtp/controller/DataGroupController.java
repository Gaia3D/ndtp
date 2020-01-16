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
import ndtp.domain.Key;
import ndtp.domain.Policy;
import ndtp.domain.UserSession;
import ndtp.service.DataGroupService;
import ndtp.service.PolicyService;

@Slf4j
@Controller
@RequestMapping("/data-group/")
public class DataGroupController {

	@Autowired
	private DataGroupService dataGroupService;

	@Autowired
	private ObjectMapper objectMapper;

	@Autowired
	private PolicyService policyService;

	/**
	 * 데이터 그룹 목록
	 * @param request
	 * @param dataGroup
	 * @param model
	 * @return
	 */
	@GetMapping(value = "list")
	public String list(HttpServletRequest request, @ModelAttribute DataGroup dataGroup, Model model) {
		List<DataGroup> dataGroupList = dataGroupService.getListDataGroup();

		model.addAttribute("dataGroupList", dataGroupList);

		return "/data/list-group";
	}

	/**
	 * 데이터 그룹 정보
	 * @param dataGroup
	 * @return
	 */
	@GetMapping(value = "detail")
	@ResponseBody
	public Map<String, Object> ajaxProject(DataGroup dataGroup) {

		log.info("@@@@@ detail-group dataGroup = {}", dataGroup);

		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		try {
			// TODO @Valid 로 구현해야 함
			if(dataGroup.getDataGroupId() == null) {
				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
				result.put("errorCode", "input.invalid");
				result.put("message", message);

				return result;
			}

			dataGroup = dataGroupService.getDataGroup(dataGroup);
			result.put("dataGroup", dataGroup);
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

	/**
    * 지도에서 위치 찾기
    * @param model
    * @return
    */
    @GetMapping(value = "location-map")
    public String locationMap(HttpServletRequest request, Model model) {

        log.info("@@ locationMap");

        Policy policy = policyService.getPolicy();
        String policyJson = "";

        try {
            policyJson = objectMapper.writeValueAsString(policy);
        } catch (Exception e) {
            e.printStackTrace();
        }

        model.addAttribute("policy", policy);
        model.addAttribute("policyJson", policyJson);

        return "/data/location-map";
    }

	/**
	 * 데이터 그룹 등록 페이지 이동
	 * @param model
	 * @return
	 */
	@GetMapping(value = "input")
	public String input(Model model) {
		Policy policy = policyService.getPolicy();

		List<DataGroup> dataGroupList = dataGroupService.getListDataGroup();

		DataGroup dataGroup = new DataGroup();
		dataGroup.setParentName(policy.getContentDataGroupRoot());
		dataGroup.setParent(0);

		model.addAttribute("policy", policy);
		model.addAttribute("dataGroup", dataGroup);
		model.addAttribute("dataGroupList", dataGroupList);

		return "/data/input-group";
	}

	/**
	 * 데이터 그룹 등록
	 * @param request
	 * @param dataGroup
	 * @param bindingResult
	 * @return
	 */
	@PostMapping(value = "insert")
	@ResponseBody
	public Map<String, Object> insert(HttpServletRequest request, @Valid @ModelAttribute DataGroup dataGroup, BindingResult bindingResult) {

		log.info("@@@@@ insert-group dataGroup = {}", dataGroup);

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

			dataGroup.setUserId(userSession.getUserId());

			dataGroupService.insertDataGroup(dataGroup);
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

	/**
	 * 데이터 그룹 트리 순서 수정 (up/down)
	 * @param request
	 * @param dataGroupId
	 * @param dataGroup
	 * @return
	 */
	@PostMapping(value = "view-order/{dataGroupId}")
	@ResponseBody
	public Map<String, Object> moveDataGroup(HttpServletRequest request, @PathVariable Integer dataGroupId, @ModelAttribute DataGroup dataGroup) {
		log.info("@@ dataGroup = {}", dataGroup);

		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		try {
			dataGroup.setDataGroupId(dataGroupId);

			int updateCount = dataGroupService.updateDataGroupViewOrder(dataGroup);
			if(updateCount == 0) {
				statusCode = HttpStatus.BAD_REQUEST.value();
				errorCode = "data.group.view-order.invalid";
			}
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

    /**
	 * 데이터 그룹 삭제
	 * @param dataGroupId
	 * @param model
	 * @return
	 */
	@GetMapping(value = "delete")
	public String delete(@RequestParam("dataGroupId") Integer dataGroupId, Model model) {

		// TODO validation 체크 해야 함
		DataGroup dataGroup = new DataGroup();
		dataGroup.setDataGroupId(dataGroupId);

		dataGroupService.deleteDataGroup(dataGroup);

		return "redirect:/data-group/list";
	}
}
