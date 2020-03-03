package ndtp.support;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

import org.apache.commons.compress.archivers.zip.ZipArchiveEntry;
import org.apache.commons.compress.archivers.zip.ZipArchiveOutputStream;

import lombok.extern.slf4j.Slf4j;
import ndtp.domain.LayerFileInfo;

/**
 * TODO 사용안함. 삭제 예정
 * @author Jeongdae
 *
 */
@Slf4j
public class ZipSupport {

	public static void makeZip(String zipFileName, List<LayerFileInfo> layerFileInfoList) throws Exception {

//		// buffer size
//		int size = 1024;
//		byte[] buf = new byte[size];
//         
//        try (	FileOutputStream fileOutputStream = new FileOutputStream(zipFileName);
//        		BufferedOutputStream bufferedOutputStream = new BufferedOutputStream(fileOutputStream);
//        		ZipArchiveOutputStream zipArchiveOutputStream = new ZipArchiveOutputStream(bufferedOutputStream)) {
//        	
//        	zipArchiveOutputStream.setEncoding("UTF-8");
//        	for(LayerFileInfo layerFileInfo : layerFileInfoList) {
//        		
//        		try (	FileInputStream fileInputStream = new FileInputStream(layerFileInfo.getFilePath() + layerFileInfo.getFileRealName());
//        				BufferedInputStream bufferedInputStream = new BufferedInputStream(fileInputStream, size)) {
//        			// zip에 넣을 다음 entry 를 가져온다.
//        			zipArchiveOutputStream.putArchiveEntry(new ZipArchiveEntry(layerFileInfo.getFileRealName()));
//        			
//        			int len;
//        			while((len = bufferedInputStream.read(buf,0,size)) != -1) {
//        				zipArchiveOutputStream.write(buf,0,len);
//        			}
//        			zipArchiveOutputStream.closeArchiveEntry();
//        		} catch(IOException e) {
//        			log.info("@@ IOException. message = {}", e.getMessage());
//        			throw new RuntimeException(e.getMessage());
//        		} catch(Exception e) {
//        			log.info("@@ Exception. message = {}", e.getMessage());
//					throw new RuntimeException(e.getMessage());
//        		}
//            }
//        } catch (FileNotFoundException e) {
//        	log.info("@@ FileNotFoundException. message = {}", e.getMessage());
//        }
	}
}
