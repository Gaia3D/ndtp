package ndtp.service.impl;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.AllArgsConstructor;
import ndtp.domain.AttributeRepository;
import ndtp.persistence.AttributeRepositoryMapper;
import ndtp.service.AttributeRepositoryService;

@AllArgsConstructor
@Service
public class AttributeRepositoryServiceImpl implements AttributeRepositoryService {
	
	private final AttributeRepositoryMapper attributeRepositoryMapper;
	
	@Transactional(readOnly=true)
	public AttributeRepository getDataAttribute(String buildName) {
		return attributeRepositoryMapper.getDataAttribute(buildName);
	}
	
}
