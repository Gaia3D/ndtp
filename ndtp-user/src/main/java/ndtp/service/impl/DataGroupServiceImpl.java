package ndtp.service.impl;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.slf4j.Slf4j;
import ndtp.config.PropertiesConfig;
import ndtp.domain.DataGroup;
import ndtp.domain.Depth;
import ndtp.domain.Move;
import ndtp.persistence.DataGroupMapper;
import ndtp.service.DataGroupService;
import ndtp.service.GeoPolicyService;
import ndtp.utils.FileUtils;

@Slf4j
@Service
public class DataGroupServiceImpl implements DataGroupService {
	
	@Autowired
	private DataGroupMapper dataGroupMapper;
	@Autowired
	private GeoPolicyService geoPolicyService;
	@Autowired
	private PropertiesConfig propertiesConfig;

	/**
	 * Data Group 총건수
	 * @param dataGroup
	 * @return
	 */
	public Long getDataGroupTotalCount(DataGroup dataGroup) {
		return dataGroupMapper.getDataGroupTotalCount(dataGroup);
	}
	
	/**
     * 데이터 그룹 목록
     * @return
     */
	@Transactional(readOnly = true)
	public List<DataGroup> getAllListDataGroup() {
		return dataGroupMapper.getAllListDataGroup();
	}
	
	public List<DataGroup> getListDataGroup(DataGroup dataGroup) {
		return dataGroupMapper.getListDataGroup(dataGroup);
	}
	
	/**
     * 데이터 그룹 정보 조회
     * @return
     */
	@Transactional(readOnly = true)
	public DataGroup getDataGroup(DataGroup dataGroup) {
		return dataGroupMapper.getDataGroup(dataGroup);
	}
	
	/**
     * 기본 데이터 그룹 정보 조회
     * @return
     */
	@Transactional(readOnly = true)
	public DataGroup getBasicDataGroup() {
		return dataGroupMapper.getBasicDataGroup();
	}

    /**
     * 데이터 그룹 등록
     * @param dataGroup
     * @return
     */
    @Transactional
	public int insertDataGroup(DataGroup dataGroup) {
    	
    	//GeoPolicy geoPolicy = geoPolicyService.getGeoPolicy();
    	
    	DataGroup parentDataGroup = new DataGroup();
    	Integer depth = 0;
    	if(dataGroup.getParent() > 0) {
	    	parentDataGroup.setDataGroupId(dataGroup.getParent());
	    	parentDataGroup = dataGroupMapper.getDataGroup(parentDataGroup);
	    	depth = parentDataGroup.getDepth() + 1;
    	}
	    
    	// 디렉토리 생성
    	String dataGroupPath = dataGroup.getUserId() + "/" + dataGroup.getDataGroupKey() + "/";
    	FileUtils.makeDirectoryByPath(propertiesConfig.getDataServiceDir(), dataGroupPath);
    	dataGroup.setDataGroupPath(dataGroupPath);
    	int result = dataGroupMapper.insertDataGroup(dataGroup);
    	
    	if(depth > 1) {
	    	// parent 의 children update
    		Integer children = parentDataGroup.getChildren();
    		if(children == null) children = 0;
    		children += 1;
    		parentDataGroup.setChildren(children);
	    	return dataGroupMapper.updateDataGroup(parentDataGroup);
    	}
    	
    	return result;
    }
    
	/**
	 * 데이터 그룹 수정
	 * @param dataGroup
	 * @return
	 */
    @Transactional
	public int updateDataGroup(DataGroup dataGroup) {
    	return dataGroupMapper.updateDataGroup(dataGroup);
    }
    
