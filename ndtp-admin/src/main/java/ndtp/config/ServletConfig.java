package ndtp.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.ComponentScan.Filter;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.FilterType;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.core.Ordered;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.validation.beanvalidation.LocalValidatorFactoryBean;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import lombok.extern.slf4j.Slf4j;
import ndtp.interceptor.ConfigInterceptor;
import ndtp.interceptor.LogInterceptor;
import ndtp.interceptor.SecurityInterceptor;

@Slf4j
@EnableWebMvc
@Configuration
@ComponentScan(basePackages = { "ndtp.config, ndtp.controller, ndtp.interceptor, ndtp.validator" }, includeFilters = {
		@Filter(type = FilterType.ANNOTATION, value = Component.class),
		@Filter(type = FilterType.ANNOTATION, value = Controller.class),
		@Filter(type = FilterType.ANNOTATION, value = RestController.class)})
public class ServletConfig implements WebMvcConfigurer {
	
	@Autowired
	private PropertiesConfig propertiesConfig;
	
	@Autowired
	private ConfigInterceptor configInterceptor;
	@Autowired
	private LogInterceptor logInterceptor;
	@Autowired
	private SecurityInterceptor securityInterceptor;
	
	@Override
    public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
        configurer.enable();
    }
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		log.info(" @@@ ServletConfig addInterceptors @@@@ ");
		
		registry.addInterceptor(securityInterceptor)
				.addPathPatterns("/**")
				.excludePathPatterns("/f4d/**",	"/sign/**", "/css/**", "/externlib/**", "favicon*", "/images/**", "/js/**");
		registry.addInterceptor(logInterceptor)
				.addPathPatterns("/**")
				.excludePathPatterns("/f4d/**",	"/sign/**", "/css/**", "/externlib/**", "favicon*", "/images/**", "/js/**");
		registry.addInterceptor(configInterceptor)
				.addPathPatterns("/**")
				.excludePathPatterns("/f4d/**",	"/sign/**", "/css/**", "/externlib/**", "favicon*", "/images/**", "/js/**");
    }
	
	@Bean
	@ConditionalOnMissingBean(InternalResourceViewResolver.class)
	public InternalResourceViewResolver viewResolver() {
		log.info(" @@@ ServletConfig viewResolver @@@");
		InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
		viewResolver.setPrefix("/WEB-INF/views");
		viewResolver.setSuffix(".jsp");
		viewResolver.setOrder(3);
		
		return viewResolver;
	}
	
	@Bean
	public LocaleResolver localeResolver() {
		SessionLocaleResolver sessionLocaleResolver = new SessionLocaleResolver();
		return sessionLocaleResolver;
	}

	@Bean
	public ReloadableResourceBundleMessageSource messageSource(){
		ReloadableResourceBundleMessageSource messageSource = new ReloadableResourceBundleMessageSource();
		messageSource.setBasename("classpath:/messages/messages");
		messageSource.setDefaultEncoding("UTF-8");
		return messageSource;
	}

	@Bean
	public MessageSourceAccessor getMessageSourceAccessor(){
		ReloadableResourceBundleMessageSource m = messageSource();
		return new MessageSourceAccessor(m);
	}
	
	/**
     * anotation @Valid 를 사용하려면 이 빈을 생성해 줘야 함
     */
    @Bean
    public LocalValidatorFactoryBean getValidator() {
        LocalValidatorFactoryBean bean = new LocalValidatorFactoryBean();
        bean.setValidationMessageSource(messageSource());
        return bean;
    }
	
	@Override
    public void addViewControllers(ViewControllerRegistry registry) {
		registry.addViewController("/").setViewName("forward:/sign/signin");
        registry.setOrder(Ordered.HIGHEST_PRECEDENCE);
    }
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		log.info(" @@@ ServletConfig addResourceHandlers @@@");
		
		// F4D converter file 경로
		registry.addResourceHandler("/f4d/**").addResourceLocations("file:" + propertiesConfig.getDataServiceDir());
		
		registry.addResourceHandler("/css/**").addResourceLocations("/css/");
		registry.addResourceHandler("/externlib/**").addResourceLocations("/externlib/");
		registry.addResourceHandler("/images/**").addResourceLocations("/images/");
		registry.addResourceHandler("/js/**").addResourceLocations("/js/");
		
//		registry.addResourceHandler("/webjars/**").addResourceLocations("classpath:/META-INF/resources/webjars/");
	}
	
	
//	/**
//	 * TODO rest-template-mode 값으로 결정 하는게 아니라 request.isSecure 로 http, https 를 판별해서 결정 해야 하는데....
//	 *      그럴경우 bean 설정이 아니라.... 개별 코드에서 판별을 해야 함 ㅠ.ㅠ
//	 * @return
//	 * @throws KeyStoreException
//	 * @throws NoSuchAlgorithmException
//	 * @throws KeyManagementException
//	 */
//	@Bean
//    public RestTemplate restTempate() throws KeyStoreException, NoSuchAlgorithmException, KeyManagementException {
//    	// https://github.com/jonashackt/spring-boot-rest-clientcertificate/blob/master/src/test/java/de/jonashackt/RestClientCertTestConfiguration.java
//    	
//    	String restTemplateMode = propertiesConfig.getRestTemplateMode();
//    	RestTemplate restTemplate = null;
//    	RestTemplateBuilder builder = new RestTemplateBuilder(new CustomRestTemplateCustomizer());
//    	if("http".equals(restTemplateMode)) {
//    		restTemplate = builder.errorHandler(new RestTemplateResponseErrorHandler())
//						.setConnectTimeout(Duration.ofMillis(10000))
//	            		.setReadTimeout(Duration.ofMillis(10000))
//	            		.build();
//    	} else {
//    		TrustStrategy acceptingTrustStrategy = (X509Certificate[] chain, String authType) -> true;
//	    	SSLContext sslContext = org.apache.http.ssl.SSLContexts.custom().loadTrustMaterial(null, acceptingTrustStrategy).build();
//	 
//	    	SSLConnectionSocketFactory csf = new SSLConnectionSocketFactory(sslContext);
//	    	CloseableHttpClient httpClient = HttpClients.custom().setSSLSocketFactory(csf).build();
//	 
//	    	HttpComponentsClientHttpRequestFactory requestFactory = new HttpComponentsClientHttpRequestFactory();
//	        requestFactory.setHttpClient(httpClient);
//	        
//	    	restTemplate = builder.errorHandler(new RestTemplateResponseErrorHandler())
//						.setConnectTimeout(Duration.ofMillis(10000))
//	            		.setReadTimeout(Duration.ofMillis(10000))
//	            		.build();
//			restTemplate.setRequestFactory(requestFactory);
//    	}
//    	
//		return restTemplate;
//    }
}
