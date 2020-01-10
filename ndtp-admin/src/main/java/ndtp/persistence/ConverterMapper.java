package ndtp.persistence;

import org.springframework.stereotype.Repository;

import ndtp.domain.ConverterJob;
import ndtp.domain.ConverterJobFile;

/**
 * f4d converter manager
 * @author jeongdae
 *
 */
@Repository
public interface ConverterMapper {
	
	/**
	 * insert converter job
	 * @param converterJob
	 * @return
	 */
	public Long insertConverterJob(ConverterJob converterJob);
	
	/**
	 * insert converter job file
	 * @param converterJobFile
	 * @return
	 */
	public Long insertConverterJobFile(ConverterJobFile converterJobFile);
	
	/**
	 * update
	 * @param converterJob
	 */
	public void updateConverterJob(ConverterJob converterJob);
}
