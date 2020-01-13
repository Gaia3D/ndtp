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

}
