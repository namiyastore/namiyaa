package global.sesoc.namiya.vo;

public class linenotify {
	
	String userid;
    String token;
    String onoff;
	
    public linenotify(String userid, String token, String onoff) {
		super();
		this.userid = userid;
		this.token = token;
		this.onoff = onoff;
	}

	public String getUserid() {
		return userid;
	}

	public String getToken() {
		return token;
	}

	public String getOnoff() {
		return onoff;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public void setOnoff(String onoff) {
		this.onoff = onoff;
	}

	@Override
	public String toString() {
		return "linenotify [userid=" + userid + ", token=" + token + ", onoff=" + onoff + "]";
	}
    
}
