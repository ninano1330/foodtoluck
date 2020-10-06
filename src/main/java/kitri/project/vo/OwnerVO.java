package kitri.project.vo;


import org.springframework.stereotype.Component;

@Component
public class OwnerVO {
	String owner_id;
	String reg_number;
	
	public OwnerVO(){}

	
	public OwnerVO(String owner_id, String reg_number) {
		super();
		this.owner_id = owner_id;
		this.reg_number = reg_number;
	}


	public String getOwner_id() {
		return owner_id;
	}

	public void setOwner_id(String owner_id) {
		this.owner_id = owner_id;
	}

	public String getReg_number() {
		return reg_number;
	}

	public void setReg_number(String reg_number) {
		this.reg_number = reg_number;
	}
}
