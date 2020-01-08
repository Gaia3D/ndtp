package ndtp.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Callable;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import lombok.extern.slf4j.Slf4j;
import ndtp.config.PropertiesConfig;
import ndtp.domain.DataGroup;
import ndtp.domain.DataType;
import ndtp.domain.FileType;
import ndtp.domain.Key;
import ndtp.domain.PageType;
import ndtp.domain.Pagination;
import ndtp.domain.Policy;
import ndtp.domain.UploadData;
import ndtp.domain.UploadDataFile;
import ndtp.domain.UploadDirectoryType;
import ndtp.domain.UserSession;
import ndtp.service.DataGroupService;
import ndtp.service.PolicyService;
import ndtp.service.UploadDataService;
import ndtp.utils.DateUtils;
import ndtp.utils.FileUtils;
import ndtp.utils.FormatUtils;

/**
 * 3D 데이터 파일 업로더
 * TODO 설계 파일 안의 texture 의 경우 설계 파일에서 참조하는 경우가 있으므로 이름 변경 불가.
 * @author jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/upload-data/")
public class UploadDataController {
	
	// 파일 copy 시 버퍼 사이즈
	public static final int BUFFER_SIZE = 8192;
	
	@Autowired
	private DataGroupService dataGroupService;
	
	@Autowired
	private PolicyService policyService;
	
	@Autowired
	private PropertiesConfig propertiesConfig;
	
	@Autowired
	private UploadDataService uploadDataService;
	
	/**
	 * 데이터 upload 화면
	 * @param model
	 * @return
	 */
	@GetMapping(value = "input")
	public String input(HttpServletRequest request, Model model) {
		
		DataGroup basicDataGroup = dataGroupService.getBasicDataGroup();
		
		UploadData uploadData = UploadData.builder().
											dataGroupId(basicDataGroup.getDataGroupId()).
											dataGroupName(basicDataGroup.getDataGroupName()).build();
		List<DataGroup> dataGroupList = dataGroupService.getListDataGroup();
		
		model.addAttribute("uploadData", uploadData);
		model.addAttribute("dataGroupList", dataGroupList);
		
		return "/upload-data/input";
	}
	
	/**
	 * TODO 비동기로 처리해야 할듯
	 * data upload 처리
	 * @param model
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@PostMapping(value = "insert")
	@ResponseBody
	public Callable<Map<String, Object>> insert(MultipartHttpServletRequest request) {
		return () -> {
			// TODO 파일 목록에 zip 파일이 포함되어 있는 경우 어떻게 가져갈지
			
			Map<String, Object> result = new HashMap<>();
			int statusCode = 0;
			String errorCode = null;
			String message = null;
			try {
				Policy policy = policyService.getPolicy();
				// 여긴 null 체크를 안 하는게 맞음. 없음 장애가 나야 함
				String[] uploadTypes = policy.getUserUploadType().toLowerCase().split(",");
				List<String> possibleExtList = Arrays.asList(uploadTypes);
				
				errorCode = dataValidate(request);
				if(!StringUtils.isEmpty(errorCode)) {
					log.info("@@@@@@@@@@@@ errorCode = {}", errorCode);
					result.put("statusCode", HttpStatus.BAD_REQUEST.value());
					result.put("errorCode", errorCode);
					result.put("message", message);
		            return result;
				}
				
				UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
				String userId = userSession.getUserId();
				List<UploadDataFile> uploadDataFileList = new ArrayList<>();
				Map<String, MultipartFile> fileMap = request.getFileMap();
				
				Map<String, Object> uploadMap = null;
				String today = DateUtils.getToday(FormatUtils.YEAR_MONTH_DAY_TIME14);
				
				// 1 directory 생성
				String makedDirectory = FileUtils.makeDirectory(userId, UploadDirectoryType.YEAR_MONTH, propertiesConfig.getUploadDataDir());
				log.info("@@@@@@@ = {}", makedDirectory);
				
				// 2 한건이면서 zip 의 경우
				boolean isZipFile = false;
				int fileCount = fileMap.values().size();
				if(fileCount == 1) {
					// processAsync(policy, userId, fileMap, makedDirectory);
					for (MultipartFile multipartFile : fileMap.values()) {
						String[] divideNames = multipartFile.getOriginalFilename().split("\\.");
						String fileExtension = divideNames[divideNames.length - 1];
						if(UploadData.ZIP_EXTENSION.equals(fileExtension.toLowerCase())) {
							isZipFile = true;
							// zip 파일
							uploadMap = unzip(policy, possibleExtList, today, userId, multipartFile, makedDirectory);
							
							// validation 체크
							if(uploadMap.containsKey("errorCode")) {
								errorCode = (String)uploadMap.get("errorCode");
								log.info("@@@@@@@@@@@@ errorCode = {}", errorCode);
								result.put("statusCode", HttpStatus.BAD_REQUEST.value());
								result.put("errorCode", errorCode);
								result.put("message", message);
					            return result;
							}
							
							uploadDataFileList = (List<UploadDataFile>)uploadMap.get("uploadDataFileList");
						}
					}
				}
				
				if(!isZipFile) {
					// 3 그 외의 경우는 재귀적으로 파일 복사
					for (MultipartFile multipartFile : fileMap.values()) {
						log.info("@@@@@@@@@@@@@@@ name = {}, original_name = {}", multipartFile.getName(), multipartFile.getOriginalFilename());
						
						UploadDataFile uploadDataFile = new UploadDataFile();
						Boolean converterTarget = false;
						
						// 파일 기본 validation 체크
						errorCode = fileValidate(policy, possibleExtList, multipartFile);
						if(!StringUtils.isEmpty(errorCode)) {
							log.info("@@@@@@@@@@@@ errorCode = {}", errorCode);
							result.put("statusCode", HttpStatus.BAD_REQUEST.value());
							result.put("errorCode", errorCode);
							result.put("message", message);
				            return result;
						}
						
						String originalName = multipartFile.getOriginalFilename();
						String[] divideFileName = originalName.split("\\.");
	        			String saveFileName = userId + "_" + today + "_" + System.nanoTime();
	        			String tempDirectory = userId + "_" + System.nanoTime();
	        			String extension = null;
	        			if(divideFileName != null && divideFileName.length != 0) {
	        				extension = divideFileName[divideFileName.length - 1];
	        				if(UploadData.ZIP_EXTENSION.equals(extension.toLowerCase())) {
	        					log.info("@@@@@@@@@@@@ upload.file.type.invalid");
	        					result.put("statusCode", HttpStatus.BAD_REQUEST.value());
								result.put("errorCode", "upload.file.type.invalid");
								result.put("message", message);
					            return result;
	        				}
	        				
	        				if(possibleExtList.contains(extension)) {
	        					saveFileName = saveFileName + "." + extension;
	        					converterTarget = true;
	        				} else {
	        					saveFileName = originalName;
	        				}
	        			}
	        			
						// 파일을 upload 디렉토리로 복사
						FileUtils.makeDirectory(makedDirectory + tempDirectory);
	        			long size = 0L;
						try (	InputStream inputStream = multipartFile.getInputStream();
								OutputStream outputStream = new FileOutputStream(makedDirectory + tempDirectory + File.separator + saveFileName)) {
						
							int bytesRead = 0;
							byte[] buffer = new byte[BUFFER_SIZE];
							while ((bytesRead = inputStream.read(buffer, 0, BUFFER_SIZE)) != -1) {
								size += bytesRead;
								outputStream.write(buffer, 0, bytesRead);
							}
						
							uploadDataFile.setFileType(FileType.FILE.name());
							uploadDataFile.setFileExt(extension);
	            			uploadDataFile.setFileName(multipartFile.getOriginalFilename());
	            			uploadDataFile.setFileRealName(saveFileName);
	            			uploadDataFile.setFilePath(makedDirectory + tempDirectory + File.separator);
	            			uploadDataFile.setFileSubPath(tempDirectory);
	            			uploadDataFile.setFileSize(String.valueOf(size));
	            			uploadDataFile.setConverterTarget(converterTarget);
	            			uploadDataFile.setDepth(1);
						} catch(Exception e) {
							e.printStackTrace();
							log.info("@@@@@@@@@@@@ upload.file.type.invalid");
        					result.put("statusCode", HttpStatus.INTERNAL_SERVER_ERROR.value());
							result.put("errorCode", "file.copy.exception");
							result.put("message", message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage());
				            return result;
						}
	
						uploadDataFileList.add(uploadDataFile);
			        }
				}
	
				UploadData uploadData = new UploadData();
				uploadData.setDataName(request.getParameter("dataName"));
				uploadData.setDataGroupId(Integer.valueOf(request.getParameter("dataGroupId")));
				uploadData.setSharing(request.getParameter("sharing"));
				uploadData.setDataType(request.getParameter("dataType"));
				//uploadData.setLocation("POINT(" + request.getParameter("longitude") + " " + request.getParameter("latitude") + ")");
				uploadData.setUserId(userId);
				if(request.getParameter("latitude") != null && !"".equals(request.getParameter("latitude"))
						&& request.getParameter("longitude") != null && !"".equals(request.getParameter("longitude"))) {
					uploadData.setLatitude(new BigDecimal(request.getParameter("latitude")) );
					uploadData.setLongitude(new BigDecimal(request.getParameter("longitude")) );
					uploadData.setAltitude(new BigDecimal(request.getParameter("altitude")) );
				}
				uploadData.setDescription(request.getParameter("description"));
				uploadData.setFileCount(uploadDataFileList.size());
				
				uploadDataService.insertUploadData(uploadData, uploadDataFileList);       
			} catch(Exception e) {
				e.printStackTrace();
				statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
				errorCode = "db.exception";
				message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
			}
			
			result.put("statusCode", statusCode);
			result.put("errorCode", errorCode);
			result.put("message", message);
			
			return result;
		};
	}
	
	/**
	 * 업로딩 파일을 압축 해제
	 * @param policy
	 * @param possibleExtList
	 * @param today
	 * @param userId
	 * @param multipartFile
	 * @param targetDirectory
	 * @return
	 * @throws Exception
	 */
	private Map<String, Object> unzip(Policy policy, List<String> possibleExtList, String today, String userId, MultipartFile multipartFile, String targetDirectory) throws Exception {
		Map<String, Object> result = new HashMap<>();
		String errorCode = fileValidate(policy, possibleExtList, multipartFile);
		if(!StringUtils.isEmpty(errorCode)) {
			result.put("errorCode", errorCode);
			return result;
		}
		
		// input directory 생성
		targetDirectory = targetDirectory + userId + "_" + System.nanoTime() + File.separator;
		FileUtils.makeDirectory(targetDirectory);
		
		List<UploadDataFile> uploadDataFileList = new ArrayList<>();
		
		File uploadedFile = new File(targetDirectory + multipartFile.getOriginalFilename());
		multipartFile.transferTo(uploadedFile);
		
		try ( ZipFile zipFile = new ZipFile(uploadedFile);) {
//			String saveFileName = userId + "_" + today + "_" + System.nanoTime() + "." + fileInfo.getFile_ext();
//			long size = 0L;
//			InputStream inputStream = multipartFile.getInputStream();
//			fileInfo.setFile_real_name(saveFileName);
//			fileInfo.setFile_size(String.valueOf(size));
//			fileInfo.setFile_path(sourceDirectory);
			
			String directoryPath = targetDirectory;
			String subDirectoryPath = "";
			String directoryName = null;
			int depth = 1;
			Enumeration<? extends ZipEntry> entries = zipFile.entries();
			while( entries.hasMoreElements() ) {
            	UploadDataFile uploadDataFile = new UploadDataFile();
            	
            	ZipEntry entry = entries.nextElement();
            	String unzipfileName = targetDirectory + entry.getName();
            	Boolean converterTarget = false;
            	if( entry.isDirectory() ) {
            		uploadDataFile.setFileType(FileType.DIRECTORY.name());
            		if(directoryName == null) {
            			uploadDataFile.setFileName(entry.getName());
            			uploadDataFile.setFileRealName(entry.getName());
            			directoryName = entry.getName();
            			directoryPath = directoryPath + directoryName;
            			//subDirectoryPath = directoryName;
            		} else {
            			String fileName = entry.getName().substring(entry.getName().indexOf(directoryName) + directoryName.length());  
            			uploadDataFile.setFileName(fileName);
            			uploadDataFile.setFileRealName(fileName);
            			directoryName = fileName;
            			directoryPath = directoryPath + fileName;
            			subDirectoryPath = fileName;
            		}
            		
                	File file = new File(unzipfileName);
                    file.mkdirs();
                    uploadDataFile.setFilePath(directoryPath);
                    uploadDataFile.setFileSubPath(subDirectoryPath);
                    uploadDataFile.setDepth(depth);
                    depth++;
            	} else {
            		String fileName = null;
            		String extension = null;
            		String[] divideFileName = null;
            		String saveFileName = null;
            		if(directoryName == null) {
            			fileName = entry.getName();
            			divideFileName = fileName.split("\\.");
            			saveFileName = fileName;
            			if(divideFileName != null && divideFileName.length != 0) {
            				extension = divideFileName[divideFileName.length - 1];
            				if(possibleExtList.contains(extension)) {
            					saveFileName = userId + "_" + today + "_" + System.nanoTime() + "." + extension;
            					converterTarget = true;
	        				}
            			}
            		} else {
            			fileName = entry.getName().substring(entry.getName().indexOf(directoryName) + directoryName.length());  
            			divideFileName = fileName.split("\\.");
            			saveFileName = fileName;
            			if(divideFileName != null && divideFileName.length != 0) {
            				extension = divideFileName[divideFileName.length - 1];
            				if(possibleExtList.contains(extension)) {
            					saveFileName = userId + "_" + today + "_" + System.nanoTime() + "." + extension;
            					converterTarget = true;
	        				}
            			}
            		}
            		
                	try ( 	InputStream inputStream = zipFile.getInputStream(entry);
                			FileOutputStream outputStream = new FileOutputStream(directoryPath + saveFileName); ) {
                		int data = inputStream.read();
                		while(data != -1){
                			outputStream.write(data);
                            data = inputStream.read();
                        }
                		
                		uploadDataFile.setFileType(FileType.FILE.name());
                		uploadDataFile.setFileExt(extension);
                		uploadDataFile.setFileName(fileName);
                		uploadDataFile.setFileRealName(saveFileName);
                		uploadDataFile.setFilePath(directoryPath);
                		uploadDataFile.setFileSubPath(subDirectoryPath);
                		uploadDataFile.setDepth(depth);
                    } catch(Exception e) {
                    	e.printStackTrace();
                    	uploadDataFile.setErrorMessage(e.getMessage());
                    }
                }
            	uploadDataFile.setConverterTarget(converterTarget);
            	uploadDataFile.setFileSize(String.valueOf(entry.getSize()));
            	uploadDataFileList.add(uploadDataFile);
            }
		} catch(IOException ex) {
			ex.printStackTrace(); 
		}
		
		result.put("uploadDataFileList", uploadDataFileList);
		return result;
	}
	
	/**
	 * 업로딩 파일 목록
	 * @param request
	 * @param uploadData
	 * @param pageNo
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "list")
	public String list(HttpServletRequest request, UploadData uploadData, @RequestParam(defaultValue="1") String pageNo, Model model) {
		log.info("@@ uploadData = {}", uploadData);
		
//		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
//		uploadData.setUserId(userSession.getUserId());
		
		String today = DateUtils.getToday(FormatUtils.YEAR_MONTH_DAY);
		if(StringUtils.isEmpty(uploadData.getStartDate())) {
			uploadData.setStartDate(today.substring(0,4) + DateUtils.START_DAY_TIME);
		} else {
			uploadData.setStartDate(uploadData.getStartDate().substring(0, 8) + DateUtils.START_TIME);
		}
		if(StringUtils.isEmpty(uploadData.getEndDate())) {
			uploadData.setEndDate(today + DateUtils.END_TIME);
		} else {
			uploadData.setEndDate(uploadData.getEndDate().substring(0, 8) + DateUtils.END_TIME);
		}
		
		long totalCount = uploadDataService.getUploadDataTotalCount(uploadData);
		
		Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(PageType.LIST, uploadData), totalCount, Long.valueOf(pageNo).longValue());
		log.info("@@ pagination = {}", pagination);
		
		uploadData.setOffset(pagination.getOffset());
		uploadData.setLimit(pagination.getPageRows());
		List<UploadData> uploadDataList = new ArrayList<>();
		if(totalCount > 0l) {
			uploadDataList = uploadDataService.getListUploadData(uploadData);
		}
		
		model.addAttribute(pagination);
		model.addAttribute("uploadDataList", uploadDataList);
		
		return "/upload-data/list";
	}
	
	/**
	 * @param policy
	 * @param multipartFile
	 * @return
	 */
	private static String fileValidate(Policy policy, List<String> possibleExtList, MultipartFile multipartFile) {
		
		// 2 파일 이름
		String fileName = multipartFile.getOriginalFilename();
		if(fileName == null) {
			log.info("@@ fileName is null");
			return "file.name.invalid";
		} else if(fileName.indexOf("..") >= 0 || fileName.indexOf("/") >= 0) {
			// TODO File.seperator 정규 표현식이 안 먹혀서 이렇게 처리함
			log.info("@@ fileName = {}", fileName);
			return "file.name.invalid";
		}
		
		// 3 파일 확장자
		String[] fileNameValues = fileName.split("\\.");
//		if(fileNameValues.length != 2) {
//			log.info("@@ fileNameValues.length = {}, fileName = {}", fileNameValues.length, fileName);
//			uploadLog.setError_code("fileinfo.name.invalid");
//			return uploadLog;
//		}
//		if(fileNameValues[0].indexOf(".") >= 0 || fileNameValues[0].indexOf("..") >= 0) {
//			log.info("@@ fileNameValues[0] = {}", fileNameValues[0]);
//			uploadLog.setError_code("fileinfo.name.invalid");
//			return uploadLog;
//		}
		// LowerCase로 비교
		String extension = fileNameValues[fileNameValues.length - 1];
		
		if(!possibleExtList.contains(extension.toLowerCase())) {
			log.info("@@ possibleExtList = {}, extension = {}", possibleExtList, extension);
			return "file.ext.invalid";
		}
		
		// 4 파일 사이즈
		// TODO 파일은 사이즈가 커서 제한을 해야 할지 의문?
		long fileSize = multipartFile.getSize();
		log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@ user upload file size = {} KB", (fileSize / 1000));
		if( fileSize > (policy.getUserUploadMaxFilesize() * 1000000l)) {
			log.info("@@ fileSize = {}, user upload max filesize = {} M", (fileSize / 1000), policy.getUserUploadMaxFilesize());
			return "file.size.invalid";
		}
		
		return null;
	}
	
	/**
	 * 데이터 upload 수정
	 * @param model
	 * @return
	 */
	@GetMapping(value = "modify")
	public String modify(HttpServletRequest request, UploadData uploadData, Model model) {
		
//		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
//		uploadData.setUserId(userSession.getUserId());
		
		uploadData = uploadDataService.getUploadData(uploadData);
		List<UploadDataFile> uploadDataFileList = uploadDataService.getListUploadDataFile(uploadData);
		
		model.addAttribute("uploadData", uploadData);
		model.addAttribute("uploadDataFileList", uploadDataFileList);
		return "/upload-data/modify";
	}
	
	/**
	 * 선택 upload-data 삭제
	 * @param request
	 * @param checkIds
	 * @param model
	 * @return
	 */
	@PostMapping(value = "delete")
	@ResponseBody
	public Map<String, Object> deleteDatas(HttpServletRequest request, @RequestParam("checkIds") String checkIds) {
		
		log.info("@@@@@@@ checkIds = {}", checkIds);
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		try {
			if(checkIds.length() <= 0) {
				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
				result.put("errorCode", "check.value.required");
				result.put("message", message);
	            return result;
			}
			
			UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
			
			uploadDataService.deleteUploadDatas(userSession.getUserId(), checkIds);
		} catch(Exception e) {
			e.printStackTrace();
			statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
			errorCode = "db.exception";
			message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
		}
		
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		
		return result;
	}
	
	/**
	 * validation 체크
	 * @param request
	 * @return
	 */
	private String dataValidate(MultipartHttpServletRequest request) {
		
		if(StringUtils.isEmpty(request.getParameter("dataName"))) {
			return "data.name.empty";
		}
		if(StringUtils.isEmpty(request.getParameter("dataGroupId"))) {
			return "data.group.id.empty";
		}
		if(StringUtils.isEmpty(request.getParameter("sharing"))) {
			return "data.sharing.empty";
		}
		
		String dataType = request.getParameter("dataType");
		if(StringUtils.isEmpty(dataType)) {
			return "data.type.empty";
		}
		
		// citygml, indoorgml 의 경우 위도, 경도, 높이를 포함하고 있어서 validation 체크를 하지 않음
		if(!dataType.equals(DataType.CITYGML.getValue()) && !dataType.equals(DataType.INDOORGML.getValue())) {
			if(StringUtils.isEmpty(request.getParameter("latitude"))) {
				return "data.latitude.empty";
			}
			if(StringUtils.isEmpty(request.getParameter("longitude"))) {
				return "data.longitude.empty";
			}
			if(StringUtils.isEmpty(request.getParameter("height"))) {
				return "data.altitude.empty";
			}
		}
		
		Map<String, MultipartFile> fileMap = request.getFileMap();
		if(fileMap.isEmpty()) {
			return "data.file.empty";
		}
		
		return null;
	}
