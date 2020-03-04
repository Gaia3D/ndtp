package ndtp.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ConsDataInfo {
    private String dataName;
    private Float lon;
    private Float lat;
    private Float alt;
    private Float heading;
    private Float pitch;
    private Float roll;
    private ConsType step;
}
