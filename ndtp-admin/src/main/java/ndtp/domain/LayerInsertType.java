package ndtp.domain;

public enum LayerInsertType {
	UPLOAD("upload"),
	GEOSERVER("geoserver");
	
	private final String value;
	
	LayerInsertType(String value) {
		this.value = value;
	}
	
	public String getValue() {
		return this.value;
	}
}
