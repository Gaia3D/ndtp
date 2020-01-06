package ndtp.service.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;

import lombok.extern.slf4j.Slf4j;
import ndtp.config.PropertiesConfig;
import ndtp.domain.Layer;
import ndtp.domain.LayerFileInfo;
import ndtp.domain.Policy;
import ndtp.geospatial.Ogr2OgrExecute;
import ndtp.persistence.LayerFileInfoMapper;
import ndtp.persistence.LayerMapper;
import ndtp.security.Crypt;
import ndtp.service.LayerService;
import ndtp.service.PolicyService;

/**
 * 여기서는 Geoserver Rest API 결과를 가지고 파싱 하기 때문에 RestTemplate을 커스트마이징하면 안됨
 * @author Cheon JeongDae
 *
 */
@Slf4j
@Service
public class LayerServiceImpl implements LayerService {

	@Value("${spring.datasource.url}")
	private String url;
	@Value("${spring.datasource.username}")
	private String username;
	@Value("${spring.datasource.password}")
	private String password;

    @Autowired
    private PolicyService policyService;

    @Autowired
    private PropertiesConfig propertiesConfig;

    @Autowired
    private LayerMapper layerMapper;
    @Autowired
    private LayerFileInfoMapper layerFileInfoMapper;

    /**
	 * Layer 총 건수
	 * @param accessLog
	 * @return
	 */
    @Transactional(readOnly=true)
	public Long getLayerTotalCount(Layer layer) {
    	return layerMapper.getLayerTotalCount(layer);
    }
    
    /**
    * layer 목록
    * @return
    */
    @Transactional(readOnly=true)
    public List<Layer> getListLayer(Layer layer) {
        return layerMapper.getListLayer(layer);
    }

    /**
    * layer 정보 취득
    * @param layerId
    * @return
    */
    @Transactional(readOnly=true)
    public Layer getLayer(Integer layerId) {
        return layerMapper.getLayer(layerId);
    }

    /**
    * 자식 레이어 중 순서가 최대인 레이어를 검색
    * @param layerId
    * @return
    */
    @Transactional(readOnly=true)
    public Layer getMaxViewOrderChildLayer(Integer layerId) {
        return layerMapper.getMaxViewOrderChildLayer(layerId);
    }

    /**
    * 자식 레이어 개수
    * @param layerId
    * @return
    */
    @Transactional(readOnly=true)
    public int getChildLayerCount(Integer layerId) {
        return layerMapper.getChildLayerCount(layerId);
    }

    /**
    * 부모와 표시 순서로 레이어 조회
    * @param layer
    * @return
    */
    private Layer getLayerByParentAndViewOrder(Layer layer) {
        return layerMapper.getLayerByParentAndViewOrder(layer);
    }

    /**
    * 레이어 테이블의 컬럼 타입이 어떤 geometry 타입인지를 구함
    * @param layerKey
    * @return
    */
    @Transactional(readOnly=true)
    public String getGeometryType(String layerKey) {
        return layerMapper.getGeometryType(layerKey);
    }

    @Transactional(readOnly = true)
    public String getLayerColumn(String layerKey) {
    	return layerMapper.getLayerColumn(layerKey);
    }

    /**
    * 레이어 등록
    * @param layer
    * @return
    */
    @Transactional
    public int insertLayer(Layer layer) {
        return layerMapper.insertLayer(layer);
    }

    /**
    * 레이어 트리 정보 수정
    * @param layer
    * @return
    */
    @Transactional
    public int updateTreeLayer(Layer layer) {
        return layerMapper.updateTreeLayer(layer);
    }

