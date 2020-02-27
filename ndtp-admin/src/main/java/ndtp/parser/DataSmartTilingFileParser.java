package ndtp.parser;

import java.util.Map;

import ndtp.domain.DataSmartTilingFileInfo;

/**
 * @author Cheon JeongDae
 *
 */
public interface DataSmartTilingFileParser {
	
	/**
	 * @param dataGroupId
	 * @param dataSmartTilingFileInfo
	 * @return
	 */
	Map<String, Object> parse(Integer dataGroupId, DataSmartTilingFileInfo fileInfo);
}
