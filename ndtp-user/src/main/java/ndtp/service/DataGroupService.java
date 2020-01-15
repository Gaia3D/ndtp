package ndtp.service;

import java.util.List;

import ndtp.domain.DataGroup;

public interface DataGroupService {
	
	/**
	 * Data Group 총건수
	 * @param dataGroup
	 * @return
	 */
	Long getDataGroupTotalCount(DataGroup dataGroup);
	
	/**
     * 데이터 그룹 전체 목록
     * @return
     */
    List<DataGroup> getAllListDataGroup();
    
    /**
     * 데이터 그룹 목록
     * @return
     */
    List<DataGroup> getListDataGroup(DataGroup dataGroup);
    
    /**
     * 데이터 정보 조회
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
	 * 데이터 그룹 표시 순서 수정. UP, DOWN
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
