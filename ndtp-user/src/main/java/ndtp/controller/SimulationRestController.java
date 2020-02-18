package ndtp.controller;

import java.io.*;
import java.nio.file.*;
import java.util.*;

import javax.servlet.http.HttpServletRequest;

import ndtp.domain.*;
import ndtp.persistence.StructPermissionMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
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
	String PREFIX_URL = "C:\\data\\mago3d\\normal-upload-data\\";
	String SAVE_PATH = "C:\\data\\mago3d\\normal-upload-data\\";

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
    }

    @RequestMapping(value = "/cityPlanModelSelect", method = RequestMethod.GET)
    @GetMapping(produces = MediaType.APPLICATION_JSON_VALUE)
    public Object cityPlanModelSelect(String FileName) {
//    	String resultFullPath = "C:\\data\\Apartment_Building_26_obj\\Apartment_Building_26_obj.gltf"; 
    	String resultFullPath = "C:\\data\\Apartment_Building_26_obj\\" + FileName; 
        File fi = new File(resultFullPath.trim());
        try {
            ObjectMapper mapper = new ObjectMapper();
            InputStream targetStream = new FileInputStream(fi);
            return mapper.readValue(targetStream, Object.class);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    @RequestMapping(value = "/cityPlanResultInsert", method = RequestMethod.POST)
    public List<String> cityPlanResultInsert(CityPlanResult cityPlanResult) {
    	List<String> result = this.simServiceImpl.procCityPlanResult(cityPlanResult);
		return result;
    }
    
	@RequestMapping(value = "/upload", method = RequestMethod.POST)
	public List<String> upload(MultipartHttpServletRequest mReq) {
		String os = System.getProperty("os.name").toLowerCase();
		if (os.contains("mac")) {
			PREFIX_URL = "/Users/junho/data/mago3d/";
			SAVE_PATH = "/Users/junho/data/mago3d/";
		}

		Map<String, MultipartFile> fileMap = mReq.getFileMap();
		Collection<MultipartFile> mFileCollection = fileMap.values();

		MultipartFile[] files = mFileCollection.toArray(MultipartFile[]::new);

		String originFileName = "";
		String saveFileName = "";
		for(MultipartFile mtf : files) {
			String fileName = mtf.getOriginalFilename();
			String extName = fileName.substring(fileName.lastIndexOf("."), fileName.length());
			if (extName.contains("pdf")) {
				originFileName = fileName;
				saveFileName = genSaveFileName(extName);
				try{
					writeFile(mtf, saveFileName, SAVE_PATH);
				} catch(Exception e) {
					e.printStackTrace();
				}
			}
		}

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
				.saveFilePath(SAVE_PATH)
				.saveFileName(saveFileName)
				.originFileName(originFileName)
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

	@RequestMapping(value = "/viewPdf", method = RequestMethod.POST)
	public String viewPdf(HttpServletRequest req) {
		String os = System.getProperty("os.name").toLowerCase();

		String projectPath = System.getProperty("user.dir");
		String fileName = req.getParameter("save_file_name");
		String oriFilePath = "";
		String copyFilePath = "";

		if (os.contains("mac")) {
			oriFilePath = "/Users/junho/data/mago3d/" + fileName;
			copyFilePath = projectPath + "/src/main/webapp/externlib/pdfjs/web/pdf_files/" + fileName;
		} else {
			oriFilePath = SAVE_PATH + fileName;
			copyFilePath = projectPath + "\\src\\main\\webapp\\externlib\\pdfjs\\web\\pdf_files\\" + fileName;
		}

		Path source = Paths.get(oriFilePath);
		Path target = Paths.get(copyFilePath);

		// 사전체크
		if (source == null) {
			throw new IllegalArgumentException("source must be specified");
		}
		if (target == null) {
			throw new IllegalArgumentException("target must be specified");
		}
		if (Files.exists(target)) {
			return fileName;
		}

		// 소스파일이 실제로 존재하는지 체크
		if (!Files.exists(source, new LinkOption[] {})) {
			throw new IllegalArgumentException("Source file doesn't exist: "
					+ source.toString());
		}

		try {
			Files.copy(source, target, StandardCopyOption.REPLACE_EXISTING); // 파일복사

		} catch (IOException e) {
			e.printStackTrace();
		}

//		Base64.Encoder encoder = Base64.getEncoder();
		if (Files.exists(target, new LinkOption[] {})) { // 파일이 정상적으로 생성이 되었다면
			// System.out.println("File Copied");
//			String a = encoder.encodeToString(fileName.getBytes());
//			return encoder.encodeToString(fileName.getBytes());
			return fileName;
		} else {
			System.out.println("File Copy Failed");
//			return encoder.encodeToString("false".getBytes());
			return "false";
		}

	}

	private String genSaveFileName(String extName) {
		String fileName = "";

		Calendar calendar = Calendar.getInstance();
		fileName += calendar.get(Calendar.YEAR);
		fileName += calendar.get(Calendar.MONTH);
		fileName += calendar.get(Calendar.DATE);
		fileName += calendar.get(Calendar.HOUR);
		fileName += calendar.get(Calendar.MINUTE);
		fileName += calendar.get(Calendar.SECOND);
		fileName += calendar.get(Calendar.MILLISECOND);
		fileName += extName;

		return fileName;
	}
	private boolean writeFile(MultipartFile multipartFile, String saveFileName, String SAVE_PATH) throws IOException{
		boolean result = false;

		this.genSaveFileName(SAVE_PATH);

		byte[] data = multipartFile.getBytes();
		FileOutputStream fos = new FileOutputStream(SAVE_PATH + "/" + saveFileName);
		fos.write(data);
		fos.close();

		return result;
	}
}
