package global.sesoc.namiya.vo;

public class Linenotify {
	
	private String userid;
    private String token;
    private int onoff;
    
    public Linenotify() { }

	public String getUserid() {
		return userid;
	}

	public String getToken() {
		return token;
	}

	public int getOnoff() {
		return onoff;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public void setOnoff(int onoff) {
		this.onoff = onoff;
	}

	@Override
	public String toString() {
		return "Linenotify [userid=" + userid + ", token=" + token + ", onoff=" + onoff + "]";
	}
    
}
