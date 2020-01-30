package ndtp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ndtp.domain.ApprovalStatus;
import ndtp.domain.ApprovalType;
import ndtp.domain.DataInfo;
import ndtp.domain.DataInfoAdjustLog;
import ndtp.domain.DataInfoLog;
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
	public Long getDataAdjustLogTotalCount(DataInfoAdjustLog dataInfoAdjustLog) {
		return dataAdjustLogMapper.getDataAdjustLogTotalCount(dataInfoAdjustLog);
	}
	
	/**
	 * 데이터 geometry 변경 요청 목록
	 * @param dataInfoAdjustLog
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<DataInfoAdjustLog> getListDataAdjustLog(DataInfoAdjustLog dataInfoAdjustLog) {
		return dataAdjustLogMapper.getListDataAdjustLog(dataInfoAdjustLog);
	}
	
	/**
	 * 데이터 geometry 조회
	 * @param dataAdjustLogId
	 * @return
	 */
	@Transactional(readOnly=true)
	public DataInfoAdjustLog getDataAdjustLog(Long dataAdjustLogId) {
		return dataAdjustLogMapper.getDataAdjustLog(dataAdjustLogId);
	}
	
	/**
	 * 데이터 geometry 변경 이력 등록
	 * @param dataInfoLog
	 * @return
	 */
	
	/**
	 * 데이터 geometry 변경 요청 상태 변경
	 * @param dataInfoAdjustLog
	 * @return
	 */
	@Transactional
	public int updateDataAdjustLogStatus(DataInfoAdjustLog dataInfoAdjustLog) {
		
		DataInfoAdjustLog dbDataInfoAdjustLog = dataAdjustLogMapper.getDataAdjustLog(dataInfoAdjustLog.getDataAdjustLogId());
		
		DataInfo dataInfo = new DataInfo();
		if(ApprovalStatus.APPROVAL == ApprovalStatus.valueOf(dataInfoAdjustLog.getStatus().toUpperCase())) {
			// 화면에서 승인으로 상태 변경을 요청한 경우. 대기 상태여야 함
			if(ApprovalStatus.REQUEST != ApprovalStatus.valueOf(dbDataInfoAdjustLog.getStatus().toUpperCase())) {
				throw new IllegalArgumentException("DataInfoLog Status Exception");
			}
			
			// data_info 를 update
			dataInfo.setDataId(dbDataInfoAdjustLog.getDataId());
			dataInfo.setLocation("POINT(" + dbDataInfoAdjustLog.getLongitude() + " " + dbDataInfoAdjustLog.getLatitude() + ")");
			dataInfo.setAltitude(dbDataInfoAdjustLog.getAltitude());
			dataInfo.setHeading(dbDataInfoAdjustLog.getHeading());
			dataInfo.setPitch(dbDataInfoAdjustLog.getPitch());
			dataInfo.setRoll(dbDataInfoAdjustLog.getRoll());
			dataService.updateData(dataInfo);
		} else if(ApprovalStatus.REJECT == ApprovalStatus.valueOf(dataInfoAdjustLog.getStatus().toUpperCase())) {
			// 화면에서 기각으로 상태 변경을 요청한 경우. 대기 상태여야 함
			if(ApprovalStatus.REQUEST != ApprovalStatus.valueOf(dbDataInfoAdjustLog.getStatus().toUpperCase())) {
				throw new IllegalArgumentException("DataInfoLog Status Exception");
			}
			// 아무 처리도 하지 않음
		} else if(ApprovalStatus.ROLLBACK == ApprovalStatus.valueOf(dataInfoAdjustLog.getStatus().toUpperCase())) {
			// 화면에서 원복으로 상태 변경을 요청한 경우. 승인 또는 기각 상태여야 함
			
			if(ApprovalStatus.APPROVAL != ApprovalStatus.valueOf(dbDataInfoAdjustLog.getStatus().toUpperCase())
					&& ApprovalStatus.REJECT != ApprovalStatus.valueOf(dbDataInfoAdjustLog.getStatus())) {
				throw new IllegalArgumentException("DataInfoLog Status Exception");
			}
			// data_info 의 상태를 원래대로 되돌림. 를 update
			dataInfo.setDataId(dbDataInfoAdjustLog.getDataId());
			dataInfo.setLocation("POINT(" + dbDataInfoAdjustLog.getLongitude() + " " + dbDataInfoAdjustLog.getLatitude() + ")");
			dataInfo.setAltitude(dbDataInfoAdjustLog.getBeforeAltitude());
			dataInfo.setHeading(dbDataInfoAdjustLog.getBeforeHeading());
			dataInfo.setPitch(dbDataInfoAdjustLog.getBeforePitch());
			dataInfo.setRoll(dbDataInfoAdjustLog.getBeforeRoll());
			dataService.updateData(dataInfo);
		}
		
		return dataAdjustLogMapper.updateDataAdjustLogStatus(dataInfoAdjustLog);
	}
}
