//package ndtp.controller;
//
//import java.io.BufferedInputStream;
//import java.io.BufferedOutputStream;
//import java.io.File;
//import java.io.FileInputStream;
//import java.io.FileOutputStream;
//import java.io.IOException;
//import java.io.InputStream;
//import java.io.OutputStream;
//import java.net.URLDecoder;
//import java.net.URLEncoder;
//import java.time.LocalDateTime;
//import java.time.format.DateTimeFormatter;
//import java.util.ArrayList;
//import java.util.Enumeration;
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//import java.util.zip.ZipEntry;
//import java.util.zip.ZipFile;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import org.springframework.beans.BeanUtils;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.HttpStatus;
//import org.springframework.http.ResponseEntity;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.util.FileCopyUtils;
//import org.springframework.util.StringUtils;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.PathVariable;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.multipart.MultipartFile;
//import org.springframework.web.multipart.MultipartHttpServletRequest;
//
//import com.fasterxml.jackson.databind.ObjectMapper;
//
//import lombok.extern.slf4j.Slf4j;
//import ndtp.config.PropertiesConfig;
//import ndtp.domain.CacheManager;
//import ndtp.domain.Layer;
//import ndtp.domain.LayerFileInfo;
//import ndtp.domain.Policy;
//import ndtp.domain.RoleKey;
//import ndtp.domain.UserSession;
//import ndtp.service.PolicyService;
//import ndtp.support.RoleSupport;
//
//@Slf4j
//@Controller
//@RequestMapping("/")
//public class LayerController {
//
//    @Autowired
//    private LayerService layerService;
//    @Autowired
//    private JibunService jibunService;
//    @Autowired
//    private LayerFileInfoService layerFileInfoService;
//    @Autowired
//    private ObjectMapper objectMapper;
//    @Autowired
//    private PolicyService policyService;
//    @Autowired
//    private PropertiesConfig propertiesConfig;
//
//    // 파일 copy 시 버퍼 사이즈
//    public static final int BUFFER_SIZE = 8192;
//
//    /**
//    * layer 목록
//    * @param model
//    * @return
//    */
//    @GetMapping(value = "layer/list")
//    public String listLayer(HttpServletRequest request, Model model) {
//        String roleCheckResult = roleValidator(request);
//        if(roleCheckResult != null) return roleCheckResult;
//
//        List<Layer> layerList = layerService.getListLayer(new Layer());
//
//        // 이 메서드로 감싸면 html escape 처리를 하지 않음
//        //model.addAttribute("layerListJson", new Handlebars.SafeString(layerListJson));
//        model.addAttribute("layerList", layerList);
//        return "/layer/list";
//    }
//
//    /**
//    * layer 상세
//    * @param model
//    * @return
//    */
//    @GetMapping(value = "layer/detail")
//    public String detail(HttpServletRequest request, Model model) {
//        String roleCheckResult = roleValidator(request);
//        if(roleCheckResult != null) return roleCheckResult;
//
//        return "/layer/detail";
//    }
//
//    /**
//    * layer 수정
//    * @param model
//    * @return
//    */
//    @GetMapping(value = "layers/{layerId}")
//    public String modifyLayer(HttpServletRequest request, @PathVariable("layerId") Integer layerId, Model model) {
//        String roleCheckResult = roleValidator(request);
//        if(roleCheckResult != null) return roleCheckResult;
//
//        Policy policy = policyService.getPolicy();
//        Layer layer = layerService.getLayer(layerId);
//
//        List<LayerFileInfo> layerFileInfoList = layerFileInfoService.getListLayerFileInfo(layerId);
//        LayerFileInfo layerFileInfo = new LayerFileInfo();
//        for(int i = 0; i < layerFileInfoList.size(); i++) {
//            if(layerFileInfoList.get(i).getFileExt().equals("shp")) {
//                layerFileInfo = layerFileInfoList.get(i);
//            }
//        }
//        model.addAttribute("policy", policy);
//        model.addAttribute("layer", layer);
//        model.addAttribute("layerFileInfo", layerFileInfo);
//        model.addAttribute("layerFileInfoList", layerFileInfoList);
//        model.addAttribute("layerFileInfoListSize", layerFileInfoList.size());
//        return "/layer/modify";
//    }
//
//    /**
//    * shape 파일 변환
//    * TODO dropzone 이 파일 갯수만큼 form data를 전송해 버려서 command 패턴을(Layer layer) 사용할 수 없음
//    * dropzone 이 예외 처리가 이상해서 BAD_REQUEST 를 던지지 않고 OK 를 넣짐
//    * @param model
//    * @return
//    */
//    @SuppressWarnings("unchecked")
//    @PostMapping(value = "layers/{layerId}")
//    public ResponseEntity<?> updateLayer(MultipartHttpServletRequest request, @PathVariable("layerId") Integer layerId) {
//
//        boolean isRollback = false;
//        Layer rollbackLayer = new Layer();
//        boolean isLayerFileInfoExist = false;
//        LayerFileInfo rollbackLayerFileInfo = null;
//        Integer deleteLayerFileInfoGroupId = null;
//
//        String errorCode = null;
//        try {
//            errorCode = layerValidate(request);
//            if(!StringUtils.isEmpty(errorCode)) {
//                Map<String, Object> result = new HashMap<>();
//                result.put("statusCode", HttpStatus.OK.value());
//                result.put("error", new APIError("입력값이 유효하지 않습니다.", errorCode));
//                return new ResponseEntity<>(result, HttpStatus.OK);
//            }
//
//            UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
//            String userId = userSession.getUserId();
//
//            List<LayerFileInfo> layerFileInfoList = new ArrayList<>();
//            Map<String, MultipartFile> fileMap = request.getFileMap();
//
//            Policy policy = policyService.getPolicy();
//            String shapeEncoding = replaceInvalidValue(request.getParameter("shapeEncoding"));
//            String comment = replaceInvalidValue(request.getParameter("comment"));
//            String today = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
//
//            // layer 변경 횟수가 많지 않아서 년 단위로 관리할 예정
//            String makedDirectory = propertiesConfig.getUploadDir();
//            createDirectory(makedDirectory);
//            makedDirectory = makedDirectory + today.substring(0,4) + File.separator;
//            createDirectory(makedDirectory);
//            log.info("@@@@@@@ = {}", makedDirectory);
//
//            Layer layer = layerService.getLayer(layerId);
//            BeanUtils.copyProperties(layer, rollbackLayer);
//            // layer 파일의 경우 한 세트가 같은 이름에 확장자만 달라야 한다.
//            String groupFileName = layer.getLayerKey() + "_" + today;
//
//            // 한건이면서 zip 의 경우
//            boolean isZipFile = false;
//            int fileCount = fileMap.values().size();
//            log.info("********************************************* fileCount = {}", fileCount);
//            if(fileCount == 1) {
//                for (MultipartFile multipartFile : fileMap.values()) {
//                    String[] divideNames = multipartFile.getOriginalFilename().split("\\.");
//                    String fileExtension = divideNames[divideNames.length - 1];
//                    if(LayerFileInfo.ZIP_EXTENSION.equals(fileExtension.toLowerCase())) {
//                        isZipFile = true;
//                        // zip 파일
//                        Map<String, Object> uploadMap = unzip(policy, groupFileName, multipartFile, shapeEncoding, comment, makedDirectory);
//                        layerFileInfoList = (List<LayerFileInfo>)uploadMap.get("layerFileInfoList");
//                    }
//                }
//            }
//
//            if(!isZipFile) {
//                for (MultipartFile multipartFile : fileMap.values()) {
//                    log.info("@@@@@@@@@@@@@@@ name = {}, original_name = {}", multipartFile.getName(), multipartFile.getOriginalFilename());
//
//                    String saveFileName = groupFileName;
//                    LayerFileInfo layerFileInfo = new LayerFileInfo();
//
//                    // 파일 기본 validation 체크
//                    errorCode = fileValidate(policy, multipartFile);
//                    if(!StringUtils.isEmpty(errorCode)) {
//                        Map<String, Object> result = new HashMap<>();
//                        result.put("statusCode", HttpStatus.OK.value());
//                        result.put("error", new APIError("첨부 파일이 유효하지 않습니다.", errorCode));
//                        return new ResponseEntity<>(result, HttpStatus.OK);
//                    }
//
//                    String originalName = multipartFile.getOriginalFilename();
//                    String[] divideFileName = originalName.split("\\.");
//                    String extension = null;
//                    if(divideFileName != null && divideFileName.length != 0) {
//                        extension = divideFileName[divideFileName.length - 1];
//                        if(LayerFileInfo.ZIP_EXTENSION.equals(extension.toLowerCase())) {
//                            log.info("@@@@@@@@@@@@ upload.file.type.invalid");
//                            Map<String, Object> result = new HashMap<>();
//                            result.put("statusCode", HttpStatus.OK.value());
//                            result.put("error", new APIError("첨부 파일이 유효하지 않습니다.", "upload.file.type.invalid"));
//                            return new ResponseEntity<>(result, HttpStatus.OK);
//                        }
//                        saveFileName = saveFileName + "." + extension;
//                    }
//
//                    long size = 0L;
//                    try (	InputStream inputStream = multipartFile.getInputStream();
//                            OutputStream outputStream = new FileOutputStream(makedDirectory + saveFileName)) {
//
//                        int bytesRead = 0;
//                        byte[] buffer = new byte[BUFFER_SIZE];
//                        while ((bytesRead = inputStream.read(buffer, 0, BUFFER_SIZE)) != -1) {
//                            size += bytesRead;
//                            outputStream.write(buffer, 0, bytesRead);
//                        }
//                        layerFileInfo.setFileExt(extension);
//                        layerFileInfo.setFileName(multipartFile.getOriginalFilename());
//                        layerFileInfo.setFileRealName(saveFileName);
//                        layerFileInfo.setFilePath(makedDirectory);
//                        layerFileInfo.setFileSize(String.valueOf(size));
//                        layerFileInfo.setShapeEncoding(shapeEncoding);
//                        layerFileInfo.setComment(comment);
//
//                    } catch(Exception e) {
//                        e.printStackTrace();
//                        layerFileInfo.setErrorMessage(e.getMessage());
//                    }
//
//                    layerFileInfoList.add(layerFileInfo);
//                }
//            }
//
//            // TODO dropzone 이 form data를 파일 횟수 만큼 전송을 해 버림. 원인 찾는중
//            layer.setLayerId(layerId);
//            layer.setLayerName(request.getParameter("layerName"));
//            layer.setViewType(replaceInvalidValue(request.getParameter("viewType")));
//            layer.setCoordinate(replaceInvalidValue(request.getParameter("coordinate")));
//            layer.setGeometryType(replaceInvalidValue(request.getParameter("geometryType")));
//            layer.setManagementDept(replaceInvalidValue(request.getParameter("managementDept")));
//            layer.setManagementUserId(replaceInvalidValue(request.getParameter("managementUserId")));
//            layer.setManagementSubUserId(replaceInvalidValue(request.getParameter("managementSubUserId")));
//            layer.setUseYn(request.getParameter("useYn"));
//            layer.setBlockDefaultYn(request.getParameter("blockDefaultYn"));
//            layer.setFacilityDefaultYn(request.getParameter("facilityDefaultYn"));
//            layer.setMobileDefaultYn(request.getParameter("mobileDefaultYn"));
//            layer.setLabelDisplayYn(request.getParameter("labelDisplayYn"));
//            layer.setZIndex(new Integer(request.getParameter("zIndex")));
//            // TODO shape 파일을 등록해야 1로 설정하는게 맞는데... 애매하네...
//            layer.setStatus("1");
//            layer.setDescription(replaceInvalidValue(request.getParameter("description")));
//            layer.setUserId(userId);
//            log.info("@@ layer = {}", layer);
//
//            // TODO geoserver 에서 postgresql 로 hang 걸리는게 있어서 우선 이럻게 처리 함. 추후 개선 예정
//            // 여기서 부터 문제가 생기는 것은 rollback 처리를 합니다.
//            // 1. 레이어 이력 파일이 존재하는 검사
//            isLayerFileInfoExist = layerFileInfoService.isLayerFileInfoExist(layer.getLayerId());
//            if(isLayerFileInfoExist) {
//                // 2. 존재하면 백업을 위해 조회
//                rollbackLayerFileInfo = layerFileInfoService.getEnableLayerFileInfo(layerId);
//            }
//            log.info("----- isLayerFileInfoExist = {}", isLayerFileInfoExist);
//            // 3. 레이어 기본 정보 및 레이어 이력 정보 등록
//            Map<String, Object> updateLayerMap = layerService.updateLayer(layer, isLayerFileInfoExist, layerFileInfoList);
//            if(!layerFileInfoList.isEmpty()) {
//                isRollback = true;
//
//                deleteLayerFileInfoGroupId = (Integer)updateLayerMap.get("layerFileInfoGroupId");
//                // 4. org2ogr 실행
//                layerService.insertOgr2Ogr(layer, isLayerFileInfoExist, (String)updateLayerMap.get("shapeFileName"), (String)updateLayerMap.get("shapeEncoding"));
//
//                // org2ogr 로 등록한 데이터의 version을 갱신
//                Map<String, String> orgMap = new HashMap<>();
//                orgMap.put("version", ((Integer)updateLayerMap.get("version")).toString());
//                orgMap.put("tableName", layer.getLayerKey());
//                orgMap.put("enableYn", "Y");
//                // 5. shape 파일 테이블의 현재 데이터의 활성화 하고 날짜를 업데이트
//                layerFileInfoService.updateOgr2OgrDataVersion(orgMap);
//                // 6. geoserver에 신규 등록일 경우 등록, 아닐경우 통과
//                layerService.registerLayer(policy, layer.getLayerKey());
//
//                //업로드 하는 데이터가 지번일 경우 오라클 테이블을 비우고 insert
//                //상수를 앞에 쓰면 NullPointerException이 발생하지 않는다.
//                //뒤에 비즈니스 로직에 layerKey가 필요하다면  layerKey를 앞에써서  exception을 발생시켜 처리하는게 좋다~
//                String layerKey = layer.getLayerKey();
//                if("layer_lot_number".equals(layerKey)) {
//                    List<Jibun> jibunList = jibunService.getListAllJibun();
//                    try {
//                        jibunService.insertJibun(jibunList);
//                    } catch(RuntimeException e) {
//                        throw new RuntimeException(e);
//                    }
//                }
//            }
//
//            return new ResponseEntity<>(HttpStatus.OK.value(), HttpStatus.OK);
//        } catch(Exception e) {
//            if(isRollback) {
//                // rollback 처리
//                layerService.rollbackLayer(rollbackLayer, isLayerFileInfoExist, rollbackLayerFileInfo, deleteLayerFileInfoGroupId);
//            }
//
//            e.printStackTrace();
//
//            Map<String, Object> result = new HashMap<>();
//            result.put("statusCode", HttpStatus.OK.value());
//            result.put("error", new APIError(e.getCause() != null ? e.getCause().getMessage() : e.getMessage()));
//            return new ResponseEntity<>(result, HttpStatus.OK);
//        }
//    }
//
//    private String replaceInvalidValue(String value) {
//        if("null".equals(value)) value = null;
//        return value;
//    }
//
//    /**
//    * 업로딩 파일을 압축 해제
//    * @param policy
//    * @param groupFileName layer 의 경우 한 세트가 같은 이름에 확장자만 달라야 함
//    * @param userId
//    * @param multipartFile
//    * @param targetDirectory
//    * @return
//    * @throws Exception
//    */
//    private Map<String, Object> unzip(Policy policy, String groupFileName, MultipartFile multipartFile, String shapeEncoding, String comment, String targetDirectory) throws Exception {
//        Map<String, Object> result = new HashMap<>();
//        String errorCode = fileValidate(policy, multipartFile);
//        if(!StringUtils.isEmpty(errorCode)) {
//            result.put("errorCode", errorCode);
//            return result;
//        }
//
//        // temp 디렉토리에 압축을 해제 함
//        String tempDirectory = targetDirectory + "temp" + File.separator;
//        createDirectory(tempDirectory);
//
//        List<LayerFileInfo> layerFileInfoList = new ArrayList<>();
//
//        File uploadedFile = new File(tempDirectory + multipartFile.getOriginalFilename());
//        multipartFile.transferTo(uploadedFile);
//
//        try ( ZipFile zipFile = new ZipFile(uploadedFile);) {
//            String directoryPath = targetDirectory;
//            Enumeration<? extends ZipEntry> entries = zipFile.entries();
//            while( entries.hasMoreElements() ) {
//                LayerFileInfo layerFileInfo = new LayerFileInfo();
//                ZipEntry entry = entries.nextElement();
//                if( entry.isDirectory() ) {
//                    String unzipfileName = directoryPath + entry.getName();
//                    log.info("--------- unzip directory = {}", unzipfileName);
//                    File file = new File(unzipfileName);
//                    file.mkdirs();
//                } else {
//                    String fileName = null;
//                    String extension = null;
//                    String[] divideFileName = null;
//                    String saveFileName = null;
//
//                    fileName = entry.getName();
//                    divideFileName = fileName.split("\\.");
//                    if(divideFileName != null && divideFileName.length != 0) {
//                        extension = divideFileName[divideFileName.length - 1];
//                        saveFileName = groupFileName + "." + extension;
//                        log.info("--------- unzip saveFileName = {}", saveFileName);
//                    }
//
//                    try ( 	InputStream inputStream = zipFile.getInputStream(entry);
//                            FileOutputStream outputStream = new FileOutputStream(targetDirectory + saveFileName); ) {
//                        int data = inputStream.read();
//                        while(data != -1){
//                            outputStream.write(data);
//                            data = inputStream.read();
//                        }
//
//                        layerFileInfo.setFileExt(extension);
//                        layerFileInfo.setFileName(fileName);
//                        layerFileInfo.setFileRealName(saveFileName);
//                        layerFileInfo.setFilePath(directoryPath);
//                        layerFileInfo.setShapeEncoding(shapeEncoding);
//                        layerFileInfo.setComment(comment);
//
//                    } catch(Exception e) {
//                        e.printStackTrace();
//                        layerFileInfo.setErrorMessage(e.getMessage());
//                    }
//                }
//                layerFileInfo.setFileSize(String.valueOf(entry.getSize()));
//                if( !entry.isDirectory() ) {
//                    layerFileInfoList.add(layerFileInfo);
//                }
//            }
//        } catch(IOException ex) {
//            ex.printStackTrace();
//        }
//
//        log.info("##################### unzip layerFileInfoList = {}", layerFileInfoList.size());
//        result.put("layerFileInfoList", layerFileInfoList);
//        return result;
//    }
//
//    /**
//    * @param policy
//    * @param multipartFile
//    * @return
//    */
//    private static String fileValidate(Policy policy, MultipartFile multipartFile) {
//
//        // 2 파일 이름
//        String fileName = multipartFile.getOriginalFilename();
////		if(fileName == null) {
////			log.info("@@ fileName is null");
////			uploadLog.setError_code("fileinfo.name.invalid");
////			return uploadLog;
////		} else if(fileName.indexOf("..") >= 0 || fileName.indexOf("/") >= 0) {
////			// TODO File.seperator 정규 표현식이 안 먹혀서 이렇게 처리함
////			log.info("@@ fileName = {}", fileName);
////			uploadLog.setError_code("fileinfo.name.invalid");
////			return uploadLog;
////		}
//
//        // 3 파일 확장자
//        String[] fileNameValues = fileName.split("\\.");
////		if(fileNameValues.length != 2) {
////			log.info("@@ fileNameValues.length = {}, fileName = {}", fileNameValues.length, fileName);
////			uploadLog.setError_code("fileinfo.name.invalid");
////			return uploadLog;
////		}
////		if(fileNameValues[0].indexOf(".") >= 0 || fileNameValues[0].indexOf("..") >= 0) {
////			log.info("@@ fileNameValues[0] = {}", fileNameValues[0]);
////			uploadLog.setError_code("fileinfo.name.invalid");
////			return uploadLog;
////		}
//        // LowerCase로 비교
//        String extension = fileNameValues[fileNameValues.length - 1];
////		List<String> extList = new ArrayList<String>();
////		if(policy.getUser_upload_type() != null && !"".equals(policy.getUser_upload_type())) {
////			String[] uploadTypes = policy.getUser_upload_type().toLowerCase().split(",");
////			extList = Arrays.asList(uploadTypes);
////		}
////		if(!extList.contains(extension.toLowerCase())) {
////			log.info("@@ extList = {}, extension = {}", extList, extension);
////			uploadLog.setError_code("fileinfo.ext.invalid");
////			return uploadLog;
////		}
//
//        // 4 파일 사이즈
//        long fileSize = multipartFile.getSize();
//        log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@ upload file size = {} KB", (fileSize / 1000));
//        if( fileSize > (policy.getUserUploadMaxFilesize() * 1000000l)) {
//            log.info("@@ fileSize = {}, user upload max filesize = {} M", (fileSize / 1000), policy.getUserUploadMaxFilesize());
//            return "fileinfo.size.invalid";
//        }
//
//        return null;
//    }
//
//    /**
//    * @param userId
//    * @param today
//    * @param targetDirectory
//    * @return
//    */
//    private void createDirectory(String targetDirectory) {
//        File directory = new File(targetDirectory);
//        if(!directory.exists()) {
//            directory.mkdir();
//        }
//    }
//
//    /**
//    * validation 체크
//    * @param request
//    * @return
//    */
//    private String layerValidate(MultipartHttpServletRequest request) {
//
//        if(StringUtils.isEmpty(request.getParameter("layerName"))) {
//            return "layer.name.empty";
//        }
//        return null;
//    }
//
//    /**
//    * shape 파일 목록
//    * @param model
//    * @return
//    */
//    @GetMapping(value = "layers/{layerId}/layer-fileinfos")
//    public ResponseEntity<?> listLayerFileInfo(HttpServletRequest request, @PathVariable Integer layerId) {
//
//        try {
//            List<LayerFileInfo> layerFileInfoList = layerFileInfoService.getListLayerFileInfo(layerId);
//
//            return new ResponseEntity<>(layerFileInfoList, HttpStatus.OK);
//        } catch(Exception e) {
//            e.printStackTrace();
//
//            Map<String, Object> result = new HashMap<>();
//            result.put("statusCode", HttpStatus.INTERNAL_SERVER_ERROR.value());
//            result.put("error", new APIError(e.getCause() != null ? e.getCause().getMessage() : e.getMessage()));
//            return new ResponseEntity<>(result, HttpStatus.INTERNAL_SERVER_ERROR);
//        }
//    }
//
//    /**
//    * shape 파일 다운 로드
//    * @param model
//    * @return
//    */
//    @GetMapping(value = "layer/{layerId}/layer-file-info/{layerFileInfoGroupId}/download")
//    public void download(HttpServletRequest request, HttpServletResponse response,
//            @PathVariable Integer layerId, @PathVariable Integer layerFileInfoGroupId) {
//        log.info("@@@@@@@@@@@@ layerId = {}, layerFileInfoGroupId = {}", layerId, layerFileInfoGroupId);
//
//        try {
//
//            Layer layer = layerService.getLayer(layerId);
//            List<LayerFileInfo> layerFileInfoList = layerFileInfoService.getLayerFileInfoGroup(layerFileInfoGroupId);
//
//            //db정보를 기준으로 shp파일 정보를 업데이트
//            layerService.exportOgr2Ogr(layerFileInfoList, layer);
//
//            String today = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
//
//            String makedDirectory = propertiesConfig.getUploadDir();
//            makedDirectory = makedDirectory + "zip" + File.separator;
//            createDirectory(makedDirectory);
//            log.info("@@@@@@@ zip directory = {}", makedDirectory);
//
//            // layer 파일의 경우 한 세트가 같은 이름에 확장자만 달라야 한다.
//            String zipFileName = makedDirectory + layer.getLayerKey() + "_" + today + "_" + System.nanoTime() + ".zip";
//
//            ZipSupport.makeZip(zipFileName, layerFileInfoList);
//
//            response.setContentType("application/force-download");
//            response.setHeader("Content-Transfer-Encoding", "binary");
//            setDisposition(layer.getLayerName() + ".zip", request, response);
//
//            File zipFile = new File(zipFileName);
//            try(	BufferedInputStream in = new BufferedInputStream(new FileInputStream(zipFile));
//                    BufferedOutputStream out = new BufferedOutputStream(response.getOutputStream());) {
//
//                FileCopyUtils.copy(in, out);
//                out.flush();
//            } catch (Exception e) {
//                e.printStackTrace();
//            }
//        } catch(Exception e) {
//            e.printStackTrace();
//        }
//    }
//
//    /**
//    * 비활성화 상태의 layer를 활성화
//    * @param model
//    * @return
//    */
//    @PostMapping(value = "layers/{layerId}/layer-file-infos/{layerFileInfoId}")
//    public ResponseEntity<?> updateLayerByLayerFileInfoId(HttpServletRequest request,
//                                                            @PathVariable Integer layerId,
//                                                            @PathVariable Integer layerFileInfoId,
//                                                            Integer layerFileInfoGroupId) {
//
//        log.info("@@@@@@@@@@@@ layerId = {}, layerFileInfoId = {}", layerId, layerFileInfoId);
//
//        try {
//            layerService.updateLayerByLayerFileInfoId(layerId, layerFileInfoGroupId, layerFileInfoId);
//
//            return new ResponseEntity<>(HttpStatus.OK.value(), HttpStatus.OK);
//        } catch(Exception e) {
//            e.printStackTrace();
//
//            Map<String, Object> result = new HashMap<>();
//            result.put("statusCode", HttpStatus.INTERNAL_SERVER_ERROR.value());
//            result.put("error", new APIError(e.getCause() != null ? e.getCause().getMessage() : e.getMessage()));
//            return new ResponseEntity<>(result, HttpStatus.INTERNAL_SERVER_ERROR);
//        }
//    }
//
//    @GetMapping(value = "/layer/file-info/{layerFileInfoId}")
//    public ResponseEntity<?> viewFileDetail(@PathVariable Integer layerFileInfoId) {
//        try {
//            LayerFileInfo layerFileInfo = layerFileInfoService.getLayerFileInfo(layerFileInfoId);
//            log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@ layerFileInfo = {}", layerFileInfo);
//
//            return new ResponseEntity<>(layerFileInfo, HttpStatus.OK);
//        } catch (Exception e) {
//            e.printStackTrace();
//
//            Map<String, Object> result = new HashMap<>();
//            result.put("statusCode", HttpStatus.INTERNAL_SERVER_ERROR.value());
//            result.put("error", new APIError(e.getCause() != null ? e.getCause().getMessage() : e.getMessage()));
//            return new ResponseEntity<>(result, HttpStatus.INTERNAL_SERVER_ERROR);
//        }
//    }
//
//    /**
//    * layer 지도 보기
//    * @param model
//    * @return
//    */
//    @GetMapping(value = "layer/{layerId}/map")
//    public String viewLayerMap(HttpServletRequest request, @PathVariable Integer layerId, Integer layerFileInfoId, Model model) {
//
//        log.info("@@ layerId = {}, layerFileInfoId = {}", layerId, layerFileInfoId);
//
//        Policy policy = policyService.getPolicy();
//        Layer layer = layerService.getLayer(layerId);
//        Integer version = 0;
//        if(layerFileInfoId != null)	{
//            version = layerFileInfoService.getLayerShapeFileVersion(layerFileInfoId);
//        }
//
//        // TODO 좀 무식하군... 쿼리 하나 더 만들기 귀찮아서....
//        Layer baseLayer = new Layer();
//        baseLayer.setBlockDefaultYn("Y");
//        List<Layer> baseLayerList = layerService.getListLayer(baseLayer);
//        List<String> baseLayerKeyList = new ArrayList<>();
//        for(Layer tempLayer : baseLayerList) {
//            baseLayerKeyList.add(tempLayer.getLayerKey());
//        }
//
//        String[] baseLayerKeys = baseLayerKeyList.toArray(new String[baseLayerKeyList.size()]);
//
//        String policyJson = "";
//        String baseLayerKeysJson = "";
//
//        try {
//            policyJson = objectMapper.writeValueAsString(policy);
//            baseLayerKeysJson = objectMapper.writeValueAsString(baseLayerKeys);
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//        model.addAttribute("policyJson", policyJson);
//        model.addAttribute("layer", layer);
//        model.addAttribute("version", version);
//        model.addAttribute("baseLayerKeysJson", baseLayerKeysJson);
//
//        return "/layer/popup-map";
//    }
//
//    private String roleValidator(HttpServletRequest request) {
//        UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
//        List<String> userGroupRoleKeyList = CacheManager.getUserGroupRoleKeyList(userSession.getUserGroupId());
//        if(!RoleSupport.isUserGroupRoleValid(userGroupRoleKeyList, RoleKey.ADMIN_LAYER_MANAGE.name())) {
//            request.setAttribute("httpStatusCode", 403);
//            return "/error/error";
//        }
//        return null;
//    }
//
//    /**
//    * 다운로드시 한글 깨짐 방지 처리
//    */
//    private void setDisposition(String filename, HttpServletRequest request, HttpServletResponse response) throws Exception {
//        String browser = WebUtil.getBrowser(request);
//        String dispositionPrefix = "attachment; filename=";
//        String encodedFilename = null;
//
//        log.info("================================= browser = {}", browser);
//        if (browser.equals("MSIE")) {
//            encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
//        } else if (browser.equals("Trident")) {       // IE11 문자열 깨짐 방지
//            encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
//        } else if (browser.equals("Firefox")) {
//            encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
//            encodedFilename = URLDecoder.decode(encodedFilename, "UTF-8");
//        } else if (browser.equals("Opera")) {
//            encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
//        } else if (browser.equals("Chrome")) {
//            StringBuffer sb = new StringBuffer();
//            for (int i = 0; i < filename.length(); i++) {
//                char c = filename.charAt(i);
//                if (c > '~') {
//                    sb.append(URLEncoder.encode("" + c, "UTF-8"));
//                } else {
//                    sb.append(c);
//                }
//            }
//            encodedFilename = sb.toString();
//        } else if (browser.equals("Safari")){
//            encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1")+ "\"";
//            encodedFilename = URLDecoder.decode(encodedFilename, "UTF-8");
//        }
//        else {
//            encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1")+ "\"";
//        }
//
//        response.setHeader("Content-Disposition", dispositionPrefix + encodedFilename);
//        if ("Opera".equals(browser)){
//            response.setContentType("application/octet-stream;charset=UTF-8");
//        }
//    }
//}
