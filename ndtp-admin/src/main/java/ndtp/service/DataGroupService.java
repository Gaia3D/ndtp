package ndtp.service;

import java.util.List;

import ndtp.domain.DataGroup;

public interface DataGroupService {
	
	/**
     * 데이터 그룹 목록
     * @return
     */
    List<DataGroup> getListDataGroup();
    
    /**
     * 데이터 그룹 정보 조회
     * @param dataGroup
     * @return
     */
    DataGroup getDataGroup(DataGroup dataGroup);
    
    /**
     * 기본 데이터 그룹 정보 조회
     * @return
     */
    DataGroup getBasicDataGroup();

    /**
     * 데이터 그룹 등록
     * @param dataGroup
     * @return
     */
    int insertDataGroup(DataGroup dataGroup);
    
	/**
	 * 데이터 그룹 수정
	 * @param dataGroup
	 * @return
	 */
	int updateDataGroup(DataGroup dataGroup);
	
	/**
	 * 데이터 그룹 표시 순서 수정 (up/down)
	 * @param dataGroup
	 * @return
	 */
	int updateDataGroupViewOrder(DataGroup dataGroup);
    
	/**
	 * 데이터 그룹 삭제
	 * @param dataGroup
	 * @return
	 */
	int deleteDataGroup(DataGroup dataGroup);
}
