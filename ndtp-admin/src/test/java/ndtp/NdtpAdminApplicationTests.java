package ndtp;

import java.util.EnumMap;
import java.util.Map;

import org.junit.jupiter.api.Test;

import ndtp.domain.MenuTarget;
import ndtp.domain.ShapeFileExt;

class NdtpAdminApplicationTests {

	@Test
	void contextLoads() {
		
		 System.out.println(ShapeFileExt.findBy("shp"));
	}

}
