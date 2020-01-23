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
     * 부모와 표시 순서로 메뉴 조회
     * @param dataGroup
     * @return
     */
    DataGroup getDataGroupByParentAndViewOrder(DataGroup dataGroup);

    /**
     * 데이터 그룹 등록
     * @param dataGroup
     * @return
     */
    int insertDataGroup(DataGroup dataGroup);

	/**
	 * 그룹Key 중복 체크
	 * @param dataGroupKey
	 * @return
	 */
	int getDuplicationKeyCount(String dataGroupKey);

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

	/**
	 * ancestor를 이용하여 데이터 그룹 삭제
	 * @param dataGroup
	 * @return
	 */
	int deleteDataGroupByAncestor(DataGroup dataGroup);

	/**
	 * parent를 이용하여 데이터 그룹 삭제
	 * @param dataGroup
	 * @return
	 */
	int deleteDataGroupByParent(DataGroup dataGroup);
}
