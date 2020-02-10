package ndtp.service;

import ndtp.domain.DataAttribute;
import ndtp.domain.DataAttributeFileInfo;

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
	
}
