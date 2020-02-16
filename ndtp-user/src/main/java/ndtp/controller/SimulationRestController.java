package ndtp.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.*;

import javax.servlet.http.HttpServletRequest;

import ndtp.domain.*;
import ndtp.persistence.StructPermissionMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;
import ndtp.service.CivilVoiceCommentService;
import ndtp.service.CivilVoiceService;
import ndtp.service.impl.SimuServiceImpl;
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
		String resultFullPath = sfm.getSaveFilePath() + sfm.getSaveFileName();
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

    @RequestMapping(value = "/cityPlanUpload", method = RequestMethod.POST)
    public List<String> upload(MultipartFile[] files) {
    	List<String> result = this.simServiceImpl.procStroeShp(files);
		return result;
        // PROCESS...
    }
    
    @RequestMapping(value = "/cityPlanSelect", method = RequestMethod.GET)
    @GetMapping(produces = MediaType.APPLICATION_JSON_VALUE)
    public Object cityPlanSelect() {
    	SimFileMaster sfm =  this.simServiceImpl.getSimFileMaster();
    	String resultFullPath = sfm.getSaveFilePath() + sfm.getSaveFileName();
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

		//todo: change
		StructPermission spObj = StructPermission.builder()
				.constructor(constructor)
				.constructorType(constructor_type)
				.permOfficer("ndtp")
				.birthday(birthday)
				.licenseNum(license_num)
				.phoneNumber(phone_number)
				.isComplete("N")
				.latitude("127.786754")
				.longitude("36.643957")
				.build();

		structPermissionMapper.insertStructPermission(spObj);

		List<String> result = this.simServiceImpl.procStroeShp(files);
		return result;
	}

	@RequestMapping(value = "/getPermRequest", method = RequestMethod.POST)
	public List<StructPermission> getPermRequest(HttpServletRequest request, StructPermission sp) {
		List<StructPermission> result = structPermissionMapper.selectStructPermission();
		System.out.println(result);

		return result;
	}
	@RequestMapping(value = "/getPermRequestByConstructor", method = RequestMethod.POST)
	public StructPermission getPermRequestByConstructor(HttpServletRequest request, StructPermission sp) {
		String is_complete = sp.getIsComplete();
		String constructor = sp.getConstructor();

		StructPermission oneResult = structPermissionMapper.selectOne(sp);
		System.out.println(oneResult);

		return oneResult;
	}
	@RequestMapping(value = "/updateStructPermission", method = RequestMethod.POST)
	public int updateStructPermission(HttpServletRequest req) {
		String suitableCheck = req.getParameter("suitableCheck");
		if (suitableCheck.equals("false")) {
			return 0;
		}

		StructPermission sp = StructPermission.builder()
				.constructor(req.getParameter("constructor"))
				.constructorType(req.getParameter("constructor_type"))
				.build();

		int result = structPermissionMapper.updateStructPermission(sp);
		System.out.println(result);

		return result;
	}

}
