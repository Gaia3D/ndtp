package ndtp.persistence;

import java.util.List;

import ndtp.domain.ConsDataInfo;
import org.springframework.stereotype.Repository;

import ndtp.domain.CityPlanResult;
import ndtp.domain.SimFileMaster;
import ndtp.domain.UserSession;

@Repository
public interface SimuMapper {

	int insertSimCityPlanFile(SimFileMaster simFileInfo);
	int insertConsProcFile(SimFileMaster simFileInfo);
	int insertSimCityPlanFileResult(CityPlanResult simFileInfo);

	SimFileMaster getSimCityPlanFile();
	List<SimFileMaster> getSimMasterList(SimFileMaster sfm);
	ConsDataInfo getConsDataInfo(ConsDataInfo sfm);

}
