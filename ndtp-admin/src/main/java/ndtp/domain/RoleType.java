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
}
