package ndtp.service.impl;

import java.io.File;
import java.math.BigDecimal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.slf4j.Slf4j;
import ndtp.config.PropertiesConfig;
import ndtp.domain.ConverterJob;
import ndtp.domain.ConverterJobFile;
import ndtp.domain.ConverterJobStatus;
import ndtp.domain.DataGroup;
import ndtp.domain.DataInfo;
import ndtp.domain.LocationUdateType;
import ndtp.domain.MethodType;
import ndtp.domain.QueueMessage;
import ndtp.domain.ServerTarget;
import ndtp.domain.UploadData;
import ndtp.domain.UploadDataFile;
import ndtp.persistence.ConverterMapper;
import ndtp.service.AMQPPublishService;
import ndtp.service.ConverterService;
import ndtp.service.DataGroupService;
import ndtp.service.DataService;
import ndtp.service.GeoPolicyService;
import ndtp.service.UploadDataService;
import ndtp.utils.FileUtils;

/**
 * converter manager
 * @author jeongdae
 *
 */
@Slf4j
@Service
public class ConverterServiceImpl implements ConverterService {

	@Autowired
	private AMQPPublishService aMQPPublishService;
	
	@Autowired
	private DataService dataService;
	
	@Autowired
	private DataGroupService dataGroupService;
	@Autowired
	private GeoPolicyService geoPolicyService;
	@Autowired
	private PropertiesConfig propertiesConfig;
	@Autowired
	private UploadDataService uploadDataService;
	
	@Autowired
	private ConverterMapper converterMapper;
	
	/**
	 * converter job 총 건수
	 * @param converterJob
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getConverterJobTotalCount(ConverterJob converterJob) {
		return converterMapper.getConverterJobTotalCount(converterJob);
	}
	
	/**
	 * converter job file 총 건수
	 * @param converterJobFile
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getConverterJobFileTotalCount(ConverterJobFile converterJobFile) {
		return converterMapper.getConverterJobFileTotalCount(converterJobFile);
	}
	
	/**
	 * converter job 목록
	 * @param converterLog
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<ConverterJob> getListConverterJob(ConverterJob converterJob) {
		return converterMapper.getListConverterJob(converterJob);
	}
	
	/**
	 * converter job file 목록
	 * @param converterJobFile
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<ConverterJobFile> getListConverterJobFile(ConverterJobFile converterJobFile) {
		return converterMapper.getListConverterJobFile(converterJobFile);
	}
	
	/**
	 * converter 변환
	 * @param converterJob
	 * @return
	 */
	@Transactional
	public int insertConverter(ConverterJob converterJob) {
		
		String dataGroupRootPath = propertiesConfig.getDataServiceDir();
		
		String title = converterJob.getTitle();
		String converterTemplate = converterJob.getConverterTemplate();
		String userId = converterJob.getUserId();
		BigDecimal usf = converterJob.getUsf();
		
		String[] uploadDataIds = converterJob.getConverterCheckIds().split(",");
		for(String uploadDataId : uploadDataIds) {
			// 1. 변환해야 할 파일 목록을 취득
			UploadData uploadData = new UploadData();
			uploadData.setUserId(userId);
			uploadData.setUploadDataId(Long.valueOf(uploadDataId));
			uploadData.setConverterTarget(true);
			List<UploadDataFile> uploadDataFileList = uploadDataService.getListUploadDataFile(uploadData);
			
			// 2. converter job 을 등록
			ConverterJob inConverterJob = new ConverterJob();
			inConverterJob.setUploadDataId(Long.valueOf(uploadDataId));
			inConverterJob.setUserId(userId);
			inConverterJob.setTitle(title);
			inConverterJob.setUsf(usf);
			inConverterJob.setConverterTemplate(converterTemplate);
			inConverterJob.setFileCount(uploadDataFileList.size());
			converterMapper.insertConverterJob(inConverterJob);
			
			Long converterJobId = inConverterJob.getConverterJobId();
			for(UploadDataFile uploadDataFile : uploadDataFileList) {
				ConverterJobFile converterJobFile = new ConverterJobFile();
				converterJobFile.setUserId(userId);
				converterJobFile.setConverterJobId(converterJobId);
				converterJobFile.setUploadDataId(Long.valueOf(uploadDataId));
				converterJobFile.setUploadDataFileId(uploadDataFile.getUploadDataFileId());
				converterJobFile.setDataGroupId(uploadDataFile.getDataGroupId());
				converterJobFile.setUserId(userId);
				converterJobFile.setUsf(usf);
				
				// 3. job file을 하나씩 등록
				converterMapper.insertConverterJobFile(converterJobFile);
				
				// 4. 데이터를 등록
				DataInfo dataInfo = insertData(userId, uploadDataFile);
				
				// 5. 데이터 그룹 신규 생성의 경우 데이터 건수 update, location_update_type 이 auto 일 경우 dataInfo 위치 정보로 dataGroup 위치 정보 수정 
				updateDataGroup(userId, dataInfo, uploadDataFile);
				
				// queue 를 실행
				executeConverter(userId, dataGroupRootPath, converterJobFile, uploadDataFile);
			}
			
			uploadData.setConverterCount(1);
			uploadDataService.updateUploadData(uploadData);
		}
		
		return uploadDataIds.length;
	}
	
