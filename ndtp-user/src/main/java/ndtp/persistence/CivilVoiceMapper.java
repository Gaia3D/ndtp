package ndtp.persistence;

import java.util.List;

import ndtp.domain.CivilVoice;

public interface CivilVoiceMapper {
	/**
	 * 시민 참여 목록 조회
	 * @param civilvoice
	 * @return
	 */
	List<CivilVoice> getListCivilVoice(CivilVoice civilvoice);
	
	/**
	 * 시민 참여 전체 건수 조회
	 * @param civilvoice
	 * @return
	 */
	Long getCivilVoiceTotalCount(CivilVoice civilvoice);
	
	/**
	 * 시민 참여 한건에 대한 정보 조회
	 * @return
	 */
	CivilVoice getCivilVocieById();
	
	/**
	 * 등록
	 * @param civilvoice
	 * @return
	 */
	int insertCivilVoice(CivilVoice civilvoice);
	
	/**
	 * 수정
	 * @param civilvoice
	 * @return
	 */
	int updateCivilVoice(CivilVoice civilvoice);
	
	/**
	 * 삭제 
	 * @param civilvoice
	 * @return
	 */
	int deleteCivilVoice(CivilVoice civilvoice);
}
