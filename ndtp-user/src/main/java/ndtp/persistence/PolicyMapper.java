package ndtp.persistence;

import org.springframework.stereotype.Repository;

import ndtp.domain.Policy;

/**
 * 운영 정책
 * @author jeongdae
 *
 */
@Repository
public interface PolicyMapper {

	/**
	 * 운영 정책 정보
	 * @return
	 */
	Policy getPolicy();
	
	/**
	 * 업로딩 가능 확장자 조회
	 * @return 업로딩 가능 확장자
	 */
	String getUserUploadType();
	
}
