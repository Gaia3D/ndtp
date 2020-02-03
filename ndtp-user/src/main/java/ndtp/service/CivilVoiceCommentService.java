package ndtp.service;

import java.util.List;

import ndtp.domain.CivilVoiceComment;

public interface CivilVoiceCommentService {
	
	/**
	 * 시민 참여 댓글 목록 조회
	 * @param CivilVoiceId
	 * @return
	 */
	List<CivilVoiceComment> getListCivilVoiceComment(Long CivilVoiceId);
	
	/**
	 * 등록
	 * @param civilvoiceComment
	 * @return
	 */
	int insertCivilVoiceComment(CivilVoiceComment civilvoiceComment);
	
	/**
	 * 수정
	 * @param civilvoiceComment
	 * @return
	 */
	int updateCivilVoiceComment(CivilVoiceComment civilvoiceComment);
	
	/**
	 * 삭제 
	 * @param civilvoiceComment
	 * @return
	 */
	int deleteCivilVoiceComment(CivilVoiceComment civilvoiceComment);
}