    /**
	 * 데이터 그룹 표시 순서 수정. UP, DOWN
	 * @param dataGroup
	 * @return
	 */
    @Transactional
	public int updateDataGroupViewOrder(DataGroup dataGroup) {
    	
    	DataGroup dbDataGroup = dataGroupMapper.getDataGroup(dataGroup);
    	dbDataGroup.setUpdateType(dataGroup.getUpdateType());
    	
    	Integer modifyViewOrder = dbDataGroup.getViewOrder();
    	DataGroup searchDataGroup = new DataGroup();
    	searchDataGroup.setUpdateType(dbDataGroup.getUpdateType());
    	searchDataGroup.setParent(dbDataGroup.getParent());
    	
    	if(Move.UP == Move.valueOf(dbDataGroup.getUpdateType())) {
    		// 바로 위 메뉴의 view_order 를 +1
    		searchDataGroup.setViewOrder(dbDataGroup.getViewOrder());
    		searchDataGroup = getDataGroupByParentAndViewOrder(searchDataGroup);
    		
    		if(searchDataGroup == null) return 0;
    		
	    	dbDataGroup.setViewOrder(searchDataGroup.getViewOrder());
	    	searchDataGroup.setViewOrder(modifyViewOrder);
    	} else {
    		// 바로 아래 메뉴의 view_order 를 -1 함
    		searchDataGroup.setViewOrder(dbDataGroup.getViewOrder());
    		searchDataGroup = getDataGroupByParentAndViewOrder(searchDataGroup);
    		
    		if(searchDataGroup == null) return 0;
    		
    		dbDataGroup.setViewOrder(searchDataGroup.getViewOrder());
    		searchDataGroup.setViewOrder(modifyViewOrder);
    	}
    	
    	updateViewOrderDataGroup(searchDataGroup);
		return updateViewOrderDataGroup(dbDataGroup);
    }
    
    /**
     * 부모와 표시 순서로 메뉴 조회
     * @param dataGroup
     * @return
     */
    private DataGroup getDataGroupByParentAndViewOrder(DataGroup dataGroup) {
    	return dataGroupMapper.getDataGroupByParentAndViewOrder(dataGroup);
    }
    
    /**
	 * 
	 * @param userGroup
	 * @return
	 */
	private int updateViewOrderDataGroup(DataGroup dataGroup) {
		return dataGroupMapper.updateDataGroupViewOrder(dataGroup);
	}
    
	/**
	 * 데이터 그룹 삭제
	 * @param dataGroup
	 * @return
	 */
    @Transactional
	public int deleteDataGroup(DataGroup dataGroup) {
    	// 삭제하고, children update
    	
    	dataGroup = dataGroupMapper.getDataGroup(dataGroup);
    	log.info("--- 111111111 delete dataGroup = {}", dataGroup);
    	
    	int result = 0;
    	if(Depth.ONE == Depth.findBy(dataGroup.getDepth())) {
    		log.info("--- one ================");
    		result = dataGroupMapper.deleteDataGroupByAncestor(dataGroup);
    	} else if(Depth.TWO == Depth.findBy(dataGroup.getDepth())) {
    		log.info("--- two ================");
    		result = dataGroupMapper.deleteDataGroupByParent(dataGroup);
    		
    		DataGroup ancestorDataGroup = new DataGroup();
    		ancestorDataGroup.setDataGroupId(dataGroup.getAncestor());
    		ancestorDataGroup = dataGroupMapper.getDataGroup(ancestorDataGroup);
    		ancestorDataGroup.setChildren(ancestorDataGroup.getChildren() + 1);
	    	
    		log.info("--- delete ancestorDataGroup = {}", ancestorDataGroup);
    		
	    	dataGroupMapper.updateDataGroup(ancestorDataGroup);
    		// ancestor - 1
    	} else if(Depth.THREE == Depth.findBy(dataGroup.getDepth())) {
    		log.info("--- three ================");
    		result = dataGroupMapper.deleteDataGroup(dataGroup);
    		log.info("--- dataGroup ================ {}", dataGroup);
    		
    		DataGroup parentDataGroup = new DataGroup();
	    	parentDataGroup.setDataGroupId(dataGroup.getParent());
	    	parentDataGroup = dataGroupMapper.getDataGroup(parentDataGroup);
	    	log.info("--- parentDataGroup ================ {}", parentDataGroup);
	    	parentDataGroup.setChildren(parentDataGroup.getChildren() - 1);
	    	log.info("--- parentDataGroup children ================ {}", parentDataGroup);
	    	dataGroupMapper.updateDataGroup(parentDataGroup);
    	} else {
    		
    	}
    	
    	return result;
    }
}
