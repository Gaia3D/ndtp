package ndtp.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import ndtp.domain.SimFileMaster;
import ndtp.domain.UserSession;

@Repository
public interface SimuMapper {

	/**
	 * 시뮬레이션 도시계획 파일 Insert
	 * @param userSession
	 * @return
	 */
	int insertSimCityPlanFile(SimFileMaster simFileInfo);

	SimFileMaster getSimCityPlanFileList();

}
