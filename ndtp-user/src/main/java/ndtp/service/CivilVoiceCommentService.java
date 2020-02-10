package ndtp.service;

import java.util.List;

import ndtp.domain.CivilVoiceComment;

public interface CivilVoiceCommentService {

	/**
	 * 시민 참여 댓글 목록 조회
	 * @param civilVoiceComment
	 * @return
	 */
	List<CivilVoiceComment> getListCivilVoiceComment(CivilVoiceComment civilVoiceComment);

	/**
	 * 시민 참여 댓글 전체 건수 조회
	 * @param civilVoiceComment
	 * @return
	 */
	Long getListCivilVoiceCommentTotalCount(CivilVoiceComment civilVoiceComment);

	/**
	 * 등록
	 * @param civilvoiceComment
	 * @return
	 */
	int insertCivilVoiceComment(CivilVoiceComment civilVoiceComment);

	/**
	 * 수정
	 * @param civilvoiceComment
	 * @return
	 */
	int updateCivilVoiceComment(CivilVoiceComment civilVoiceComment);

	/**
	 * 삭제
	 * @param civilvoiceComment
	 * @return
	 */
	int deleteCivilVoiceComment(CivilVoiceComment civilVoiceComment);
}
