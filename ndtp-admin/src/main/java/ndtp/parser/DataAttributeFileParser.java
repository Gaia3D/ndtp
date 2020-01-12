package ndtp.parser;

import java.util.Map;

import ndtp.domain.FileInfo;

/**
 * @author Cheon JeongDae
 *
 */
public interface DataAttributeFileParser {
	
	/**
	 * parse
	 * @param dataId
	 * @param fileInfo
	 * @return
	 */
	Map<String, Object> parse(Long dataId, FileInfo fileInfo);
}
