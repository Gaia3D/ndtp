package ndtp.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import ndtp.domain.*;
import ndtp.persistence.SimuMapper;
import ndtp.persistence.StructPermissionMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;
import ndtp.service.CivilVoiceCommentService;
import ndtp.service.CivilVoiceService;
import ndtp.service.impl.SimuServiceImpl;
import ndtp.utils.WebUtils;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Slf4j
@RestController
@RequestMapping("/data/simulation-rest")
public class SimulationRestController {
	@Autowired
	private StructPermissionMapper structPermissionMapper;

	private static final long PAGE_ROWS = 5l;
	private static final long PAGE_LIST_COUNT = 5l;
	private final CivilVoiceService civilVoiceService;
	private final CivilVoiceCommentService civilVoiceCommentService;
	private final SimuServiceImpl simServiceImpl;

	public SimulationRestController(CivilVoiceService civilVoiceService, CivilVoiceCommentService civilVoiceCommentService, SimuServiceImpl simServiceImpl) {
		this.civilVoiceService = civilVoiceService;
		this.civilVoiceCommentService = civilVoiceCommentService;
		this.simServiceImpl = simServiceImpl;
	}

	@RequestMapping(value = "/select", method = RequestMethod.GET)
	@GetMapping(produces = MediaType.APPLICATION_JSON_VALUE)
	public Object select() {
		SimFileMaster sfm =  this.simServiceImpl.getSimFileMaster();
		String resultFullPath = sfm.getSave_file_path() + sfm.getSave_file_name();
		File fi = new File(resultFullPath.trim());
		try {
			ObjectMapper mapper = new ObjectMapper();
			InputStream targetStream = new FileInputStream(fi);
			return mapper.readValue(targetStream, Object.class);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
		// PROCESS...

	}

	@RequestMapping(value = "/upload", method = RequestMethod.POST)
	public List<String> upload(MultipartHttpServletRequest mReq) {
		Map<String, MultipartFile> fileMap = mReq.getFileMap();
		Collection<MultipartFile> mFileCollection = fileMap.values();

		MultipartFile[] files = mFileCollection.toArray(MultipartFile[]::new);

		String constructor = mReq.getParameter("constructor");
		String constructor_type = mReq.getParameter("constructor_type");
		String birthday = mReq.getParameter("birthday");
		String license_num = mReq.getParameter("license_num");
		String phone_number = mReq.getParameter("phone_number");

		structPermissionMapper.insertStructPermission(
				new StructPermission(constructor, constructor_type, birthday, license_num, phone_number));

		List<String> result = this.simServiceImpl.procStroeShp(files);
		return result;

	}



}
