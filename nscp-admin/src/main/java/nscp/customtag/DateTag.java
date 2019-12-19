package nscp.customtag;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.SkipPageException;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import lombok.extern.slf4j.Slf4j;

/**
 * 화면단 날짜 표시용
 * @author Jeongdae
 *
 */
@Slf4j
public class DateTag extends SimpleTagSupport {

	// TODO 이 변수는 여기가 맞는 걸까?
	public static final SimpleDateFormat viewDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private LocalDateTime localDateTime;
	private String format;
	
	public DateTag() {
	}
	
	public void setLocalDateTime(LocalDateTime localDateTime) {
		this.localDateTime = localDateTime;
	}

	public void setFormat(String format) {
		this.format = format;
	}

	@Override
	public void doTag() throws JspException, IOException {
		log.info("LocalDateTime is  = {}", localDateTime);
		log.info("Format is  = {}", format);
		try { 
			
			String format = viewDateFormat.format(localDateTime);
			getJspContext().getOut().write(format.substring(0, 19));
			
		} catch (Exception e) {
			e.printStackTrace(); // stop page from loading further by throwing SkipPageException 
			throw new SkipPageException("Exception in formatting " + localDateTime + " with format " + format); 
		}
	}
}
