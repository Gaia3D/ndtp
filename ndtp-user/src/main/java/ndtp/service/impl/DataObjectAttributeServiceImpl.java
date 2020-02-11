package ndtp.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.slf4j.Slf4j;
import ndtp.domain.DataObjectAttribute;
import ndtp.persistence.DataObjectAttributeMapper;
import ndtp.service.DataObjectAttributeService;
import ndtp.service.DataService;

/**
 * 데이터 Object 속성 관리
 * @author jeongdae
 *
 */
@Slf4j
@Service
public class DataObjectAttributeServiceImpl implements DataObjectAttributeService {
	
	@Autowired
	private DataService dataService;
	@Autowired
	private DataObjectAttributeMapper dataObjectAttributeMapper;
	
	/**
	 * 데이터 Object 속성 정보를 취득
	 * @param dataId
	 * @return
	 */
	@Transactional(readOnly=true)
	public DataObjectAttribute getDataObjectAttribute(Long dataId) {
		return dataObjectAttributeMapper.getDataObjectAttribute(dataId);
	}
}
