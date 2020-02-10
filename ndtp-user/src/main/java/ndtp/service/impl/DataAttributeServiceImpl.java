package ndtp.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.slf4j.Slf4j;
import ndtp.domain.DataAttribute;
import ndtp.persistence.DataAttributeMapper;
import ndtp.service.DataAttributeService;
import ndtp.service.DataService;

/**
 * 데이터 속성 관리
 * @author jeongdae
 *
 */
@Slf4j
@Service
public class DataAttributeServiceImpl implements DataAttributeService {
	
	@Autowired
	private DataService dataService;
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
