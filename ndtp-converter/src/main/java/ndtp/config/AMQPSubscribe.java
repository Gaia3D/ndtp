package ndtp.config;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CompletableFuture;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import lombok.extern.slf4j.Slf4j;
import ndtp.domain.ConverterJob;
import ndtp.domain.ConverterJobStatus;
import ndtp.domain.QueueMessage;
import ndtp.support.ProcessBuilderSupport;

@Slf4j
@Component
public class AMQPSubscribe {
	
	@Autowired
	private PropertiesConfig propertiesConfig;
	@Autowired
	private RestTemplate restTemplate;
	
	public void handleMessage(QueueMessage queueMessage) {
		Long converterJobId = queueMessage.getConverterJobId();
		log.info(" @@@@@@ handleMessage start. converterJobId = {}", converterJobId);
		
		CompletableFuture.supplyAsync( () -> {
			List<String> command = new ArrayList<>();
			command.add(propertiesConfig.getConverterDir());
			command.add("#inputFolder");
			command.add(queueMessage.getInputFolder());
			command.add("#outputFolder");
			command.add(queueMessage.getOutputFolder());
			command.add("#meshType");
			command.add(queueMessage.getMeshType());
			command.add("#log");
			command.add(queueMessage.getLogPath());
			command.add("#indexing");
			command.add(queueMessage.getIndexing());
			
			
			log.info(" >>>>>> command = {}", command.toString());
			
			String result = ConverterJobStatus.SUCCESS.name();
			try {
				int exitCode = ProcessBuilderSupport.execute(command);
				
				if(exitCode == 0) result = ConverterJobStatus.SUCCESS.name();
				else result = ConverterJobStatus.FAIL.name();
			} catch (Exception e1) {
				result = ConverterJobStatus.FAIL.name();
				log.info(" handleMessage exception = {}", e1.getMessage());
				e1.printStackTrace();
			}
			return result;
        })
		.exceptionally(e -> {
        	log.info("exceptionally exception = {}", e.getMessage());
        	updateConverterJobStatus(converterJobId, ConverterJobStatus.FAIL.name(), e.getMessage());
        	return null;
        })
		// 앞의 비동기 작업의 결과를 받아 사용하며 return이 없다.
		.thenAccept(s -> {
			log.info("thenAccept result = {}", s);
			updateConverterJobStatus(converterJobId, s, null);
			log.info("thenAccept end");
		});
	}
	
	/**
	 * 데이터 변환 job 상태 변경
	 * @param converterJobId
	 * @param status
	 * @param errorCode
	 */
	private void updateConverterJobStatus(Long converterJobId, String status, String errorCode) {
		log.info("@@ updateConverterJobStatus converterJobId = {}, status = {}, errorCode = {}", converterJobId, status, errorCode);
		ConverterJob converterJob = new ConverterJob();
		converterJob.setConverterJobId(converterJobId);
		converterJob.setStatus(status);
		converterJob.setErrorCode(errorCode);
		
		try {
			URI uri = new URI(propertiesConfig.getCmsRestServer() + "/api/converter/status");
			restTemplate.postForEntity(uri, converterJob, Map.class);
		} catch (URISyntaxException e) {
			log.info("데이터 converter 상태 변경 api 호출 실패 = {}", e.getMessage());
			e.printStackTrace();
		}
	}
	
//	public void handleMessage2(QueueMessage queueMessage) {
//		log.info("@@ Subscribe receive message");
//		log.info("@@ queueMessage = {}", queueMessage);
//		
//		Runnable connverterRun = () -> {
//			List<String> command = new ArrayList<>();
//			command.add(propertiesConfig.getConverterDir());
//			command.add("-inputFolder");
//			command.add(queueMessage.getInputFolder());
//			command.add("-outputFolder");
//			command.add(queueMessage.getOutputFolder());
//			command.add("-meshType");
//			command.add(queueMessage.getMeshType());
//			command.add("-log");
//			command.add(queueMessage.getLogPath());
//			command.add("-indexing");
//			command.add(queueMessage.getIndexing());
//			
//			log.info(" >>>>>> command = {}", command.toString());
//			
//			ProcessBuilderSupport.execute(command);
//		};
//		
//		new Thread(connverterRun, "F4D-Converter-Thread-JobId=" + queueMessage.getConverterJobId()).start();
//	}
}
