package ndtp.domain;

public enum DataStatus {

	// 사용중
	USE("0"),
	// 사용 중지
	FORBID("1"),
	// 삭제(화면 비표시)
	DELETE("2");

	private final String value;
		
	DataStatus(String value) {
		this.value = value;
	}
	
	public String getValue() {
		return this.value;
	}
	
	/**
	 * TODO values for loop 로 변환
	 * @param value
	 * @return
	 */
	public static DataStatus findBy(String value) {
		for(DataStatus sataStatus : values()) {
			if(sataStatus.getValue().equals(value)) return sataStatus; 
		}
		return null;
	}
}
