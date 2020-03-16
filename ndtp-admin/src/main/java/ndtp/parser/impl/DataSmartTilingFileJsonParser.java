package ndtp.parser.impl;

import java.math.BigDecimal;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.util.StringUtils;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;
import ndtp.domain.DataGroup;
import ndtp.domain.DataInfo;
import ndtp.domain.DataSmartTilingFileInfo;
import ndtp.parser.DataSmartTilingFileParser;

@Slf4j
public class DataSmartTilingFileJsonParser implements DataSmartTilingFileParser {

	@Override
	public Map<String, Object> parse(Integer dataGroupId, DataSmartTilingFileInfo fileInfo) {
		
		int totalCount = 0;
		int parseSuccessCount = 0;
		int parseErrorCount = 0;
		
		DataGroup dataGroup = new DataGroup();
		List<DataInfo> dataInfoList = new ArrayList<>();
		try {
			byte[] jsonData = Files.readAllBytes(Paths.get(fileInfo.getFilePath() + fileInfo.getFileRealName()));
			String encodingData = new String(jsonData, StandardCharsets.UTF_8);
			
			ObjectMapper objectMapper = new ObjectMapper();
			//read JSON like DOM Parser
			JsonNode jsonNode = objectMapper.readTree(encodingData);
			
//			String dataName = jsonNode.path("data_name").asText();
//			String dataKey = jsonNode.path("data_key").asText();
			String longitude = jsonNode.path("longitude").asText().trim();
			String latitude = jsonNode.path("latitude").asText().trim();
			String altitude = jsonNode.path("height").asText().trim();
			String mappingType = jsonNode.path("mapping_type").asText();
			JsonNode metainfo = jsonNode.path("attributes");
			JsonNode childrenNode = jsonNode.path("children");
			
			dataGroup.setDataGroupId(dataGroupId);
//			dataGroup.setDataGroupName(dataName);
//			dataGroup.setDataGroupKey(dataKey);
			
			if(!StringUtils.isEmpty(longitude)) {
				longitude = longitude.replace("null", "");
				if(!StringUtils.isEmpty(longitude)) dataGroup.setLongitude(new BigDecimal(longitude));
			}
			if(!StringUtils.isEmpty(latitude)) {
				latitude = latitude.replace("null", "");
				if(!StringUtils.isEmpty(latitude)) dataGroup.setLatitude(new BigDecimal(latitude));
			}
			if(!StringUtils.isEmpty(altitude)) {
				altitude = altitude.replace("null", "");
				if(!StringUtils.isEmpty(altitude)) dataGroup.setAltitude(new BigDecimal(altitude));
			}
			if(dataGroup.getLongitude() != null && dataGroup.getLatitude() != null) {
				dataGroup.setLocation("POINT(" + dataGroup.getLongitude() + " " + dataGroup.getLatitude() + ")");
			}
			dataGroup.setDepth(1);
			dataGroup.setMetainfo(metainfo.toString());
			
			if(childrenNode.isArray() && childrenNode.size() != 0) {
				dataInfoList.addAll(parseChildren(null, 0, childrenNode));
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("SmartTiling json 파일 파싱 오류. message = " + e.getMessage());
		}
		
		Map<String, Object> result = new HashMap<>();
		result.put("dataGroup", dataGroup);
		result.put("dataInfoList", dataInfoList);
		result.put("totalCount", dataInfoList.size());
		result.put("parseSuccessCount", dataInfoList.size());
		result.put("parseErrorCount", 0);
		return result;
	}
	
	/**
	 * 자식 data 들을 재귀적으로 파싱
	 * @param dataInfoList
	 * @param depth
	 * @param childrenNode
	 * @return
	 */
	private List<DataInfo> parseChildren(List<DataInfo> dataInfoList, int depth, JsonNode childrenNode) {
		if(dataInfoList == null) dataInfoList = new ArrayList<>();
		
		depth++;
		int viewOrder = 1;
		for(JsonNode jsonNode : childrenNode) {
			String dataName = jsonNode.path("data_name").asText();
			String dataKey = jsonNode.path("data_key").asText();
			String longitude = jsonNode.path("longitude").asText().trim();
			String latitude = jsonNode.path("latitude").asText().trim();
			String altitude = jsonNode.path("height").asText().trim();
			String heading = jsonNode.path("heading").asText().trim();
			String pitch = jsonNode.path("pitch").asText().trim();
			String roll = jsonNode.path("roll").asText().trim();
			String mappingType = jsonNode.path("mapping_type").asText();
			JsonNode metainfo = jsonNode.path("attributes");
			JsonNode childrene = jsonNode.path("children");
			
			DataInfo dataInfo = new DataInfo();
			dataInfo.setDataName(dataName);
			dataInfo.setDataKey(dataKey);
			if(longitude != null && !"".equals(longitude)) dataInfo.setLongitude(new BigDecimal(longitude));
			if(latitude != null && !"".equals(latitude)) dataInfo.setLatitude(new BigDecimal(latitude));
			if(altitude != null && !"".equals(altitude)) dataInfo.setAltitude(new BigDecimal(altitude));
			if(dataInfo.getLongitude() != null && dataInfo.getLatitude() != null) {
				dataInfo.setLocation("POINT(" + dataInfo.getLongitude() + " " + dataInfo.getLatitude() + ")");
			}
			if(heading != null && !"".equals(heading)) dataInfo.setHeading(new BigDecimal(heading));
			if(pitch != null && !"".equals(pitch)) dataInfo.setPitch(new BigDecimal(pitch));
			if(roll != null && !"".equals(roll)) dataInfo.setRoll(new BigDecimal(roll));
			
			dataInfo.setMappingType(mappingType);
			dataInfo.setMetainfo(metainfo.toString());
			dataInfo.setChildrenDepth(depth);
			dataInfo.setChildrenViewOrder(viewOrder);
			// TODO ancestor 같은것도 넣어 줘야 하는데..... 귀찮아서
			
			dataInfoList.add(dataInfo);
			
			if(childrene.isArray() && childrene.size() != 0) {
				parseChildren(dataInfoList, depth, childrene);
			}
			
			viewOrder++;
		}
		
		return dataInfoList;
	}
}