	private void executeConverter(String userId, String dataGroupRootPath, ConverterJobFile converterJobFile, UploadDataFile uploadDataFile) {
		DataGroup dataGroup = new DataGroup();
		dataGroup.setUserId(userId);
		dataGroup.setDataGroupId(uploadDataFile.getDataGroupId());
		dataGroup = dataGroupService.getDataGroup(dataGroup);
		
		// path 와 File.seperator 의 차이점 때문에 변환
		String dataGroupFilePath = FileUtils.getFilePath(dataGroup.getDataGroupPath());
		
		log.info("-------------------------------------------------------");
		log.info("----------- dataGroupRootPath = {}", dataGroupRootPath);
		log.info("----------- dataGroup.getDataGroupPath() = {}", dataGroup.getDataGroupPath());
		
		log.info("----------- input = {}", uploadDataFile.getFilePath());
		log.info("----------- output = {}", dataGroupRootPath + dataGroupFilePath);
		log.info("----------- log = {}", dataGroupRootPath + dataGroupFilePath + "logTest.txt");
		
		log.info("-------------------------------------------------------");
		
		QueueMessage queueMessage = new QueueMessage();
		queueMessage.setServerTarget(ServerTarget.USER.name());
		queueMessage.setConverterJobId(converterJobFile.getConverterJobId());
		queueMessage.setInputFolder(uploadDataFile.getFilePath());
		queueMessage.setOutputFolder(dataGroupRootPath + dataGroupFilePath);
		queueMessage.setMeshType("0");
		queueMessage.setLogPath(dataGroupRootPath + dataGroupFilePath + "logTest.txt");
		queueMessage.setIndexing("y");
		queueMessage.setUsf(converterJobFile.getUsf());
		queueMessage.setUserId(userId);
		
		// TODO
		// 조금 미묘하다. transaction 처리를 할지, 관리자 UI 재 실행을 위해서는 여기가 맞는거 같기도 하고....
		// 별도 기능으로 분리해야 하나?
		try {
			aMQPPublishService.send(queueMessage);
		} catch(Exception ex) {
			ConverterJob converterJob = new ConverterJob();
			converterJob.setUserId(userId);
			converterJob.setConverterJobId(converterJobFile.getConverterJobId());
			converterJob.setStatus(ConverterJobStatus.WAITING.name());
			converterJob.setErrorCode(ex.getMessage());
			converterMapper.updateConverterJob(converterJob);
			
			ex.printStackTrace();
		}
	}
	
