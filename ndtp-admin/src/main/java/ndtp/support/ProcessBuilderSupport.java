package ndtp.support;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;

import lombok.extern.slf4j.Slf4j;
import ndtp.config.PropertiesConfig;

/**
 * @author Cheon JeongDae
 *
 */
@Slf4j
public class ProcessBuilderSupport {

	public static void execute(List<String> command, String path) {
		
		log.info("---------- start ----------");
		log.info("@@@@@@@ command = {}", command);
		
		ProcessBuilder processBuilder = new ProcessBuilder(command);
		
		// Bug Fix : Potential Command Injection
		// 참고 : https://cheatsheetseries.owasp.org/cheatsheets/OS_Command_Injection_Defense_Cheat_Sheet.html
		Map<String, String> env = processBuilder.environment();
		
		log.info("@@@@@@@ path = {}", env.get(path));
		if (env.get(path) != null && !env.get(path).isEmpty()) {
			processBuilder.directory(new File(FilenameUtils.getName(env.get(path))));
		}
		
		processBuilder.redirectErrorStream(true);
		InputStream inputStream = null;
        InputStreamReader inputStreamReader = null;
        BufferedReader bufferedReader = null;
        
		try {
			Process process = processBuilder.start();
			
			inputStream = process.getInputStream();
			inputStreamReader = new InputStreamReader(inputStream);
			bufferedReader = new BufferedReader(inputStreamReader);
			
			String readLine = null;
			while((readLine = bufferedReader.readLine()) != null) {
				log.info(readLine);
//				if(readLine.indexOf("ERROR") >= 0 || readLine.indexOf("FAILURE") >= 0) {
//					throw new RuntimeException("ProcessBuilderHelper readLine Error. " + readLine);
//				}
			}
			
			process.waitFor();
			log.info("---------- end ----------");
			
			bufferedReader.close();
			inputStreamReader.close();
			inputStream.close();
		} catch (IOException e) {
			throw new RuntimeException("IOException . " + e.getMessage());
		} catch (Exception e) {
			throw new RuntimeException("Exception readLine Error. " + e.getMessage());
		} finally {
			if (bufferedReader != null) { try { bufferedReader.close(); } catch (IOException e) { log.info("@@ IOException. message = {}", e.getMessage()); } }
			if (inputStreamReader != null) { try { inputStreamReader.close(); } catch (IOException e) { log.info("@@ IOException. message = {}", e.getMessage()); } }
			if (inputStream != null) { try { inputStream.close(); } catch (IOException e) { log.info("@@ IOException. message = {}", e.getMessage()); } }
		}
	}
}
