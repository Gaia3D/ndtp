package ndtp.domain;

import lombok.*;

import java.util.Date;

@Data
@ToString(callSuper = true)
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class StructPermission {
	private Integer perm_seq;
	private String constructor;
	private String constructor_type;
	private String perm_officer;
	private String birthday;
	private String license_num;
	private String phone_number;
	private String is_complete;
	private String latitude;
	private String longitude;
	private Date apply_date;
	public StructPermission(String constructor, String constructor_type, String perm_officer,
							String birthday, String license_num, String phone_number,
							String latitude, String longitude) {
		super();
		this.perm_seq = 0;
		this.constructor = constructor;
		this.constructor_type = constructor_type;
		this.perm_officer = perm_officer;
		this.birthday = birthday;
		this.license_num = license_num;
		this.phone_number = phone_number;
		this.is_complete = "N";
		this.latitude = latitude;
		this.longitude = longitude;
		this.apply_date = new Date();
	}
}


