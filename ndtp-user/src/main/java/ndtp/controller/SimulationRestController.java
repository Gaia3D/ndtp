package ndtp.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;
import ndtp.domain.CivilVoice;
import ndtp.domain.Key;
import ndtp.domain.PageType;
import ndtp.domain.Pagination;
import ndtp.domain.SimFileMaster;
import ndtp.domain.UserSession;
import ndtp.service.CivilVoiceCommentService;
import ndtp.service.CivilVoiceService;
import ndtp.service.impl.SimuServiceImpl;
import ndtp.utils.WebUtils;

@Slf4j
@RestController
@RequestMapping("/data/simulation-rest")
public class SimulationRestController {

	private static final long PAGE_ROWS = 5l;
	private static final long PAGE_LIST_COUNT = 5l;
	private final CivilVoiceService civilVoiceService;
	private final CivilVoiceCommentService civilVoiceCommentService;
	private final SimuServiceImpl simServiceImpl;

	public SimulationRestController(CivilVoiceService civilVoiceService, CivilVoiceCommentService civilVoiceCommentService, SimuServiceImpl simServiceImpl) {
		this.civilVoiceService = civilVoiceService;
		this.civilVoiceCommentService = civilVoiceCommentService;
		this.simServiceImpl = simServiceImpl;
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
		civilVoice.setClientIp(WebUtils.getClientIp(request));
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

			result.put("totalCount", totalCount);
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

	/**
	 * 시민 참여 상세 조회
	 * @param request
	 * @param civilVoiceId
	 * @param civilVoice
	 * @return
	 */
	@GetMapping("/{civilVoiceId}")
	public Map<String, Object> detail(HttpServletRequest request, @PathVariable Long civilVoiceId, CivilVoice civilVoice) {
		log.info("@@@@@ detail civilVoice = {}, civilVoiceId = {}", civilVoice, civilVoiceId);
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());

		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		try {
			// TODO @Valid 로 구현해야 함
			if(civilVoiceId == null) {
				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
				result.put("errorCode", "input.invalid");
				result.put("message", message);
				return result;
			}
			civilVoice = civilVoiceService.getCivilVocieById(civilVoiceId);
			statusCode = HttpStatus.OK.value();
			result.put("civilVoice", civilVoice);
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

	@RequestMapping(value = "/select", method = RequestMethod.GET)
	@GetMapping(produces = MediaType.APPLICATION_JSON_VALUE)
	public Object select() {
		SimFileMaster sfm =  this.simServiceImpl.getSimFileMaster();
		String resultFullPath = sfm.getSave_file_path() + sfm.getSave_file_name();
		File fi = new File(resultFullPath.trim());
		try {
			ObjectMapper mapper = new ObjectMapper();
			InputStream targetStream = new FileInputStream(fi);
			return mapper.readValue(targetStream, Object.class);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
		// PROCESS...

	}

	@RequestMapping(value = "/upload", method = RequestMethod.POST)
	public List<String> upload(MultipartFile[] files) {
		List<String> result = this.simServiceImpl.procStroeShp(files);
		return result;
		// PROCESS...

	}


	/**
	 * 시민참여 등록
	 * @param request
	 * @param civilVoice
	 * @param bindingResult
	 * @return
	 */
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
