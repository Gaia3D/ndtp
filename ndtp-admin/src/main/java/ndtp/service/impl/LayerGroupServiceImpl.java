package ndtp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.slf4j.Slf4j;
import ndtp.domain.Layer;
import ndtp.domain.LayerGroup;
import ndtp.domain.Move;
import ndtp.persistence.LayerGroupMapper;
import ndtp.service.LayerGroupService;
import ndtp.service.LayerService;

@Slf4j
@Service
public class LayerGroupServiceImpl implements LayerGroupService {
	
	@Autowired
	private LayerService layerService;
	
	@Autowired
	private LayerGroupMapper layerGroupMapper;
	
//	@Autowired
//	private LayerMapper layerMapper;

	/** 
	 * 레이어 그룹 목록 조회한다.
	 */
	@Transactional(readOnly = true)
	public List<LayerGroup> getListLayerGroup() {
		return layerGroupMapper.getListLayerGroup();
	}
	
	/**
	 * 레이어 그룹 목록 및 하위 레이어를 조회
     * @return
     */
	@Transactional(readOnly = true)
	public List<LayerGroup> getListLayerGroupAndLayer() {
		List<LayerGroup> layerGroupList = layerGroupMapper.getListLayerGroup();
		for(LayerGroup layerGroup : layerGroupList) {
			Layer layer = new Layer();
			layer.setLayerGroupId(layerGroup.getLayerGroupId());
			layerGroup.setLayerList(layerService.getListLayer(layer));
		}
		
		return layerGroupList;
	}
	
//	/** 
//	 * Depth에 따라 레이어 그룹 목록 조회한다.
//	 */
//	@Transactional(readOnly = true)
//	public List<LayerGroupDto> getListByDepth(int depth) {
//		List<LayerGroupDto> layerGroupDtoList = new ArrayList<>();
//		List<LayerGroup> layerGroupList = layerGroupMapper.getListByDepth(depth);
//		for(LayerGroup layerGroup : layerGroupList) {
//			LayerGroupDto layerGroupDto = new LayerGroupDto();
//			layerGroupDto = layerGroupDto.fromEntity(layerGroup);
//			layerGroupDtoList.add(layerGroupDto);
//		}
//		
//		return layerGroupDtoList;
//	}
//
//	/** 
//	 * 레이어 그룹 정보(1건)를 조회한다.
//	 */
//	@Transactional(readOnly = true)
//	public LayerGroupDto read(int layerGroupId) {
//		LayerGroupDto layerGroupDto = new  LayerGroupDto();
//		LayerGroup layerGroup  = layerGroupMapper.read(layerGroupId);
//		
//		return layerGroupDto.fromEntity(layerGroup);
//	}
//	
//	/** 
//	 * 부모 레이어 그룹 정보(1건)를 조회한다.
//	 */
//	@Transactional(readOnly = true)
//	public LayerGroupDto readParent(int parnet) {
//		LayerGroupDto layerGroupDto = new  LayerGroupDto();
//		LayerGroup layerGroup  = layerGroupMapper.readParent(parnet);
//		if(layerGroup == null) {
//			return null;
//		}
//		return layerGroupDto.fromEntity(layerGroup);
//	}

