package global.sesoc.namiya.vo;


public class Profile {
	
	private int profile_seq;
	private String userid;
	private String originalfile;
	private String savedfile;
	private String content;
	private String nickname;
	
	public Profile() {}

	
	
	public Profile(int profile_seq, String userid, String originalfile, String savedfile, String content,
			String nickname) {
		super();
		this.profile_seq = profile_seq;
		this.userid = userid;
		this.originalfile = originalfile;
		this.savedfile = savedfile;
		this.content = content;
		this.nickname = nickname;
	}



	public int getProfile_seq() {
		return profile_seq;
	}

	public void setProfile_seq(int profile_seq) {
		this.profile_seq = profile_seq;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getOriginalfile() {
		return originalfile;
	}

	public void setOriginalfile(String originalfile) {
		this.originalfile = originalfile;
	}

	public String getSavedfile() {
		return savedfile;
	}

	public void setSavedfile(String savedfile) {
		this.savedfile = savedfile;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}



	@Override
	public String toString() {
		return "Profile [profile_seq=" + profile_seq + ", userid=" + userid + ", originalfile=" + originalfile
				+ ", savedfile=" + savedfile + ", content=" + content + ", nickname=" + nickname + "]";
	}
	
	
}
