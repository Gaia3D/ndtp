package ndtp.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import ndtp.domain.DataGroup;
import ndtp.domain.LayerGroup;

@Repository
public interface LayerGroupMapper {
	/**
     * 레이어 그룹 목록 조회
     * @return
     */
    List<LayerGroup> getListLayerGroup();
    
    /**
     * 데이터 정보 조회
     * @param layerGroup
     * @return
     */
    LayerGroup getLayerGroup(LayerGroup layerGroup);
    
    /**
     * 부모와 표시 순서로 메뉴 조회
     * @param layerGroup
     * @return
     */
    LayerGroup getLayerGroupByParentAndViewOrder(LayerGroup layerGroup);

    
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
//    /**
//     * 부모 레이어 그룹 정보 한 건을 조회한다.
//     * @param parnets
//     * @return
//     */
//    LayerGroup readParent(int parnet);
//    
//    /**
//	 * 레이어 그룹의 하위 자식을 조회한다.
//	 * @param layerGroupId
//	 * @return
//	 */
//    List<LayerGroup> readChild(int layerGroupId);
    
    /**
     * 레이어 그룹 등록
     * @param layerGroup
     * @return
     */
    int insertLayerGroup(LayerGroup layerGroup);
    
//    /**
//	 * 레이어 그룹의 하위 레이어 그룹 갯수를 수정한다.
//	 * @param layerGroup
//	 * @return
//	 */
//	int updateChildCount(LayerGroup layerGroup);
//	
//	/**
//	 * 레이어 그룹을 수정한다.
//	 * @param layerGroup
//	 * @return
//	 */
//	int update(LayerGroup layerGroup);
//	
    /**
	 * 데이터 그룹 표시 순서 수정. UP, DOWN
	 * @param dataGroup
	 * @return
	 */
	int updateLayerGroupViewOrder(LayerGroup layerGroup);
//    
//    /**
//     * 레이어 그룹을 삭제한다.
//     * @param layerGroupId
//     * @return
//     */
//    int delete(int layerGroupId);
//    
//    /**
//     * 레이어 그룹 및 하위 그룹을 삭제한다.
//     * @param layerGroupId
//     * @return
//     */
//    int deleteChild(int layerGroupId);
}
