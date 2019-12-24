package ndtp.domain;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.format.annotation.DateTimeFormat;

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
public class UserPolicy implements Serializable {

	private static final long serialVersionUID = -6548874769672071277L;

	// 고유 번호
	private Integer userPolicyId;
	// 사용자 아이디
	private String userId;
	// 지번 라벨 표시 여부
	private String labelYn;
	// 사용자 설정 레이어
	private ArrayList<HashMap<String, String>> baseLayerList;
	private String baseLayers;
	// 사용자 설정 라벨
	private String layerLabel;

	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Timestamp updateDate;

	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Timestamp insertDate;

}
