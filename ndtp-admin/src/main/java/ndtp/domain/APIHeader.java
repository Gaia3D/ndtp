package ndtp.domain;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * @author Cheon JeongDae
 *
 */
@Getter
@Setter
@ToString
public class APIHeader implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 307548813245126235L;
	
	private String userId;
	private String apiKey;
	private String token;
	private String role;
	private String algorithm;
	private String type;
}
