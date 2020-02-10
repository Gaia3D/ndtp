package ndtp.controller;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import lombok.extern.slf4j.Slf4j;
import ndtp.config.PropertiesConfig;
import ndtp.domain.DataAttribute;
import ndtp.domain.DataAttributeFileInfo;
import ndtp.domain.DataInfo;
import ndtp.domain.DataObjectAttribute;
import ndtp.domain.DataObjectAttributeFileInfo;
import ndtp.domain.FileInfo;
import ndtp.domain.Key;
import ndtp.domain.UserSession;
import ndtp.service.DataAttributeService;
import ndtp.service.DataObjectAttributeService;
import ndtp.service.DataService;
import ndtp.utils.FileUtils;

@Slf4j
@RestController
@RequestMapping("/datas")
public class DataRestController {
	
	@Autowired
	private DataService dataService;
	@Autowired
	private DataAttributeService dataAttributeService;
	@Autowired
	private DataObjectAttributeService dataObjectAttributeService;
	@Autowired
	private PropertiesConfig propertiesConfig;
	
	/**
	 * 데이터 정보
	 * @param dataId
	 * @return
	 */
	@GetMapping("/{dataId}")
	public Map<String, Object> detail(HttpServletRequest request, @PathVariable Long dataId) {
		
		log.info("@@@@@ dataId = {}", dataId);
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		try {
			if(dataId == null || dataId.longValue() <=0l) {
				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
				result.put("errorCode", "input.invalid");
				result.put("message", message);
				return result;
			}
			
			DataInfo dataInfo = new DataInfo();
			//dataInfo.setUserId(userSession.getUserId());
			dataInfo.setDataId(dataId);
			
			dataInfo = dataService.getData(dataInfo);
			
			result.put("dataInfo", dataInfo);
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
	 * 사용자 데이터 수정
	 * @param request
	 * @param dataGroup
	 * @param bindingResult
	 * @return
	 */
	@PostMapping("/{dataId}")
	public Map<String, Object> update(HttpServletRequest request, @PathVariable Integer dataId, @ModelAttribute DataInfo dataInfo) {
		
		log.info("@@@@@ update dataInfo = {}, dataId = {}", dataInfo, dataId);
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		
		try {
			// @Valid 로
			if(dataId == null) {
				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
				result.put("errorCode", "input.invalid");
				result.put("message", message);
				
				return result;
			}
			
//			dataInfo.setUserId(userSession.getUserId());
			if(dataInfo.getLongitude() != null && dataInfo.getLatitude() != null) {
				dataInfo.setLocation("POINT(" + dataInfo.getLongitude() + " " + dataInfo.getLatitude() + ")");
			}
			dataService.updateData(dataInfo);
		} catch (Exception e) {
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
	 * 데이터 속성 정보
	 * @param dataId
	 * @return
	 */
	@GetMapping("/attributes/{dataId}")
	public Map<String, Object> detailAttribute(HttpServletRequest request, @PathVariable Long dataId) {
		
		log.info("@@@@@ dataId = {}", dataId);
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		try {
			if(dataId == null || dataId.longValue() <=0l) {
				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
				result.put("errorCode", "input.invalid");
				result.put("message", message);
				return result;
			}
			
			DataAttribute dataAttribute = dataAttributeService.getDataAttribute(dataId);
			result.put("dataAttribute", dataAttribute);
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
	 * 데이터 Object 속성 정보
	 * @param dataId
	 * @return
	 */
	@GetMapping("/object/attributes/{dataId}")
	public Map<String, Object> detailObjectAttribute(HttpServletRequest request, @PathVariable Long dataId) {
		
		log.info("@@@@@ dataId = {}", dataId);
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		try {
			if(dataId == null || dataId.longValue() <=0l) {
				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
				result.put("errorCode", "input.invalid");
				result.put("message", message);
				return result;
			}
			
			DataObjectAttribute dataObjectAttribute = dataObjectAttributeService.getDataObjectAttribute(dataId);
			result.put("dataObjectAttribute", dataObjectAttribute);
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
	 * Data Attribute 수정
	 * @param model
	 * @return
	 */
	@PostMapping(value = "/attributes")
	public Map<String, Object> insertDataAttribute(MultipartHttpServletRequest request) {
		
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		try {
			Long dataId = Long.valueOf(request.getParameter("attributeFileDataId"));
			MultipartFile multipartFile = request.getFile("attributeFileName");
			// TODO
			FileInfo fileInfo = FileUtils.upload(multipartFile, FileUtils.DATA_ATTRIBUTE_UPLOAD, propertiesConfig.getDataAttributeUploadDir());
			if(fileInfo.getErrorCode() != null && !"".equals(fileInfo.getErrorCode())) {
				log.info("@@@@@@@@@@@@@@@@@@@@ error_code = {}", fileInfo.getErrorCode());
				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
				result.put("errorCode", fileInfo.getErrorCode());
				result.put("message", message);
				
				return result;
			}
			
			UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
			
			ModelMapper modelMapper = new ModelMapper();
			DataAttributeFileInfo dataAttributeFileInfo = modelMapper.map(fileInfo, DataAttributeFileInfo.class);
			dataAttributeFileInfo.setUserId(userSession.getUserId());
			dataAttributeFileInfo.setDataId(dataId);
			
			dataAttributeFileInfo = dataAttributeService.insertDataAttribute(dataId, dataAttributeFileInfo);
			
			result.put("totalCount", dataAttributeFileInfo.getTotalCount());
			result.put("parseSuccessCount", dataAttributeFileInfo.getParseSuccessCount());
			result.put("parseErrorCount", dataAttributeFileInfo.getParseErrorCount());
			result.put("insertSuccessCount", dataAttributeFileInfo.getInsertSuccessCount());
			result.put("updateSuccessCount", dataAttributeFileInfo.getUpdateSuccessCount());
			result.put("insertErrorCount", dataAttributeFileInfo.getInsertErrorCount());
			
			// 파일 삭제
			File copyFile = new File(fileInfo.getFilePath() + fileInfo.getFileRealName());
			if(copyFile.exists()) {
				copyFile.delete();
			}
		} catch (Exception e) {
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
	 * Data object Attribute 수정
	 * @param model
	 * @return
	 */
	@PostMapping(value = "/object/attributes")
	public Map<String, Object> insertDataObjectAttribute(MultipartHttpServletRequest request) {
		
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		try {
			Long dataId = Long.valueOf(request.getParameter("objectAttributeFileDataId"));
			MultipartFile multipartFile = request.getFile("objectAttributeFileName");
			// TODO
			FileInfo fileInfo = FileUtils.upload(multipartFile, FileUtils.DATA_ATTRIBUTE_UPLOAD, propertiesConfig.getDataAttributeUploadDir());
			if(fileInfo.getErrorCode() != null && !"".equals(fileInfo.getErrorCode())) {
				log.info("@@@@@@@@@@@@@@@@@@@@ error_code = {}", fileInfo.getErrorCode());
				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
				result.put("errorCode", fileInfo.getErrorCode());
				result.put("message", message);
				
				return result;
			}
			
			UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
			
			ModelMapper modelMapper = new ModelMapper();
			DataObjectAttributeFileInfo dataObjectAttributeFileInfo = modelMapper.map(fileInfo, DataObjectAttributeFileInfo.class);
			dataObjectAttributeFileInfo.setUserId(userSession.getUserId());
			dataObjectAttributeFileInfo.setDataId(dataId);
			
			dataObjectAttributeFileInfo = dataObjectAttributeService.insertDataObjectAttribute(dataId, dataObjectAttributeFileInfo);
			
			result.put("totalCount", dataObjectAttributeFileInfo.getTotalCount());
			result.put("parseSuccessCount", dataObjectAttributeFileInfo.getParseSuccessCount());
			result.put("parseErrorCount", dataObjectAttributeFileInfo.getParseErrorCount());
			result.put("insertSuccessCount", dataObjectAttributeFileInfo.getInsertSuccessCount());
			result.put("updateSuccessCount", dataObjectAttributeFileInfo.getUpdateSuccessCount());
			result.put("insertErrorCount", dataObjectAttributeFileInfo.getInsertErrorCount());
			
			// 파일 삭제
			File copyFile = new File(fileInfo.getFilePath() + fileInfo.getFileRealName());
			if(copyFile.exists()) {
				copyFile.delete();
			}
		} catch (Exception e) {
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
}
