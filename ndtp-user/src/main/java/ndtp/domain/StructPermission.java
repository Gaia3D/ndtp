package ndtp.domain;

import lombok.*;

import java.util.Date;

@Data
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class StructPermission {
	private Integer permSeq;
	private String constructor;
	private String constructorType;
	private String permOfficer;
	private String birthday;
	private String licenseNum;
	private String phoneNumber;
	private String isComplete;
	private String latitude;
	private String longitude;
	private String saveFilePath;
	private String saveFileName;
	private String originFileName;
	private Date applyDate;
}


