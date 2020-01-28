package ndtp.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import ndtp.domain.ApprovalStatus;
import ndtp.domain.DataGroup;
import ndtp.domain.DataInfoLog;
import ndtp.domain.Key;
import ndtp.domain.PageType;
import ndtp.domain.Pagination;
import ndtp.domain.UserSession;
import ndtp.service.DataGroupService;
import ndtp.service.DataLogService;
import ndtp.utils.DateUtils;
import ndtp.utils.FormatUtils;

/**
 * Data
 * @author jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/data/")
public class DataLogController {
	
	@Autowired
	private DataGroupService dataGroupService;
	@Autowired
	private DataLogService dataLogService;
	
	/**
	 * Data 목록
	 * @param request
	 * @param dataInfo
	 * @param pageNo
	 * @param list_counter
	 * @param model
	 * @return
	 */
	@GetMapping(value = "list-data-log")
	public String listDataLog(Locale locale, HttpServletRequest request, DataInfoLog dataInfoLog, @RequestParam(defaultValue="1") String pageNo, Model model) {
		
		log.info("@@ dataInfoLog = {}", dataInfoLog);
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		
		DataGroup dataGroup = new DataGroup();
		dataGroup.setUserId(userSession.getUserId());
		List<DataGroup> dataGroupList = dataGroupService.getListDataGroup(dataGroup);
		
		if(!StringUtils.isEmpty(dataInfoLog.getStartDate())) {
			dataInfoLog.setStartDate(dataInfoLog.getStartDate().substring(0, 8) + DateUtils.START_TIME);
		}
		if(!StringUtils.isEmpty(dataInfoLog.getEndDate())) {
			dataInfoLog.setEndDate(dataInfoLog.getEndDate().substring(0, 8) + DateUtils.END_TIME);
		}

		long totalCount = dataLogService.getDataInfoLogTotalCount(dataInfoLog);
		Pagination pagination = new Pagination(	request.getRequestURI(), 
												getSearchParameters(PageType.LIST, dataInfoLog), 
												totalCount, 
												Long.valueOf(pageNo).longValue(), 
												dataInfoLog.getListCounter());
		log.info("@@ pagination = {}", pagination);
		
		dataInfoLog.setOffset(pagination.getOffset());
		dataInfoLog.setLimit(pagination.getPageRows());
		List<DataInfoLog> dataInfoLogList = new ArrayList<>();
		if(totalCount > 0l) {
			dataInfoLogList = dataLogService.getListDataInfoLog(dataInfoLog);
		}
		
		model.addAttribute(pagination);
		model.addAttribute("dataGroupList", dataGroupList);
		model.addAttribute("dataInfoLogList", dataInfoLogList);
		return "/data/list-data-log";
	}
	
	/**
	 * Data Info Log 상태 수정
	 * @param request
	 * @param dataInfo
	 * @return
	 */
	@PostMapping(value = "update-data-log-status")
	@ResponseBody
	public Map<String, Object> updateDataInfoLogStatus(HttpServletRequest request, @Valid DataInfoLog dataInfoLog, Errors errors) {
		log.info("@@ dataInfoLog = {}", dataInfoLog);
		
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		try {
			dataInfoLog.setMethodMode("update");
			if(errors.hasErrors()) {
				message = errors.getAllErrors().get(0).getDefaultMessage();
				statusCode = HttpStatus.BAD_REQUEST.value();
				
				result.put("statusCode", statusCode);
				result.put("errorCode", "validation.error");
				result.put("message", message);
				
				return result;
            }
			
			if(ApprovalStatus.APPROVAL == ApprovalStatus.valueOf(dataInfoLog.getStatusLevel().toUpperCase())) {
				dataInfoLog.setStatus(ApprovalStatus.APPROVAL.name().toLowerCase());
			} else if(ApprovalStatus.REJECT == ApprovalStatus.valueOf(dataInfoLog.getStatusLevel().toUpperCase())) {
				dataInfoLog.setStatus(ApprovalStatus.REJECT.name().toLowerCase());
			} else if(ApprovalStatus.ROLLBACK == ApprovalStatus.valueOf(dataInfoLog.getStatusLevel().toUpperCase())) {
				dataInfoLog.setStatus(ApprovalStatus.ROLLBACK.name().toLowerCase());
			}
			
			dataLogService.updateDataInfoLogStatus(dataInfoLog);
			
			// TODO cache 갱신 되어야 함
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
	 * 검색 조건
	 * @param pageType
	 * @param dataInfoLog
	 * @return
	 */
	private String getSearchParameters(PageType pageType, DataInfoLog dataInfoLog) {
		return dataInfoLog.getParameters();
	}
}