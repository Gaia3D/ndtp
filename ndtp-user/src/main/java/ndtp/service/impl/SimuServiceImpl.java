package ndtp.service.impl;

import java.awt.image.BufferedImage;
import java.io.*;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

import javax.imageio.ImageIO;

import com.fasterxml.jackson.databind.ObjectMapper;
import ndtp.config.PropertiesConfig;
import ndtp.domain.*;
import ndtp.persistence.StructPermissionMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import ndtp.persistence.SimuMapper;

@Service
public class SimuServiceImpl {
	@Autowired
	private SimuMapper simuMapper;

	@Autowired
	private StructPermissionMapper structPermissionMapper;

	@Autowired
	private PropertiesConfig propertiesConfig;

	public SimFileMaster getSimFileMaster() {
		return this.simuMapper.getSimCityPlanFile();
	}

	@Transactional
	public List<String> procStroeShp(MultipartFile[] files, FileType ft) {
		String Path = "";
		List<String> result = new ArrayList<String>();
		for(MultipartFile mtf : files) {
			String Name = mtf.getOriginalFilename();
			result.add(this.restoreByStroeShp(mtf, ft));
		}
		return result;
	}

	/**
	 * 건설 공정 관리 프로세스
	 * @param sfm
	 * @return
	 */
	@Transactional
	public void procConstProc(SimFileMaster sfm) {
		String Path = "";

		Integer consRatio = sfm.getConsRatio();

		// 파일 저장 로직 절차
		//save file -> return array
		saveMultiFile(sfm.getFiles());

		// make f4d
		movedFinishFolder mff = runFileConvertProcess();

		List<SimFileMaster> fmeSimFileList = getFileListInFolder(mff.getMovedFinishOutputFolder());

		// dumi object
		// movedFinishFolder mff = new movedFinishFolder(propertiesConfig.getServiceF4dFinishRootDir(), propertiesConfig.getServiceF4dOutputDir(), propertiesConfig.getServiceF4dFailRootDir());
		List<SimFileMaster>  fmeSFM = fmeSimFileList.stream().filter(obj -> obj.getSaveFileName().contains(".json")).collect(Collectors.toList());
		for (SimFileMaster sfmObj : fmeSFM) {
			sfmObj.setConsType(getConsTypeByConsTypeString(sfm.getConsTypeString()));

			SimFileMaster obj = SimFileMaster.builder()
					.saveFilePath(sfmObj.getSaveFilePath())
					.saveFileName(sfmObj.getSaveFileName())
					.consRatio(consRatio)
					.consType(sfmObj.getConsType())
					.originFileName(sfmObj.getOriginFileName())
					.build();
			if (sfm.getCityTypeString().equals("s")) {
				obj.setSaveFileType(FileType.CONSTPROCSEJON);
			} else if(sfm.getSaveFileType().equals("p")) {
				obj.setSaveFileType(FileType.CONSTPROCBUSAN);
			}
			simuMapper.insertConsProcFile(obj);
		}
	}

	public List<SimFileMaster> getConsBuildList(SimFileMaster sfm) {
		return this.simuMapper.getSimMasterList(sfm);
	}

	public ConsType getConsTypeByConsTypeString(String consTypeString) {
		ConsType ct = null;
		if (consTypeString.equals("0")) {
			ct = ConsType.StepOne;
		} else if (consTypeString.equals("1")) {
			ct = ConsType.StepTwo;
		} else if  (consTypeString.equals("2")) {
			ct = ConsType.StepThree;
		} else if  (consTypeString.equals("3")) {
			ct = ConsType.StepFour;
		} else if  (consTypeString.equals("4")) {
			ct = ConsType.StepFive;
		} else if  (consTypeString.equals("5")) {
			ct = ConsType.StepSix;
		}
		return ct;
	}

