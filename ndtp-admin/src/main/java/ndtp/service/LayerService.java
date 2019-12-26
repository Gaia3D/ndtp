package ndtp.service;

import java.util.List;
import java.util.Map;

import ndtp.domain.Layer;
import ndtp.domain.LayerFileInfo;
import ndtp.domain.Policy;

public interface LayerService {

    /**
    * layer 목록
    * @return
    */
    List<Layer> getListLayer(Layer layer);

    /**
    * layer 정보 취득
    * @param layerId
    * @return
    */
    Layer getLayer(Integer layerId);

    /**
    * 자식 레이어 중 순서가 최대인 레이어를 검색
    * @param layerId
    * @return
    */
    Layer getMaxViewOrderChildLayer(Integer layerId);

    /**
    * 자식 레이어 개수
    * @param layerId
    * @return
    */
    int getChildLayerCount(Integer layerId);

    /**
    * 레이어 테이블의 컬럼 타입이 어떤 geometry 타입인지를 구함
    * @param layerKey
    * @return
    */
    String getGeometryType(String layerKey);

    /**
     * 레이어의 칼럼 목록을 조회 
     * @param layerKey
     * @return
     */
    String getLayerColumn(String layerKey);

    /**
    * 레이어 등록
    * @param layer
    * @return
    */
    int insertLayer(Layer layer);

    /**
    * 레이어 트리 정보 수정
    * @param layer
    * @return
    */
    int updateTreeLayer(Layer layer);

    /**
    * shape 파일을 이용한 layer 정보 수정
    * @param layer
    * @param isLayerFileInfoExist
    * @param layerFileInfoList
    * @return
    * @throws Exception
    */
    Map<String, Object> updateLayer(Layer layer, boolean isLayerFileInfoExist, List<LayerFileInfo> layerFileInfoList);

    /**
    * Ogr2Ogr 실행
    * @param layer
    * @param isLayerFileInfoExist
    * @param shapeFileName
    * @param shapeEncoding
    * @throws Exception
    */
    void insertOgr2Ogr(Layer layer, boolean isLayerFileInfoExist, String shapeFileName, String shapeEncoding) throws Exception;

    /**
     * shp파일 정보를 db정보를 기준으로 갱신
     * @param version
     * @return
     */
    void exportOgr2Ogr(List<LayerFileInfo> layerFileInfoList, Layer layer) throws Exception;
    
    /**
    * layer 가 등록 되어 있지 않은 경우 rest api 를 이용해서 layer를 등록
    * @throws Exception
    */
    void registerLayer(Policy policy, String layerKey) throws Exception;

    /**
    * 레이어 롤백 처리
    * @param layer
    * @param isLayerFileInfoExist
    * @param layerFileInfo
    * @param deleteLayerFileInfoGroupId
    */
    void rollbackLayer(Layer layer, boolean isLayerFileInfoExist, LayerFileInfo layerFileInfo, Integer deleteLayerFileInfoGroupId);

    /**
    * layer 를 이 shape 파일로 활성화
    * @param layerId
    * @param layerFileInfoGroupId
    * @param layerFileInfoId
    * @return
    */
    int updateLayerByLayerFileInfoId(Integer layerId, Integer layerFileInfoGroupId, Integer layerFileInfoId);

    /**
    * 레이어 트리 순서 수정, up, down
    * @param layer
    * @return
    */
    int updateMoveTreeLayer(Layer layer);

    /**
    * 레이어 삭제
    * @param layerId
    * @return
    */
    int deleteLayer(Integer layerId);
}
