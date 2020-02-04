package ndtp.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.http.HttpStatus;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.slf4j.Slf4j;
import ndtp.domain.CivilVoice;
import ndtp.domain.Key;
import ndtp.domain.PageType;
import ndtp.domain.Pagination;
import ndtp.domain.UserSession;
import ndtp.service.CivilVoiceCommentService;
import ndtp.service.CivilVoiceService;
import ndtp.utils.WebUtils;

@Slf4j
@RestController
@RequestMapping("/civil-voices")
public class CivilVoiceRestController {
	
	private static final long PAGE_ROWS = 5l;
	private static final long PAGE_LIST_COUNT = 5l;
	private final CivilVoiceService civilVoiceService;
	private final CivilVoiceCommentService civilVoiceCommentService;
	
	public CivilVoiceRestController(CivilVoiceService civilVoiceService, CivilVoiceCommentService civilVoiceCommentService) {
		this.civilVoiceService = civilVoiceService;
		this.civilVoiceCommentService = civilVoiceCommentService;
	}
	
	/**
	 * 시민 참여 목록 조회 
	 * @param request
	 * @param civilVoice
	 * @param pageNo
	 * @return
	 */
	@GetMapping
	public Map<String, Object> list(HttpServletRequest request, CivilVoice civilVoice, @RequestParam(defaultValue="1") String pageNo) {
		log.info("civilVoice list ===================== {} " , civilVoice);
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		civilVoice.setUserId(userSession.getUserId());
		civilVoice.setUserIp(WebUtils.getClientIp(request));
		try {
			long totalCount = civilVoiceService.getCivilVoiceTotalCount(civilVoice);
			
			Pagination pagination = new Pagination(	request.getRequestURI(), 
													getSearchParameters(PageType.LIST, civilVoice), 
													totalCount, 
													Long.valueOf(pageNo).longValue(),
													PAGE_ROWS,
													PAGE_LIST_COUNT);
			log.info("@@ pagination = {}", pagination);
			
			civilVoice.setOffset(pagination.getOffset());
			civilVoice.setLimit(pagination.getPageRows());
			List<CivilVoice> civilVoiceList = new ArrayList<>();
			if(totalCount > 0l) {
				civilVoiceList = civilVoiceService.getListCivilVoice(civilVoice);
			}
			
			result.put("pagination", pagination);
			result.put("civilVoiceList", civilVoiceList);
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
	
	@PostMapping
	public Map<String, Object> insert(HttpServletRequest request, @Valid @ModelAttribute CivilVoice civilVoice, BindingResult bindingResult) {
		log.info("civilVoice ======================= {} " , civilVoice.getTitle());
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		
		try {
			if(bindingResult.hasErrors()) {
				message = bindingResult.getAllErrors().get(0).getDefaultMessage();
				log.info("@@@@@ message = {}", message);
				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
				result.put("errorCode", errorCode);
				result.put("message", message);
	            return result;
			}
			
			civilVoice.setUserId(userSession.getUserId());
			if(civilVoice.getLongitude() != null && civilVoice.getLatitude() != null) {
				civilVoice.setLocation("POINT(" + civilVoice.getLongitude() + " " + civilVoice.getLatitude() + ")");
			}
			civilVoiceService.insertCivilVoice(civilVoice);
		} catch (Exception e) {
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
	 * @param dataGroup
	 * @return
	 */
	private String getSearchParameters(PageType pageType, CivilVoice civilVoice) {
		StringBuffer buffer = new StringBuffer(civilVoice.getParameters());
		return buffer.toString();
	}
}
