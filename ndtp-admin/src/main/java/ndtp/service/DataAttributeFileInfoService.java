package ndtp.service;

import ndtp.domain.DataAttributeFileInfo;

/**
 * 데이터 파일 처리
 * @author jeongdae
 *
 */
public interface DataAttributeFileInfoService {
	
//	/**
//	 * 파일 정보 획득
//	 * @param fileInfoId
//	 * @return
//	 */
//	public FileInfo getFileInfo(Long fileInfoId);
//	
//	/**
//	 * 파일 파싱 로그 획득
//	 * @param fileParseLogId
//	 * @return
//	 */
//	public FileParseLog getFileParseLog(Long fileParseLogId);
//
//	/**
//	 * 파일 정보 등록
//	 * @param fileInfo
//	 * @return
//	 */
//	public int insertFileInfo(FileInfo fileInfo);
//	
//	/**
//	 * 사용자 일괄 등록
//	 * @param fileInfo
//	 * @return
//	 */
//	public FileInfo insertExcelUser(FileInfo fileInfo);
//	
//	/**
//	 * Data 일괄 등록
//	 * @param projectId
//	 * @param fileInfo
//	 * @return
//	 */
//	public FileInfo insertDataFile(Integer projectId, FileInfo fileInfo);
	
	/**
	 * Data Attribute 등록
	 * @param dataId
	 * @param dataFileInfo
	 * @return
	 */
	public DataAttributeFileInfo insertDataAttributeFile(Long dataId, DataAttributeFileInfo dataFileInfo);
	
//	/**
//	 * Data Object Attribute 등록
//	 * @param dataId
//	 * @param fileInfo
//	 * @return
//	 */
//	public FileInfo insertDataObjectAttributeFile(Long dataId, FileInfo fileInfo);
//	
//	/**
//	 * 파일 파싱 로그 등록
//	 * @param fileParseLog
//	 * @return
//	 */
//	public int insertFileParseLog(FileParseLog fileParseLog);
//	
//	/**
//	 * 파일 정보 수정
//	 * @param fileInfo
//	 * @return
//	 */
//	public int updateFileInfo(FileInfo fileInfo);
}
