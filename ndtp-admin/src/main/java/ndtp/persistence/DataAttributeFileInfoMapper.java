package ndtp.persistence;

import org.springframework.stereotype.Repository;

import ndtp.domain.DataAttributeFileInfo;


/**
 * 데이터 속성 파일 처리
 * @author jeongdae
 *
 */
@Repository
public interface DataAttributeFileInfoMapper {
	
//	/**
//	 * 파일 정보 획득
//	 * @param file_info_id
//	 * @return
//	 */
//	FileInfo getFileInfo(Long file_info_id);
//	
//	/**
//	 * 파일 파싱 로그 획득
//	 * @param file_parse_log_id
//	 * @return
//	 */
//	FileParseLog getFileParseLog(Long file_parse_log_id);
//
	/**
	 * 데이터 속성 파일 정보 등록
	 * @param dataFileInfo
	 * @return
	 */
	int insertDataAttributeFileInfo(DataAttributeFileInfo dataFileInfo);
//	
//	/**
//	 * 파일 파싱 로그 등록
//	 * @param fileParseLog
//	 * @return
//	 */
//	int insertFileParseLog(FileParseLog fileParseLog);
//	
//	/**
//	 * 파일 정보 수정
//	 * @param fileInfo
//	 * @return
//	 */
//	int updateFileInfo(FileInfo fileInfo);
}
