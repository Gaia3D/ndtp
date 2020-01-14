package ndtp.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import ndtp.config.PropertiesConfig;
import ndtp.domain.ConverterJob;
import ndtp.domain.Key;
import ndtp.domain.PageType;
import ndtp.domain.Pagination;
import ndtp.domain.UploadData;
import ndtp.domain.UserSession;
import ndtp.service.ConverterService;
import ndtp.utils.DateUtils;
import ndtp.utils.FormatUtils;

/**
 * Data Converter
 * @author jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/converter/")
public class ConverterController {
	
	@Autowired
	private PropertiesConfig propertiesConfig;
	
	@Autowired
	private ConverterService converterService;
	
	/**
	 * TODO 우선은 여기서 적당히 구현해 두고... 나중에 좀 깊이 생각해 보자. converter에 어디까지 넘겨야 할지
	 * converter job insert
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "insert")
	@ResponseBody
	public Map<String, Object> insert(HttpServletRequest request, ConverterJob converterJob) {
		log.info("@@@ converterJob = {}", converterJob);
		
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		try {
			if(converterJob.getConverterCheckIds().length() <= 0) {
				log.info("@@@@@ message = {}", message);
				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
				result.put("errorCode", "check.value.required");
				result.put("message", message);
	            return result;
			}
			if(StringUtils.isEmpty(converterJob.getTitle())) {
				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
				result.put("errorCode", "converter.title.empty");
				result.put("message", message);
	            return result;
			}
			
			UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
			converterJob.setUserId(userSession.getUserId());
			
			converterService.insertConverter(converterJob);
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
	 * converter job 목록
	 * @param request
	 * @param membership_id
	 * @param pageNo
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "list")
	public String list(HttpServletRequest request, ConverterJob converterJob, @RequestParam(defaultValue="1") String pageNo, Model model) {
		
//		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
//		converterJob.setUserId(userSession.getUserId());		
		log.info("@@ converterJob = {}", converterJob);
		
		String today = DateUtils.getToday(FormatUtils.YEAR_MONTH_DAY);
		if(StringUtils.isEmpty(converterJob.getStartDate())) {
			converterJob.setStartDate(today.substring(0,4) + DateUtils.START_DAY_TIME);
		} else {
			converterJob.setStartDate(converterJob.getStartDate().substring(0, 8) + DateUtils.START_TIME);
		}
		if(StringUtils.isEmpty(converterJob.getEndDate())) {
			converterJob.setEndDate(today + DateUtils.END_TIME);
		} else {
			converterJob.setEndDate(converterJob.getEndDate().substring(0, 8) + DateUtils.END_TIME);
		}
		
		long totalCount = converterService.getListConverterJobTotalCount(converterJob);
		
		Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(PageType.LIST, converterJob), totalCount, Long.valueOf(pageNo).longValue());
		log.info("@@ pagination = {}", pagination);
		
		converterJob.setOffset(pagination.getOffset());
		converterJob.setLimit(pagination.getPageRows());
		List<ConverterJob> converterJobList = new ArrayList<>();
		if(totalCount > 0l) {
			converterJobList = converterService.getListConverterJob(converterJob);
		}
		
		model.addAttribute(pagination);
		model.addAttribute("converterJobList", converterJobList);
		return "/converter/list";
	}
	
//	/**
//	 * converter job 파일 목록
//	 * @param request
//	 * @param membership_id
//	 * @param pageNo
//	 * @param model
//	 * @return
//	 */
//	@RequestMapping(value = "list-converter-job-file.do")
//	public String listConverterJobFile(HttpServletRequest request, ConverterJobFile converterJobFile, @RequestParam(defaultValue="1") String pageNo, Model model) {
//		
//		UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
//		converterJobFile.setUser_id(userSession.getUser_id());		
//		log.info("@@ converterJobFile = {}", converterJobFile);
//		
//		if(StringUtil.isNotEmpty(converterJobFile.getStart_date())) {
//			converterJobFile.setStart_date(converterJobFile.getStart_date().substring(0, 8) + DateUtil.START_TIME);
//		}
//		if(StringUtil.isNotEmpty(converterJobFile.getEnd_date())) {
//			converterJobFile.setEnd_date(converterJobFile.getEnd_date().substring(0, 8) + DateUtil.END_TIME);
//		}
//		long totalCount = converterService.getListConverterJobFileTotalCount(converterJobFile);
//		
//		Pagination pagination = new Pagination(request.getRequestURI(), getSearchParametersConverterJobFile(converterJobFile), totalCount, Long.valueOf(pageNo).longValue());
//		log.info("@@ pagination = {}", pagination);
//		
//		converterJobFile.setOffset(pagination.getOffset());
//		converterJobFile.setLimit(pagination.getPageRows());
//		List<ConverterJobFile> converterJobFileList = new ArrayList<>();
//		if(totalCount > 0l) {
//			converterJobFileList = converterService.getListConverterJobFile(converterJobFile);
//		}
//		
//		model.addAttribute(pagination);
//		model.addAttribute("converterJobFileList", converterJobFileList);
//		return "/converter/list-converter-job-file";
//	}
	
	/**
	 * 검색 조건
	 * @param search
	 * @return
	 */
	private String getSearchParameters(PageType pageType, ConverterJob converterJob) {
		StringBuffer buffer = new StringBuffer(converterJob.getParameters());
		boolean isListPage = true;
		if(pageType == PageType.MODIFY || pageType == PageType.DETAIL) {
			isListPage = false;
		}
		
//		if(!isListPage) {
//			buffer.append("pageNo=" + request.getParameter("pageNo"));
//			buffer.append("&");
//			buffer.append("list_count=" + uploadData.getList_counter());
//		}
		
		return buffer.toString();
	}
}