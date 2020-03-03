package ndtp.domain;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;

import lombok.*;
import org.springframework.web.multipart.MultipartFile;

@Data
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class CityPlanResult {
	private int cityPlanResultSeq;
	private Float cityPlanTargetArea;
	private Float cityPlanStdFloorCov;
	private Float floorCoverateRatio;
	private Float cityPlanStdBuildCov;
	private Float buildCoverateRatio;
	private int simFileMasterImgNum;
	private MultipartFile files;
	private Date createDt;
//	public CityPlanResult() {
//
//	}
//	public CityPlanResult(Float cityPlanTargetArea, int cityPlanStdFloorCov, int floorCoverateRatio,
//			int cityPlanStdBuildCov, int buildCoverateRatio, MultipartFile files) {
//		super();
//		this.cityPlanTargetArea = cityPlanTargetArea;
//		this.cityPlanStdFloorCov = cityPlanStdFloorCov;
//		this.floorCoverateRatio = floorCoverateRatio;
//		this.cityPlanStdBuildCov = cityPlanStdBuildCov;
//		this.buildCoverateRatio = buildCoverateRatio;
//		this.files = files;
//	}
//	public CityPlanResult(int cityPlanResultSeq, Float cityPlanTargetArea, int cityPlanStdFloorCov,
//			int floorCoverateRatio, int cityPlanStdBuildCov, int buildCoverateRatio, int simFileMasterImgNum, Date createDt) {
//		super();
//		this.cityPlanResultSeq = cityPlanResultSeq;
//		this.cityPlanTargetArea = cityPlanTargetArea;
//		this.cityPlanStdFloorCov = cityPlanStdFloorCov;
//		this.floorCoverateRatio = floorCoverateRatio;
//		this.cityPlanStdBuildCov = cityPlanStdBuildCov;
//		this.buildCoverateRatio = buildCoverateRatio;
//		this.simFileMasterImgNum = simFileMasterImgNum;
//		this.createDt = createDt;
//	}
//	public CityPlanResult(int cityPlanResultSeq, Float cityPlanTargetArea, int cityPlanStdFloorCov,
//			int floorCoverateRatio, int cityPlanStdBuildCov, int buildCoverateRatio, int simFileMasterImgNum,
//			MultipartFile files, Date createDt) {
//		super();
//		this.cityPlanResultSeq = cityPlanResultSeq;
//		this.cityPlanTargetArea = cityPlanTargetArea;
//		this.cityPlanStdFloorCov = cityPlanStdFloorCov;
//		this.floorCoverateRatio = floorCoverateRatio;
//		this.cityPlanStdBuildCov = cityPlanStdBuildCov;
//		this.buildCoverateRatio = buildCoverateRatio;
//		this.simFileMasterImgNum = simFileMasterImgNum;
//		this.files = files;
//		this.createDt = createDt;
//	}
	
	
}
