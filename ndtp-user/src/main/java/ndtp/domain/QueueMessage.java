package ndtp.domain;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class QueueMessage implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6581364684193739905L;
	
	private Long converterJobId;
	private String inputFolder;
	private String outputFolder;
	private String meshType;
	private String logPath;
	private String indexing;
}
