package ndtp.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import ndtp.domain.CivilVoice;

@Repository
public interface CivilVoiceMapper {
	
	/**
	 * 시민 참여 총 건수
	 * @param civilVoice
	 * @return
	 */
	Long getCivilVoiceTotalCount(CivilVoice civilVoice);
	
	/**
	 * 시민 참여 목록
	 * @param civilVoice
	 * @return
	 */
    List<CivilVoice> getListCivilVoice(CivilVoice civilVoice);

    /**
     * 시민 참여 상세 조회
     * @param civilVoice
     * @return
     */
    CivilVoice getCivilVoice(CivilVoice civilVoice);
    
    /**
     * 시민 참여 등록
     * @param civilVoice
     * @return
     */
    int insertCivilVoice(CivilVoice civilVoice);

    /**
     * 시민 참여 수정
     * @param civilVoice
     * @return
     */
    int updateCivilVoice(CivilVoice civilVoice);

    /**
     * 시민 참여 삭제
     * @param civilVoice
     * @return
     */
    int deleteCivilVoice(CivilVoice civilVoice);
}
