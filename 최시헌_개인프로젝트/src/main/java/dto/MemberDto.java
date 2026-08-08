package dto;

public class MemberDto {
	private String name, id, password, password_length, 
	email_1, email_2, phone_1, phone_2, phone_3, region, 
	reg_date, update_date, exit_date;

	public MemberDto(String name, String id, String password, String password_length, String email_1, String email_2,
			String phone_1, String phone_2, String phone_3, String region, String reg_date, String update_date,
			String exit_date) {
		super();
		this.name = name;
		this.id = id;
		this.password = password;
		this.password_length = password_length;
		this.email_1 = email_1;
		this.email_2 = email_2;
		this.phone_1 = phone_1;
		this.phone_2 = phone_2;
		this.phone_3 = phone_3;
		this.region = region;
		this.reg_date = reg_date;
		this.update_date = update_date;
		this.exit_date = exit_date;
	}

	public String getName() {
		return name;
	}

	public String getId() {
		return id;
	}

	public String getPassword() {
		return password;
	}

	public String getPassword_length() {
		return password_length;
	}

	public String getEmail_1() {
		return email_1;
	}

	public String getEmail_2() {
		return email_2;
	}

	public String getPhone_1() {
		return phone_1;
	}

	public String getPhone_2() {
		return phone_2;
	}

	public String getPhone_3() {
		return phone_3;
	}

	public String getRegion() {
		return region;
	}

	public String getReg_date() {
		return reg_date;
	}

	public String getUpdate_date() {
		return update_date;
	}

	public String getExit_date() {
		return exit_date;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}


