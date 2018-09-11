package global.sesoc.namiya.vo;

public class Members {
	private String userid;
	private String password;
	private String username;
	private String birthday;
	private String gender;
	private String email;
	private String phoneNo;
	private String fullAddr;
	private String zipcode;
	private String myurl;
	public Members() {
		super();
	}
	public Members(String userid, String password, String username, String birthday, String gender, String email,
			String phoneNo, String fullAddr, String zipcode, String myurl) {
		super();
		this.userid = userid;
		this.password = password;
		this.username = username;
		this.birthday = birthday;
		this.gender = gender;
		this.email = email;
		this.phoneNo = phoneNo;
		this.fullAddr = fullAddr;
		this.zipcode = zipcode;
		this.myurl = myurl;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhoneNo() {
		return phoneNo;
	}
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}
	public String getFullAddr() {
		return fullAddr;
	}
	public void setFullAddr(String fullAddr) {
		this.fullAddr = fullAddr;
	}
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public String getMyurl() {
		return myurl;
	}
	public void setMyurl(String myurl) {
		this.myurl = myurl;
	}
	@Override
	public String toString() {
		return "Members [userid=" + userid + ", password=" + password + ", username=" + username + ", birthday="
				+ birthday + ", gender=" + gender + ", email=" + email + ", phoneNo=" + phoneNo + ", fullAddr="
				+ fullAddr + ", zipcode=" + zipcode + ", myurl=" + myurl + "]";
	}

	
	
	
	
	
	
	
}
