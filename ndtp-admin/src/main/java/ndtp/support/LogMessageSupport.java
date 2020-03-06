package ndtp.support;

import lombok.extern.slf4j.Slf4j;

/**
 * profile에 따른 logMessage 출력
 * @author PSH
 *
 */
@Slf4j
public class LogMessageSupport {
	
	public static boolean stackTraceEnable = false;
	
	/**
	 * log print
	 * @param e
	 * @param message
	 * @param value
	 */
	public static void printMessage(Exception e, String message, Object... value) {
		if(stackTraceEnable) {
			e.printStackTrace();
		} else {
			log.info(message, value);
		}
	}
}
