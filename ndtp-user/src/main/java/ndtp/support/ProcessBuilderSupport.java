package ndtp.support;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.List;

import lombok.extern.slf4j.Slf4j;

/**
 * @author Cheon JeongDae
 *
 */
@Slf4j
public class ProcessBuilderSupport {

	public static void execute(List<String> command) {
		
		log.info("---------- start ----------");
		log.info("@@@@@@@ command = {}", command);
		
		ProcessBuilder processBuilder = new ProcessBuilder(command);
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
			log.info("@@ IOException. message = {}", e.getMessage());
			throw new RuntimeException("IOException . " + e.getMessage());
		} catch (Exception e) {
			log.info("@@ Exception. message = {}", e.getMessage());
			throw new RuntimeException("Exception readLine Error. " + e.getMessage());
		} finally {
			if (bufferedReader != null) { try { bufferedReader.close(); } catch (IOException e) { log.info("@@ IOException. message = {}", e.getMessage()); } }
			if (inputStreamReader != null) { try { inputStreamReader.close(); } catch (IOException e) { log.info("@@ IOException. message = {}", e.getMessage()); } }
			if (inputStream != null) { try { inputStream.close(); } catch (IOException e) { log.info("@@ IOException. message = {}", e.getMessage()); } }
		}
	}
}
