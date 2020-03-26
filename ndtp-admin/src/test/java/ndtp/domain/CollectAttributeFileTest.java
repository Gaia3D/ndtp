package ndtp.domain;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

import org.junit.jupiter.api.Test;

import lombok.extern.slf4j.Slf4j;

@Slf4j
class CollectAttributeFileTest {

	String inputDirectory = "C:\\data\\mago3d\\f4d\\service\\admin\\basic\\";
	String outDirectory = "C:\\data\\mago3d\\smart-tiling-attribute";
	
	@Test
	void test() throws Exception {
		File targetFile = new File(inputDirectory);
		if(!targetFile.isDirectory()) {
			throw new Exception("입력 디렉토리 오류");
		}
		
		File[] fileList = targetFile.listFiles();
		for(File file : fileList) {
			log.info("--- file name = {}", file.getName());
			if(file.isDirectory() && file.getName().indexOf("F4D_")>=0) {
				log.info("**** target file name = {}", file.getName());
				moveAttribute(file);
			}
		}
	}
	
	private void moveAttribute(File file) throws IOException {
		String directoryName = file.getName();
		String subPath = file.getName() + File.separator;
		
		File[] childFileList = file.listFiles();
		for(File childFile : childFileList) {
			if(childFile.isFile() && childFile.getName().equals("attributes.json")) {
				Files.copy(new File(inputDirectory + subPath + File.separator + childFile.getName()).toPath(), 
						new File(outDirectory + File.separator + directoryName + "_" +childFile.getName()).toPath());
			}
		}
	}
}
