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
	private Date applyDate;
	public StructPermission(String constructor, String constructor_type, String perm_officer,
							String birthday, String license_num, String phone_number,
							String latitude, String longitude) {
		super();
		this.permSeq = 0;
		this.constructor = constructor;
		this.constructorType = constructor_type;
		this.permOfficer = perm_officer;
		this.birthday = birthday;
		this.licenseNum = license_num;
		this.phoneNumber = phone_number;
		this.isComplete = "N";
		this.latitude = latitude;
		this.longitude = longitude;
		this.applyDate = new Date();
	}
}