	public FileType getCityTypeByCityTypeString(String cityTypeString) {
		FileType ft = null;
		if (cityTypeString.equals("s")) {
			ft = FileType.CONSTPROCSEJON;
		} else if (cityTypeString.equals("p")) {
			ft = FileType.CONSTPROCBUSAN;
		} else if (cityTypeString.equals("g")) {
			ft = FileType.CONSTPROCGEUMGANG;
		}
		return ft;
	}

	@Transactional
	public List<String> procCityPlanResult(CityPlanResult cpr) {
		String Path = "";
		List<String> result = new ArrayList<String>();

		result.add(this.restoreByImg(cpr, FileType.IMGFILE));
		return result;
	}

	public StructPermission procAcceptBuild(MultipartFile[] files, StructPermission spParam) {
		List<SimFileMaster> lsfm = saveMultiFile(files);

		movedFinishFolder mff = runFileConvertProcess();
		// dumi object
		// movedFinishFolder mff = new movedFinishFolder(propertiesConfig.getServiceF4dFinishRootDir(), propertiesConfig.getServiceF4dOutputDir(), propertiesConfig.getServiceF4dFailRootDir());
		List<SimFileMaster> simFileList = getFileListInFolder(mff.getMovedFinishOutputFolder());
		SimFileMaster sfm = simFileList.stream().filter(obj -> obj.getSaveFileName().contains(".json")).findAny().get();
		SimFileMaster sfmPDF = lsfm.stream().filter(obj -> obj.getSaveFileName().contains(".pdf")).findAny().get();

		// savedBuildingInfo
		StructPermission spObj = StructPermission.builder()
				.constructor(spParam.getConstructor())
				.constructorType(spParam.getConstructorType())
				.permOfficer("ndtp")
				.birthday(spParam.getBirthday())
				.licenseNum(spParam.getLicenseNum())
				.isComplete("N")
				.latitude(spParam.getLatitude())
				.longitude(spParam.getLongitude())
				.altitude(spParam.getAltitude())
				.heading(spParam.getHeading())
				.pitch(spParam.getPitch())
				.roll(spParam.getRoll())
				.saveFilePath(sfmPDF.getSaveFilePath())
				.saveFileName(sfmPDF.getSaveFileName())
				.saveModelFilePath(sfm.getSaveFilePath())
				.saveModelFileName(sfm.getSaveFileName())
				.build();
		int result = structPermissionMapper.insertStructPermission(spObj);
		StructPermission spNew = structPermissionMapper.selectNew(spObj);
		return spNew;
	}

