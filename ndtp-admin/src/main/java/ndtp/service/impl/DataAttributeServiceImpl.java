package ndtp.service.impl;

import java.util.Map;

//import org.apache.commons.lang.StringUtils;
//import org.apache.poi.hssf.usermodel.HSSFWorkbook;
//import org.apache.poi.ss.usermodel.Cell;
//import org.apache.poi.ss.usermodel.Row;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.slf4j.Slf4j;
import ndtp.domain.DataAttribute;
import ndtp.domain.DataAttributeFileInfo;
import ndtp.domain.DataInfo;
import ndtp.parser.DataAttributeFileParser;
import ndtp.parser.impl.DataAttributeFileJsonParser;
import ndtp.persistence.DataAttributeMapper;
import ndtp.service.DataAttributeService;
import ndtp.service.DataService;
import ndtp.utils.FileUtils;

/**
 * 데이터 속성 관리
 * @author jeongdae
 *
 */
@Slf4j
@Service
public class DataAttributeServiceImpl implements DataAttributeService {
	
	@Autowired
	private DataService dataService;
	@Autowired
	private DataAttributeMapper dataAttributeMapper;
	
	/**
	 * 데이터 속성 정보를 취득
	 * @param dataId
	 * @return
	 */
	@Transactional(readOnly=true)
	public DataAttribute getDataAttribute(Long dataId) {
		return dataAttributeMapper.getDataAttribute(dataId);
	}
	
	/**
	 * 데이터 속성 등록
	 * @param dataId
	 * @param dataAttributeFileInfo
	 * @return
	 */
	@Transactional
	public DataAttributeFileInfo insertDataAttribute(Long dataId, DataAttributeFileInfo dataAttributeFileInfo) {
		
		// 파일 이력을 저장
		dataAttributeMapper.insertDataAttributeFileInfo(dataAttributeFileInfo);
		
		DataAttributeFileParser dataAttributeFileParser = null;
		if(FileUtils.EXTENSION_JSON.equals(dataAttributeFileInfo.getFileExt())) {
			dataAttributeFileParser = new DataAttributeFileJsonParser();
		} else {
			dataAttributeFileParser = new DataAttributeFileJsonParser();
		}
		Map<String, Object> map = dataAttributeFileParser.parse(dataId, dataAttributeFileInfo);
		
		String attribute = (String) map.get("attribute");
		int insertSuccessCount = 0;
		int updateSuccessCount = 0;
		int insertErrorCount = 0;
		try {
			DataAttribute dataAttribute = dataAttributeMapper.getDataAttribute(dataId);
			if(dataAttribute == null) {
				dataAttribute = new DataAttribute();
				dataAttribute.setDataId(dataId);
				dataAttribute.setAttributes(attribute);
				dataAttributeMapper.insertDataAttribute(dataAttribute);
				insertSuccessCount++;
			} else {
				dataAttribute.setAttributes(attribute);
				dataAttributeMapper.updateDataAttribute(dataAttribute);
				updateSuccessCount++;
			}
		} catch(Exception e) {
			e.printStackTrace();
			// TODO 파싱을 하지 않아서 따로 로그를 남길 필요는 현재는 없음. 삭제 할 예정
//			fileParseLog.setIdentifier_value(fileInfo.getUser_id());
//			fileParseLog.setError_code(e.getMessage());
//			fileMapper.insertFileParseLog(fileParseLog);
			insertErrorCount++;
		}
		
		dataAttributeFileInfo.setTotalCount((Integer) map.get("totalCount"));
		dataAttributeFileInfo.setParseSuccessCount((Integer) map.get("parseSuccessCount"));
		dataAttributeFileInfo.setParseErrorCount((Integer) map.get("parseErrorCount"));
		dataAttributeFileInfo.setInsertSuccessCount(insertSuccessCount);
		dataAttributeFileInfo.setUpdateSuccessCount(updateSuccessCount);
		dataAttributeFileInfo.setInsertErrorCount(insertErrorCount);
		
		dataAttributeMapper.updateDataAttributeFileInfo(dataAttributeFileInfo);
		
		// 데이터 속성 필드 수정
		DataInfo dataInfo = new DataInfo();
		dataInfo.setDataId(dataAttributeFileInfo.getDataId());
		dataInfo.setAttributeExist(true);
		dataService.updateData(dataInfo);
		
		return dataAttributeFileInfo;
	}
	
	/**
	 * 파일 정보 등록
	 * @param dataFileInfo
	 * @return
	 */
	@Transactional
	public int insertDataAttributeFileInfo(DataAttributeFileInfo dataFileInfo) {
		return dataAttributeMapper.insertDataAttributeFileInfo(dataFileInfo);
	}
}
