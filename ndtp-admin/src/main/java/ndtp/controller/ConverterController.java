package ndtp.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import ndtp.config.PropertiesConfig;
import ndtp.domain.ConverterJob;
import ndtp.domain.Key;
import ndtp.domain.UserSession;
import ndtp.service.ConverterService;

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
	
//	@Autowired
//	private ConverterService converterService;
	
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
			
//			converterService.insertConverter(converterJob);
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
	
//	/**
//	 * converter job 목록
//	 * @param request
//	 * @param membership_id
//	 * @param pageNo
//	 * @param model
//	 * @return
//	 */
//	@RequestMapping(value = "list-converter-job.do")
//	public String listConverterJob(HttpServletRequest request, ConverterJob converterJob, @RequestParam(defaultValue="1") String pageNo, Model model) {
//		
//		UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
//		converterJob.setUser_id(userSession.getUser_id());		
//		log.info("@@ converterJob = {}", converterJob);
//		
//		if(StringUtil.isNotEmpty(converterJob.getStart_date())) {
//			converterJob.setStart_date(converterJob.getStart_date().substring(0, 8) + DateUtil.START_TIME);
//		}
//		if(StringUtil.isNotEmpty(converterJob.getEnd_date())) {
//			converterJob.setEnd_date(converterJob.getEnd_date().substring(0, 8) + DateUtil.END_TIME);
//		}
//		long totalCount = converterService.getListConverterJobTotalCount(converterJob);
//		
//		Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(converterJob), totalCount, Long.valueOf(pageNo).longValue());
//		log.info("@@ pagination = {}", pagination);
//		
//		converterJob.setOffset(pagination.getOffset());
//		converterJob.setLimit(pagination.getPageRows());
//		List<ConverterJob> converterJobList = new ArrayList<>();
//		if(totalCount > 0l) {
//			converterJobList = converterService.getListConverterJob(converterJob);
//		}
//		
//		model.addAttribute(pagination);
//		model.addAttribute("converterJobList", converterJobList);
//		return "/converter/list-converter-job";
//	}
//	
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
	
//	/**
//	 * 검색 조건
//	 * @param dataInfo
//	 * @return
//	 */
//	private String getSearchParameters(ConverterJob converterJob) {
//		StringBuffer buffer = new StringBuffer();
//		buffer.append("&");
//		buffer.append("search_word=" + StringUtil.getDefaultValue(converterJob.getSearch_word()));
//		buffer.append("&");
//		buffer.append("search_option=" + StringUtil.getDefaultValue(converterJob.getSearch_option()));
//		buffer.append("&");
//		try {
//			buffer.append("search_value=" + URLEncoder.encode(StringUtil.getDefaultValue(converterJob.getSearch_value()), "UTF-8"));
//		} catch(Exception e) {
//			e.printStackTrace();
//			buffer.append("search_value=");
//		}
//		buffer.append("&");
//		buffer.append("start_date=" + StringUtil.getDefaultValue(converterJob.getStart_date()));
//		buffer.append("&");
//		buffer.append("end_date=" + StringUtil.getDefaultValue(converterJob.getEnd_date()));
//		buffer.append("&");
//		buffer.append("order_word=" + StringUtil.getDefaultValue(converterJob.getOrder_word()));
//		buffer.append("&");
//		buffer.append("order_value=" + StringUtil.getDefaultValue(converterJob.getOrder_value()));
//		return buffer.toString();
//	}
//	
//	/**
//	 * 파일 검색 조건
//	 * @param dataInfo
//	 * @return
//	 */
//	private String getSearchParametersConverterJobFile(ConverterJobFile converterJobFile) {
//		StringBuffer buffer = new StringBuffer();
//		buffer.append("&");
//		buffer.append("search_word=" + StringUtil.getDefaultValue(converterJobFile.getSearch_word()));
//		buffer.append("&");
//		buffer.append("search_option=" + StringUtil.getDefaultValue(converterJobFile.getSearch_option()));
//		buffer.append("&");
//		try {
//			buffer.append("search_value=" + URLEncoder.encode(StringUtil.getDefaultValue(converterJobFile.getSearch_value()), "UTF-8"));
//		} catch(Exception e) {
//			e.printStackTrace();
//			buffer.append("search_value=");
//		}
//		buffer.append("&");
//		buffer.append("start_date=" + StringUtil.getDefaultValue(converterJobFile.getStart_date()));
//		buffer.append("&");
//		buffer.append("end_date=" + StringUtil.getDefaultValue(converterJobFile.getEnd_date()));
//		buffer.append("&");
//		buffer.append("order_word=" + StringUtil.getDefaultValue(converterJobFile.getOrder_word()));
//		buffer.append("&");
//		buffer.append("order_value=" + StringUtil.getDefaultValue(converterJobFile.getOrder_value()));
//		return buffer.toString();
//	}
}