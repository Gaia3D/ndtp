package ndtp.parser;

import java.util.Map;

import ndtp.domain.DataAttributeFileInfo;

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
	Map<String, Object> parse(Long dataId, DataAttributeFileInfo dataAttributeFileInfo);
}
