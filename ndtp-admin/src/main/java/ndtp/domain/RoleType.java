package ndtp.domain;

public enum RoleType {

	// 사용자
	USER("0"),
	// 서버
	SERVER("1"),
	// api
	API("2");

	private final String value;
		
	RoleType(String value) {
		this.value = value;
	}
	
	public String getValue() {
		return this.value;
	}
	
	public static RoleType findBy(String value) {
		if("0".equals(value)) return RoleType.USER;
		else if("1".equals(value)) return RoleType.SERVER;
		else if("2".equals(value)) return RoleType.API;
		else return null;
	}
}
