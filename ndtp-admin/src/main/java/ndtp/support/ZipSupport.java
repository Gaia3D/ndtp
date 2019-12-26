package ndtp.support;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.util.List;

import org.apache.commons.compress.archivers.zip.ZipArchiveEntry;
import org.apache.commons.compress.archivers.zip.ZipArchiveOutputStream;

import ndtp.domain.LayerFileInfo;

public class ZipSupport {

	public static void makeZip(String zipFileName, List<LayerFileInfo> layerFileInfoList) throws Exception {

		// buffer size
		int size = 1024;
		byte[] buf = new byte[size];
         
        try (	FileOutputStream fileOutputStream = new FileOutputStream(zipFileName);
        		BufferedOutputStream bufferedOutputStream = new BufferedOutputStream(fileOutputStream);
        		ZipArchiveOutputStream zipArchiveOutputStream = new ZipArchiveOutputStream(bufferedOutputStream)) {
        	
        	zipArchiveOutputStream.setEncoding("UTF-8");
        	for(LayerFileInfo layerFileInfo : layerFileInfoList) {
        		
        		try (	FileInputStream fileInputStream = new FileInputStream(layerFileInfo.getFilePath() + layerFileInfo.getFileRealName());
        				BufferedInputStream bufferedInputStream = new BufferedInputStream(fileInputStream, size)) {
        			// zip에 넣을 다음 entry 를 가져온다.
        			zipArchiveOutputStream.putArchiveEntry(new ZipArchiveEntry(layerFileInfo.getFileRealName()));
        			
        			int len;
        			while((len = bufferedInputStream.read(buf,0,size)) != -1) {
        				zipArchiveOutputStream.write(buf,0,len);
        			}
        			zipArchiveOutputStream.closeArchiveEntry();
        		} catch(Exception e) {
        			e.printStackTrace();
					throw new RuntimeException(e.getMessage());
        		}
            }
        } catch (FileNotFoundException e) {
        	e.printStackTrace();
        }
	}
}
