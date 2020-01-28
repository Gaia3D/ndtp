package ndtp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ndtp.domain.ApprovalStatus;
import ndtp.domain.ApprovalType;
import ndtp.domain.DataInfo;
import ndtp.domain.DataInfoLog;
import ndtp.domain.GeoPolicy;
import ndtp.persistence.DataLogMapper;
import ndtp.service.DataLogService;
import ndtp.service.DataService;
import ndtp.service.GeoPolicyService;

/**
 * Data Change Request Log
 * @author jeongdae
 *
 */
@Service
public class DataLogServiceImpl implements DataLogService {

	@Autowired
	private DataService dataService;
	
	@Autowired
	private DataLogMapper dataLogMapper;
	@Autowired
	private GeoPolicyService geoPolicyService;
	
	/**
	 * Data 변경 요청 수
	 * @param dataInfoLog
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getDataInfoLogTotalCount(DataInfoLog dataInfoLog) {
		return dataLogMapper.getDataInfoLogTotalCount(dataInfoLog);
	}
	
	/**
	 * 데이터 변경 요청 로그
	 * @param dataInfoLog
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<DataInfoLog> getListDataInfoLog(DataInfoLog dataInfoLog) {
		return dataLogMapper.getListDataInfoLog(dataInfoLog);
	}
	
	/**
	 * data info log 조회
	 * @param dataInfoLogId
	 * @return
	 */
	@Transactional(readOnly=true)
	public DataInfoLog getDataInfoLog(Long dataInfoLogId) {
		return dataLogMapper.getDataInfoLog(dataInfoLogId);
	}
	
	/**
	 * 데이터 위치 변경 요청 이력 등록
	 * @param dataInfoLog
	 * @return
	 */
	@Transactional
	public int insertDataInfoLog(DataInfoLog dataInfoLog) {
		
		GeoPolicy geoPolicy = geoPolicyService.getGeoPolicy();
		String dataChangeRequestDecision = geoPolicy.getDataChangeRequestDecision();
		
		DataInfo dataInfo = dataService.getData(DataInfo.builder().dataId(dataInfoLog.getDataId()).build());
		String location = "POINT(" + dataInfo.getLongitude() + " " + dataInfo.getLatitude() + ")";
		
		dataInfoLog.setDataGroupId(dataInfo.getDataGroupId());
		dataInfoLog.setUserId(dataInfo.getUserId());
		dataInfoLog.setBeforeLocation(location);
		dataInfoLog.setBeforeAltitude(dataInfo.getAltitude());
		dataInfoLog.setBeforeHeading(dataInfo.getHeading());
		dataInfoLog.setBeforePitch(dataInfo.getPitch());
		dataInfoLog.setBeforeRoll(dataInfo.getRoll());
		dataInfoLog.setLocation("POINT(" + dataInfoLog.getLongitude() + " " + dataInfoLog.getLatitude() + ")");
		
		if(ApprovalType.AUTO == ApprovalType.valueOf(dataChangeRequestDecision.toUpperCase())) {
			// 자동 승인의 경우
			dataInfoLog.setStatus(ApprovalStatus.APPROVAL.name().toLowerCase());
			
			// TODO 데이터 그룹의 init 이 데이터로 되어 있을 경우 이 값도 update 해 줘야 함
			// data_info 를 update
			dataInfo.setLocation("POINT(" + dataInfoLog.getLongitude() + " " + dataInfoLog.getLatitude() + ")");
			dataInfo.setAltitude(dataInfoLog.getAltitude());
			dataInfo.setHeading(dataInfoLog.getHeading());
			dataInfo.setPitch(dataInfoLog.getPitch());
			dataInfo.setRoll(dataInfoLog.getRoll());
			dataService.updateData(dataInfo);
		} else if(ApprovalType.APPROVAL == ApprovalType.valueOf(dataChangeRequestDecision.toUpperCase())) {
			// 승인이 필요한 경우
			dataInfoLog.setStatus(ApprovalStatus.REQUEST.name().toLowerCase());
		} else {
			// 기타
			
		}
				
		return dataLogMapper.insertDataInfoLog(dataInfoLog);
	}
}
