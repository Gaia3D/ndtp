package ndtp.domain;

import java.util.Date;

import lombok.*;

@Data
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class SimFileMaster {
	private Integer simFileSeq;
	private String originFileName;
	private String saveFileName;
	private String saveFilePath;
	private Date createDt;
	private FileType saveFileType;
	private Float lon;
	private Float lat;
	private Float alt;
	private String consType;
	private String cityType;
	private Integer cons_ratio;
	private String objectid;
}