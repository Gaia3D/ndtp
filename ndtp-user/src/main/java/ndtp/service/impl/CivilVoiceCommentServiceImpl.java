package ndtp.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import ndtp.domain.CivilVoiceComment;
import ndtp.persistence.CivilVoiceCommentMapper;
import ndtp.service.CivilVoiceCommentService;

@Service
public class CivilVoiceCommentServiceImpl implements CivilVoiceCommentService {
	private final CivilVoiceCommentMapper civilVoiceCommentMapper;
	
	public CivilVoiceCommentServiceImpl(CivilVoiceCommentMapper civilVoiceCommentMapper) {
		this.civilVoiceCommentMapper = civilVoiceCommentMapper;
	}
	
	@Override
	public List<CivilVoiceComment> getListCivilVoiceComment(Long CivilVoiceId) {
		return civilVoiceCommentMapper.getListCivilVoiceComment(CivilVoiceId);
	}

	@Override
	public int insertCivilVoiceComment(CivilVoiceComment civilVoiceComment) {
		return civilVoiceCommentMapper.insertCivilVoiceComment(civilVoiceComment);
	}

	@Override
	public int updateCivilVoiceComment(CivilVoiceComment civilVoiceComment) {
		return civilVoiceCommentMapper.updateCivilVoiceComment(civilVoiceComment);
	}

	@Override
	public int deleteCivilVoiceComment(CivilVoiceComment civilVoiceComment) {
		return civilVoiceCommentMapper.deleteCivilVoiceComment(civilVoiceComment);
	}

}