	/**
	 * dataKey 존재하지 않을 경우 insert, 존재할 경우 update
	 * @param userId
	 * @param uploadDataFile
	 */
	private DataInfo insertData(String userId, UploadDataFile uploadDataFile) {
		String dataKey = uploadDataFile.getFileRealName().substring(0, uploadDataFile.getFileRealName().lastIndexOf("."));
		DataInfo dataInfo = new DataInfo();
		dataInfo.setDataGroupId(uploadDataFile.getDataGroupId());
		dataInfo.setDataKey(dataKey);
		
		dataInfo = dataService.getDataByDataKey(dataInfo);
		if(dataInfo == null) {
			int order = 1;
			// TODO nodeType 도 입력해야 함
			String metainfo = "{\"isPhysical\": true}";
			
			dataInfo = new DataInfo();
			dataInfo.setMethodType(MethodType.INSERT);
			dataInfo.setDataGroupId(uploadDataFile.getDataGroupId());
			dataInfo.setSharing(uploadDataFile.getSharing());
			dataInfo.setDataType(uploadDataFile.getDataType());
			dataInfo.setDataKey(uploadDataFile.getFileRealName().substring(0, uploadDataFile.getFileRealName().lastIndexOf(".")));
			dataInfo.setDataName(uploadDataFile.getFileName().substring(0, uploadDataFile.getFileName().lastIndexOf(".")));
			dataInfo.setUserId(userId);
			dataInfo.setLatitude(uploadDataFile.getLatitude());
			dataInfo.setLongitude(uploadDataFile.getLongitude());
			dataInfo.setAltitude(uploadDataFile.getAltitude());
			if(uploadDataFile.getLongitude() != null && uploadDataFile.getLatitude() != null) {
				dataInfo.setLocation("POINT(" + uploadDataFile.getLongitude() + " " + uploadDataFile.getLatitude() + ")");
			}
			dataInfo.setMetainfo(metainfo);
			dataService.insertData(dataInfo);
		} else {
			dataInfo.setMethodType(MethodType.UPDATE);
			dataInfo.setSharing(uploadDataFile.getSharing());
			dataInfo.setDataType(uploadDataFile.getDataType());
			dataInfo.setDataName(uploadDataFile.getFileName().substring(0, uploadDataFile.getFileName().lastIndexOf(".")));
			dataInfo.setUserId(userId);
			dataInfo.setLatitude(uploadDataFile.getLatitude());
			dataInfo.setLongitude(uploadDataFile.getLongitude());
			dataInfo.setAltitude(uploadDataFile.getAltitude());
			if(uploadDataFile.getLongitude() != null && uploadDataFile.getLatitude() != null) {
				dataInfo.setLocation("POINT(" + uploadDataFile.getLongitude() + " " + uploadDataFile.getLatitude() + ")");
			}
			dataService.updateData(dataInfo);
		}
		
		return dataInfo;
	}
	
	/**
	 * dataKey 존재하지 않을 경우 insert, 존재할 경우 update
	 * @param userId
	 * @param dataInfo
	 * @param uploadDataFile
	 */
	private void updateDataGroup(String userId, DataInfo dataInfo, UploadDataFile uploadDataFile) {
		DataGroup dataGroup = DataGroup.builder()
				.userId(userId)
				.dataGroupId(uploadDataFile.getDataGroupId())
				.build();
		
		DataGroup dbDataGroup = dataGroupService.getDataGroup(dataGroup);
		
		if(MethodType.INSERT == dataInfo.getMethodType()) {
			dataGroup.setDataCount(dbDataGroup.getDataCount() + 1);
		}

		if(LocationUdateType.AUTO == LocationUdateType.valueOf(dbDataGroup.getLocationUpdateType().toUpperCase())) {
			dataGroup.setLocation("POINT(" + dataInfo.getLongitude() + " " + dataInfo.getLatitude() + ")");
			dataGroup.setAltitude(dataInfo.getAltitude());
		}
		
		dataGroupService.updateDataGroup(dataGroup);
	}
	
	/**
	 * 데이터 변환 작업 상태를 변경
	 * @param converterJob
	 * @return
	 */
	@Transactional
	public int updateConverterJob(ConverterJob converterJob) {
		return converterMapper.updateConverterJob(converterJob);
	}
}
