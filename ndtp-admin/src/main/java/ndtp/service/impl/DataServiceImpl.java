package ndtp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ndtp.domain.DataGroup;
import ndtp.domain.DataInfo;
import ndtp.domain.DataInfoLog;
import ndtp.domain.DataInfoSimple;
import ndtp.domain.MethodType;
import ndtp.persistence.DataMapper;
import ndtp.service.DataGroupService;
import ndtp.service.DataLogService;
import ndtp.service.DataService;

/**
 * Data
 * @author jeongdae
 *
 */
@Service
public class DataServiceImpl implements DataService {

	@Autowired
	private DataMapper dataMapper;
	
	@Autowired
	private DataGroupService dataGroupService;
	
	@Autowired
	private DataLogService dataLogService;
	
	/**
	 * Data 수
	 * @param dataInfo
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getDataTotalCount(DataInfo dataInfo) {
		return dataMapper.getDataTotalCount(dataInfo);
	}
	
	/**
	 * 데이터 상태별 통계 정보
	 * @param dataInfo
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getDataTotalCountByStatus(String status) {
		return dataMapper.getDataTotalCountByStatus(status);
	}
	
	/**
	 * Data 목록
	 * @param dataInfo
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<DataInfo> getListData(DataInfo dataInfo) {
		return dataMapper.getListData(dataInfo);
	}
	
	/**
	 * 데이터 그룹에 포함되는 모든 데이터를 취득
	 * @param dataGroupId
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<DataInfoSimple> getListAllDataByDataGroupId(Integer dataGroupId) {
		return dataMapper.getListAllDataByDataGroupId(dataGroupId);
	}
	
	/**
	 * Data 정보 취득
	 * @param data_id
	 * @return
	 */
	@Transactional(readOnly=true)
	public DataInfo getData(DataInfo dataInfo) {
		return dataMapper.getData(dataInfo);
	}
	
	/**
	 * Data 정보 취득
	 * @param dataInfo
	 * @return
	 */
	@Transactional(readOnly=true)
	public DataInfo getDataByDataKey(DataInfo dataInfo) {
		return dataMapper.getDataByDataKey(dataInfo);
	}
	
	/**
	 * 최상위 root dataInfo 정보 취득
	 * @param projectId
	 * @return
	 */
	@Transactional(readOnly=true)
	public DataInfo getRootDataByDataGroupId(Integer dataGroupId) {
		return dataMapper.getRootDataByDataGroupId(dataGroupId);
	}
	
	/**
	 * Data 정보 취득
	 * @param dataInfo
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<DataInfo> getDataByConverterJob(DataInfo dataInfo) {
		return dataMapper.getDataByConverterJob(dataInfo);
	}
	
	/**
	 * Data 등록
	 * @param dataInfo
	 * @return
	 */
	@Transactional
	public int insertData(DataInfo dataInfo) {
		dataMapper.insertData(dataInfo);
		DataInfoLog dataInfoLog = new DataInfoLog(dataInfo);
		dataInfoLog.setChangeType(MethodType.INSERT.name().toLowerCase());
		return dataLogService.insertDataInfoLog(dataInfoLog);
	}
	
	/**
	 * Data 수정
	 * @param dataInfo
	 * @return
	 */
	@Transactional
	public int updateData(DataInfo dataInfo) {
		// TODO 환경 설정 값을 읽어 와서 update 할 건지, delete 할건지 분기를 타야 함
		dataMapper.updateData(dataInfo);
		dataInfo = dataMapper.getData(dataInfo);
		DataInfoLog dataInfoLog = new DataInfoLog(dataInfo);
		dataInfoLog.setChangeType(MethodType.UPDATE.name().toLowerCase());
		dataInfoLog.setUpdateUserId(dataInfo.getUserId());
		return dataLogService.insertDataInfoLog(dataInfoLog);
	}
	/**
	 * Data 상태 수정
	 * @param dataInfo
	 * @return
	 */
	@Transactional
	public int updateDataStatus(DataInfo dataInfo) {
		return dataMapper.updateDataStatus(dataInfo);
	}
	
	/**
	 * Data 삭제
	 * @param dataInfo
	 * @return
	 */
	@Transactional
	public int deleteData(DataInfo dataInfo) {
		// 데이터 그룹 count -1
		dataInfo = dataMapper.getData(dataInfo);
		
		DataGroup dataGroup = new DataGroup();
		dataGroup.setDataGroupId(dataInfo.getDataGroupId());
		dataGroup = dataGroupService.getDataGroup(dataGroup);
		
		DataGroup tempDataGroup = DataGroup.builder()
				.dataGroupId(dataGroup.getDataGroupId())
				.dataCount(dataGroup.getDataCount() - 1).build();
		dataGroupService.updateDataGroup(tempDataGroup);
		
		return dataMapper.deleteData(dataInfo);
		// TODO 디렉토리도 삭제 해야 함
	}
	
	/**
	 * 일괄 Data 삭제
	 * @param checkIds
	 * @return
	 */
	@Transactional
	public int deleteDataList(String userId, String checkIds) {
		// TODO sql in 으로 한번 query 가능 함. 수정해야 함
		
		String[] dataIds = checkIds.split(",");
		for(String dataId : dataIds) {
			DataInfo dataInfo = new DataInfo();
			dataInfo.setUserId(userId);
			dataInfo.setDataId(Long.valueOf(dataId));
			return dataMapper.deleteData(dataInfo);
		}
		
		return checkIds.length();
	}
	
	/**
	 * Data 에 속하는 모든 Object ID를 삭제
	 * @param dataId
	 * @return
	 */
	@Transactional
	public int deleteDataObjects(Long dataId) {
		return dataMapper.deleteDataObjects(dataId);
	}
	
	/**
	 * Data 삭제
	 * @param dataInfo
	 * @return
	 */
	@Transactional
	public int deleteDataByConverterJob(DataInfo dataInfo) {
		return dataMapper.deleteDataByConverterJob(dataInfo);
	}
}
