package ndtp.controller;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.slf4j.Slf4j;
import ndtp.domain.AddrJibun;
import ndtp.domain.CountryPlaceNumber;
import ndtp.domain.District;
import ndtp.domain.NewAddress;
import ndtp.domain.Pagination;
import ndtp.domain.PlaceName;
import ndtp.domain.SkEmd;
import ndtp.domain.SkSdo;
import ndtp.domain.SkSgg;
import ndtp.service.SearchMapService;

@Slf4j
@RequestMapping("/searchmap/")
@CrossOrigin(origins = "*")
@RestController
public class SearchMapController {

	@Autowired
	private SearchMapService searchMapService;

	/**
	 * 시도 목록
	 * @return
	 */
	@GetMapping("sdos")
	public Map<String, Object> getListSdo() {
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			List<SkSdo> sdoList = searchMapService.getListSdoExceptGeom();
			map.put("sdoList", sdoList);
		} catch (Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		map.put("result", result);
		return map;
	}

	/**
	 * 시군구 목록
	 * @param sdoCode
	 * @return
	 */
	@GetMapping("sdos/{sdoCode:[0-9]+}/sggs")
	public Map<String, Object> getListSggBySdo(@PathVariable String sdoCode) {
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			// TODO 여기 들어 오지 않음. PathVariable 은 불칠전해서 이렇게 하고 싶음
			if (sdoCode == null || "".equals(sdoCode)) {
				map.put("result", "sdo.code.invalid");
				log.info("validate error 발생: {} ", map.toString());
				return map;
			}

			List<SkSgg> sggList = searchMapService.getListSggBySdoExceptGeom(sdoCode);
			map.put("sggList", sggList);
		} catch (Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}

