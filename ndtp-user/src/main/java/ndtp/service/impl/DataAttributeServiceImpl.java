package ndtp.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ndtp.domain.DataAttribute;
import ndtp.persistence.DataAttributeMapper;
import ndtp.service.DataAttributeService;

/**
 * 데이터 속성 관리
 * @author jeongdae
 *
 */
@Service
public class DataAttributeServiceImpl implements DataAttributeService {
	
	@Autowired
	private DataAttributeMapper dataAttributeMapper;
	
	/**
	 * 데이터 속성 정보를 취득
	 * @param dataId
	 * @return
	 */
	@Transactional(readOnly=true)
	public DataAttribute getDataAttribute(Long dataId) {
		return dataAttributeMapper.getDataAttribute(dataId);
	}
}
