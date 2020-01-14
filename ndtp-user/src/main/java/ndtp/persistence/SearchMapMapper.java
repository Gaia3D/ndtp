package ndtp.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import ndtp.domain.AddrJibun;
import ndtp.domain.CountryPlaceNumber;
import ndtp.domain.District;
import ndtp.domain.NewAddress;
import ndtp.domain.PlaceName;
import ndtp.domain.SkEmd;
import ndtp.domain.SkSdo;
import ndtp.domain.SkSgg;

@Repository
public interface SearchMapMapper {

	/**
	 * Sdo 목록(geom 은 제외)
	 * @return
	 */
	List<SkSdo> getListSdoExceptGeom();
	
	/**
	 * Sgg 목록(geom 은 제외)
	 * @param sdo_code
	 * @return
	 */
	List<SkSgg> getListSggBySdoExceptGeom(String sdoCode);
	
	/**
	 * emd 목록(geom 은 제외)
	 * @param skEmd
	 * @return
	 */
	List<SkEmd> getListEmdBySdoAndSggExceptGeom(SkEmd skEmd);
	
	/**
	 * 선택한 시도의 center point를 구함
	 * @param skSdo
	 * @return
	 */
	public String getCentroidSdo(SkSdo skSdo);
	
	/**
	 * 선택한 시군구 center point를 구함
	 * @param skSgg
	 * @return
	 */
	public String getCentroidSgg(SkSgg skSgg);
	
	/**
	 * 선택한 읍면동 center point를 구함
	 * @param skEmd
	 * @return
	 */
	public String getCentroidEmd(SkEmd skEmd);
	
	/**
	 * 행정구역 검색 총 건수
	 * @param district
	 * @return
	 */
	Long getDistrictTotalCount(District district);
	
	/**
	 * 지명 검색 총 건수
	 * @param placeName
	 * @return
	 */
	Long getPlaceNameTotalCount(PlaceName placeName);
	
	/**
	 * 지번 검색 총 건수
	 * @param addrJibun
	 * @return
	 */
	Long getJibunTotalCount(AddrJibun addrJibun);
	
	/**
	 * 새 주소 검색 총 건수
	 * @param newAddress
	 * @return
	 */
	Long getNewAddressTotalCount(NewAddress newAddress);
	
	/**
	 * 국가 지점 번호 검색 총 건수
	 * @param countryPlaceNumber
	 * @return
	 */
	Long getCountryPlaceNumberTotalCount(CountryPlaceNumber countryPlaceNumber);
	
	/**
	 * 행정 구역 검색
	 * @param district
	 * @return
	 */
	List<District> getListDistrict(District district);
	
	/**
	 * 지명 구역 검색
	 * @param placeName
	 * @return
	 */
	List<PlaceName> getListPlaceName(PlaceName placeName);
	
	/**
	 * 지번 검색 목록
	 * @param addrJibun
	 * @return
	 */
	List<AddrJibun> getListJibun(AddrJibun addrJibun);
	
	/**
	 * 새 주소 검색
	 * @param newAddress
	 * @return
	 */
	List<NewAddress> getListNewAddress(NewAddress newAddress);
	
	/**
	 * 국가 지점번호 검색 검색
	 * @param countryPlaceNumber
	 * @return
	 */
	List<CountryPlaceNumber> getListCountryPlaceNumber(CountryPlaceNumber countryPlaceNumber);
}