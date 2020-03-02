package ndtp.domain;

import lombok.*;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class LonsLatsItem {
    String data_key;
    Float longitude;
    Float latitude;
}
