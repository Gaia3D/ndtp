package ndtp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.slf4j.Slf4j;
import ndtp.domain.DataGroup;
import ndtp.persistence.DataGroupMapper;
import ndtp.service.DataGroupService;

@Slf4j
@Service
public class DataGroupServiceImpl implements DataGroupService {
	
	@Autowired
	private DataGroupMapper dataGroupMapper;

	/**
     * 데이터 그룹 목록
     * @return
     */
	@Transactional(readOnly = true)
	public List<DataGroup> getListDataGroup() {
		return dataGroupMapper.getListDataGroup();
	}

    /**
     * 데이터 그룹 등록
     * @param dataGroup
     * @return
     */
    @Transactional
	public int insertDataGroup(DataGroup dataGroup) {
    	return dataGroupMapper.insertDataGroup(dataGroup);
    }
    
	/**
	 * 데이터 그룹 수정
	 * @param dataGroup
	 * @return
	 */
    @Transactional
	public int updateDataGroup(DataGroup dataGroup) {
    	return dataGroupMapper.updateDataGroup(dataGroup);
    }
    
	/**
	 * 데이터 그룹 삭제
	 * @param dataGroupId
	 * @return
	 */
    @Transactional
	public int deleteDataGroup(int dataGroupId) {
    	return dataGroupMapper.deleteDataGroup(dataGroupId);
    }
}
