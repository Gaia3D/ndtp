package ndtp.persistence;

import org.springframework.stereotype.Repository;

import ndtp.domain.AttributeRepository;

@Repository
public interface AttributeRepositoryMapper {
	AttributeRepository getDataAttribute(String buildName);
}
