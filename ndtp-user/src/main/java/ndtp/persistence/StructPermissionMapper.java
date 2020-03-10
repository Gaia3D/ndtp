package ndtp.persistence;

import ndtp.domain.StructPermission;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface StructPermissionMapper {

	int insertStructPermission(StructPermission structPermission);

	List<StructPermission> selectStructPermission(StructPermission sp);

	StructPermission selectOne(StructPermission structPermission);
	StructPermission selectNew(StructPermission structPermission);

	StructPermission putPermSend(StructPermission structPermission);

	int updateStructPermission(StructPermission structPermission);
	int updateBatchAgenda(StructPermission structPermission);
}
