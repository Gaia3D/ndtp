package ndtp.service;

import ndtp.domain.DataAttribute;

/**
 * 데이터 파일 속성 관리
 * @author jeongdae
 *
 */
public interface DataAttributeService {
	
	/**
	 * 데이터 속성 정보를 취득
	 * @param dataId
	 * @return
	 */
	DataAttribute getDataAttribute(Long dataId);
	
	/**
	 * 데이터 속성 등록
	 * @param dataAttribute
	 * @return
	 */
	int insertDataAttribute(DataAttribute dataAttribute);
	
	/**
	 * 데이터 속성 수정
	 * @param dataAttribute
	 * @return
	 */
	int updateDataAttribute(DataAttribute dataAttribute);
}
