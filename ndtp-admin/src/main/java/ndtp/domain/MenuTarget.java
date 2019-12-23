package ndtp.domain;

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
	
	public static MenuTarget findBy(String value) {
		if("0".equals(value)) return MenuTarget.USER;
		else if("1".equals(value)) return MenuTarget.ADMIN;
		else return null;
	}
}