    /**
    * shape 파일을 이용한 layer 정보 수정
    * @param layer
    * @param isLayerFileInfoExist
    * @param layerFileInfoList
    * @return
    * @throws Exception
    */
    @Transactional
    public Map<String, Object> updateLayer(Layer layer, boolean isLayerFileInfoExist, List<LayerFileInfo> layerFileInfoList) {

        Map<String, Object> layerFileInfoGroupMap = new HashMap<>();

        // layer 정보 수정
        layerMapper.updateLayer(layer);

        // shape 파일이 있을 경우
        if(!layerFileInfoList.isEmpty()) {
            String shapeFileName = null;
            String shapeEncoding = null;
            Integer layerId = layer.getLayerId();
            String userId = layer.getUserId();
            String tableName = layer.getLayerKey();

            if(isLayerFileInfoExist) {
                // 모든 layer_file_info 의 shape 상태를 비활성화로 update 함
                layerFileInfoMapper.updateLayerFileInfoAllDisabledByLayerId(layerId);
                // 이 레이어의 지난 데이터를 비 활성화 상태로 update 함
                layerFileInfoMapper.updateShapePreDataDisable(tableName);
            }

            Integer layerFileInfoGroupId = 0;
            List<Integer> layerFileInfoGroupIdList = new ArrayList<>();
            for(LayerFileInfo layerFileInfo : layerFileInfoList) {
                layerFileInfo.setLayerId(layerId);
                layerFileInfo.setUserId(userId);
                layerFileInfo.setEnableYn("Y");

                layerFileInfoMapper.insertLayerFileInfoMapper(layerFileInfo);
                layerFileInfoGroupIdList.add(layerFileInfo.getLayerFileInfoId());

                if(LayerFileInfo.SHAPE_EXTENSION.equals(layerFileInfo.getFileExt().toLowerCase())) {
                    layerFileInfoGroupId = layerFileInfo.getLayerFileInfoId();
                    shapeFileName = layerFileInfo.getFilePath() + layerFileInfo.getFileRealName();
                    shapeEncoding = layerFileInfo.getShapeEncoding();
                }
            }
            log.info("---- shapeFileName = {}", shapeFileName);

            Integer fileVersion = layerFileInfoMapper.getMaxFileVersion(layerId);
            if(fileVersion == null) fileVersion = 0;
            fileVersion = fileVersion + 1;
            layerFileInfoGroupMap.put("fileVersion", fileVersion);
            layerFileInfoGroupMap.put("shapeFileName", shapeFileName);
            layerFileInfoGroupMap.put("shapeEncoding", shapeEncoding);
            layerFileInfoGroupMap.put("layerFileInfoGroupId", layerFileInfoGroupId);
            layerFileInfoGroupMap.put("layerFileInfoGroupIdList", layerFileInfoGroupIdList);
            log.info("+++ layerFileInfoGroupMap = {}", layerFileInfoGroupMap);
            layerFileInfoMapper.updateLayerFileInfoGroup(layerFileInfoGroupMap);
        }

        return layerFileInfoGroupMap;
    }

    /**
    * Ogr2Ogr 실행
    * @param layer
    * @param isLayerFileInfoExist
    * @param shapeFileName
    * @param shapeEncoding
    * @throws Exception
    */
    @Transactional
    public void insertOgr2Ogr(Layer layer, boolean isLayerFileInfoExist, String shapeFileName, String shapeEncoding) throws Exception {
        String osType = propertiesConfig.getOsType().toUpperCase();
        String dbName = Crypt.decrypt(url);
        dbName = dbName.substring(dbName.lastIndexOf("/") + 1);
        String driver = "PG:host=localhost dbname=" + dbName + " user=" + Crypt.decrypt(username) + " password=" + Crypt.decrypt(password);
        //Layer dbLayer = layerMapper.getLayer(layer.getLayerId());

        String updateOption = null;
        if(isLayerFileInfoExist) {
            // update 실행
            updateOption = "update";
        } else {
            // insert 실행
            updateOption = "insert";
        }

        Policy policy = policyService.getPolicy();
        String layerSourceCoordinate = policy.getLayerSourceCoordinate();
        String layerTargetCoordinate = policy.getLayerTargetCoordinate();
//		ShapeFileParser shapeFileParser = new ShapeFileParser();
//		shapeFileParser.parse(shapeFileName);

        Ogr2OgrExecute ogr2OgrExecute = new Ogr2OgrExecute(osType, driver, shapeFileName, shapeEncoding, layer.getLayerKey(), updateOption, layerSourceCoordinate, layerTargetCoordinate);
        ogr2OgrExecute.insert();
    }

