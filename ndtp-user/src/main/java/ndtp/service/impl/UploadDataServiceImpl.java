package ndtp.service.impl;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ndtp.domain.FileType;
import ndtp.domain.UploadData;
import ndtp.domain.UploadDataFile;
import ndtp.persistence.UploadDataMapper;
import ndtp.service.UploadDataService;

/**
 * @author Cheon JeongDae
 *
 */
@Service
public class UploadDataServiceImpl implements UploadDataService {

	@Autowired
	private UploadDataMapper uploadDataMapper;
	
	/**
	 * 업로딩 데이터 총 건수
	 * @param uploadData
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getUploadDataTotalCount(UploadData uploadData) {
		return uploadDataMapper.getUploadDataTotalCount(uploadData);
	}
	
	/**
	 * 업로딩 데이터 목록
	 * @param uploadData
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<UploadData> getListUploadData(UploadData uploadData) {
		return uploadDataMapper.getListUploadData(uploadData);
	}
	
	/**
	 * 업로딩 정보
	 * @param uploadData
	 * @return
	 */
	@Transactional(readOnly=true)
	public UploadData getUploadData(UploadData uploadData) {
		return uploadDataMapper.getUploadData(uploadData);
	}
	
	/**
	 * 업로딩 데이터 파일 총 건수
	 * @param uploadDataFile
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getUploadDataFileTotalCount(UploadDataFile uploadDataFile) {
		return uploadDataMapper.getUploadDataFileTotalCount(uploadDataFile);
	}

	/**
	 * 업로딩 데이터 파일 총 용량
	 * @param uploadDataFile
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getUploadDataFileTotalSize(UploadDataFile uploadDataFile) {
		return uploadDataMapper.getUploadDataFileTotalSize(uploadDataFile);
	}
	
	/**
	 * 업로딩 데이터 파일 목록
	 * @param uploadData
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<UploadDataFile> getListUploadDataFile(UploadData uploadData) {
		return uploadDataMapper.getListUploadDataFile(uploadData);
	}
	
	/**
	 * 사용자 파일 정보 업로딩
	 * @param uploadData
	 * @param uploadDataFileList
	 * @return
	 */
	@Transactional
	public int insertUploadData(UploadData uploadData, List<UploadDataFile> uploadDataFileList) {
		int result = uploadDataMapper.insertUploadData(uploadData);
		
		Long uploadDataId = uploadData.getUploadDataId();
//		Integer dataGroupId = uploadData.getDataGroupId();
//		String sharing = uploadData.getSharing();
//		String dataType = uploadData.getDataType();
		String userId = uploadData.getUserId();
		for(UploadDataFile uploadDataFile : uploadDataFileList) {
			uploadDataFile.setUploadDataId(uploadDataId);
			uploadDataFile.setUserId(userId);
			uploadDataMapper.insertUploadDataFile(uploadDataFile);
			result++;
		}
		return result;
	}
	
	/**
	 * 사용자 파일 정보 수정
	 * @param uploadData
	 * @return
	 */
	@Transactional
	public int updateUploadData(UploadData uploadData) {
		return uploadDataMapper.updateUploadData(uploadData);
	}
	
	/**
	 * 업로딩 데이터 삭제
	 * @param checkIds
	 * @return
	 */
	@Transactional
	public int deleteUploadDatas(String userId, String checkIds) {
		String[] uploadDatas = checkIds.split(",");
		
		for(String uploadDataId : uploadDatas) {
			UploadData uploadData = new UploadData();
			uploadData.setUserId(userId);
			uploadData.setUploadDataId(Long.valueOf(uploadDataId));
			
			List<UploadDataFile> uploadDataFileList = uploadDataMapper.getListUploadDataFile(uploadData);
			uploadDataMapper.deleteUploadDataFile(uploadData);
			// 2 upload_data 삭제
			uploadDataMapper.deleteUploadData(uploadData);
			
			for(UploadDataFile deleteUploadDataFile : uploadDataFileList) {
				String fileName = null;
				if(FileType.DIRECTORY == FileType.valueOf(deleteUploadDataFile.getFileType())) {
					fileName = deleteUploadDataFile.getFilePath();
				} else {
					fileName = deleteUploadDataFile.getFilePath() + deleteUploadDataFile.getFileRealName();
				}
				
				File file = new File(fileName);
				if(file.exists()) {
					file.delete();
				}
			}
		}
			
		return uploadDatas.length;
	}
}
