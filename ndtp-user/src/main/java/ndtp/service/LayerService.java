package ndtp.service;

import java.util.List;

import ndtp.domain.Layer;

public interface LayerService {

    /**
    * layer 목록
    * @return
    */
    List<Layer> getListLayer(Layer layer);
}
