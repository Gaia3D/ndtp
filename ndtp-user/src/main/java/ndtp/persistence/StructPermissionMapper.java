package ndtp.persistence;

import ndtp.domain.StructPermission;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface StructPermissionMapper {

	int insertStructPermission(StructPermission structPermission);

	List<StructPermission> selectStructPermission();
	StructPermission selectOne(StructPermission structPermission);

}
