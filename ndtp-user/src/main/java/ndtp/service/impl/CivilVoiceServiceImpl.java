package ndtp.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ndtp.domain.CivilVoice;
import ndtp.persistence.CivilVoiceCommentMapper;
import ndtp.persistence.CivilVoiceMapper;
import ndtp.service.CivilVoiceService;

@Service
public class CivilVoiceServiceImpl implements CivilVoiceService {
	private final CivilVoiceMapper civilVoiceMapper;
	private final CivilVoiceCommentMapper civilVoiceCommentMapper;

	public CivilVoiceServiceImpl(CivilVoiceMapper civilVoiceMapper, CivilVoiceCommentMapper civilVoiceCommentMapper) {
		this.civilVoiceMapper = civilVoiceMapper;
		this.civilVoiceCommentMapper = civilVoiceCommentMapper;
	}

	@Transactional(readOnly = true)
	public List<CivilVoice> getListCivilVoice(CivilVoice civilvoice) {
		return civilVoiceMapper.getListCivilVoice(civilvoice);
	}

	@Transactional(readOnly = true)
	public Long getCivilVoiceTotalCount(CivilVoice civilVoice) {
		return civilVoiceMapper.getCivilVoiceTotalCount(civilVoice);
	}

	@Transactional(readOnly = true)
	public CivilVoice getCivilVocieById(CivilVoice civilVoice) {
		return civilVoiceMapper.getCivilVocieById(civilVoice);
	}

	@Transactional
	public int insertCivilVoice(CivilVoice civilVoice) {
		return civilVoiceMapper.insertCivilVoice(civilVoice);
	}

	@Transactional
	public int updateCivilVoice(CivilVoice civilVoice) {
		return civilVoiceMapper.updateCivilVoice(civilVoice);
	}

	@Transactional
	public int updateCivilVoiceViewCount(CivilVoice civilVoice) {
		return civilVoiceMapper.updateCivilVoiceViewCount(civilVoice);
	}

	@Transactional
	public int deleteCivilVoice(CivilVoice civilVoice) {
		civilVoiceCommentMapper.deleteCivilVoiceCommentFromId(civilVoice.getCivilVoiceId());
		return civilVoiceMapper.deleteCivilVoice(civilVoice.getCivilVoiceId());
	}

}
