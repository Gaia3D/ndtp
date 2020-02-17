package ndtp.domain;

import java.math.BigDecimal;
import java.sql.Timestamp;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
public class CityPlanResult {
	private String cityPlanTargetArea;
	private String cityPlanStdFloorCov;
	private String floorCoverateRatio;
	private String cityPlanStdBuildCov;
	private String buildCoverateRatio;
	private MultipartFile files;
	public CityPlanResult(String cityPlanTargetArea, String cityPlanStdFloorCov, String floorCoverateRatio,
			String cityPlanStdBuildCov, String buildCoverateRatio, MultipartFile files) {
		super();
		this.cityPlanTargetArea = cityPlanTargetArea;
		this.cityPlanStdFloorCov = cityPlanStdFloorCov;
		this.floorCoverateRatio = floorCoverateRatio;
		this.cityPlanStdBuildCov = cityPlanStdBuildCov;
		this.buildCoverateRatio = buildCoverateRatio;
		this.files = files;
	}
	
}