//	
//	/**
//	 * 최근 upload-data
//	 * @param request
//	 * @return
//	 */
//	@RequestMapping(value = "ajax-upload-data-widget.do")
//	@ResponseBody
//	public Map<String, Object> uploadDataWidget(HttpServletRequest request) {
//		
//		log.info(" >>>>>>>>>>>>>>>>>>>>>>>>>>>> uploadDataWidget");
//		Map<String, Object> result = new HashMap<>();
//		int statusCode = 0;
//		String errorCode = null;
//		String message = null;
//		try {
//			UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
//			
//			UploadData uploadData = new UploadData();
//			uploadData.setUser_id(userSession.getUser_id());
//			uploadData.setOffset(0l);
//			uploadData.setLimit(10l);
//			List<UploadData> uploadDataList = uploadDataService.getListUploadData(uploadData);
//			
//			map.put("uploadDataList", uploadDataList);
//			map.put("uploadDataListSize", uploadDataList.size());
//		} catch(Exception e) {
//			e.printStackTrace();
//			result = "db.exception";
//		}
//		
//		map.put("result", result);
//		return map;
//	}
//	
//	/**
//	 * 최근 upload-data
//	 * @param request
//	 * @return
//	 */
//	@RequestMapping(value = "ajax-upload-data-count-widget.do")
//	@ResponseBody
//	public Map<String, Object> uploadDataCountWidget(HttpServletRequest request) {
//		
//		log.info(" >>>>>>>>>>>>>>>>>>>>>>>>>>>> uploadDataCountWidget");
//		Map<String, Object> result = new HashMap<>();
//		int statusCode = 0;
//		String errorCode = null;
//		String message = null;
//		try {
//			UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
//			
//			UploadDataFile uploadDataFile = new UploadDataFile();
//			uploadDataFile.setUser_id(userSession.getUser_id());
//			Long uploadDataTotalCount = uploadDataService.getUploadDataFileTotalCount(uploadDataFile);
//			
//			map.put("uploadDataTotalCount", uploadDataTotalCount);
//		} catch(Exception e) {
//			e.printStackTrace();
//			result = "db.exception";
//		}
//		
//		map.put("result", result);
//		return map;
//	}
//	
//	/**
//	 * 최근 upload-data
//	 * @param request
//	 * @return
//	 */
//	@RequestMapping(value = "ajax-upload-data-size-widget.do")
//	@ResponseBody
//	public Map<String, Object> uploadDataSizeWidget(HttpServletRequest request) {
//		
//		log.info(" >>>>>>>>>>>>>>>>>>>>>>>>>>>> uploadDataSizeWidget");
//		Map<String, Object> result = new HashMap<>();
//		int statusCode = 0;
//		String errorCode = null;
//		String message = null;
//		try {
//			UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
//			
//			UploadDataFile uploadDataFile = new UploadDataFile();
//			uploadDataFile.setUser_id(userSession.getUser_id());
//			Long uploadDataTotalSize = uploadDataService.getUploadDataFileTotalSize(uploadDataFile);
//			if(uploadDataTotalSize == null) {
//				uploadDataTotalSize = 0l;
//			} else {
//				uploadDataTotalSize = uploadDataTotalSize/1000l;
//			}
//			
//			map.put("uploadDataTotalSize", uploadDataTotalSize );
//		} catch(Exception e) {
//			e.printStackTrace();
//			result = "db.exception";
//		}
//		
//		map.put("result", result);
//		return map;
//	}
	
	/**
	 * 검색 조건
	 * @param search
	 * @return
	 */
	private String getSearchParameters(PageType pageType, UploadData uploadData) {
		StringBuffer buffer = new StringBuffer(uploadData.getParameters());
		boolean isListPage = true;
		if(pageType == PageType.MODIFY || pageType == PageType.DETAIL) {
			isListPage = false;
		}
		
//		if(!isListPage) {
//			buffer.append("pageNo=" + request.getParameter("pageNo"));
//			buffer.append("&");
//			buffer.append("list_count=" + uploadData.getList_counter());
//		}
		
		return buffer.toString();
	}
}
