package ndtp.domain;

import lombok.Data;

import java.util.Date;

@Data
public class StructPermission {
	private Integer perm_seq;
	private String constructor;
	private String constructor_type;
	private String birthday;
	private String license_num;
	private String phone_number;
	private String is_complete;
	private Date apply_date;
	public StructPermission(String constructor, String constructor_type, String birthday,
							String license_num, String phone_number) {
		super();
		this.constructor = constructor;
		this.constructor_type = constructor_type;
		this.birthday = birthday;
		this.license_num = license_num;
		this.phone_number = phone_number;
		this.is_complete = "N";
	}
}
