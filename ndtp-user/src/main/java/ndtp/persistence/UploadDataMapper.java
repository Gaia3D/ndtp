package ndtp.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import ndtp.domain.UploadData;
import ndtp.domain.UploadDataFile;

@Repository
public interface UploadDataMapper {

	/**
	 * 업로딩 데이터 총 건수
	 * @param uploadData
	 * @return
	 */
	Long getUploadDataTotalCount(UploadData uploadData);
	
	/**
	 * 업로딩 데이터 목록
	 * @param uploadData
	 * @return
	 */
	List<UploadData> getListUploadData(UploadData uploadData);
	
	/**
	 * 업로딩 정보
	 * @param uploadData
	 * @return
	 */
	UploadData getUploadData(UploadData uploadData);
	
//	/**
//	 * 업로딩 데이터 파일 총 건수
//	 * @param uploadDataFile
//	 * @return
//	 */
//	Long getUploadDataFileTotalCount(UploadDataFile uploadDataFile);
//
//	/**
//	 * 업로딩 데이터 파일 총 용량
//	 * @param uploadDataFile
//	 * @return
//	 */
//	Long getUploadDataFileTotalSize(UploadDataFile uploadDataFile);
	
	/**
	 * 업로딩 데이터 파일 목록
	 * @param uploadData
	 * @return
	 */
	List<UploadDataFile> getListUploadDataFile(UploadData uploadData);
	
	/**
	 * 사용자 파일 정보 업로딩
	 * @param uploadData
	 * @return
	 */
	int insertUploadData(UploadData uploadData);
	
	/**
	 * 사용자 파일 업로딩
	 * @param uploadDataFile
	 * @return
	 */
	int insertUploadDataFile(UploadDataFile uploadDataFile);
	
	/**
	 * 사용자 파일 정보 수정
	 * @param uploadData
	 * @return
	 */
	int updateUploadData(UploadData uploadData);
	
	/**
	 * 사용자 파일 업로딩 수정
	 * @param uploadDataFile
	 * @return
	 */
	int updateUploadDataFile(UploadDataFile uploadDataFile);

	/**
	 * 업로딩 데이터 정보 삭제
	 * @param uploadData
	 * @return
	 */
	int deleteUploadData(UploadData uploadData);
	
	/**
	 * 업로딩 데이터 파일 삭제
	 * @param uploadData
	 * @return
	 */
	int deleteUploadDataFile(UploadData uploadData);
}
