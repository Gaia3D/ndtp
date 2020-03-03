package ndtp.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;
import ndtp.domain.DataGroup;
import ndtp.domain.DataInfoSimple;
import ndtp.domain.Key;
import ndtp.domain.LocationUdateType;
import ndtp.domain.UserSession;
import ndtp.service.DataGroupService;
import ndtp.service.DataService;
import ndtp.service.PolicyService;

@Slf4j
@RestController
@RequestMapping("/data-groups")
public class DataGroupRestController {

	@Autowired
	private DataService dataService;
	@Autowired
	private DataGroupService dataGroupService;

	@Autowired
	private ObjectMapper objectMapper;

	@Autowired
	private PolicyService policyService;

	/**
	 * 그룹Key 중복 체크
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/duplication")
	public Map<String, Object> ajaxKeyDuplicationCheck(HttpServletRequest request, DataGroup dataGroup) {
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		Boolean duplication = Boolean.TRUE;
		try {
			// TODO @Valid 로 구현해야 함
			if(StringUtils.isEmpty(dataGroup.getDataGroupKey())) {
				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
				result.put("errorCode", "data.group.key.empty");
				result.put("message", message);
				
				return result;
			}
			
			duplication = dataGroupService.isDataGroupKeyDuplication(dataGroup);
			log.info("@@ duplication = {}", duplication);
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
		
		result.put("duplication", duplication);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		
		return result;
	}
	
	/**
	 * 사용자 데이터 그룹 정보
	 * @param dataGroup
	 * @return
	 */
	@GetMapping("/{dataGroupId}")
	public Map<String, Object> detail(	HttpServletRequest request, @PathVariable Integer dataGroupId, DataGroup dataGroup ) {
		
		log.info("@@@@@ detail dataGroup = {}, dataGroupId = {}", dataGroup, dataGroupId);
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		try {
			// TODO @Valid 로 구현해야 함
			if(dataGroupId == null) {
				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
				result.put("errorCode", "input.invalid");
				result.put("message", message);
				
				return result;
			}
			
//			dataGroup.setUserId(userSession.getUserId());
//			dataGroup.setDataGroupId(dataGroupId);
			dataGroup = dataGroupService.getDataGroup(dataGroup);
			
			statusCode = HttpStatus.OK.value();
			result.put("dataGroup", dataGroup);
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
	
	/**
	 * 데이터 그룹 등록
	 * @param request
	 * @param dataGroup
	 * @param bindingResult
	 * @return
	 */
	@PostMapping
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
			if(dataGroup.getLongitude() != null && dataGroup.getLatitude() != null) {
				dataGroup.setLocationUpdateType(LocationUdateType.USER.name().toLowerCase());
				dataGroup.setLocation("POINT(" + dataGroup.getLongitude() + " " + dataGroup.getLatitude() + ")");
			}
			dataGroupService.insertDataGroup(dataGroup);
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

	/**
	 * 데이터 그룹 수정
	 * @param request
	 * @param dataGroup
	 * @param bindingResult
	 * @return
	 */
	@PostMapping("/{dataGroupId}")
	public Map<String, Object> update(HttpServletRequest request, @PathVariable Integer dataGroupId, @Valid DataGroup dataGroup, BindingResult bindingResult) {
		
		log.info("@@ dataGroup = {}", dataGroup);
		
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;

		try {
			// @Valid 로 dataGroupKey를 걸어 뒀더니 수정화면에서는 수정 불가라서 hidden으로는 보내고 싶지 않고~
			if(dataGroupId == null) {
				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
				result.put("errorCode", "input.invalid");
				result.put("message", message);
				
				return result;
			}

			if(dataGroup.getLongitude() != null && dataGroup.getLatitude() != null) {
				dataGroup.setLocationUpdateType(LocationUdateType.USER.name().toLowerCase());
				dataGroup.setLocation("POINT(" + dataGroup.getLongitude() + " " + dataGroup.getLatitude() + ")");
			}
			dataGroupService.updateDataGroup(dataGroup);
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

	/**
	 * 데이터 그룹 트리 순서 수정 (up/down)
	 * @param request
	 * @param dataGroupId
	 * @param dataGroup
	 * @return
	 */
	@PostMapping(value = "/view-order/{dataGroupId}")
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
	
	/**
	 * Smart Tiling 데이터 다운로드
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/download/{dataGroupId}")
	public String downloadSmartTiling(HttpServletRequest request, HttpServletResponse response, @PathVariable Integer dataGroupId) {
		
		log.info("@@ dataGroupId = {}", dataGroupId);
		
		if(dataGroupId != null) {
			String pattern = "^[0-9]*$";
			if(!Pattern.matches(pattern, String.valueOf(dataGroupId))) {
				log.info("@@ 유효하지 않은 데이터[숫자타입 아님] 입니다.");
				return null;
			}
		}
		
		response.setContentType("application/force-download");
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Content-Disposition", "attachment; filename=\"" + dataGroupId + ".json\"");
		
		DataGroup dataGroup = DataGroup.builder().dataGroupId(dataGroupId).build();
		dataGroup = dataGroupService.getDataGroup(dataGroup);
		
		List<DataInfoSimple> dataInfoList = dataService.getListAllDataByDataGroupId(dataGroupId);
		dataGroup.setDatas(dataInfoList);
		try {
			String dataJson = objectMapper.writeValueAsString(dataGroup);
			
			// 불필요한 코드
			dataJson = dataJson.replaceAll("<", "&lt;");
			dataJson = dataJson.replaceAll(">", "&gt;");
			response.getWriter().write(dataJson);
		} catch(JsonProcessingException e) {
			log.info("@@@@@@@@@@@@ jsonProcessing exception. message = {}", e.getCause() != null ? e.getCause().getMessage() : e.getMessage());
		} catch(RuntimeException e) {
			log.info("@@@@@@@@@@@@ runtime exception. message = {}", e.getCause() != null ? e.getCause().getMessage() : e.getMessage());
		} catch(Exception e) {
			log.info("@@@@@@@@@@@@ exception. message = {}", e.getCause() != null ? e.getCause().getMessage() : e.getMessage());
		}
			
		return null;
	}
}
