package ndtp.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.slf4j.Slf4j;
import ndtp.domain.District;
import ndtp.domain.Pagination;
import ndtp.domain.SkEmd;
import ndtp.domain.SkSdo;
import ndtp.domain.SkSgg;
import ndtp.service.SearchMapService;

@Slf4j
@RequestMapping("/searchmap")
@CrossOrigin(origins = "*")
@RestController
public class SearchMapController {

	@Autowired
	private SearchMapService searchMapService;

	/**
	 * 시도 목록
	 * @return
	 */
	@GetMapping("/sdos")
	public Map<String, Object> getListSdo() {
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		try {
			List<SkSdo> sdoList = searchMapService.getListSdoExceptGeom();
			result.put("sdoList", sdoList);
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
	 * 시군구 목록
	 * @param sdoCode
	 * @return
	 */
	@GetMapping("/sdos/{sdoCode:[0-9]+}/sggs")
	public Map<String, Object> getListSggBySdo(@PathVariable String sdoCode) {
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		try {
			// TODO 여기 들어 오지 않음. PathVariable 은 불칠전해서 이렇게 하고 싶음
			if (sdoCode == null || "".equals(sdoCode)) {
				log.info("@@@@@ message = {}", "sdo.code.invalid");
				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
				result.put("errorCode", "sdo.code.invalid");
				result.put("message", message);
	            return result;
			}

			List<SkSgg> sggList = searchMapService.getListSggBySdoExceptGeom(sdoCode);
			result.put("sggList", sggList);
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
	 * 읍면동 목록 TODO PathVariable 대신 SkEmd으로 받고 싶다.
	 * @param sdoCode
	 * @param sggCode
	 * @return
	 */
	@GetMapping("/sdos/{sdoCode:[0-9]+}/sggs/{sggCode:[0-9]+}/emds")
	public Map<String, Object> getListEmdBySdoAndSgg(@PathVariable String sdoCode, @PathVariable String sggCode) {
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		try {
			// TODO 여기 들어 오지 않음. PathVariable 은 불칠전해서 이렇게 하고 싶음
			if (sdoCode == null || "".equals(sdoCode)) {
				log.info("@@@@@ message = {}", "sdo.code.invalid");
				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
				result.put("errorCode", "sdo.code.invalid");
				result.put("message", message);
	            return result;
			}
			if (sggCode == null || "".equals(sggCode)) {
				log.info("@@@@@ message = {}", "sgg.code.invalid");
				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
				result.put("errorCode", "sgg.code.invalid");
				result.put("message", message);
	            return result;
			}

			SkEmd mapEmd = new SkEmd();
			mapEmd.setSdoCode(sdoCode);
			mapEmd.setSggCode(sggCode);

			List<SkEmd> emdList = searchMapService.getListEmdBySdoAndSggExceptGeom(mapEmd);
			result.put("emdList", emdList);
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
	 * 선택 한 위치의 center point를 구함
	 * 
	 * @param skEmd
	 * @return
	 */
	@GetMapping("/centroids")
	public Map<String, Object> getCentroid(SkEmd skEmd) {
		log.info("@@@@ skEmd = {}", skEmd);

		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		try {
			// TODO 여기 들어 오지 않음. PathVariable 은 불칠전해서 이렇게 하고 싶음
			String centerPoint = null;
			if (skEmd.getLayerType() == 1) {
				// 시도
				SkSdo skSdo = new SkSdo();
				skSdo.setName(skEmd.getName());
				skSdo.setBjcd(skEmd.getBjcd());
				centerPoint = searchMapService.getCentroidSdo(skSdo);
				log.info("@@@@ sdo center point {}", centerPoint);
			} else if (skEmd.getLayerType() == 2) {
				// 시군구
				SkSgg skSgg = new SkSgg();
				skSgg.setName(skEmd.getName());
				skSgg.setBjcd(skEmd.getBjcd());
				centerPoint = searchMapService.getCentroidSgg(skSgg);
				log.info("@@@@ sgg center point {}", centerPoint);
			} else if (skEmd.getLayerType() == 3) {
				// 읍면동
				centerPoint = searchMapService.getCentroidEmd(skEmd);
				log.info("@@@@ emd center point {}", centerPoint);
			}

			String[] location = centerPoint.substring(centerPoint.indexOf("(") + 1, centerPoint.indexOf(")")).split(" ");
			result.put("longitude", location[0]);
			result.put("latitude", location[1]);
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
	 * 행정구역
	 * @param district
	 * @return
	 */
	@GetMapping("/district")
	public Map<String, Object> districts(HttpServletRequest request, District district, @RequestParam(defaultValue = "1") String pageNo) {

		// TODO 아직 정리가 안되서.... fullTextSearch라는 변수를 임시로 추가해 두었음. 다음에 고쳐야 함
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		
		log.info("@@ district = {}", district);
		district.setSearchValue(district.getFullTextSearch());
		district.setSearchWord(district.getFullTextSearch());
		String searchKey = request.getParameter("searchKey");

		result.put("searchWord", district.getFullTextSearch());
		result.put("searchKey", searchKey);

		try {
			if (district.getSearchValue() == null || "".equals(district.getSearchValue())) {
				log.info("@@@@@ message = {}", "search.word.invalid");
				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
				result.put("errorCode", "search.word.invalid");
				result.put("message", message);
	            return result;
			}

			long totalCount = searchMapService.getDistrictTotalCount(district);
			Pagination pagination = new Pagination(request.getRequestURI(),
					getSearchParameters(district.getFullTextSearch()), totalCount, Long.parseLong(pageNo));
			log.info("@@ pagination = {}", pagination);

			district.setOffset(pagination.getOffset());
			district.setLimit(pagination.getPageRows());
			List<District> districtList = new ArrayList<>();
			if (totalCount > 0l) {
				districtList = searchMapService.getListDistrict(district);
			}

			result.put("pagination", pagination);
			result.put("totalCount", totalCount);
			result.put("districtList", districtList);
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

	private String getSearchParameters(String fullTextSearch) {
		StringBuffer buffer = new StringBuffer();
		buffer.append("&");
		try {
			buffer.append("searchValue=" + URLEncoder.encode(fullTextSearch, "UTF-8"));
		} catch (UnsupportedEncodingException e) {
			log.info("@@ objectMapper exception. message = {}", e.getCause() != null ? e.getCause().getMessage() : e.getMessage());
			buffer.append("searchValue=");
		}
		return buffer.toString();
	}
}