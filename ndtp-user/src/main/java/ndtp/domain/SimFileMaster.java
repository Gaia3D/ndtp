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

}
