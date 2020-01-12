package ndtp.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;
import ndtp.domain.DataGroup;
import ndtp.domain.DataInfo;
import ndtp.domain.GeoPolicy;
import ndtp.domain.PageType;
import ndtp.domain.Pagination;
import ndtp.domain.Policy;
import ndtp.domain.UploadData;
import ndtp.service.DataGroupService;
import ndtp.service.DataService;
import ndtp.service.GeoPolicyService;
import ndtp.service.PolicyService;
import ndtp.utils.DateUtils;
import ndtp.utils.FormatUtils;

@Slf4j
@Controller
@RequestMapping("/data/")
public class DataController {
	
//	@Autowired
//	private DataService dataService;
	
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
	
	/**
	 * converter job 목록
	 * @param request
	 * @param membership_id
	 * @param pageNo
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "list")
	public String list(HttpServletRequest request, DataInfo dataInfo, @RequestParam(defaultValue="1") String pageNo, Model model) {
		
//		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
//		converterJob.setUserId(userSession.getUserId());		
		log.info("@@ dataInfo = {}", dataInfo);
		
		String today = DateUtils.getToday(FormatUtils.YEAR_MONTH_DAY);
		if(StringUtils.isEmpty(dataInfo.getStartDate())) {
			dataInfo.setStartDate(today.substring(0,4) + DateUtils.START_DAY_TIME);
		} else {
			dataInfo.setStartDate(dataInfo.getStartDate().substring(0, 8) + DateUtils.START_TIME);
		}
		if(StringUtils.isEmpty(dataInfo.getEndDate())) {
			dataInfo.setEndDate(today + DateUtils.END_TIME);
		} else {
			dataInfo.setEndDate(dataInfo.getEndDate().substring(0, 8) + DateUtils.END_TIME);
		}
		
		long totalCount = dataService.getDataTotalCount(dataInfo);
		
		Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(PageType.LIST, dataInfo), totalCount, Long.valueOf(pageNo).longValue());
		log.info("@@ pagination = {}", pagination);
		
		dataInfo.setOffset(pagination.getOffset());
		dataInfo.setLimit(pagination.getPageRows());
		List<DataInfo> dataList = new ArrayList<>();
		if(totalCount > 0l) {
			dataList = dataService.getListData(dataInfo);
		}
		
		model.addAttribute(pagination);
		model.addAttribute("dataList", dataList);
		return "/data/list";
	}
	
	/**
	 * 데이터 등록 화면
	 */
	@GetMapping(value = "input")
	public String input(Model model) {
		Policy policy = policyService.getPolicy();
		UploadData uploadData = new UploadData();
		
		List<DataGroup> dataGroupList = dataGroupService.getListDataGroup();
		
		model.addAttribute("policy", policy);
		model.addAttribute("dataGroupList", dataGroupList);
		model.addAttribute("uploadData", uploadData);
		
		return "/data/input";
	}
	
	/**
	 * Data 정보
	 * @param data_id
	 * @param model
	 * @return
	 */
	@GetMapping(value = "detail")
	public String detail(HttpServletRequest request, DataInfo dataInfo, Model model) {
		
		log.info("@@@ detail-info dataInfo = {}", dataInfo);
		
		String listParameters = getSearchParameters(PageType.DETAIL, dataInfo);
		
		dataInfo =  dataService.getData(dataInfo);
		Policy policy = policyService.getPolicy();
		
		model.addAttribute("policy", policy);
		model.addAttribute("listParameters", listParameters);
		model.addAttribute("dataInfo", dataInfo);
		
		return "/data/detail-data";
	}
	
	/**
    * Map 에 데이터 표시
    * @param model
    * @return
	 * @throws JsonProcessingException 
    */
    @GetMapping(value = "map-data")
    public String mapData(HttpServletRequest request, DataInfo dataInfo, Model model) throws JsonProcessingException {
    	
    	log.info("@@ map-data. dataInfo = {}", dataInfo);

    	dataInfo = dataService.getData(dataInfo);
    	
    	GeoPolicy geoPolicy = geoPolicyService.getGeoPolicy();
    	String geoPolicyJson = "";
        try {
        	geoPolicyJson = objectMapper.writeValueAsString(geoPolicy);
        } catch (Exception e) {
            e.printStackTrace();
        }

        model.addAttribute("geoPolicyJson", geoPolicyJson);
        model.addAttribute("dataInfo", dataInfo);

        return "/data/map-data";
    }
	
	/**
	 * 검색 조건
	 * @param search
	 * @return
	 */
	private String getSearchParameters(PageType pageType, DataInfo dataInfo) {
		StringBuffer buffer = new StringBuffer(dataInfo.getParameters());
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
