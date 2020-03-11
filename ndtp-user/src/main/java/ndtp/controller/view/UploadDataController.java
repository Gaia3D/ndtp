package ndtp.controller.view;

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

import lombok.extern.slf4j.Slf4j;
import ndtp.config.PropertiesConfig;
import ndtp.domain.CacheManager;
import ndtp.domain.ConverterJob;
import ndtp.domain.DataGroup;
import ndtp.domain.Key;
import ndtp.domain.PageType;
import ndtp.domain.Pagination;
import ndtp.domain.RoleKey;
import ndtp.domain.SharingType;
import ndtp.domain.UploadData;
import ndtp.domain.UploadDataFile;
import ndtp.domain.UserSession;
import ndtp.service.DataGroupService;
import ndtp.service.PolicyService;
import ndtp.service.UploadDataService;
import ndtp.support.RoleSupport;
import ndtp.support.SQLInjectSupport;
import ndtp.utils.DateUtils;
import ndtp.utils.FileUtils;

/**
 * 3D 데이터 파일 업로더
 * TODO 설계 파일 안의 texture 의 경우 설계 파일에서 참조하는 경우가 있으므로 이름 변경 불가.
 * @author jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/upload-data")
public class UploadDataController {
	
	// 파일 copy 시 버퍼 사이즈
	public static final int BUFFER_SIZE = 8192;
	
	@Autowired
	private DataGroupService dataGroupService;
	
	@Autowired
	private PolicyService policyService;
	
	@Autowired
	private PropertiesConfig propertiesConfig;
	
	@Autowired
	private UploadDataService uploadDataService;
	
	/**
	 * 업로딩 파일 목록
	 * @param request
	 * @param uploadData
	 * @param pageNo
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/list")
	public String list(HttpServletRequest request, UploadData uploadData, @RequestParam(defaultValue="1") String pageNo, Model model) {
		uploadData.setSearchWord(SQLInjectSupport.replaceSqlInection(uploadData.getSearchWord()));
		uploadData.setOrderWord(SQLInjectSupport.replaceSqlInection(uploadData.getOrderWord()));
		
		log.info("@@ uploadData = {}", uploadData);
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		
		String roleCheckResult = roleValidator(request, userSession.getUserGroupId(), RoleKey.USER_DATA_CREATE.name());
		if(roleCheckResult != null) return roleCheckResult;
		
		uploadData.setUserId(userSession.getUserId());
		
		if(!StringUtils.isEmpty(uploadData.getStartDate())) {
			uploadData.setStartDate(uploadData.getStartDate().substring(0, 8) + DateUtils.START_TIME);
		}
		if(!StringUtils.isEmpty(uploadData.getEndDate())) {
			uploadData.setEndDate(uploadData.getEndDate().substring(0, 8) + DateUtils.END_TIME);
		}
		
		long totalCount = uploadDataService.getUploadDataTotalCount(uploadData);
		
		Pagination pagination = new Pagination(	request.getRequestURI(), 
												getSearchParameters(PageType.LIST, uploadData), 
												totalCount, 
												Long.parseLong(pageNo),
												uploadData.getListCounter());
		log.info("@@ pagination = {}", pagination);
		
		uploadData.setOffset(pagination.getOffset());
		uploadData.setLimit(pagination.getPageRows());
		List<UploadData> uploadDataList = new ArrayList<>();
		if(totalCount > 0l) {
			uploadDataList = uploadDataService.getListUploadData(uploadData);
		}
		
		model.addAttribute(pagination);
		model.addAttribute("uploadData", uploadData);
		model.addAttribute("converterJobForm", new ConverterJob());
		model.addAttribute("uploadDataList", uploadDataList);
		
		return "/upload-data/list";
	}
	
	/**
	 * 데이터 upload 화면
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/input")
	public String input(HttpServletRequest request, Model model) {
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		
		String roleCheckResult = roleValidator(request, userSession.getUserGroupId(), RoleKey.USER_DATA_CREATE.name());
		if(roleCheckResult != null) return roleCheckResult;
		
		DataGroup dataGroup = new DataGroup();
		dataGroup.setUserId(userSession.getUserId());
		// 자기것만 나와야 해서 dataGroupId가 필요 없음
		List<DataGroup> dataGroupList = dataGroupService.getAllListDataGroup(dataGroup);
		if(dataGroupList == null || dataGroupList.isEmpty()) {
			String dataGroupPath = userSession.getUserId() + "/basic/";
			dataGroup.setDataGroupKey("basic");
			dataGroup.setDataGroupName("기본");
			dataGroup.setDataGroupPath(propertiesConfig.getUserDataServicePath() + dataGroupPath);
			dataGroup.setSharing(SharingType.PUBLIC.name().toLowerCase());
			dataGroup.setMetainfo("{\"isPhysical\": false}");
			
			FileUtils.makeDirectoryByPath(propertiesConfig.getUserDataServiceDir(), dataGroupPath);
			dataGroupService.insertBasicDataGroup(dataGroup);
			
			dataGroupList = dataGroupService.getListDataGroup(dataGroup);
		}
		
		DataGroup basicDataGroup = dataGroupService.getBasicDataGroup(dataGroup);
		
		UploadData uploadData = UploadData.builder().
											dataGroupId(basicDataGroup.getDataGroupId()).
											dataGroupName(basicDataGroup.getDataGroupName()).build();
		
		String acceptedFiles = policyService.getUserUploadType();
		
		model.addAttribute("uploadData", uploadData);
		model.addAttribute("dataGroupList", dataGroupList);
		model.addAttribute("acceptedFiles", acceptedFiles);
		
		return "/upload-data/input";
	}
	
	/**
	 * 데이터 upload 수정
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/modify")
	public String modify(HttpServletRequest request, UploadData uploadData, Model model) {
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		uploadData.setUserId(userSession.getUserId());
		
		uploadData = uploadDataService.getUploadData(uploadData);
		List<UploadDataFile> uploadDataFileList = uploadDataService.getListUploadDataFile(uploadData);
		
		DataGroup dataGroup = new DataGroup();
		dataGroup.setUserId(userSession.getUserId());
		// 자기것만 나와야 해서 dataGroupId가 필요 없음
		List<DataGroup> dataGroupList = dataGroupService.getAllListDataGroup(dataGroup);
		
		model.addAttribute("uploadData", uploadData);
		model.addAttribute("uploadDataFileList", uploadDataFileList);
		model.addAttribute("dataGroupList", dataGroupList);
		
		return "/upload-data/modify";
	}
	
	/**
	 * 검색 조건
	 * @param search
	 * @return
	 */
	private String getSearchParameters(PageType pageType, UploadData uploadData) {
		StringBuffer buffer = new StringBuffer(uploadData.getParameters());
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
	
	private String roleValidator(HttpServletRequest request, Integer userGroupId, String roleName) {
		List<String> userGroupRoleKeyList = CacheManager.getUserGroupRoleKeyList(userGroupId);
        if(!RoleSupport.isUserGroupRoleValid(userGroupRoleKeyList, roleName)) {
			request.setAttribute("httpStatusCode", 403);
			return "/error/error";
		}
		return null;
	}
}
