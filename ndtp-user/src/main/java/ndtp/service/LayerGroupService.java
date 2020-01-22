package ndtp.service;

import java.util.List;

import ndtp.domain.LayerGroup;

public interface LayerGroupService {

    /**
     * 레이어 그룹 목록 및 하위 레이어 조회
     * @return
     */
    List<LayerGroup> getListLayerGroupAndLayer();

}
