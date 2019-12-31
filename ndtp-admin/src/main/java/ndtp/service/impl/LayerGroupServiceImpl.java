package ndtp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.slf4j.Slf4j;
import ndtp.domain.Layer;
import ndtp.domain.LayerGroup;
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
//	/** 
//	 * 레이어 그룹의 나열 순서를 위로 변경한다.
//	 */
//	@Transactional
//	public LayerGroupDto moveToUpper(int layerGroupId) {
//		LayerGroupDto layerGroupDto = new LayerGroupDto();
//		LayerGroup layerGroup = new LayerGroup();
//		layerGroup = layerGroupMapper.read(layerGroupId);
//		int beforeOrder = layerGroupDto.fromEntity(layerGroup).getViewOrder();
//		
//		// 해당 레이어 그룹의 나열 순서를 위(-1)로 변경
//		layerGroupMapper.moveToUpper(layerGroup);
//		layerGroup = layerGroupMapper.read(layerGroupId);
//		int afterOrder = layerGroupDto.fromEntity(layerGroup).getViewOrder();
//		
//		if(beforeOrder == afterOrder) {
//			layerGroupDto.setMessage("레이어 그룹의 처음입니다.");
//		} else {
//			layerGroupDto.setMessage(null);
//			// 기존 레이어 그룹의 나열 순서를 변경 (-1)
//			layerGroupMapper.updateUpper(layerGroup);
//		}
//		
//		return layerGroupDto;
//	}
//	
//	/** 
//	 * 레이어 그룹의 나열 순서를 아래로 변경한다.
//	 */
//	@Transactional
//	public LayerGroupDto moveToLower(int layerGroupId) {
//		LayerGroupDto layerGroupDto = new LayerGroupDto();
//		LayerGroup layerGroup = new LayerGroup();
//		layerGroup = layerGroupMapper.read(layerGroupId);
//		int beforeOrder = layerGroupDto.fromEntity(layerGroup).getViewOrder();
//		
//		// 해당 레이어 그룹의 나열 순서를 위(-1)로 변경
//		layerGroupMapper.moveToLower(layerGroup);
//		layerGroup = layerGroupMapper.read(layerGroupId);
//		int afterOrder = layerGroupDto.fromEntity(layerGroup).getViewOrder();
//		
//		if(beforeOrder == afterOrder) {
//			layerGroupDto.setMessage("레이어 그룹의 마지막입니다.");
//		} else {
//			layerGroupDto.setMessage(null);
//			// 기존 레이어 그룹의 나열 순서를 변경 (-1)
//			layerGroupMapper.updateLower(layerGroup);
//		}
//		
//		return layerGroupDto;
//	}
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

}
