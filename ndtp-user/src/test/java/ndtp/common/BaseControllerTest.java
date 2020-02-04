package ndtp.common;

import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.web.servlet.MockMvc;

import com.fasterxml.jackson.databind.ObjectMapper;

import ndtp.NdtpUserApplication;

@ExtendWith(SpringExtension.class)
@ContextConfiguration(classes = NdtpUserApplication.class)
@SpringBootTest
@AutoConfigureMockMvc
public class BaseControllerTest {
	@Autowired
	protected MockMvc mockMvc;
	@Autowired
	protected MockHttpSession session;
	@Autowired
	protected ObjectMapper objectMapper;
}
