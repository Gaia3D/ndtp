package ndtp.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.slf4j.Slf4j;
import ndtp.domain.CivilVoiceComment;
import ndtp.domain.Key;
import ndtp.domain.PageType;
import ndtp.domain.Pagination;
import ndtp.domain.UserSession;
import ndtp.service.CivilVoiceCommentService;
import ndtp.service.CivilVoiceService;
import ndtp.support.SQLInjectSupport;
import ndtp.utils.WebUtils;

@Slf4j
@RestController
@RequestMapping("/civil-voice-comments")
public class CivilVoiceCommentRestController {

	private static final long PAGE_ROWS = 5l;
	private static final long PAGE_LIST_COUNT = 5l;
	private final CivilVoiceService civilVoiceService;
	private final CivilVoiceCommentService civilVoiceCommentService;

	public CivilVoiceCommentRestController(CivilVoiceService civilVoiceService, CivilVoiceCommentService civilVoiceCommentService) {
		this.civilVoiceService = civilVoiceService;
		this.civilVoiceCommentService = civilVoiceCommentService;
	}

	/**
	 * 시민 참여 댓글 목록 조회
	 * @param request
	 * @param civilVoice
	 * @param pageNo
	 * @return
	 */
	@GetMapping("/{civilVoiceId}")
	public Map<String, Object> list(HttpServletRequest request, @PathVariable Long civilVoiceId, CivilVoiceComment civilVoiceComment, @RequestParam(defaultValue="1") String pageNo) {
		log.info("civilVoiceComment list ===================== {} " , civilVoiceComment);
		
		civilVoiceComment.setSearchWord(SQLInjectSupport.replaceSqlInection(civilVoiceComment.getSearchWord()));
		civilVoiceComment.setOrderWord(SQLInjectSupport.replaceSqlInection(civilVoiceComment.getOrderWord()));
		
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;

		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		civilVoiceComment.setUserId(userSession.getUserId());
		civilVoiceComment.setClientIp(WebUtils.getClientIp(request));
		civilVoiceComment.setCivilVoiceId(civilVoiceId);
		try {
			long totalCount = civilVoiceCommentService.getCivilVoiceCommentTotalCount(civilVoiceComment);
			Pagination pagination = new Pagination(	request.getRequestURI(), getSearchParameters(PageType.LIST, civilVoiceComment),
					totalCount, Long.valueOf(pageNo).longValue(), PAGE_ROWS, PAGE_LIST_COUNT);
			log.info("@@ pagination = {}", pagination);

			civilVoiceComment.setOffset(pagination.getOffset());
			civilVoiceComment.setLimit(pagination.getPageRows());
			List<CivilVoiceComment> civilVoiceCommentList = new ArrayList<>();
			if(totalCount > 0l) {
				civilVoiceCommentList = civilVoiceCommentService.getListCivilVoiceComment(civilVoiceComment);
			}

			result.put("totalCount", totalCount);
			result.put("pagination", pagination);
			result.put("civilVoiceCommentList", civilVoiceCommentList);
		} catch(DataAccessException e) {
			statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
			errorCode = "db.exception";
			message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
			log.info("@@ db.exception. message = {}", message);
		} catch(RuntimeException e) {
			statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
			errorCode = "runtime.exception";
			message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
			log.info("@@ runtime.exception. message = {}", message);
		} catch(Exception e) {
			statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
			errorCode = "unknown.exception";
			message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
			log.info("@@ exception. message = {}", message);
		}

		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);

		return result;
	}

	/**
	 * 시민참여 댓글 등록
	 * @param request
	 * @param civilVoiceComment
	 * @param bindingResult
	 * @return
	 */
	@PostMapping
	public Map<String, Object> insert(HttpServletRequest request, @Valid @ModelAttribute CivilVoiceComment civilVoiceComment, BindingResult bindingResult) {
		log.info("civilVoiceComment ======================= {} " , civilVoiceComment.getTitle());
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());

		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;

		if(StringUtils.isEmpty(civilVoiceComment.getTitle())) {
			civilVoiceComment.setTitle("동의합니다");
		}

		try {
			if(bindingResult.hasErrors()) {
				message = bindingResult.getAllErrors().get(0).getDefaultMessage();
				log.info("@@@@@ message = {}", message);
				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
				result.put("errorCode", errorCode);
				result.put("message", message);
	            return result;
			}

			civilVoiceComment.setUserId(userSession.getUserId());
			Boolean alreadyRegistered = civilVoiceCommentService.alreadyRegistered(civilVoiceComment);
            if(alreadyRegistered) {
                result.put("statusCode", HttpStatus.BAD_REQUEST.value());
                result.put("errorCode", "already.agreed");
                result.put("message", message);
                return result;
            }

			civilVoiceComment.setClientIp(WebUtils.getClientIp(request));
			civilVoiceCommentService.insertCivilVoiceComment(civilVoiceComment);
		} catch(DataAccessException e) {
			statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
			errorCode = "db.exception";
			message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
			log.info("@@ db.exception. message = {}", message);
		} catch(RuntimeException e) {
			statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
			errorCode = "runtime.exception";
			message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
			log.info("@@ runtime.exception. message = {}", message);
		} catch(Exception e) {
			statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
			errorCode = "unknown.exception";
			message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
			log.info("@@ exception. message = {}", message);
		}

		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * 검색 조건
	 * @param pageType
	 * @param civilVoiceComment
	 * @return
	 */
	private String getSearchParameters(PageType pageType, CivilVoiceComment civilVoiceComment) {
		StringBuffer buffer = new StringBuffer(civilVoiceComment.getParameters());
		return buffer.toString();
	}
}
