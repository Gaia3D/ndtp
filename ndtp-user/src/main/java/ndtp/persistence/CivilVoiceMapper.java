package ndtp.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import ndtp.domain.CivilVoice;

@Repository
public interface CivilVoiceMapper {
	/**
	 * 시민 참여 목록 조회
	 * @param civilvoice
	 * @return
	 */
	List<CivilVoice> getListCivilVoice(CivilVoice civilVoice);

	/**
	 * 시민 참여 전체 건수 조회
	 * @param civilvoice
	 * @return
	 */
	Long getCivilVoiceTotalCount(CivilVoice civilVoice);

	/**
	 * 시민 참여 한건에 대한 정보 조회
	 * @param civilVoice
	 * @return
	 */
	CivilVoice getCivilVocieById(CivilVoice civilVoice);

	/**
	 * 등록
	 * @param civilvoice
	 * @return
	 */
	int insertCivilVoice(CivilVoice civilVoice);

	/**
	 * 수정
	 * @param civilvoice
	 * @return
	 */
	int updateCivilVoice(CivilVoice civilVoice);

	/**
	 * 삭제
	 * @param civilvoice
	 * @return
	 */
	int deleteCivilVoice(CivilVoice civilVoiceId);

	/**
	 * 전체 삭제
	 * @return
	 */
	int deleteAllCivilVoice();
}
