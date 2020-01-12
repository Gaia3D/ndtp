//package ndtp.parser.impl;
//
//import java.nio.file.Files;
//import java.nio.file.Paths;
//import java.util.HashMap;
//import java.util.Map;
//
//import ndtp.domain.FileInfo;
//import ndtp.domain.DataAttributeFileParseLog;
//import ndtp.parser.DataAttributeFileParser;
//
//public class DataAttributeFileJsonParser implements DataAttributeFileParser {
//
//	@Override
//	public Map<String, Object> parse(Long dataId, FileInfo fileInfo) {
//		
//		int totalCount = 0;
//		int parseSuccessCount = 0;
//		int parseErrorCount = 0;
//		String attribute = null;
//		
//		DataAttributeFileParseLog fileParseLog = new DataAttributeFileParseLog();
//		fileParseLog.setFile_info_id(fileInfo.getDataFileInfoId());
//		fileParseLog.setLogType(DataAttributeFileParseLog.FILE_PARSE_LOG);		
//		
//		try {
//			//ObjectMapper objectMapper = new ObjectMapper();
//			byte[] jsonData = Files.readAllBytes(Paths.get(fileInfo.getFile_path() + fileInfo.getFile_real_name()));
//			attribute = new String(jsonData);
//			
//			parseSuccessCount++;
//		} catch (Exception e) {
//			parseErrorCount++;
//			e.printStackTrace();
//			throw new RuntimeException("Data 일괄 등록 Json 파일 파싱 오류!");
//		}
//		
//		Map<String, Object> result = new HashMap<>();
//		result.put("attribute", attribute);
//		result.put("totalCount", 1);
//		result.put("parseSuccessCount", parseSuccessCount);
//		result.put("parseErrorCount", parseErrorCount);
//		return result;
//	}
//}
