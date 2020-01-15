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
import ndtp.config.PropertiesConfig;
import ndtp.domain.CivilVoice;
import ndtp.domain.Key;
import ndtp.domain.PageType;
import ndtp.domain.Pagination;
import ndtp.domain.Policy;
import ndtp.domain.RoleKey;
import ndtp.domain.UserSession;
import ndtp.service.CivilVoiceService;
import ndtp.service.PolicyService;
import ndtp.utils.DateUtils;
import ndtp.utils.FormatUtils;

@Slf4j
@Controller
@RequestMapping("/civil-voice/")
public class CivilVoiceController implements AuthorizationController {

	@Autowired
    private CivilVoiceService civilVoiceService;

	@Autowired
    private PolicyService policyService;

    @Autowired
    private PropertiesConfig propertiesConfig;

    /**
	 * 시민 참여 목록
	 */
    @RequestMapping(value = "list")
	public String list(HttpServletRequest request, @RequestParam(defaultValue="1") String pageNo, CivilVoice civilVoice, Model model) {
		String roleCheckResult = roleValidate(request);
    	if(roleValidate(request) != null) return roleCheckResult;

    	String today = DateUtils.getToday(FormatUtils.YEAR_MONTH_DAY);
		if(StringUtils.isEmpty(civilVoice.getStartDate())) {
			civilVoice.setStartDate(today.substring(0,4) + DateUtils.START_DAY_TIME);
		} else {
			civilVoice.setStartDate(civilVoice.getStartDate().substring(0, 8) + DateUtils.START_TIME);
		}
		if(StringUtils.isEmpty(civilVoice.getEndDate())) {
			civilVoice.setEndDate(today + DateUtils.END_TIME);
		} else {
			civilVoice.setEndDate(civilVoice.getEndDate().substring(0, 8) + DateUtils.END_TIME);
		}

		Long totalCount = civilVoiceService.getCivilVoiceTotalCount(civilVoice);
		Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(PageType.LIST, civilVoice), totalCount, Long.valueOf(pageNo).longValue());
		civilVoice.setOffset(pagination.getOffset());
		civilVoice.setLimit(pagination.getPageRows());

		List<CivilVoice> civilVoiceList = new ArrayList<>();
		if(totalCount > 0l) {
			civilVoiceList = civilVoiceService.getListCivilVoice(civilVoice);
		}

		model.addAttribute(pagination);
		model.addAttribute("civilVoice", civilVoice);
		model.addAttribute("civilVoiceList", civilVoiceList);

		return "/civil-voice/list";
	}

	/**
	 * 사용자 상세 정보
	 * @param request
	 * @param userInfo
	 * @param model
	 * @return
	 */
	@GetMapping(value = "detail")
	public String detail(HttpServletRequest request, CivilVoice civilVoice, Model model) {
		String listParameters = getSearchParameters(PageType.DETAIL, civilVoice);

		civilVoice =  civilVoiceService.getCivilVoice(civilVoice);
		Policy policy = policyService.getPolicy();

		model.addAttribute("policy", policy);
		model.addAttribute("listParameters", listParameters);
		model.addAttribute("civilVoice", civilVoice);
		return "/civil-voice/detail";
	}

	/**
	 * 사용자 등록 화면
	 */
	@GetMapping(value = "input")
	public String input(Model model) {
		Policy policy = policyService.getPolicy();

		model.addAttribute("policy", policy);
		model.addAttribute("civilVoice", new CivilVoice());
		return "/user/input";
	}

	/**
	 * 검색 조건
	 * @param search
	 * @return
	 */
	private String getSearchParameters(PageType pageType, CivilVoice userInfo) {
		StringBuffer buffer = new StringBuffer(userInfo.getParameters());
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

	private String roleValidate(HttpServletRequest request) {
    	UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		int httpStatusCode = getRoleStatusCode(userSession.getUserGroupId(), RoleKey.ADMIN_USER_MANAGE.name());
		if(httpStatusCode > 200) {
			log.info("@@ httpStatusCode = {}", httpStatusCode);
			request.setAttribute("httpStatusCode", httpStatusCode);
			return "/error/error";
		}

		return null;
    }

}