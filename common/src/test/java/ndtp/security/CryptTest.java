package ndtp.security;

import org.junit.jupiter.api.Test;

import ndtp.security.Crypt;

public class CryptTest {

	/**
	 * 암복호화 테스트
	 */
	@Test
	public void 암복호화() {
		System.out.println("url : " + Crypt.encrypt("jdbc:postgresql://localhost:5432/postgres"));
		System.out.println("user : " + Crypt.encrypt("postgres"));
		System.out.println("password : " + Crypt.encrypt("guest"));

		System.out.println(Crypt.decrypt("qKC0oX5lnFU7C7tyXmqfdg=="));
	}
}
