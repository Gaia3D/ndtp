package ndtp.service;

import ndtp.domain.AttributeRepository;

public interface AttributeRepositoryService {
	
	AttributeRepository getDataAttribute(String buildName);
}
