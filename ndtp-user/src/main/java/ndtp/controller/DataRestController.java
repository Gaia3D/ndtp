package ndtp.controller;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;
import ndtp.config.PropertiesConfig;
import ndtp.domain.DataGroup;
import ndtp.domain.DataInfo;
import ndtp.domain.Key;
import ndtp.domain.PageType;
import ndtp.domain.Pagination;
import ndtp.domain.UserSession;
import ndtp.service.DataGroupService;
import ndtp.service.DataService;
import ndtp.service.GeoPolicyService;
import ndtp.service.PolicyService;
import ndtp.utils.DateUtils;

@Slf4j
@RestController
@RequestMapping("/datas")
public class DataRestController {
	private static final long PAGE_ROWS = 5l;
	private static final long PAGE_LIST_COUNT = 5l;
	
	@Autowired
	private DataGroupService dataGroupService;
	@Autowired
	private DataService dataService;

	@Autowired
	private GeoPolicyService geoPolicyService;
	
	@Autowired
	private ObjectMapper objectMapper;
	@Autowired
	private PolicyService policyService;
	
	@Autowired
	private PropertiesConfig propertiesConfig;
	
	/**
	 * 데이터 그룹 정보
	 * @param projectId
	 * @return
	 */
	@GetMapping(value = "/{dataGroupId}/list")
	public Map<String, Object> allList(HttpServletRequest request, @PathVariable Integer dataGroupId) {
		
		log.info("@@@@@ list dataGroupId = {}", dataGroupId);
		
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
			
			DataInfo dataInfo = new DataInfo();
			//dataInfo.setUserId(userSession.getUserId());
			dataInfo.setDataGroupId(dataGroupId);
			List<DataInfo> dataInfoList = dataService.getAllListData(dataInfo);
			result.put("dataInfoList", dataInfoList);
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
	 * 데이터 그룹 정보
	 * @param projectId
	 * @return
	 */
	@GetMapping
	public Map<String, Object> list(HttpServletRequest request, DataInfo dataInfo, @RequestParam(defaultValue="1") String pageNo) {
		
		log.info("@@@@@ list dataInfo = {}, pageNo = {}", dataInfo, pageNo);
		
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		try {
			//dataInfo.setUserId(userSession.getUserId());
			if(!StringUtils.isEmpty(dataInfo.getStartDate())) {
				dataInfo.setStartDate(dataInfo.getStartDate().substring(0, 8) + DateUtils.START_TIME);
			}
			if(!StringUtils.isEmpty(dataInfo.getEndDate())) {
				dataInfo.setEndDate(dataInfo.getEndDate().substring(0, 8) + DateUtils.END_TIME);
			}
			
			long totalCount = dataService.getDataTotalCount(dataInfo);
			
			Pagination pagination = new Pagination(	request.getRequestURI(), 
													getSearchParameters(PageType.LIST, dataInfo), 
													totalCount, 
													Long.valueOf(pageNo).longValue(),
													PAGE_ROWS,
													PAGE_LIST_COUNT);
			log.info("@@ pagination = {}", pagination);
			
			dataInfo.setOffset(pagination.getOffset());
			dataInfo.setLimit(pagination.getPageRows());
			List<DataInfo> dataList = new ArrayList<>();
			if(totalCount > 0l) {
				dataList = dataService.getListData(dataInfo);
			}
			
			result.put("pagination", pagination);
			result.put("dataList", dataList);
			
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
	 * 데이터 그룹 정보
	 * @param projectId
	 * @return
	 */
	@GetMapping("/{dataId}")
	public Map<String, Object> detail(HttpServletRequest request, @PathVariable Long dataId) {
		
		log.info("@@@@@ dataId = {}", dataId);
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		try {
			if(dataId == null || dataId.longValue() <=0l) {
				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
				result.put("errorCode", "input.invalid");
				result.put("message", message);
				return result;
			}
			
			DataInfo dataInfo = new DataInfo();
			//dataInfo.setUserId(userSession.getUserId());
			dataInfo.setDataId(dataId);
			
			dataInfo = dataService.getData(dataInfo);
			
			result.put("dataInfo", dataInfo);
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
	 * @param search
	 * @return
	 */
	private String getSearchParameters(PageType pageType, DataInfo dataInfo) {
		StringBuffer buffer = new StringBuffer(dataInfo.getParameters());
//		buffer.append("&");
//		try {
//			buffer.append("dataName=" + URLEncoder.encode(getDefaultValue(dataInfo.getDataName()), "UTF-8"));
//		} catch(Exception e) {
//			e.printStackTrace();
//			buffer.append("dataName=");
//		}
		
		buffer.append("&");
		buffer.append("status=");
		buffer.append(dataInfo.getStatus());
		buffer.append("&");
		buffer.append("dataType=");
		buffer.append(dataInfo.getDataType());
		return buffer.toString();
	}
	
	private String getDefaultValue(String value) {
		if(value == null || "".equals(value.trim())) {
			return "";
		}
		
		return value;
	}
}
