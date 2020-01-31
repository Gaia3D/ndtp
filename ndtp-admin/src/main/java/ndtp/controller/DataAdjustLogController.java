package ndtp.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.extern.slf4j.Slf4j;
import ndtp.domain.DataGroup;
import ndtp.domain.DataInfoAdjustLog;
import ndtp.domain.Key;
import ndtp.domain.PageType;
import ndtp.domain.Pagination;
import ndtp.domain.UserSession;
import ndtp.service.DataAdjustLogService;
import ndtp.service.DataGroupService;
import ndtp.service.DataService;
import ndtp.utils.DateUtils;

/**
 * 데이터 geometry 변경 이력
 * @author jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/data-adjust-log")
public class DataAdjustLogController {
	
	@Autowired
	private DataService dataService;
	@Autowired
	private DataGroupService dataGroupService;
	@Autowired
	private DataAdjustLogService dataAdjustLogService;
	
	/**
	 * 데이터 geometry 변경 이력 목록
	 * @param locale
	 * @param request
	 * @param dataInfoAdjustLog
	 * @param pageNo
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/list")
	public String list(Locale locale, HttpServletRequest request, DataInfoAdjustLog dataInfoAdjustLog, @RequestParam(defaultValue="1") String pageNo, Model model) {
		
		log.info("@@ dataInfoAdjustLog = {}", dataInfoAdjustLog);
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		
		DataGroup dataGroup = new DataGroup();
		dataGroup.setUserId(userSession.getUserId());
		List<DataGroup> dataGroupList = dataGroupService.getListDataGroup(dataGroup);
		
		if(!StringUtils.isEmpty(dataInfoAdjustLog.getStartDate())) {
			dataInfoAdjustLog.setStartDate(dataInfoAdjustLog.getStartDate().substring(0, 8) + DateUtils.START_TIME);
		}
		if(!StringUtils.isEmpty(dataInfoAdjustLog.getEndDate())) {
			dataInfoAdjustLog.setEndDate(dataInfoAdjustLog.getEndDate().substring(0, 8) + DateUtils.END_TIME);
		}

		long totalCount = dataAdjustLogService.getDataAdjustLogTotalCount(dataInfoAdjustLog);
		Pagination pagination = new Pagination(	request.getRequestURI(), 
												getSearchParameters(PageType.LIST, dataInfoAdjustLog), 
												totalCount, 
												Long.valueOf(pageNo).longValue(), 
												dataInfoAdjustLog.getListCounter());
		log.info("@@ pagination = {}", pagination);
		
		dataInfoAdjustLog.setOffset(pagination.getOffset());
		dataInfoAdjustLog.setLimit(pagination.getPageRows());
		List<DataInfoAdjustLog> dataAdjustLogList = new ArrayList<>();
		if(totalCount > 0l) {
			dataAdjustLogList = dataAdjustLogService.getListDataAdjustLog(dataInfoAdjustLog);
		}
		
		model.addAttribute(pagination);
		model.addAttribute("dataGroupList", dataGroupList);
		model.addAttribute("dataAdjustLogList", dataAdjustLogList);
		return "/data-adjust-log/list";
	}
	
	/**
	 * 검색 조건
	 * @param pageType
	 * @param dataInfoAdjustLog
	 * @return
	 */
	private String getSearchParameters(PageType pageType, DataInfoAdjustLog dataInfoAdjustLog) {
		return dataInfoAdjustLog.getParameters();
	}
}