    /**
    * layer 를 이 shape 파일로 활성화
    * @param layerId
    * @param layerFileInfoGroupId
    * @return
    */
    @Transactional
    public int updateLayerByLayerFileInfoId(Integer layerId, Integer layerFileInfoGroupId, Integer layerFileInfoId) {
        int result = 0;
        // layer 정보 수정
        Layer layer = layerMapper.getLayer(layerId);
        String tableName = layer.getLayerKey();

        // 모든 layer_file_info 의 shape 상태를 비활성화로 update 함
        layerFileInfoMapper.updateLayerFileInfoAllDisabledByLayerId(layerId);
        // shape table 모든 데이터를 비활성화 함
        layerFileInfoMapper.updateShapePreDataDisable(tableName);

        LayerFileInfo layerFileInfo = new LayerFileInfo();
        layerFileInfo.setLayerId(layerId);
        layerFileInfo.setLayerFileInfoGroupId(layerFileInfoGroupId);
        layerFileInfo.setEnableYn("Y");
        layerFileInfoMapper.updateLayerFileInfoByGroupId(layerFileInfo);

        Integer fileVersion = layerFileInfoMapper.getLayerShapeFileVersion(layerFileInfoId);
        Map<String, String> orgMap = new HashMap<>();
        orgMap.put("fileVersion", fileVersion.toString());
        orgMap.put("tableName", tableName);
        orgMap.put("enableYn", "Y");
        result = layerFileInfoMapper.updateOgr2OgrStatus(orgMap);

        return result;
    }

