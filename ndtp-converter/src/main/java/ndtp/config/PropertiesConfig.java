package ndtp.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;

import lombok.Data;

@Data
@Configuration
@PropertySource("classpath:ndtp.properties")
@ConfigurationProperties(prefix = "ndtp")
public class PropertiesConfig {
	
	private String osType;
	private boolean callRemoteEnable;
	private String serverIp;
	private String serverPort;
	private String restAuthKey;
	
	private String queueServerHost;
	private String queueServerPort;
	private String queueUser;
	private String queuePassword;
	private String queueName;
	private String exchange;
	
	// User excel batch registration
	private String uploadDataDir;
	
	// F4D Converter.exe 가 있는 경로
	private String converterDir;	
	
}
