package ndtp.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class movedFinishFolder {
    private String movedFinsihInputFolder;
    private String movedFinishOutputFolder;
    private String movedFailFolder;
}
