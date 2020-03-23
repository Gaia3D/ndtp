package ndtp.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class MjBuild {
	private String buildName;
	private String molitUfid;
	private String bprpSe;
	private String buldNm;
	private String batcNm;
	private String buldSe;
	private String pnuNo;
}
