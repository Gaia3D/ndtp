package ndtp.controller;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.web.servlet.MockMvc;

import ndtp.NdtpUserApplication;
import ndtp.service.CivilVoiceCommentService;
import ndtp.service.CivilVoiceService;

@ExtendWith(SpringExtension.class)
@ContextConfiguration(classes = NdtpUserApplication.class)
@SpringBootTest
@AutoConfigureMockMvc
public class CivilVoiceTests {
	@Autowired
	MockMvc mockMvc;
	@Autowired
	CivilVoiceService civilVoiceService;
	@Autowired
	CivilVoiceCommentService civilVoiceCommentService;
	
	
	@Test
	public void 테스트() {
		System.out.println("test");
	}
}
