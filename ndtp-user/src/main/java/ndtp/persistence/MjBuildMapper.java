package ndtp.persistence;

import org.springframework.stereotype.Repository;

import ndtp.domain.MjBuild;

@Repository
public interface MjBuildMapper {
	MjBuild getDataInfo(MjBuild mjBuild);
}
