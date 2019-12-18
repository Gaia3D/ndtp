package nscp.security;

import org.junit.jupiter.api.Test;

public class CryptTest {

	/**
	 * 암복호화 테스트
	 */
	@Test
	public void 암복호화() {
		System.out.println("url : " + Crypt.encrypt("jdbc:postgresql://localhost:5432/postgres"));
		System.out.println("user : " + Crypt.encrypt("postgres"));
		System.out.println("password : " + Crypt.encrypt("postgres"));
		System.out.println(Crypt.decrypt("b+qpJGas3zhrkBob5IXKGIkE5ieXxNczvHC6DMXU6iTptUTTSY89RhklLR3hS/2g"));
	}
}