	/** 
	 * 레이어 그룹 등록
	 */
	@Transactional
	public int insertLayerGroup(LayerGroup layerGroup) {
		// TODO 자식 존재 유무 부분은 나중에 추가 하자.
		return layerGroupMapper.insertLayerGroup(layerGroup);
	}
	
//	/**
//	 * 레이어 그룹의 하위 레이어 그룹 갯수를 수정한다.
//	 */
//	@Transactional
//	public int updateChildCount(LayerGroupDto layerGroupDto) {
//		LayerGroup layerGroup = new LayerGroup();
//		layerGroup = layerGroupDto.toEntityLayer(layerGroupDto);
//		return layerGroupMapper.updateChildCount(layerGroup);
//	}
//
//	/** 
//	 * 레이어 그룹을 수정한다.
//	 */
//	@Transactional
//	public int update(LayerGroupDto layerGroupDto) {
//		LayerGroup layerGroup = new LayerGroup();
//		layerGroup = layerGroupDto.toEntityLayer(layerGroupDto);
//		// 레이어 그룹 수정
//		int result = layerGroupMapper.update(layerGroup);
//		// 레이어에 있는 그룹명 수정
//		result += layerMapper.updateGroupName(layerGroup);
//		return result;
//	}
//	
//
//	/** 
//	 * 레이어 그룹을 삭제한다.
//	 */
//	@Transactional
//	public int delete(int layerGroupId) {
//		int result = 0;
//		// 삭제할 레이어 조회
//		LayerGroupDto layerGroupDto = new LayerGroupDto();
//		LayerGroup layerGroup = layerGroupMapper.read(layerGroupId);
//		int childCount = layerGroupDto.fromEntity(layerGroup).getChild();
//		if(childCount == 0) {
//			// 해당 그룹의 레이어 삭제
//			layerMapper.deleteAll(layerGroupId);
//			// 해당 그룹만 삭제
//			result += layerGroupMapper.delete(layerGroupId);
//			
//		} else {
//			// 해당 그룹의 레이어 삭제
//			layerMapper.deleteAll(layerGroupId);
//			// 해당 그룹의 자식 레이어 삭제
//			List<LayerGroup> childGroupList = layerGroupMapper.readChild(layerGroupId);
//			for(LayerGroup childGroup : childGroupList) {
//				LayerGroupDto dto = new LayerGroupDto();
//				dto = dto.fromEntity(childGroup);
//				layerMapper.deleteAll(dto.getLayerGroupId());
//			}
//			// 자식 그룹 삭제
//			result += layerGroupMapper.deleteChild(layerGroupId);
//			result += layerGroupMapper.delete(layerGroupId);
//		}
//		// 자식 갯수 업데이트
//		result += layerGroupMapper.updateChildCount(layerGroup);
//		
//		return result;
//	}
//
//	/**
//	 * 레이어 그룹명을 조회한다.
//	 * @param layerGroupId
//	 * @return
//	 */
//	@Transactional
//	public String getGroupName(int layerGroupId) {
//		return layerGroupMapper.getGroupName(layerGroupId);
//	}
	
	/**
	 * 데이터 그룹 표시 순서 수정. UP, DOWN
	 * @param layerGroup
	 * @return
	 */
    @Transactional
	public int updateLayerGroupViewOrder(LayerGroup layerGroup) {
    	
    	LayerGroup dbLayerGroup = layerGroupMapper.getLayerGroup(layerGroup);
    	dbLayerGroup.setUpdateType(layerGroup.getUpdateType());
    	
    	Integer modifyViewOrder = layerGroup.getViewOrder();
    	LayerGroup searchLayerGroup = new LayerGroup();
    	searchLayerGroup.setUpdateType(dbLayerGroup.getUpdateType());
    	searchLayerGroup.setParent(dbLayerGroup.getParent());
    	
    	if(Move.UP == Move.valueOf(dbLayerGroup.getUpdateType())) {
    		// 바로 위 메뉴의 view_order 를 +1
    		searchLayerGroup.setViewOrder(dbLayerGroup.getViewOrder());
    		searchLayerGroup = getDataLayerByParentAndViewOrder(searchLayerGroup);
    		
    		if(searchLayerGroup == null) return 0;
    		
	    	dbLayerGroup.setViewOrder(searchLayerGroup.getViewOrder());
	    	searchLayerGroup.setViewOrder(modifyViewOrder);
    	} else {
    		// 바로 아래 메뉴의 view_order 를 -1 함
    		searchLayerGroup.setViewOrder(dbLayerGroup.getViewOrder());
    		searchLayerGroup = getDataLayerByParentAndViewOrder(searchLayerGroup);
    		
    		if(searchLayerGroup == null) return 0;
    		
    		dbLayerGroup.setViewOrder(searchLayerGroup.getViewOrder());
    		searchLayerGroup.setViewOrder(modifyViewOrder);
    	}
    	
    	updateViewOrderLayerGroup(searchLayerGroup);
		return updateViewOrderLayerGroup(dbLayerGroup);
    }
    
    /**
     * 부모와 표시 순서로 메뉴 조회
     * @param layerGroup
     * @return
     */
    private LayerGroup getDataLayerByParentAndViewOrder(LayerGroup layerGroup) {
    	return layerGroupMapper.getLayerGroupByParentAndViewOrder(layerGroup);
    }
    
    /**
	 * 
	 * @param layerGroup
	 * @return
	 */
	private int updateViewOrderLayerGroup(LayerGroup layerGroup) {
		return layerGroupMapper.updateLayerGroupViewOrder(layerGroup);
	}

}
