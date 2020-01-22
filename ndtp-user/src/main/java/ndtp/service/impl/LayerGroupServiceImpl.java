package ndtp.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ndtp.domain.Layer;
import ndtp.domain.LayerGroup;
import ndtp.persistence.LayerGroupMapper;
import ndtp.service.LayerGroupService;
import ndtp.service.LayerService;

@Service
public class LayerGroupServiceImpl implements LayerGroupService {

	private final LayerService layerService;

	private final LayerGroupMapper layerGroupMapper;
	
	public LayerGroupServiceImpl(LayerService layerService, LayerGroupMapper layerGroupMapper) {
		this.layerService = layerService;
		this.layerGroupMapper = layerGroupMapper;
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
}
