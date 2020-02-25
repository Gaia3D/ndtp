package ndtp.domain;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

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
	private ConsType consType;
	private Float lon;
	private Float lat;
	private Float alt;
	private String consTypeString;
	private String cityTypeString;
	private Integer consRatio;
	private String objectid;
	private MultipartFile[] files;
}