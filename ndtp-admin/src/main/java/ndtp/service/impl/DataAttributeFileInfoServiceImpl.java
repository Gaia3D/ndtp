package ndtp.service.impl;

//import org.apache.commons.lang.StringUtils;
//import org.apache.poi.hssf.usermodel.HSSFWorkbook;
//import org.apache.poi.ss.usermodel.Cell;
//import org.apache.poi.ss.usermodel.Row;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.slf4j.Slf4j;
import ndtp.domain.DataAttributeFileInfo;
import ndtp.persistence.DataAttributeFileInfoMapper;
import ndtp.service.DataAttributeFileInfoService;

/**
 * 파일 처리
 * @author jeongdae
 *
 */
@Slf4j
@Service
public class DataAttributeFileInfoServiceImpl implements DataAttributeFileInfoService {
	
//	@Autowired
//	private PropertiesConfig propertiesConfig;
//	
//	@Autowired
//	private UserService userService;
//	@Autowired
//	private DataService dataService;
	@Autowired
	private DataAttributeFileInfoMapper dataAttributeFileInfoMapper;
	
	// 사용자 일괄 등록 Excel 파일 컬럼수
	private int EXCEL_UPLOAD_USER_COLUMN = 15;
	// Data 일괄 등록 Excel 파일 컬럼수
	private int EXCEL_UPLOAD_DATA_COLUMN = 9;
	// 엑셀에 최대 등록 가능한 건수
//	private int MAX_COUNT = 65000;
	
	/**
	 * DATA Attribute 한건 등록
	 * @param dataId
	 * @param dataFileInfo
	 * @return
	 */
	@Transactional
	public DataAttributeFileInfo insertDataAttributeFile(Long dataId, DataAttributeFileInfo dataFileInfo) {
		
//		// 파일 이력을 저장
//		insertDataAttributeFileInfo(dataFileInfo);
//		
//		DataAttributeFileParser dataAttributeFileParser = null;
//		if(FileUtil.EXTENSION_JSON.equals(dataFileInfo.getFile_ext())) {
//			dataAttributeFileParser = new DataAttributeFileJsonParser();
//		} else {
//			dataAttributeFileParser = new DataAttributeFileJsonParser();
//		}
//		Map<String, Object> map = dataAttributeFileParser.parse(dataId, dataFileInfo);
//		
//		String attribute = (String) map.get("attribute");
//		
//		DataAttributeFileParseLog fileParseLog = new DataAttributeFileParseLog();
//		fileParseLog.setFile_info_id(dataFileInfo.getFile_info_id());
//		fileParseLog.setLog_type(DataAttributeFileParseLog.DB_INSERT_LOG);
//		
//		int insertSuccessCount = 0;
//		int updateSuccessCount = 0;
//		int insertErrorCount = 0;
//		try {
//			DataInfoAttribute dataInfoAttribute = dataService.getDataAttribute(dataId);
//			if(dataInfoAttribute == null) {
//				dataInfoAttribute = new DataInfoAttribute();
//				dataInfoAttribute.setData_id(dataId);
//				dataInfoAttribute.setAttributes(attribute);
//				dataService.insertDataAttribute(dataInfoAttribute);
//				insertSuccessCount++;
//			} else {
//				dataInfoAttribute.setAttributes(attribute);
//				dataService.updateDataAttribute(dataInfoAttribute);
//				updateSuccessCount++;
//			}
//		} catch(Exception e) {
//			e.printStackTrace();
//			fileParseLog.setIdentifier_value(dataFileInfo.getUser_id());
//			fileParseLog.setError_code(e.getMessage());
//			fileMapper.insertFileParseLog(fileParseLog);
//			insertErrorCount++;
//		}
//		
//		dataFileInfo.setTotal_count((Integer) map.get("totalCount"));
//		dataFileInfo.setParse_success_count((Integer) map.get("parseSuccessCount"));
//		dataFileInfo.setParse_error_count((Integer) map.get("parseErrorCount"));
//		dataFileInfo.setInsert_success_count(insertSuccessCount);
//		dataFileInfo.setUpdate_success_count(updateSuccessCount);
//		dataFileInfo.setInsert_error_count(insertErrorCount);
//		fileMapper.updateFileInfo(dataFileInfo);
//		
//		return dataFileInfo;
		
		return null;
	}
	
	/**
	 * 파일 정보 등록
	 * @param dataFileInfo
	 * @return
	 */
	@Transactional
	public int insertDataAttributeFileInfo(DataAttributeFileInfo dataFileInfo) {
		return dataAttributeFileInfoMapper.insertDataAttributeFileInfo(dataFileInfo);
	}
}
