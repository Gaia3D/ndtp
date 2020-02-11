package ndtp.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ndtp.domain.CivilVoice;
import ndtp.persistence.CivilVoiceMapper;
import ndtp.service.CivilVoiceService;

@Service
public class CivilVoiceServiceImpl implements CivilVoiceService {
	private final CivilVoiceMapper civilVoiceMapper;

	public CivilVoiceServiceImpl(CivilVoiceMapper civilVoiceMapper) {
		this.civilVoiceMapper = civilVoiceMapper;
	}

	@Override
	@Transactional(readOnly = true)
	public List<CivilVoice> getListCivilVoice(CivilVoice civilvoice) {
		return civilVoiceMapper.getListCivilVoice(civilvoice);
	}

	@Override
	@Transactional(readOnly = true)
	public Long getCivilVoiceTotalCount(CivilVoice civilVoice) {
		return civilVoiceMapper.getCivilVoiceTotalCount(civilVoice);
	}

	@Override
	@Transactional(readOnly = true)
	public CivilVoice getCivilVocieById(CivilVoice civilVoice) {
		return civilVoiceMapper.getCivilVocieById(civilVoice);
	}

	@Override
	@Transactional
	public int insertCivilVoice(CivilVoice civilVoice) {
		return civilVoiceMapper.insertCivilVoice(civilVoice);
	}

	@Override
	@Transactional
	public int updateCivilVoice(CivilVoice civilVoice) {
		return civilVoiceMapper.updateCivilVoice(civilVoice);
	}

	@Override
	@Transactional
	public int deleteCivilVoice(CivilVoice civilVoice) {
		return civilVoiceMapper.deleteCivilVoice(civilVoice);
	}

}
