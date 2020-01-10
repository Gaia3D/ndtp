package ndtp.config;

import java.util.ArrayList;
import java.util.List;

import lombok.extern.slf4j.Slf4j;
import ndtp.domain.QueueMessage;
import ndtp.support.ProcessBuilderSupport;

@Slf4j
public class AMQPSubscribe {
	private PropertiesConfig propertiesConfig;
	
	public AMQPSubscribe(PropertiesConfig propertiesConfig) {
		this.propertiesConfig = propertiesConfig;
	}
	
	public void handleMessage(QueueMessage queueMessage) {
		log.info("@@ Subscribe receive message");
		log.info("@@ queueMessage = {}", queueMessage);
		
		Runnable connverterRun = () -> {
			List<String> command = new ArrayList<>();
			command.add(propertiesConfig.getConverterDir());
			command.add("-inputFolder");
			command.add(queueMessage.getInputFolder());
			command.add("-outputFolder");
			command.add(queueMessage.getOutputFolder());
			command.add("-meshType");
			command.add(queueMessage.getMeshType());
			command.add("-log");
			command.add(queueMessage.getLogPath());
			command.add("-indexing");
			command.add(queueMessage.getIndexing());
			
			log.info(" >>>>>> command = {}", command.toString());
			
			ProcessBuilderSupport.execute(command);
		};
		
		new Thread(connverterRun, "F4D-Converter-Thread-JobId=" + queueMessage.getConverterJobId()).start();
	}
}