		map.put("result", result);
		return map;
	}

	/**
	 * 읍면동 목록 TODO PathVariable 대신 SkEmd으로 받고 싶다.
	 * @param sdoCode
	 * @param sggCode
	 * @return
	 */
	@GetMapping("sdos/{sdoCode:[0-9]+}/sggs/{sggCode:[0-9]+}/emds")
	public Map<String, Object> getListEmdBySdoAndSgg(@PathVariable String sdoCode, @PathVariable String sggCode) {
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			// TODO 여기 들어 오지 않음. PathVariable 은 불칠전해서 이렇게 하고 싶음
			if (sdoCode == null || "".equals(sdoCode)) {
				map.put("result", "sdo.code.invalid");
				log.info("validate error 발생: {} ", map.toString());
				return map;
			}
			if (sggCode == null || "".equals(sggCode)) {
				map.put("result", "sgg.code.invalid");
				log.info("validate error 발생: {} ", map.toString());
				return map;
			}

			SkEmd mapEmd = new SkEmd();
			mapEmd.setSdoCode(sdoCode);
			mapEmd.setSggCode(sggCode);

			List<SkEmd> emdList = searchMapService.getListEmdBySdoAndSggExceptGeom(mapEmd);
			map.put("emdList", emdList);
		} catch (Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}

		map.put("result", result);
		return map;
	}

	/**
	 * 선택 한 위치의 center point를 구함
	 * 
	 * @param skEmd
	 * @return
	 */
	@GetMapping("centroids")
	public Map<String, Object> getCentroid(SkEmd skEmd) {
		log.info("@@@@ skEmd = {}", skEmd);

		Map<String, Object> map = new HashMap<>();
		String result = "success";
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
			map.put("longitude", location[0]);
			map.put("latitude", location[1]);
		} catch (Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}

		map.put("result", result);
		return map;
	}

	/**
	 * 행정구역
	 * @param district
	 * @return
	 */
	@GetMapping("district")
	public Map<String, Object> districts(HttpServletRequest request, District district, @RequestParam(defaultValue = "1") String pageNo) {

		// TODO 아직 정리가 안되서.... fullTextSearch라는 변수를 임시로 추가해 두었음. 다음에 고쳐야 함
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		log.info("@@ district = {}", district);
		district.setSearchValue(district.getFullTextSearch());
		district.setSearchWord(district.getFullTextSearch());
		String searchKey = request.getParameter("searchKey");

		map.put("searchWord", district.getFullTextSearch());
		map.put("searchKey", searchKey);

		try {
			if (district.getSearchValue() == null || "".equals(district.getSearchValue())) {
				map.put("result", "search.word.invalid");
				log.info("validate error 발생: {} ", map.toString());
				return map;
			}

			long totalCount = searchMapService.getDistrictTotalCount(district);
			Pagination pagination = new Pagination(request.getRequestURI(),
					getSearchParameters(district.getFullTextSearch()), totalCount, Long.valueOf(pageNo).longValue());
			log.info("@@ pagination = {}", pagination);

			district.setOffset(pagination.getOffset());
			district.setLimit(pagination.getPageRows());
			List<District> districtList = new ArrayList<>();
			if (totalCount > 0l) {
				districtList = searchMapService.getListDistrict(district);
			}

			map.put("pagination", pagination);
			map.put("totalCount", totalCount);
			map.put("districtList", districtList);
		} catch (Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}

		map.put("result", result);
		return map;
	}

	/**
	 * 지명 검색
	 * @param placeName
	 * @return
	 */
	@GetMapping("placeName")
	public Map<String, Object> placeNames(HttpServletRequest request, PlaceName placeName, @RequestParam(defaultValue = "1") String pageNo) {

		// TODO 아직 정리가 안되서.... fullTextSearch라는 변수를 임시로 추가해 두었음. 다음에 고쳐야 함
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		log.info("@@ placeName = {}", placeName);
		placeName.setSearchValue(placeName.getFullTextSearch());
		placeName.setSearchWord(placeName.getFullTextSearch());
		String searchKey = request.getParameter("searchKey");

		map.put("searchWord", placeName.getFullTextSearch());
		map.put("searchKey", searchKey);

		try {
			if (placeName.getSearchValue() == null || "".equals(placeName.getSearchValue())) {
				map.put("result", "search.word.invalid");
				log.info("validate error 발생: {} ", map.toString());
				return map;
			}

			long totalCount = searchMapService.getPlaceNameTotalCount(placeName);
			Pagination pagination = new Pagination(request.getRequestURI(),
					getSearchParameters(placeName.getFullTextSearch()), totalCount, Long.valueOf(pageNo).longValue());
			log.info("@@ pagination = {}", pagination);

			placeName.setOffset(pagination.getOffset());
			placeName.setLimit(pagination.getPageRows());
			List<PlaceName> placeNameList = new ArrayList<>();
			if (totalCount > 0l) {
				placeNameList = searchMapService.getListPlaceName(placeName);
			}

			map.put("pagination", pagination);
			map.put("totalCount", totalCount);
			map.put("placeNameList", placeNameList);
		} catch (Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}

		map.put("result", result);
		return map;
	}

	/**
	 * 지번 검색
	 * @param addrJibun
	 * @return
	 */
	@GetMapping("jibun")
	public Map<String, Object> jibuns(HttpServletRequest request, AddrJibun addrJibun, @RequestParam(defaultValue = "1") String pageNo) {

		// TODO 아직 정리가 안되서.... fullTextSearch라는 변수를 임시로 추가해 두었음. 다음에 고쳐야 함
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		log.info("@@ addrJibun = {}", addrJibun);
		addrJibun.setSearchValue(addrJibun.getFullTextSearch());
		String searchKey = request.getParameter("searchKey");

		map.put("searchWord", addrJibun.getFullTextSearch());
		map.put("searchKey", searchKey);

		try {
			if (addrJibun.getSearchValue() == null || "".equals(addrJibun.getSearchValue())) {
				map.put("result", "search.word.invalid");
				log.info("validate error 발생: {} ", map.toString());
				return map;
			}

			long totalCount = searchMapService.getJibunTotalCount(addrJibun);
			Pagination pagination = new Pagination(request.getRequestURI(),
					getSearchParameters(addrJibun.getFullTextSearch()), totalCount, Long.valueOf(pageNo).longValue());
			log.info("@@ pagination = {}", pagination);

			addrJibun.setOffset(pagination.getOffset());
			addrJibun.setLimit(pagination.getPageRows());
			List<AddrJibun> addrJibunList = new ArrayList<>();
			if (totalCount > 0l) {
				addrJibunList = searchMapService.getListJibun(addrJibun);
			}

			map.put("pagination", pagination);
			map.put("totalCount", totalCount);
			map.put("addrJibunList", addrJibunList);
		} catch (Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}

		map.put("result", result);
		return map;
	}

	/**
	 * 새 주소
	 * @param newAddress
	 * @return
	 */
	@GetMapping("newAddress")
	public Map<String, Object> newAddresses(HttpServletRequest request, NewAddress newAddress, @RequestParam(defaultValue = "1") String pageNo) {

		// TODO 아직 정리가 안되서.... fullTextSearch라는 변수를 임시로 추가해 두었음. 다음에 고쳐야 함
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		log.info("@@ newAddress = {}", newAddress);
		newAddress.setSearchValue(newAddress.getFullTextSearch());
		String searchKey = request.getParameter("searchKey");

		map.put("searchWord", newAddress.getFullTextSearch());
		map.put("searchKey", searchKey);

		try {
			if (newAddress.getSearchValue() == null || "".equals(newAddress.getSearchValue())) {
				map.put("result", "search.word.invalid");
				log.info("validate error 발생: {} ", map.toString());
				return map;
			}

			long totalCount = searchMapService.getNewAddressTotalCount(newAddress);
			Pagination pagination = new Pagination(request.getRequestURI(),
					getSearchParameters(newAddress.getFullTextSearch()), totalCount, Long.valueOf(pageNo).longValue());
			log.info("@@ pagination = {}", pagination);

			newAddress.setOffset(pagination.getOffset());
			newAddress.setLimit(pagination.getPageRows());
			List<NewAddress> newAddressList = new ArrayList<>();
			if (totalCount > 0l) {
				newAddressList = searchMapService.getListNewAddress(newAddress);
			}

			map.put("pagination", pagination);
			map.put("totalCount", totalCount);
			map.put("newAddressList", newAddressList);
		} catch (Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}

		map.put("result", result);
		return map;
	}

	/**
	 * 국가 지점 번호 검색
	 * @param countryPlaceNumber
	 * @return
	 */
	@GetMapping("countryPlaceNumber")
	public Map<String, Object> countryPlaceNumbers(HttpServletRequest request, CountryPlaceNumber countryPlaceNumber, @RequestParam(defaultValue = "1") String pageNo) {

		// TODO 아직 정리가 안되서.... fullTextSearch라는 변수를 임시로 추가해 두었음. 다음에 고쳐야 함
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		log.info("@@ countryPlaceNumber = {}", countryPlaceNumber);
		countryPlaceNumber.setSearchValue(countryPlaceNumber.getFullTextSearch());
		countryPlaceNumber.setSearchWord(countryPlaceNumber.getFullTextSearch());
		String searchKey = request.getParameter("searchKey");

		map.put("searchWord", countryPlaceNumber.getFullTextSearch());
		map.put("searchKey", searchKey);

		try {
			if (countryPlaceNumber.getSearchValue() == null || "".equals(countryPlaceNumber.getSearchValue())) {
				map.put("result", "search.word.invalid");
				log.info("validate error 발생: {} ", map.toString());
				return map;
			}

			long totalCount = searchMapService.getCountryPlaceNumberTotalCount(countryPlaceNumber);
			Pagination pagination = new Pagination(request.getRequestURI(),
					getSearchParameters(countryPlaceNumber.getFullTextSearch()), totalCount,
					Long.valueOf(pageNo).longValue());
			log.info("@@ pagination = {}", pagination);

			countryPlaceNumber.setOffset(pagination.getOffset());
			countryPlaceNumber.setLimit(pagination.getPageRows());
			List<CountryPlaceNumber> countryPlaceNumberList = new ArrayList<>();
			if (totalCount > 0l) {
				countryPlaceNumberList = searchMapService.getListCountryPlaceNumber(countryPlaceNumber);
			}

			map.put("pagination", pagination);
			map.put("totalCount", totalCount);
			map.put("countryPlaceNumberList", countryPlaceNumberList);
		} catch (Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}

		map.put("result", result);
		return map;
	}

	private String getSearchParameters(String fullTextSearch) {
		StringBuffer buffer = new StringBuffer();
		buffer.append("&");
		try {
			buffer.append("searchValue=" + URLEncoder.encode(fullTextSearch, "UTF-8"));
		} catch (Exception e) {
			e.printStackTrace();
			buffer.append("searchValue=");
		}
		return buffer.toString();
	}
}