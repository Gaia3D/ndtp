package ndtp.domain;

import lombok.*;

import java.util.Date;
import java.util.List;

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
	private Float latitude;
	private Float longitude;
	private String saveFilePath;
	private String saveFileName;
	private String saveModelFilePath;
	private String saveModelFileName;
	private String originFileName;
	private Date applyDate;
	private F4DObject f4dObject;
	private Float altitude;
	private Float heading;
	private Float pitch;
	private Float roll;
	private String suitable;
	private String notSuitableReason;
	private String batchChecked;
	private String agendaChecked;
}