    /**
    * layer 가 등록 되어 있지 않은 경우 rest api 를 이용해서 layer를 등록
    * @throws Exception
    */
    @Transactional
    public void registerLayer(Policy policy, String layerKey) throws Exception {
        HttpStatus httpStatus = getLayerStatus(policy, layerKey);
        if(HttpStatus.INTERNAL_SERVER_ERROR == httpStatus) {
            throw new Exception();
        }

        if(HttpStatus.OK == httpStatus) {
            log.info("layerKey = {} 는 이미 존재하는 layer 입니다.", layerKey);
            // 이미 등록 되어 있음
        } else if(HttpStatus.NOT_FOUND == httpStatus) {
            // 신규 등록
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.TEXT_XML);
            // geoserver basic 암호화 아이디:비밀번호 를 base64로 encoding
            headers.add("Authorization", "Basic " + Base64.getEncoder().encodeToString( (policy.getGeoserverUser() + ":" + policy.getGeoserverPassword()).getBytes()));

            // body
            String xmlString = "<?xml version=\"1.0\" encoding=\"utf-8\"?><featureType><name>" + layerKey + "</name></featureType>";

            List<HttpMessageConverter<?>> messageConverters = new ArrayList<HttpMessageConverter<?>>();
            //Add the String Message converter
            messageConverters.add(new StringHttpMessageConverter());
            //Add the message converters to the restTemplate

            RestTemplate restTemplate = new RestTemplate();
            restTemplate.setMessageConverters(messageConverters);

            HttpEntity<String> entity = new HttpEntity<>(xmlString, headers);
            String url = policy.getGeoserverDataUrl() + "/rest/workspaces/"
                    + policy.getGeoserverDataWorkspace() + "/datastores/" + policy.getGeoserverDataStore() + "/featuretypes?recalculate=nativebbox,latlonbbox";

            ResponseEntity<?> response = restTemplate.postForEntity(url, entity, String.class);

            //ResponseEntity<APIResult> responseEntity = restTemplate.exchange(url, HttpMethod.POST, request, APIResult.class);
            log.info("----------------------- response = {}", response);
//			log.info("----------------------- body = {}", response.getBody());

            // shape 파일이 없는 layer를 등록 하려고 하면 400 Bad Request가 나옴
        } else {
            throw new Exception("http status code = " + httpStatus.toString());
        }
    }

    /**
    * 레이어가 존재 하는지를 검사
    * @param policy
    * @param layerKey
    * @return
    * @throws Exception
    */
    private HttpStatus getLayerStatus(Policy policy, String layerKey) {
        HttpStatus httpStatus = null;
        try {
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.TEXT_XML);
            // geoserver basic 암호화 아이디:비밀번호 를 base64로 encoding
            headers.add("Authorization", "Basic " + Base64.getEncoder().encodeToString( (policy.getGeoserverUser() + ":" + policy.getGeoserverPassword()).getBytes()) );

            List<HttpMessageConverter<?>> messageConverters = new ArrayList<HttpMessageConverter<?>>();
            //Add the String Message converter
            messageConverters.add(new StringHttpMessageConverter());
            //Add the message converters to the restTemplate
            RestTemplate restTemplate = new RestTemplate();
            restTemplate.setMessageConverters(messageConverters);

            HttpEntity<String> entity = new HttpEntity<>(headers);
            String url = policy.getGeoserverDataUrl() + "/rest/workspaces/"
                        + policy.getGeoserverDataWorkspace() + "/datastores/" + policy.getGeoserverDataStore() + "/featuretypes/" + layerKey;
            log.info("-------- url = {}", url);
            ResponseEntity<?> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
            httpStatus = response.getStatusCode();
            log.info("-------- layerKey = {}, statusCode = {}, body = {}", layerKey, response.getStatusCodeValue(), response.getBody());
        } catch(Exception e) {
            log.info("-------- exception message = {}", e.getMessage());
            String message = e.getMessage();
            if(message.indexOf("404") >= 0) {
                httpStatus = HttpStatus.NOT_FOUND;
            } else {
                httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
            }
        }

        return httpStatus;
    }

    /**
    * 레이어 롤백 처리
    * @param layer
    * @param isLayerFileInfoExist
    * @param layerFileInfo
    * @param deleteLayerFileInfoGroupId
    */
    @Transactional
    public void rollbackLayer(Layer layer, boolean isLayerFileInfoExist, LayerFileInfo layerFileInfo, Integer deleteLayerFileInfoGroupId) {
        layerMapper.updateLayer(layer);
        if(isLayerFileInfoExist) {
            layerFileInfoMapper.deleteLayerFileInfoByGroupId(deleteLayerFileInfoGroupId);

            // 모든 layer_file_info 의 shape 상태를 비활성화로 update 함
            layerFileInfoMapper.updateLayerFileInfoAllDisabledByLayerId(layer.getLayerId());
            // 이 레이어의 지난 데이터를 비 활성화 상태로 update 함
            layerFileInfoMapper.updateShapePreDataDisable(layer.getLayerKey());

            // 이전 레이어 이력을 활성화
            layerFileInfoMapper.updateLayerFileInfoByGroupId(layerFileInfo);
            // 이전 shape 데이터를 활성화
            Map<String, String> orgMap = new HashMap<>();
            orgMap.put("fileVersion", layerFileInfo.getFileVersion().toString());
            orgMap.put("tableName", layer.getLayerKey());
            orgMap.put("enableYn", "Y");
            layerFileInfoMapper.updateOgr2OgrStatus(orgMap);
        } else {
            layerFileInfoMapper.deleteLayerFileInfo(layer.getLayerId());
            // TODO shape 파일에도 이력이 있음 지워 줘야 하나?
        }
    }

    /**
    * geoserver에 존재하는 레이어를 삭제
    * @param policy
    * @param layerKey
    * @return
    * @throws Exception
    */
    private HttpStatus deleteGeoserverLayer(Policy policy, String layerKey) {
        HttpStatus httpStatus = null;
        try {
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.TEXT_XML);
            // geoserver basic 암호화 아이디:비밀번호 를 base64로 encoding
            headers.add("Authorization", "Basic " + Base64.getEncoder().encodeToString( (policy.getGeoserverUser() + ":" + policy.getGeoserverPassword()).getBytes()) );

            List<HttpMessageConverter<?>> messageConverters = new ArrayList<HttpMessageConverter<?>>();
            //Add the String Message converter
            messageConverters.add(new StringHttpMessageConverter());
            //Add the message converters to the restTemplate
            RestTemplate restTemplate = new RestTemplate();
            restTemplate.setMessageConverters(messageConverters);

            HttpEntity<String> entity = new HttpEntity<>(headers);

            String url = policy.getGeoserverDataUrl() + "/rest/workspaces/"
                        + policy.getGeoserverDataWorkspace() + "/datastores/" + policy.getGeoserverDataStore() + "/featuretypes/" + layerKey + "?recurse=true";
            log.info("-------- url = {}", url);
            ResponseEntity<?> response = restTemplate.exchange(url, HttpMethod.DELETE, entity, String.class);
            httpStatus = response.getStatusCode();
            log.info("-------- geoserver layer delete. layerKey = {}, statusCode = {}, body = {}", layerKey, response.getStatusCodeValue(), response.getBody());
        } catch(Exception e) {
            log.info("-------- exception message = {}", e.getMessage());
            httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
        }

        return httpStatus;
    }

    /**
    * 레이어 트리 순서 수정, up, down
    * @param layer
    * @return
    */
    @Transactional
    public int updateMoveTreeLayer(Layer layer) {
        Integer modifyViewOrder = layer.getViewOrder();
        Layer searchLayer = new Layer();
        searchLayer.setUpdateType(layer.getUpdateType());
        searchLayer.setParent(layer.getParent());

        if ("up".equals(layer.getUpdateType())) {
            // 바로 위 메뉴의 view_order 를 +1
            searchLayer.setViewOrder(layer.getViewOrder());
            searchLayer = getLayerByParentAndViewOrder(searchLayer);
            layer.setViewOrder(searchLayer.getViewOrder());
            searchLayer.setViewOrder(modifyViewOrder);
        } else {
            // 바로 아래 메뉴의 view_order 를 -1 함
            searchLayer.setViewOrder(layer.getViewOrder());
            searchLayer = getLayerByParentAndViewOrder(searchLayer);
            layer.setViewOrder(searchLayer.getViewOrder());
            searchLayer.setViewOrder(modifyViewOrder);
        }
        updateViewOrderLayer(searchLayer);

        return updateViewOrderLayer(layer);
    }

    /**
    *
    * @param userGroup
    * @return
    */
    private int updateViewOrderLayer(Layer layer) {
        return layerMapper.updateViewOrderLayer(layer);
    }

    /**
    * 레이어 삭제
    * @param layerId
    * @return
    */
    @Transactional
    public int deleteLayer(Integer layerId) {
        // geoserver layer 삭제
        Policy policy = policyService.getPolicy();
        Layer layer = layerMapper.getLayer(layerId);

        deleteGeoserverLayer(policy, layer.getLayerKey());
        layerFileInfoMapper.deleteLayerFileInfo(layerId);
        return layerMapper.deleteLayer(layerId);
    }

    /**
     * shp파일 정보를 db 정보 기준으로 export
     */
    @Transactional
    public void exportOgr2Ogr(List<LayerFileInfo> layerFileInfoList, Layer layer) throws Exception {
        String tableName = layer.getLayerKey();
        String exportPath = null;
        String shpEncoding = null;
        Integer fileVersion = null;

        for(LayerFileInfo fileInfo : layerFileInfoList) {
            String filePath = fileInfo.getFilePath()+fileInfo.getFileRealName();
            File file = new File(filePath);
            if(file.exists()) {
                file.delete();
            }
            //fileInfoId와 fileInfoGroupId가 같을 경우 shp파일
            if(fileInfo.getLayerFileInfoId().equals(fileInfo.getLayerFileInfoGroupId())) {
                exportPath = filePath;
                fileVersion = fileInfo.getFileVersion();
                shpEncoding = fileInfo.getShapeEncoding();
            }
        }
        String osType = propertiesConfig.getOsType().toUpperCase();
        String dbName = Crypt.decrypt(url);
        dbName = dbName.substring(dbName.lastIndexOf("/") + 1);
        String driver = "PG:host=localhost dbname=" + dbName + " user=" + Crypt.decrypt(username) + " password=" + Crypt.decrypt(password);
        Policy policy = policyService.getPolicy();
        String layerSourceCoordinate = policy.getLayerSourceCoordinate();
        String layerTargetCoordinate = policy.getLayerTargetCoordinate();
        String layerColumn = getLayerColumn(tableName);
        String sql = "SELECT "+ layerColumn + ", null::text AS enable_yn, null::int AS version FROM "+tableName+" WHERE file_version="+fileVersion;

        Ogr2OgrExecute ogr2OgrExecute = new Ogr2OgrExecute(osType, driver, shpEncoding, exportPath, sql, layerSourceCoordinate, layerTargetCoordinate);
        ogr2OgrExecute.export();
    }
}