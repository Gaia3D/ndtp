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

import lombok.extern.slf4j.Slf4j;
import ndtp.domain.DataAttributeFileInfo;
import ndtp.domain.DataGroup;
import ndtp.domain.DataInfo;
import ndtp.domain.FileInfo;
import ndtp.domain.Key;
import ndtp.domain.PageType;
import ndtp.domain.Pagination;
import ndtp.domain.Policy;
import ndtp.domain.UploadData;
import ndtp.domain.UserSession;
import ndtp.service.DataGroupService;
import ndtp.service.DataService;
import ndtp.service.PolicyService;
import ndtp.utils.DateUtils;

@Slf4j
@Controller
@RequestMapping("/data")
public class DataController {

	@Autowired
	private DataGroupService dataGroupService;
	@Autowired
	private DataService dataService;
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
	@GetMapping(value = "/list")
	public String list(HttpServletRequest request, DataInfo dataInfo, @RequestParam(defaultValue="1") String pageNo, Model model) {

//		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
//		converterJob.setUserId(userSession.getUserId());
		log.info("@@ dataInfo = {}", dataInfo);

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
	@GetMapping(value = "/input")
	public String input(HttpServletRequest request, Model model) {
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());

		Policy policy = policyService.getPolicy();
		UploadData uploadData = new UploadData();

		DataGroup dataGroup = new DataGroup();
		dataGroup.setUserId(userSession.getUserId());
		List<DataGroup> dataGroupList = dataGroupService.getListDataGroup(dataGroup);

		model.addAttribute("policy", policy);
		model.addAttribute("dataGroupList", dataGroupList);
		model.addAttribute("uploadData", uploadData);

		return "/data/input";
	}

	/**
	 * Data 정보
	 * @param dataInfo
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/detail")
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

		model.addAttribute("dataInfo", dataInfo);

		return "/data/modify";
	}

	/**
	 * 데이터 삭제
	 * @param dataId
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/delete")
	public String delete(HttpServletRequest request, @RequestParam("dataId") Long dataId, Model model) {

		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());

		// TODO validation 체크 해야 함
		if(dataId == null) {
			log.info("@@@ validation error dataId = {}", dataId);
			return "redirect:/data/list";
		}

		DataInfo dataInfo = new DataInfo();
		dataInfo.setDataId(dataId);
		//dataInfo.setUserId(userId);

		dataService.deleteData(dataInfo);

		return "redirect:/data/list";
	}

	/**
     * TODO 고쳐야 함... .급해서
     * @param fileInfo
     * @return
     */
    private DataAttributeFileInfo getDataFileInfoFromFileInfo(FileInfo fileInfo) {

    	DataAttributeFileInfo dataFileInfo = new DataAttributeFileInfo();

    	dataFileInfo.setErrorCode(fileInfo.getErrorCode());
    	dataFileInfo.setErrorMessage(fileInfo.getErrorMessage());
    	dataFileInfo.setJobType(fileInfo.getJobType());
    	dataFileInfo.setUserId(fileInfo.getUserId());
    	dataFileInfo.setFileName(fileInfo.getFileName());
    	dataFileInfo.setFileRealName(fileInfo.getFileRealName());
    	dataFileInfo.setFilePath(fileInfo.getFilePath());
    	dataFileInfo.setFileSize(fileInfo.getFileSize());
    	dataFileInfo.setFileExt(fileInfo.getFileExt());

    	return dataFileInfo;
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
