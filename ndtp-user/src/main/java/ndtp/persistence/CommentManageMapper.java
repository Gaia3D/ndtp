package ndtp.persistence;

import ndtp.domain.CommentManage;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CommentManageMapper {

	int insertCommentManage(CommentManage commentManage);

	List<CommentManage> selectCondition(CommentManage commentManage);

	//	StructPermission selectOne(StructPermission structPermission);
	// 	int updateStructPermission(StructPermission structPermission);

}
