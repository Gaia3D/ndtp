package ndtp.domain;

public enum RoleTarget {

	// 사용자 사이트
	USER("0"),
	// 관리자 사이트
	ADMIN("1");

	private final String value;
		
	RoleTarget(String value) {
		this.value = value;
	}
	
	public String getValue() {
		return this.value;
	}
}
