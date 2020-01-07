package ndtp.service;

import java.util.List;

import ndtp.domain.LayerGroup;
import ndtp.domain.LayerGroup;

public interface LayerGroupService {
	
	/**
     * 레이어 그룹 목록
     * @return
     */
    List<LayerGroup> getListLayerGroup();
    
    /**
     * 데이터 정보 조회
     * @param layerGroupId
     * @return
     */
    LayerGroup getLayerGroup(Integer layerGroupId);
    
    /**
     * 레이어 그룹 목록 및 하위 레이어를 조회
     * @return
     */
    List<LayerGroup> getListLayerGroupAndLayer();
    
    /**
	 * 데이터 그룹 표시 순서 수정. UP, DOWN
	 * @param layerGroup
	 * @return
	 */
	int updateLayerGroupViewOrder(LayerGroup layerGroup);
    
	/**
	 * 레이어 그룹 등록
	 * 
	 * @param layerGroup
	 * @return
	 */
	int insertLayerGroup(LayerGroup layerGroup);
    
	/**
	 * 데이터 그룹 수정
	 * @param layerGroup
	 * @return
	 */
	int updateLayerGroup(LayerGroup layerGroup);
	
	/**
	 * 데이터 그룹 삭제
	 * @param layerGroupId
	 * @return
	 */
	int deleteLayerGroup(Integer layerGroupId);
}
