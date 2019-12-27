package ndtp.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/policy")
public class PolicyController {
	
	@GetMapping(value = "/modify")
	public String modify(HttpServletRequest reuqet, Model model) {
		
		return "/policy/modify";
	}
}
