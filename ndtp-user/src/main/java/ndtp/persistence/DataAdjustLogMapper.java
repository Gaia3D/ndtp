package ndtp.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import ndtp.domain.DataInfoAdjustLog;

/**
 * 데이터 geometry 변경 이력
 * @author jeongdae
 *
 */
@Repository
public interface DataAdjustLogMapper {

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
	 * 데이터 geometry 변경 이력 저장
	 * @param dataInfoAdjustLog
	 * @return
	 */
	int insertDataAdjustLog(DataInfoAdjustLog dataInfoAdjustLog);	
}
