package ndtp.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ndtp.domain.CivilVoice;
import ndtp.domain.CivilVoiceComment;
import ndtp.persistence.CivilVoiceCommentMapper;
import ndtp.persistence.CivilVoiceMapper;
import ndtp.service.CivilVoiceCommentService;

@Service
public class CivilVoiceCommentServiceImpl implements CivilVoiceCommentService {
	private final CivilVoiceMapper civilVoiceMapper;
	private final CivilVoiceCommentMapper civilVoiceCommentMapper;

	public CivilVoiceCommentServiceImpl(CivilVoiceMapper civilVoiceMapper, CivilVoiceCommentMapper civilVoiceCommentMapper) {
		this.civilVoiceMapper = civilVoiceMapper;
		this.civilVoiceCommentMapper = civilVoiceCommentMapper;
	}

	@Transactional(readOnly=true)
	public List<CivilVoiceComment> getListCivilVoiceComment(CivilVoiceComment civilVoiceComment) {
		return civilVoiceCommentMapper.getListCivilVoiceComment(civilVoiceComment);
	}

	@Transactional(readOnly=true)
	public Long getListCivilVoiceCommentTotalCount(CivilVoiceComment civilVoiceComment) {
		return civilVoiceCommentMapper.getListCivilVoiceCommentTotalCount(civilVoiceComment);
	}

	@Transactional
	public int insertCivilVoiceComment(CivilVoiceComment civilVoiceComment) {
		CivilVoice civilVoice = new CivilVoice();
		civilVoice.setCivilVoiceId(civilVoiceComment.getCivilVoiceId());
		civilVoiceMapper.updateCivilVoiceCommentCount(civilVoice);

		return civilVoiceCommentMapper.insertCivilVoiceComment(civilVoiceComment);
	}

	@Transactional
	public int updateCivilVoiceComment(CivilVoiceComment civilVoiceComment) {
		return civilVoiceCommentMapper.updateCivilVoiceComment(civilVoiceComment);
	}

	@Transactional
	public int deleteCivilVoiceComment(long civilVoiceCommentId) {
		return civilVoiceCommentMapper.deleteCivilVoiceComment(civilVoiceCommentId);
	}

}
