package ndtp.domain;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

import lombok.extern.slf4j.Slf4j;

@Slf4j
class UserStatusTest {

	@Test
	void test() {
		System.out.println("=== " + RoleKey.valueOf("ADMIN_SIGNIN"));
		//log.info("===" + UserStatus.valueOf("0"));
	}

}
