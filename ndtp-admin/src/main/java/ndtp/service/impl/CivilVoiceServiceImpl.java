package ndtp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ndtp.domain.CivilVoice;
import ndtp.persistence.CivilVoiceMapper;
import ndtp.service.CivilVoiceService;

/**
 * 
 * @author kimhj
 *
 */
@Service
public class CivilVoiceServiceImpl implements CivilVoiceService {

	@Autowired
    private CivilVoiceMapper civilVoiceMapper;

    @Transactional(readOnly=true)
	public Long getCivilVoiceTotalCount(CivilVoice civilVoice) {
    	return civilVoiceMapper.getCivilVoiceTotalCount(civilVoice);
	}

    @Transactional(readOnly=true)
	public List<CivilVoice> getListCivilVoice(CivilVoice civilVoice) {
		return civilVoiceMapper.getListCivilVoice(civilVoice);
	}

    @Transactional(readOnly=true)
	public CivilVoice getCivilVoice(CivilVoice civilVoice) {
		return civilVoiceMapper.getCivilVoice(civilVoice);
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
	public int deleteCivilVoice(CivilVoice civilVoice) {
		return civilVoiceMapper.deleteCivilVoice(civilVoice);
	}
}