	private List<SimFileMaster> saveMultiFile(MultipartFile[] files) {
		String originFileName = "";
		String saveFileName = "";
		String uploadDir = propertiesConfig.getServiceFileUploadDir();
		String f4dInputDir = propertiesConfig.getServiceF4dInputDir();
		cleanF4dInputFolder(f4dInputDir);

		// write files in uploadDir
		List<SimFileMaster> lsfm = new ArrayList<>();
		for(MultipartFile mtf : files) {
			String fileName = mtf.getOriginalFilename();
			String extName = fileName.substring(fileName.lastIndexOf("."), fileName.length());
			originFileName = fileName;
			saveFileName = genSaveFileName(extName);
			try{
				// Normal file saved uploadDir But IFC or Model Files is upload F4D InputFolder
				// Normal file => saved
				makeDir(uploadDir);
				writeFile(mtf, saveFileName, uploadDir);

				// if you are have model file moved process target Path
				if(saveFileName.contains(".ifc") || saveFileName.contains(".gml") || saveFileName.contains(".jpg") || saveFileName.contains(".png")  || saveFileName.contains(".3ds") || saveFileName.contains(".X") ) {
					Files.copy(new File(uploadDir + saveFileName).toPath(), new File(f4dInputDir + originFileName).toPath());
				}
				lsfm.add(SimFileMaster.builder().originFileName(originFileName).saveFilePath(uploadDir).saveFileName(saveFileName).build());
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return lsfm;
	}

	private void cleanF4dInputFolder(String f4dInputDir) {
		for( SimFileMaster obj : getFileListInFolder(f4dInputDir) ) {
			new File(obj.getSaveFilePath() + "/" + obj.getSaveFileName()).delete();
		}
	}

	private String restoreByStroeShp(MultipartFile multipartFile, FileType ft) {
		String url = null;
		String uploadDir = propertiesConfig.getServiceFileUploadDir();

		String os = System.getProperty("os.name").toLowerCase();
		if (os.contains("mac")) {
			uploadDir = "/Users/junho/data/mago3d/";
		}

		try {
			// 파일 정보
			String originFilename = multipartFile.getOriginalFilename();
			String extName = originFilename.substring(originFilename.lastIndexOf("."), originFilename.length());
			Long size = multipartFile.getSize();

			// 서버에서 저장 할 파일 이름
			String saveFileName = genSaveFileName(extName);

			System.out.println("originFilename : " + originFilename);
			System.out.println("extensionName : " + extName);
			System.out.println("saveFileName : " + saveFileName);

			if(ft == FileType.ECHODELTASHP) {
				this.writeFile(multipartFile, saveFileName, uploadDir);
				SimFileMaster sfm = SimFileMaster.builder()
						.originFileName(originFilename)
						.saveFileName(saveFileName)
						.saveFilePath(uploadDir)
						.saveFileType(ft)
						.build();
				int result = simuMapper.insertSimCityPlanFile(sfm);
			}
			url = uploadDir + saveFileName;
		}
		catch (IOException e) {
			// 원래라면 RuntimeException 을 상속받은 예외가 처리되어야 하지만
			// 편의상 RuntimeException을 던진다.
			// throw new FileUploadException();
			throw new RuntimeException(e);
		}
		return url;
	}

	private String restoreByImg(CityPlanResult cpr, FileType ft) {
		String url = null;
		String uploadDir = propertiesConfig.getServiceFileUploadDir();
		MultipartFile multipartFile = cpr.getFiles();

		String PREFIX_URL = "C:\\data\\mago3d\\normal-upload-data\\";
		String SAVE_PATH = "C:\\data\\mago3d\\normal-upload-data\\";

		String os = System.getProperty("os.name").toLowerCase();
		if (os.contains("mac")) {
			uploadDir = "/Users/junho/data/mago3d/";
			PREFIX_URL = "/Users/junho/data/mago3d/normal-upload-data/";
			SAVE_PATH = "/Users/junho/data/mago3d/normal-upload-data/";
		}

		try {
			// 파일 정보
			String originFilename = multipartFile.getOriginalFilename();
			String extName = originFilename.substring(originFilename.lastIndexOf("."), originFilename.length());
			Long size = multipartFile.getSize();

			// 서버에서 저장 할 파일 이름
			String saveFileName = genSaveFileName(extName);

			System.out.println("originFilename : " + originFilename);
			System.out.println("extensionName : " + extName);
			System.out.println("saveFileName : " + saveFileName);

			if (ft == FileType.IMGFILE) {
				// 도시계획 시뮬레이션 결과 저장
				this.writeImageFile(multipartFile, saveFileName, SAVE_PATH);

				SimFileMaster sfm = SimFileMaster.builder()
						.originFileName(originFilename)
						.saveFileName(saveFileName)
						.saveFilePath(SAVE_PATH)
						.saveFileType(ft)
						.build();
				simuMapper.insertSimCityPlanFile(sfm);
				cpr.setSimFileMasterImgNum(sfm.getSimFileSeq());
				simuMapper.insertSimCityPlanFileResult(cpr);
				
			}

			url = PREFIX_URL + saveFileName;
		}
		catch (IOException e) {
			// 원래라면 RuntimeException 을 상속받은 예외가 처리되어야 하지만
			// 편의상 RuntimeException을 던진다.
			// throw new FileUploadException();
			throw new RuntimeException(e);
		}
		return url;
	}

	// 현재 시간을 기준으로 파일 이름 생성
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
	
	// 파일을 실제로 write 하는 메서드
	private boolean writeFile(MultipartFile multipartFile, String saveFileName, String SAVE_PATH) throws IOException{
		boolean result = false;

		this.genSaveFileName(SAVE_PATH);

		byte[] data = multipartFile.getBytes();
		FileOutputStream fos = new FileOutputStream(SAVE_PATH + "/" + saveFileName);

		fos.write(data);
		fos.close();

		return result;
	}
	
	private boolean writeImageFile(MultipartFile multipartFile, String saveFileName, String SAVE_PATH) throws IOException{
		boolean result = false;

		this.genSaveFileName(SAVE_PATH);

		byte[] data = multipartFile.getBytes();
		int width = 512;
		int height = 512;

		ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(data);

		BufferedImage image = ImageIO.read(byteArrayInputStream);
		
		File outputFile = new File(SAVE_PATH + saveFileName);

		ImageIO.write(image, "png", outputFile);
		return result;
	}

	/**
	 * processing f4d converter using this method
	 * Processe the data in input folder
	 * send it to the output folder
	 */
	private movedFinishFolder runFileConvertProcess() {
		String FirstFolder = new SimpleDateFormat("yyyyMMddHHmmSS").format(new Date());

		String inputFolder = propertiesConfig.getServiceF4dInputDir();
		String outputFolder = propertiesConfig.getServiceF4dOutputDir();
		String movedFinsihInputFolder = propertiesConfig.getServiceF4dFinishRootDir() + FirstFolder + '\\' + "Input\\" ;
		String movedFinishOutputFolder = propertiesConfig.getServiceF4dFinishRootDir() + FirstFolder + '\\' + "Output\\" ;
		String movedFailFolder = propertiesConfig.getServiceF4dFailRootDir() + FirstFolder + '\\' ;
		String f4dExeRunPath = propertiesConfig.getServiceF4dRunDir();
		try {
			makeDir(inputFolder);
			makeDir(outputFolder);
			makeDir(movedFinsihInputFolder);
			makeDir(movedFinishOutputFolder);
			makeDir(movedFailFolder);

			if(procF4DProcess(inputFolder, outputFolder, f4dExeRunPath)) {
				move(new File(inputFolder), new File(movedFinsihInputFolder));
				move(new File(outputFolder), new File(movedFinishOutputFolder));
			} else {
				move(new File(inputFolder), new File(movedFailFolder));
				move(new File(outputFolder), new File(movedFailFolder));
			}
		} catch(Exception e) {
			move(new File(inputFolder), new File(movedFailFolder));
			move(new File(outputFolder), new File(movedFailFolder));
		}
		return new movedFinishFolder(movedFinsihInputFolder, movedFinishOutputFolder, movedFailFolder);
	}

	/**
	 * get FileList in Foler
	 * return result this.
	 * FileType => File, Directory
	 * list File Path with FileName
	 *
	 * @param folderPath
	 * @return retunr SimFileMaster FileData
	 */
	private List<SimFileMaster> getFileListInFolder(String folderPath) {
		File path = new File(folderPath);
		File[] fileList = path.listFiles();
		ArrayList<SimFileMaster> resultList = new ArrayList<>();
		for(File f: fileList){
			String str = f.getName();
			if(f.isDirectory()) { // is Directory
				System.out.print(str+"\t");
				System.out.print("DIR\n");
				resultList.add(new SimFileMaster().builder().saveFileType(FileType.DIRECTORY).saveFilePath(folderPath).saveFileName(str).build());
			}else { // is File
				System.out.print(str+"\t");
				System.out.print("Files\n");
				resultList.add(new SimFileMaster().builder().saveFileType(FileType.FILE).saveFilePath(folderPath).saveFileName(str).build());
			}
		}
		return resultList;
	}

	private RelativePathItem[] getJsonByRelationFile(String fullPath) throws IOException{
		ObjectMapper objectMapper = new ObjectMapper();
		File file = new File(fullPath);
		Scanner scan = new Scanner(file);
		String resultJson = "";
		while(scan.hasNextLine()){
			resultJson += scan.nextLine();
		}
		RelativePathItem[] myObjects = objectMapper.readValue(resultJson, RelativePathItem[].class);
		return myObjects;
	}

	private LonsLatsItem[] getJsonByLonsLatsFile(String fullPath) throws IOException{
		ObjectMapper objectMapper = new ObjectMapper();
		File file = new File(fullPath);
		Scanner scan = new Scanner(file);
		String resultJson = "";
		while(scan.hasNextLine()){
			resultJson += scan.nextLine();
		}
		LonsLatsItem[] myObjects = objectMapper.readValue(resultJson, LonsLatsItem[].class);
		return myObjects;
	}

	private boolean procF4DProcess(String inputFolder, String outputFolder, String F4DRunPath) throws  IOException, InterruptedException{
		Process pc = null;
		boolean result = false;
		String LogFolder = "";
		SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddhhmmss");
		String logFileName = sf.format(new Date()) + ".txt";
		String logFullPath = outputFolder + logFileName;
		String Option = "#meshType 0 #indexing y";

		F4DRunPath = F4DRunPath + " #inputFolder " + inputFolder + " #outputFolder " + outputFolder + " #log " + logFullPath + " " + Option;
		System.out.println(F4DRunPath);

		try {
			String cmdStr = F4DRunPath;

			pc = Runtime.getRuntime().exec(cmdStr);
			System.out.println("RunProcF4D");
			// any error message?
			StreamGobbler errorGobbler = new
					StreamGobbler(pc.getErrorStream(), "ERROR");

			// any output?
			StreamGobbler outputGobbler = new
					StreamGobbler(pc.getInputStream(), "OUTPUT");

			// kick them off
			errorGobbler.start();
			outputGobbler.start();

			// any error???
			int exitVal = pc.waitFor();
			System.out.println("ExitValue: " + exitVal);
			System.out.println("Process exitValue: " + exitVal);
		} catch (IOException e) {
			e.printStackTrace();
			throw new Error("IFC 파일 처리에 실패했습니다");
		} finally {
			pc.destroy();
		}
		return true;
	}

	private ConsDataInfo getConsDataInfoByName(ConsDataInfo sfm) {
		return this.simuMapper.getConsDataInfo(sfm);
	}

	public F4DObject procF4DDataStrucreByPaths(String modelFilePath, String modelFileName) throws IOException {
		F4DSubObject subF4dObj;
		List<F4DSubObject> f4dSubObjectList = new ArrayList<>();
		// if you are process citygml you have longlats, others data don't have this file
		if(modelFileName.contains("lonsLats")) {
			LonsLatsItem[] lli = getJsonByLonsLatsFile(modelFilePath + modelFileName);
			for(LonsLatsItem lliObj : lli) {
				subF4dObj = new F4DSubObject().builder()
						.data_key(lliObj.getData_key())
						.data_name(lliObj.getData_key())
						.longitude(lliObj.getLongitude())
						.latitude(lliObj.getLatitude())
						.height(0.0f)
						.heading(0.0f)
						.pitch(0.0f)
						.roll(0.0f)
						.build();
				f4dSubObjectList.add(subF4dObj);
			}
		} else {
			RelativePathItem[] rp = getJsonByRelationFile(modelFilePath + modelFileName);

			for(RelativePathItem rpObj : rp) {
				var keyName = rpObj.getData_key();
				ConsDataInfo consDataInfo = this.getConsDataInfoByName(ConsDataInfo.builder().dataName(keyName).build());
				if(consDataInfo != null) {
					subF4dObj = new F4DSubObject().builder()
							.data_key(rpObj.getData_key())
							.data_name(rpObj.getData_key())
							.longitude(consDataInfo.getLon())
							.latitude(consDataInfo.getLat())
							.height(consDataInfo.getAlt())
							.heading(consDataInfo.getHeading())
							.pitch(consDataInfo.getPitch())
							.roll(consDataInfo.getRoll())
							.ratio(consDataInfo.getRatio())
							.build();
				} else {
					String dataKey = rp[0].getData_key();
					subF4dObj = new F4DSubObject().builder().data_key(dataKey).data_name(dataKey).build();
					f4dSubObjectList.add(subF4dObj);
				}

				f4dSubObjectList.add(subF4dObj);
			}
		}
		String[] pathArr = null;

		String os = System.getProperty("os.name").toLowerCase();
		if (os.contains("mac")) {
			pathArr = modelFilePath.split("/");
		} else {
			pathArr = modelFilePath.split("\\\\");
		}

		boolean startFlat = false;
		String f4dDataKey = "";
		List<String> f4dKeyGenObj = new ArrayList<>();
		for ( String str : pathArr ) {
			if(str.equals("f4d")) {
				startFlat = true;
			} else {
				if(startFlat){
					f4dKeyGenObj.add(str);
				}
			}
		}

		for ( String str : f4dKeyGenObj ) {
			if (os.contains("mac")) {
				f4dDataKey = f4dDataKey + "/" + str;
			} else {
				f4dDataKey = f4dDataKey + "\\\\" + str;
			}
		}
		if (os.contains("mac")) {
			f4dDataKey = f4dDataKey.substring(1);
		} else {
			f4dDataKey = f4dDataKey.substring(2);
		}

		F4DObject f4dObject = new F4DObject();
		f4dObject.setF4dSubList(f4dSubObjectList);
		f4dObject.setData_key(f4dDataKey);
		f4dObject.setData_name(f4dDataKey);

		return f4dObject;
	}

	private boolean makeDir(String source) throws IOException {
		File dir = new File(source);
		if(!(dir.isDirectory())){
			dir.mkdirs();
			return false;
		} else {
			return true;
		}
	}

	public void move(File sourceF, File targetF) {
		copy(sourceF, targetF);
		delete(sourceF.getPath());
	}

	public void copy(File sourceF, File targetF){
		File[] target_file = sourceF.listFiles();
		for (File file : target_file) {
			File temp = new File(targetF.getAbsolutePath() + File.separator + file.getName());
			if(file.isDirectory()){
				temp.mkdirs();
				copy(file, temp);
			} else {
				FileInputStream fis = null;
				FileOutputStream fos = null;
				try {
					fis = new FileInputStream(file);
					fos = new FileOutputStream(temp) ;
					byte[] b = new byte[4096];
					int cnt = 0;
					while((cnt=fis.read(b)) != -1){
						fos.write(b, 0, cnt);
					}
				} catch (Exception e) {
					e.printStackTrace();
				} finally{
					try {
						fis.close();
						fos.close();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}

				}
			}
		}
	}

	public void delete(String path) {
		File folder = new File(path);
		try {
			if(folder.exists()){
				File[] folder_list = folder.listFiles();

				for (int i = 0; i < folder_list.length; i++) {
					if(folder_list[i].isFile()) {
						folder_list[i].delete();
					}else {
						delete(folder_list[i].getPath());
					}
					folder_list[i].delete();
				}
			}
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
}

class StreamGobbler extends Thread
{
	InputStream is;
	String type;

	StreamGobbler(InputStream is, String type)
	{
		this.is = is;
		this.type = type;
	}

	public void run()
	{
		try
		{
			InputStreamReader isr = new InputStreamReader(is);
			BufferedReader br = new BufferedReader(isr);
			String line=null;
			while ( (line = br.readLine()) != null)
				System.out.println(type + ">" + line);
		} catch (IOException ioe)
		{
			ioe.printStackTrace();
		}
	}
}