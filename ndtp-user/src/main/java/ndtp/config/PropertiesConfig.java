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
	 * 로컬 : local, 개발 : develop, 운영 : product
	 */
	private String profile;
	
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
    
    private String layerExportDir;
    
    private String queueServerHost;
	private String queueServerPort;
	private String queueUser;
	private String queuePassword;
	private String queueName;
	private String exchange;
    
    // F4D 파일이 변환되는 Root 경로 이자, mago3DJS 에서 요청되는 파일의 Root 경로. ServletConfig 에서 매핑
    private String dataServiceDir;
    // 관리자용
    private String adminDataServiceDir;
    private String adminDataServicePath;
    // 사용자용
    private String userDataServiceDir;
    private String userDataServicePath;
    
    private String dataUploadDir;
    private String dataAttributeDir;
    private String dataAttributeUploadDir;
    private String dataObjectAttributeUploadDir;

    private String serviceF4dRunDir;
    private String serviceF4dInputDir;
    private String serviceF4dOutputDir;
    private String serviceF4dFinishRootDir;
    private String serviceFileUploadDir;
    private String serviceF4dFailRootDir;
    private String serviceFileBuildingobjDir;
    
    private String guideDataServiceDir;
}
