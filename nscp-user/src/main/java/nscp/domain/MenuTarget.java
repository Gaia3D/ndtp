package nscp.domain;

public enum MenuTarget {
	// 사용자
	USER("0"),
	// 서버
	ADMIN("1");
	
	private final String value;
		
	MenuTarget(String value) {
		this.value = value;
	}
	
	public String getValue() {
		return this.value;
	}
}
