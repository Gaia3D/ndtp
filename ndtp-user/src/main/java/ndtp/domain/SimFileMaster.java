package ndtp.domain;

import java.util.Date;

import lombok.Data;

@Data
public class SimFileMaster {
	private Integer sim_file_seq;
	private String origin_file_name;
	private String save_file_name;
	private String save_file_path;
	private Date create_dt;
	public SimFileMaster(String origin_file_name, String save_file_name, String save_file_path) {
		super();
		this.origin_file_name = origin_file_name;
		this.save_file_name = save_file_name;
		this.save_file_path = save_file_path;
	}
	public SimFileMaster(Integer sim_file_seq, String origin_file_name, String save_file_name, String save_file_path,
						 Date create_dt) {
		super();
		this.sim_file_seq = sim_file_seq;
		this.origin_file_name = origin_file_name;
		this.save_file_name = save_file_name;
		this.save_file_path = save_file_path;
		this.create_dt = create_dt;
	}

}
