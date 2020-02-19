package ndtp.domain;

import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;

import java.sql.Timestamp;
import java.util.Date;

@Data
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class CommentManage {
	private Integer commentSeq;
	private String writer;
	private String objectName;
	private String commentTitle;
	private String commentContent;
	private String latitude;
	private String longitude;
	private String height;
//	private Date applyDate;
@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
private Timestamp applyDate;
}


