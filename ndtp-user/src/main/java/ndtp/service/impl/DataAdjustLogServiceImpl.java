package ndtp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ndtp.domain.ApprovalStatus;
import ndtp.domain.ApprovalType;
import ndtp.domain.CacheManager;
import ndtp.domain.DataInfo;
import ndtp.domain.DataAdjustLog;
import ndtp.domain.GeoPolicy;
import ndtp.persistence.DataAdjustLogMapper;
import ndtp.service.DataAdjustLogService;
import ndtp.service.DataService;
import ndtp.service.GeoPolicyService;

/**
 * 데이터 geometry 변경 이력
 * @author jeongdae
 *
 */
@Service
public class DataAdjustLogServiceImpl implements DataAdjustLogService {

	@Autowired
	private DataService dataService;
	
	@Autowired
	private DataAdjustLogMapper dataAdjustLogMapper;
	@Autowired
	private GeoPolicyService geoPolicyService;
	
	/**
	 * 데이터 geometry 변경 요청 수
	 * @param dataInfoAdjustLog
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getDataAdjustLogTotalCount(DataAdjustLog dataInfoAdjustLog) {
		return dataAdjustLogMapper.getDataAdjustLogTotalCount(dataInfoAdjustLog);
	}
	
	/**
	 * 데이터 geometry 변경 요청 목록
	 * @param dataInfoAdjustLog
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<DataAdjustLog> getListDataAdjustLog(DataAdjustLog dataInfoAdjustLog) {
		return dataAdjustLogMapper.getListDataAdjustLog(dataInfoAdjustLog);
	}
	
	/**
	 * 데이터 geometry 조회
	 * @param dataAdjustLogId
	 * @return
	 */
	@Transactional(readOnly=true)
	public DataAdjustLog getDataAdjustLog(Long dataAdjustLogId) {
		return dataAdjustLogMapper.getDataAdjustLog(dataAdjustLogId);
	}
	
	/**
	 * 데이터 geometry 변경 이력 등록
	 * @param dataInfoLog
	 * @return
	 */
	@Transactional
	public int insertDataAdjustLog(DataAdjustLog dataInfoAdjustLog) {
		
		GeoPolicy geoPolicy = CacheManager.getGeoPolicy();
		String dataChangeRequestDecision = geoPolicy.getDataChangeRequestDecision();
		
		DataInfo dataInfo = dataService.getData(DataInfo.builder().dataId(dataInfoAdjustLog.getDataId()).build());
		String location = "POINT(" + dataInfo.getLongitude() + " " + dataInfo.getLatitude() + ")";
		
		dataInfoAdjustLog.setDataGroupId(dataInfo.getDataGroupId());
		dataInfoAdjustLog.setUserId(dataInfo.getUserId());
		dataInfoAdjustLog.setBeforeLocation(location);
		dataInfoAdjustLog.setBeforeAltitude(dataInfo.getAltitude());
		dataInfoAdjustLog.setBeforeHeading(dataInfo.getHeading());
		dataInfoAdjustLog.setBeforePitch(dataInfo.getPitch());
		dataInfoAdjustLog.setBeforeRoll(dataInfo.getRoll());
		dataInfoAdjustLog.setLocation("POINT(" + dataInfoAdjustLog.getLongitude() + " " + dataInfoAdjustLog.getLatitude() + ")");
		
		if(ApprovalType.AUTO == ApprovalType.valueOf(dataChangeRequestDecision.toUpperCase())) {
			// 자동 승인의 경우
			dataInfoAdjustLog.setStatus(ApprovalStatus.APPROVAL.name().toLowerCase());
			
			// TODO 데이터 그룹의 init 이 데이터로 되어 있을 경우 이 값도 update 해 줘야 함
			// data_info 를 update
			dataInfo.setLocation("POINT(" + dataInfoAdjustLog.getLongitude() + " " + dataInfoAdjustLog.getLatitude() + ")");
			dataInfo.setAltitude(dataInfoAdjustLog.getAltitude());
			dataInfo.setHeading(dataInfoAdjustLog.getHeading());
			dataInfo.setPitch(dataInfoAdjustLog.getPitch());
			dataInfo.setRoll(dataInfoAdjustLog.getRoll());
			dataService.updateData(dataInfo);
		} else if(ApprovalType.APPROVAL == ApprovalType.valueOf(dataChangeRequestDecision.toUpperCase())) {
			// 승인이 필요한 경우
			dataInfoAdjustLog.setStatus(ApprovalStatus.REQUEST.name().toLowerCase());
		} else {
			// 기타
			
		}
				
		return dataAdjustLogMapper.insertDataAdjustLog(dataInfoAdjustLog);
	}
}
