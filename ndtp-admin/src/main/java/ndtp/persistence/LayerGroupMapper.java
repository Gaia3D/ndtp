package ndtp.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import ndtp.domain.LayerGroup;

@Repository
public interface LayerGroupMapper {
	/**
     * 레이어 그룹 목록 조회한다.
     * @return
     */
    List<LayerGroup> getListLayerGroup();
    
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
    int insert(LayerGroup layerGroup);
    
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
//	/**
//	 * 레이어 그룹의 나열 순서를 위로 변경한다.
//	 * @param layerGroup
//	 * @return
//	 */
//	int moveToUpper(LayerGroup layerGroup);
//	
//	/**
//	 * 레이어 그룹의 나열 순서를 위로 변경할 때, 나머지 레이어 그룹의 나열 순서를 재정렬 한다.
//	 * @param layerGroup
//	 * @return
//	 */
//	int updateUpper(LayerGroup layerGroup);
//	
//	/**
//	 * 레이어 그룹의 나열 순서를 아래로 변경한다.
//	 * @param layerGroup
//	 * @return
//	 */
//	int moveToLower(LayerGroup layerGroup);
//	
//	/**
//	 * 레이어 그룹의 나열 순서를 아래로 변경할 때, 나머지 레이어 그룹의 나열 순서를 재정렬 한다.
//	 * @param layerGroup
//	 * @return
//	 */
//	int updateLower(LayerGroup layerGroup);
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
