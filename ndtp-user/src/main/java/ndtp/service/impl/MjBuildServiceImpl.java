package ndtp.service.impl;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ndtp.domain.MjBuild;
import ndtp.persistence.MjBuildMapper;
import ndtp.service.MjBuildService;

@Service
public class MjBuildServiceImpl implements MjBuildService {
	
	private final MjBuildMapper mjBuildMapper;
	
	public MjBuildServiceImpl(MjBuildMapper mjBuildMapper) {
		this.mjBuildMapper = mjBuildMapper;
	}
	
	@Transactional(readOnly=true)
	public MjBuild getDataInfo(MjBuild mjBuild) {
		return mjBuildMapper.getDataInfo(mjBuild);
	}
	
}
