package ndtp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ndtp.domain.ApprovalStatus;
import ndtp.domain.DataInfo;
import ndtp.domain.DataInfoLog;
import ndtp.persistence.DataLogMapper;
import ndtp.service.DataLogService;
import ndtp.service.DataService;

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
	 * 데이터 로그 상태 변경
	 * @param dataInfoLog
	 * @return
	 */
	@Transactional
	public int updateDataInfoLogStatus(DataInfoLog dataInfoLog) {
		DataInfoLog dbDataInfoLog = dataLogMapper.getDataInfoLog(dataInfoLog.getDataInfoLogId());
		
		DataInfo dataInfo = new DataInfo();
		if(ApprovalStatus.APPROVAL == ApprovalStatus.valueOf(dataInfoLog.getStatus().toUpperCase())) {
			// 화면에서 승인으로 상태 변경을 요청한 경우. 대기 상태여야 함
			if(ApprovalStatus.REQUEST != ApprovalStatus.valueOf(dbDataInfoLog.getStatus().toUpperCase())) {
				throw new IllegalArgumentException("DataInfoLog Status Exception");
			}
			
			// data_info 를 update
			dataInfo.setDataId(dbDataInfoLog.getDataId());
			dataInfo.setLocation("POINT(" + dbDataInfoLog.getLongitude() + " " + dbDataInfoLog.getLatitude() + ")");
			dataInfo.setAltitude(dbDataInfoLog.getAltitude());
			dataInfo.setHeading(dbDataInfoLog.getHeading());
			dataInfo.setPitch(dbDataInfoLog.getPitch());
			dataInfo.setRoll(dbDataInfoLog.getRoll());
			dataService.updateData(dataInfo);
		} else if(ApprovalStatus.REJECT == ApprovalStatus.valueOf(dataInfoLog.getStatus().toUpperCase())) {
			// 화면에서 기각으로 상태 변경을 요청한 경우. 대기 상태여야 함
			if(ApprovalStatus.REQUEST != ApprovalStatus.valueOf(dbDataInfoLog.getStatus().toUpperCase())) {
				throw new IllegalArgumentException("DataInfoLog Status Exception");
			}
			// 아무 처리도 하지 않음
		} else if(ApprovalStatus.ROLLBACK == ApprovalStatus.valueOf(dataInfoLog.getStatus().toUpperCase())) {
			// 화면에서 원복으로 상태 변경을 요청한 경우. 승인 또는 기각 상태여야 함
			
			if(ApprovalStatus.APPROVAL != ApprovalStatus.valueOf(dbDataInfoLog.getStatus().toUpperCase())
					&& ApprovalStatus.REJECT != ApprovalStatus.valueOf(dbDataInfoLog.getStatus())) {
				throw new IllegalArgumentException("DataInfoLog Status Exception");
			}
			// data_info 의 상태를 원래대로 되돌림. 를 update
			dataInfo.setDataId(dbDataInfoLog.getDataId());
			dataInfo.setLocation("POINT(" + dbDataInfoLog.getLongitude() + " " + dbDataInfoLog.getLatitude() + ")");
			dataInfo.setAltitude(dbDataInfoLog.getBeforeAltitude());
			dataInfo.setHeading(dbDataInfoLog.getBeforeHeading());
			dataInfo.setPitch(dbDataInfoLog.getBeforePitch());
			dataInfo.setRoll(dbDataInfoLog.getBeforeRoll());
			dataService.updateData(dataInfo);
		}
		
		return dataLogMapper.updateDataInfoLogStatus(dataInfoLog);
	}
}
