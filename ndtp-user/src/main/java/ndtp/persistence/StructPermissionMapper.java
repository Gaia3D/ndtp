package ndtp.persistence;

import ndtp.domain.StructPermission;
import org.springframework.stereotype.Repository;

@Repository
public interface StructPermissionMapper {

	int insertStructPermission(StructPermission structPermission);

	StructPermission selectStructPermission();

}
