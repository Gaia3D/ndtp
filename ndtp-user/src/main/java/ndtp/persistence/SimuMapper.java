package ndtp.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import ndtp.domain.SimFileMaster;
import ndtp.domain.UserSession;

@Repository
public interface SimuMapper {

	int insertSimCityPlanFile(SimFileMaster simFileInfo);

	SimFileMaster getSimCityPlanFileList();

}
