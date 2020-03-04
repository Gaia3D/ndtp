package ndtp.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class F4DObject {
    private String data_key;
    private String data_name;
    private Integer cons_ratio;
    private FileType cons_type;
    private Integer step;
    private List<F4DSubObject> f4dSubList;
}