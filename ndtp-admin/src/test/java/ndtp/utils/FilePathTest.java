package ndtp.utils;

import static org.junit.jupiter.api.Assertions.*;

import java.io.File;
import java.nio.file.Paths;

import org.junit.jupiter.api.Test;

class FilePathTest {

	@Test
	void test() {
		File file = Paths.get("/f4d/test", "aa").toFile();
		System.out.println(file.getPath());
	}

}
