package ndtp.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class F4DSubObject {
    private String data_key;
    private String data_name;
    private Float longitude;
    private Float latitude;
    private Float height;
    private Float heading;
    private Float pitch;
    private Float roll;
    private Integer ratio;
}
