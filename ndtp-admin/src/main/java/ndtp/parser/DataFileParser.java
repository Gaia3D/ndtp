package ndtp.parser;

import java.util.Map;

import ndtp.domain.FileInfo;

/**
 * @author Cheon JeongDae
 *
 */
public interface DataFileParser {
	
	/**
	 * parse
	 * @param dataGroupId
	 * @param fileInfo
	 * @return
	 */
	Map<String, Object> parse(Integer dataGroupId, FileInfo fileInfo);
}
