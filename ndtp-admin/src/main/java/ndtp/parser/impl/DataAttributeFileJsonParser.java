package ndtp.parser.impl;

import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;

import ndtp.domain.DataAttributeFileInfo;
import ndtp.parser.DataAttributeFileParser;

public class DataAttributeFileJsonParser implements DataAttributeFileParser {

	@Override
	public Map<String, Object> parse(Long dataId, DataAttributeFileInfo dataAttributeFileInfo) {
		
		int parseSuccessCount = 0;
		int parseErrorCount = 0;
		String attribute = null;
		
		try {
			byte[] jsonData = Files.readAllBytes(Paths.get(dataAttributeFileInfo.getFilePath() + dataAttributeFileInfo.getFileRealName()));
			attribute = new String(jsonData);
			
			parseSuccessCount++;
		} catch (Exception e) {
			parseErrorCount++;
			e.printStackTrace();
			throw new RuntimeException("Data 속성 파일 파싱 오류!");
		}
		
		Map<String, Object> result = new HashMap<>();
		result.put("attribute", attribute);
		result.put("totalCount", 1);
		result.put("parseSuccessCount", parseSuccessCount);
		result.put("parseErrorCount", parseErrorCount);
		return result;
	}
}
