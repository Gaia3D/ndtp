package ndtp.service.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import ndtp.domain.SimFileMaster;
import ndtp.persistence.SimuMapper;


@Service
public class SimuServiceImpl {

	@Autowired
	private SimuMapper simuMapper;

	public SimFileMaster getSimFileMaster() {
		return this.simuMapper.getSimCityPlanFileList();
	}

	@Transactional
	public List<String> procStroeShp(MultipartFile[] files) {
		String Path = "";
		List<String> result = new ArrayList<String>();
		for(MultipartFile mtf : files) {
			String Name = mtf.getName();
			result.add(this.restore(mtf));
		}
		return result;
	}

	private void genFolder(String path) {
		File Folder = new File(path);

		// 해당 디렉토리가 없을경우 디렉토리를 생성합니다.
		if (!Folder.exists()) {
			try{
				Folder.mkdir(); //폴더 생성합니다.
				System.out.println("폴더가 생성되었습니다.");
			}
			catch(Exception e){
				e.getStackTrace();
			}
		}else {
			System.out.println("이미 폴더가 생성되어 있습니다.");
		}
	}

	private String restore(MultipartFile multipartFile) {
		String url = null;
//		String PREFIX_URL = "C:\\data\\mago3d\\normal-upload-data\\";
//		String SAVE_PATH = "C:\\data\\mago3d\\normal-upload-data\\";
		//todo: have to change (if running window)
		String PREFIX_URL = "/Users/junho/data/mago3d/";
		String SAVE_PATH = "/Users/junho/data/mago3d/";

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


			this.writeFile(multipartFile, saveFileName, SAVE_PATH);
			simuMapper.insertSimCityPlanFile(new SimFileMaster(originFilename, saveFileName, SAVE_PATH));
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
}
