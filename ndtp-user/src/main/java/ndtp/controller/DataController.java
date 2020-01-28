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

import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;
import ndtp.config.PropertiesConfig;
import ndtp.domain.DataGroup;
import ndtp.domain.DataInfo;
import ndtp.domain.GeoPolicy;
import ndtp.domain.Key;
import ndtp.domain.PageType;
import ndtp.domain.Pagination;
import ndtp.domain.SharingType;
import ndtp.domain.UserPolicy;
import ndtp.domain.UserSession;
import ndtp.service.DataGroupService;
import ndtp.service.DataService;
import ndtp.service.GeoPolicyService;
import ndtp.service.PolicyService;
import ndtp.service.UserPolicyService;
import ndtp.utils.DateUtils;

@Slf4j
@Controller
@RequestMapping("/data")
public class DataController {
	
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
	private UserPolicyService userPolicyService;
	
	@Autowired
	private PropertiesConfig propertiesConfig;
	
	/**
	 * 데이터 목록
	 * @param request
	 * @param dataInfo
	 * @param pageNo
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/list")
	public String list(HttpServletRequest request, DataInfo dataInfo, @RequestParam(defaultValue="1") String pageNo, Model model) {
		
		log.info("@@ dataInfo = {}, pageNo = {}", dataInfo, pageNo);
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
//		dataInfo.setUserId(userSession.getUserId());		
		
		if(!StringUtils.isEmpty(dataInfo.getStartDate())) {
			dataInfo.setStartDate(dataInfo.getStartDate().substring(0, 8) + DateUtils.START_TIME);
		}
		if(!StringUtils.isEmpty(dataInfo.getEndDate())) {
			dataInfo.setEndDate(dataInfo.getEndDate().substring(0, 8) + DateUtils.END_TIME);
		}
		
		long totalCount = dataService.getDataTotalCount(dataInfo);
		
		Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(PageType.LIST, dataInfo), totalCount, Long.valueOf(pageNo).longValue());
		log.info("@@ pagination = {}", pagination);
		
		dataInfo.setOffset(pagination.getOffset());
		dataInfo.setLimit(pagination.getPageRows());
		List<DataInfo> dataInfoList = new ArrayList<>();
		if(totalCount > 0l) {
			dataInfoList = dataService.getListData(dataInfo);
		}
		
		model.addAttribute(pagination);
		model.addAttribute("owner", userSession.getUserId());
		model.addAttribute("dataInfoList", dataInfoList);
		return "/data/list";
	}
	
	/**
	 * converter job 목록
	 * @param request
	 * @param membership_id
	 * @param pageNo
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/map")
	public String map(	HttpServletRequest request, 
						DataInfo dataInfo, 
						@RequestParam(defaultValue="1") String pageNo, 
						Model model) {
		
		log.info("@@ DataController list dataInfo = {}, pageNo = {}", dataInfo, pageNo);
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		
		GeoPolicy geoPolicy = geoPolicyService.getGeoPolicy();
		UserPolicy userPolicy = userPolicyService.getUserPolicy(userSession.getUserId());
		if(userPolicy.getUserId() != null) {
			geoPolicy.setInitLatitude(userPolicy.getInitLatitude());
			geoPolicy.setInitLongitude(userPolicy.getInitLongitude());
			geoPolicy.setInitAltitude(userPolicy.getInitAltitude());
			geoPolicy.setInitDuration(userPolicy.getInitDuration());
			geoPolicy.setInitDefaultFov(userPolicy.getInitDefaultFov());
			geoPolicy.setLod0(userPolicy.getLod0());
			geoPolicy.setLod1(userPolicy.getLod1());
			geoPolicy.setLod2(userPolicy.getLod2());
			geoPolicy.setLod3(userPolicy.getLod3());
			geoPolicy.setLod4(userPolicy.getLod4());
			geoPolicy.setLod5(userPolicy.getLod5());
			geoPolicy.setSsaoRadius(userPolicy.getSsaoRadius());
		}
		
		String geoPolicyJson = "";
		try {
			geoPolicyJson = objectMapper.writeValueAsString(geoPolicy);
		} catch(Exception e) {
			log.info("@@ objectMapper exception");
			e.printStackTrace();
		}
		
		Long commonDataCount = 0l;
		Long publicDataCount = 0l;
		Long privateDataCount = 0l;
		Long groupDataCount = 0l;
		// 그룹별 통계
		List<DataInfo> groupDataCountList = dataService.getDataTotalCountBySharing(userSession.getUserId());
		for(DataInfo statisticDataInfo : groupDataCountList) {
			if(SharingType.COMMON == SharingType.valueOf(statisticDataInfo.getSharing().toUpperCase())) {
				commonDataCount = statisticDataInfo.getDataCount();
			} else if(SharingType.PUBLIC == SharingType.valueOf(statisticDataInfo.getSharing().toUpperCase())) {
				publicDataCount = statisticDataInfo.getDataCount();
			} else if(SharingType.PRIVATE == SharingType.valueOf(statisticDataInfo.getSharing().toUpperCase())) {
				privateDataCount = statisticDataInfo.getDataCount();
			} else if(SharingType.GROUP == SharingType.valueOf(statisticDataInfo.getSharing().toUpperCase())) {
				groupDataCount = statisticDataInfo.getDataCount();
			}
		}
		
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
		
		// 데이터 그룹
		DataGroup dataGroup = new DataGroup();
		dataGroup.setUserId(userSession.getUserId());
		List<DataGroup> dataGroupList = dataGroupService.getAllListDataGroup(dataGroup);
		
		model.addAttribute(pagination);
		
		model.addAttribute("totalCount", totalCount);
		
		model.addAttribute("dataGroupTotalCount", groupDataCountList.size());
		model.addAttribute("commonDataCount", commonDataCount);
		model.addAttribute("publicDataCount", publicDataCount);
		model.addAttribute("privateDataCount", privateDataCount);
		model.addAttribute("groupDataCount", groupDataCount);
		
		model.addAttribute("dataList", dataList);
		model.addAttribute("dataGroupList", dataGroupList);
		model.addAttribute("userPolicy", userPolicy);
		model.addAttribute("geoPolicyJson", geoPolicyJson);
		model.addAttribute("baseLayers", userPolicy.getBaseLayers());
		
		return "/data/map";
	}
	
	/**
	 * 사용자 데이터 수정 화면
	 * @param request
	 * @param dataId
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/modify")
	public String modify(HttpServletRequest request, @RequestParam("dataId") Long dataId, Model model) {
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		
		DataInfo dataInfo = new DataInfo();
		//dataInfo.setUserId(userSession.getUserId());
		dataInfo.setDataId(dataId);
		
		dataInfo = dataService.getData(dataInfo);
		if(!userSession.getUserId().equals(dataInfo.getUserId())) {
			// 자신이 등록한 데이터가 아니면 수정할 수 없음
			return "redirect:/data-logs/modify?dataId=" + dataInfo.getDataId();
		}
		
		model.addAttribute("dataInfo", dataInfo);
		
		return "/data/modify";
	}

//	
//	/**
//	 * Data 정보(ajax용) - 중복이라 맘이 안 편함... 뭔가 좋은 방법이 없을까?
//	 * @param request
//	 * @param dataInfo
//	 * @return
//	 */
//	@GetMapping(value = "detail-data-info")
//	@ResponseBody
//	public Map<String, Object> detailDataInfo(HttpServletRequest request, DataInfo dataInfo) {
//		log.info("@@ dataInfo = {}", dataInfo);
//		
//		Map<String, Object> result = new HashMap<>();
//		int statusCode = 0;
//		String errorCode = null;
//		String message = null;
//		try {
//			dataInfo =  dataService.getData(dataInfo);
//			result.put("dataInfo", dataInfo);
//		} catch(Exception e) {
//			e.printStackTrace();
//            statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
//            errorCode = "db.exception";
//            message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
//		}
//		
//		result.put("statusCode", statusCode);
//		result.put("errorCode", errorCode);
//		result.put("message", message);
//		return result;
//	}
//	
//	/**
//	 * Data Attribute 정보
//	 * @param request
//	 * @param dataInfoAttribute
//	 * @return
//	 */
//	@GetMapping(value = "detail-data-attribute")
//	@ResponseBody
//	public Map<String, Object> detailDataAttribute(HttpServletRequest request, DataInfoAttribute dataInfoAttribute) {
//		log.info("@@ dataInfoAttribute = {}", dataInfoAttribute);
//		
//		Map<String, Object> result = new HashMap<>();
//		int statusCode = 0;
//		String errorCode = null;
//		String message = null;
//		try {
//			dataInfoAttribute = dataService.getDataAttribute(dataInfoAttribute.getDataId());
//			result.put("dataInfoAttribute", dataInfoAttribute);
//		} catch(Exception e) {
//			e.printStackTrace();
//            statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
//            errorCode = "db.exception";
//            message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
//		}
//		
//		result.put("statusCode", statusCode);
//		result.put("errorCode", errorCode);
//		result.put("message", message);
//		return result;
//	}
//	
//	/**
//	 * Data Origin Attribute 한건 등록
//	 * @param request
//	 * @param dataInfoAttribute
//	 * @return
//	 */
//	@PostMapping(value = "insert-data-attribute-file")
//	@ResponseBody
//	public Map<String, Object> insertDataAttributeFile(MultipartHttpServletRequest request) {
//		log.info("@@ insert-data-attribute-file start");
//		
//		Map<String, Object> result = new HashMap<>();
//		int statusCode = 0;
//		String errorCode = null;
//		String message = null;
//		try {
//			Long dataId = Long.valueOf(request.getParameter("attributeFileDataId"));
//			MultipartFile multipartFile = request.getFile("attributeFileName");
//			// TODO
//			FileInfo fileInfo = FileUtils.upload(multipartFile, FileUtils.DATA_ATTRIBUTE_UPLOAD, propertiesConfig.getDataAttributeUploadDir());
//			if(fileInfo.getErrorCode() != null && !"".equals(fileInfo.getErrorCode())) {
//				log.info("@@@@@@@@@@@@@@@@@@@@ error_code = {}", fileInfo.getErrorCode());
//				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
//				result.put("errorCode", fileInfo.getErrorCode());
//				result.put("message", message);
//				return result;
//			}
//			
////			UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
////			fileInfo.setUserId(userSession.getUserId());
////			
////			DataAttributeFileInfo dataFileInfo = getDataFileInfoFromFileInfo(fileInfo);
////			dataFileInfo = dataFileInfoService.insertDataAttributeFile(dataId, dataFileInfo);
////			
////			result.put("total_count", dataFileInfo.getTotalCount());
////			result.put("parse_success_count", dataFileInfo.getParseSuccessCount());
////			result.put("parse_error_count", dataFileInfo.getParseErrorCount());
////			result.put("insert_success_count", dataFileInfo.getInsertSuccessCount());
////			result.put("insert_error_count", dataFileInfo.getInsertErrorCount());
////			
////			// 파일 삭제
////			File copyFile = new File(dataFileInfo.getFilePath() + dataFileInfo.getFileRealName());
////			if(copyFile.exists()) {
////				copyFile.delete();
////			}
//		} catch(Exception e) {
//			e.printStackTrace();
//            statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
//            errorCode = "db.exception";
//            message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
//		}
//		
//		result.put("statusCode", statusCode);
//		result.put("errorCode", errorCode);
//		result.put("message", message);
//		return result;
//	}
//	
//	/**
//    * Map 에 데이터 표시
//    * @param model
//    * @return
//	 * @throws JsonProcessingException 
//    */
//    @GetMapping(value = "map-data")
//    public String mapData(HttpServletRequest request, DataInfo dataInfo, Model model) throws JsonProcessingException {
//    	
//    	log.info("@@ map-data. dataInfo = {}", dataInfo);
//
//    	dataInfo = dataService.getData(dataInfo);
//    	
//    	GeoPolicy geoPolicy = geoPolicyService.getGeoPolicy();
//    	String geoPolicyJson = "";
//        try {
//        	geoPolicyJson = objectMapper.writeValueAsString(geoPolicy);
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//        model.addAttribute("geoPolicyJson", geoPolicyJson);
//        model.addAttribute("dataInfo", dataInfo);
//
//        return "/data/map-data";
//    }
//    
//    /**
//     * TODO 고쳐야 함... .급해서
//     * @param fileInfo
//     * @return
//     */
//    private DataAttributeFileInfo getDataFileInfoFromFileInfo(FileInfo fileInfo) {
//    	
//    	DataAttributeFileInfo dataFileInfo = new DataAttributeFileInfo();
//    	
//    	dataFileInfo.setErrorCode(fileInfo.getErrorCode());
//    	dataFileInfo.setErrorMessage(fileInfo.getErrorMessage());
//    	dataFileInfo.setJobType(fileInfo.getJobType());
//    	dataFileInfo.setUserId(fileInfo.getUserId());
//    	dataFileInfo.setFileName(fileInfo.getFileName());
//    	dataFileInfo.setFileRealName(fileInfo.getFileRealName());
//    	dataFileInfo.setFilePath(fileInfo.getFilePath());
//    	dataFileInfo.setFileSize(fileInfo.getFileSize());
//    	dataFileInfo.setFileExt(fileInfo.getFileExt());
//    	
//    	return dataFileInfo;
//    }
	
	/**
	 * 검색 조건
	 * @param search
	 * @return
	 */
	private String getSearchParameters(PageType pageType, DataInfo dataInfo) {
		StringBuffer buffer = new StringBuffer(dataInfo.getParameters());
				
		return buffer.toString();
	}
}
