package ndtp.service;

import java.util.List;

import ndtp.domain.DataInfoAdjustLog;

/**
 * 데이터 geometry 변경 이력 관리
 * @author jeongdae
 *
 */
public interface DataAdjustLogService {
	
	/**
	 * 데이터 geometry 변경 요청 수
	 * @param dataInfo
	 * @return
	 */
	Long getDataAdjustLogTotalCount(DataInfoAdjustLog dataInfoAdjustLog);
	
	/**
	 * 데이터 geometry 변경 요청 목록
	 * @param dataInfoAdjustLog
	 * @return
	 */
	List<DataInfoAdjustLog> getListDataAdjustLog(DataInfoAdjustLog dataInfoAdjustLog);
	
	/**
	 * 데이터 geometry 변경 이력 조회
	 * @param dataAdjustLogId
	 * @return
	 */
	DataInfoAdjustLog getDataAdjustLog(Long dataAdjustLogId);
	
	/**
	 * 데이터 geometry 변경 요청 상태 변경
	 * @param dataInfoAdjustLog
	 * @return
	 */
	int updateDataAdjustLogStatus(DataInfoAdjustLog dataInfoAdjustLog);
}
