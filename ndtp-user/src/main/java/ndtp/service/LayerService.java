package ndtp.service;

import java.util.List;

import ndtp.domain.Layer;

public interface LayerService {

    /**
    * layer 목록
    * @return
    */
    List<Layer> getListLayer(Layer layer);
    
    /**
     * 기본 사용 레이어 목록 
     * @return
     */
    List<String> getListDefaultDisplayLayer();
}
