package nscp.security;

import java.util.Base64;

import org.junit.jupiter.api.Test;

public class KeyManagerTest {

	@Test
	public void keyTest() throws Exception {
		String key = KeyManager.getInitKey();
		System.out.println(key);
		
		String encryptKey = "Z25hcmlyYUAgc2kgZW1hbiB5bSAuaXJhayByb2YgYWVkaSBkYWIgYSBla2FtIHRvbiBvZCBlc2FlbHAgLHllayBpcGEjIGRudW9mIGV2YWggdW95IGZJ";
		byte[] base64decodedBytes = Base64.getDecoder().decode(encryptKey.getBytes("UTF-8"));
		String result = new String(base64decodedBytes, "UTF-8");
		result = (new StringBuffer(result)).reverse().toString();
		System.out.println("1 ===== " + result);
		result = result.substring(79, 87) + result.substring(62, 66) + result.substring(18, 22);
		System.out.println("2 ===== " + result);
	}

	@Test
	public void 키_암호화() throws Exception {
		String key = "If you have found #api key, please do not make a bad idea for kari. my name is @arirang";
		System.out.println("key = " + key);
		String reverseKey =  new StringBuffer(key).reverse().toString();
		System.out.println("reverseKey = " + reverseKey);
		String encryptKey = new String(Base64.getEncoder().encode(reverseKey.getBytes("UTF-8")));
		System.out.println("encryptKey = " + encryptKey);
	}
}
