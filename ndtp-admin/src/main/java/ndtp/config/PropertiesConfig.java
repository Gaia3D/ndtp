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
	
    /**
     * 로컬 환경은 WINDOW, 운영 환경은 LINUX 
     */
    private String osType;
    
    /**
     * 로컬 환경에서 mock 사용여부
     */
    private boolean mockEnable;
    private boolean callRemoteEnable;
    private String serverIp;
    
    // http, https
    private String restTemplateMode;
    
    private String restAuthKey;

    private String gisRestServer;
    
    private String layerUploadDir;
    
    private String queueServerHost;
	private String queueServerPort;
	private String queueUser;
	private String queuePassword;
	private String queueName;
	private String exchange;
    
    private String uploadDataDir;
    // Converted f4d file directory
    private String userConverterDir;
}
