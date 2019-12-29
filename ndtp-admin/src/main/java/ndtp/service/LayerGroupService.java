package ndtp.service;

import java.util.List;

import ndtp.domain.LayerGroup;

public interface LayerGroupService {
	
	/**
     * 레이어 그룹 목록
     * @return
     */
    List<LayerGroup> getListLayerGroup();
    
    /**
     * 레이어 그룹 목록 및 하위 레이어를 조회
     * @return
     */
    List<LayerGroup> getListLayerGroupAndLayer();
    
//    /**
//     * Depth에 따라 레이어 그룹 목록 조회한다.
//     * @return
//     */
//    List<LayerGroup> getListByDepth(int depth);
//    
//    /**
//     * 레이어 그룹 정보 한 건을 조회한다.
//     * @param layerGroupId
//     * @return
//     */
//    LayerGroup read(int layerGroupId);
//    
//    /**
//	 * 레이어 그룹명을 조회한다.
//	 * @param layerGroupId
//	 * @return
//	 */
//	String getGroupName(int layerGroupId);
//
//     /**
//      * 부모 레이어 그룹 정보 한 건을 조회한다.
//      * @param parnet
//      * @return
//      */
//	LayerGroup readParent(int parnet);
//     
     /**
     * 레이어 그룹 등록
     * @param layerGroup
     * @return
     */
    int insert(LayerGroup layerGroup);
    
//	/**
//	 * 레이어 그룹의 하위 레이어 그룹 갯수를 수정한다.
//	 * @param layerGroupDto
//	 * @return
//	 */
//	int updateChildCount(LayerGroup layerGroupDto);
//	
//	/**
//	 * 레이어 그룹을 수정한다.
//	 * @param layerGroupDto
//	 * @return
//	 */
//	int update(LayerGroup layerGroupDto);
//	
//	/**
//	 * 레이어 그룹의 나열 순서를 위로 변경한다.
//	 * @param layerGroupId
//	 * @return
//	 */
//	LayerGroup moveToUpper(int layerGroupId);
//	
//	/**
//	 * 레이어 그룹의 나열 순서를 아래로 변경한다.
//	 * @param layerGroupId
//	 * @return
//	 */
//	LayerGroup moveToLower(int layerGroupId);
//	
//    /**
//     * 레이어 그룹을 삭제한다.
//     * @param layerGroupId
//     * @return
//     */
//    int delete(int layerGroupId);
}
