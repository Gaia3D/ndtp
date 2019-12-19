package nscp.domain;

public enum RoleTarget {

	// 사용자
	USER("0"),
	// 서버
	SERVER("1");

	private final String value;
		
	RoleTarget(String value) {
		this.value = value;
	}
	
	public String getValue() {
		return this.value;
	}
}
