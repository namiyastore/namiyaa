package global.sesoc.namiya.vo;

public class Members {
	private String userid;
	private String password;
	private String username;
	private String email;
	private String phone;
	private String zip;
	private String address;
	private String myurl;
	
	public Members() {}
	
	public Members(String userid, String password, String username, String email, String phone, String zip,
			String address, String myurl) {
		super();
		this.userid = userid;
		this.password = password;
		this.username = username;
		this.email = email;
		this.phone = phone;
		this.zip = zip;
		this.address = address;
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

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getZip() {
		return zip;
	}

	public void setZip(String zip) {
		this.zip = zip;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getMyurl() {
		return myurl;
	}

	public void setMyurl(String myurl) {
		this.myurl = myurl;
	}

	@Override
	public String toString() {
		return "Members [userid=" + userid + ", password=" + password + ", username=" + username + ", email=" + email
				+ ", phone=" + phone + ", zip=" + zip + ", address=" + address + ", myurl=" + myurl + "]";
	}
	
	
	
}
