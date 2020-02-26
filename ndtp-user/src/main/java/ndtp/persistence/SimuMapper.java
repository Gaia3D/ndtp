package ndtp.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import ndtp.domain.CityPlanResult;
import ndtp.domain.SimFileMaster;
import ndtp.domain.UserSession;

@Repository
public interface SimuMapper {

	int insertSimCityPlanFile(SimFileMaster simFileInfo);
	int insertConsProcFile(SimFileMaster simFileInfo);
	int insertSimCityPlanFileResult(CityPlanResult simFileInfo);

	SimFileMaster getSimCityPlanFileList();

}
