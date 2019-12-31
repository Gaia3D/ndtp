package ndtp.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import ndtp.domain.DataGroup;

@Repository
public interface DataGroupMapper {

	/**
     * 데이터 그룹 목록
     * @return
     */
    List<DataGroup> getListDataGroup();

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
	 * 데이터 그룹 삭제
	 * @param dataGroupId
	 * @return
	 */
	int deleteDataGroup(int dataGroupId);
}
