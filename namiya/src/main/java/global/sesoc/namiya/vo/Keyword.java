package global.sesoc.namiya.vo;

public class Keyword {
	private int keywordnum;
	private String keywordname;
	private int categorynum;
	private String userid;
	
	public Keyword() {
		// TODO Auto-generated constructor stub
	}

	public Keyword(int keywordnum, String keywordname, int categorynum, String userid) {
		super();
		this.keywordnum = keywordnum;
		this.keywordname = keywordname;
		this.categorynum = categorynum;
		this.userid = userid;
	}

	public int getKeywordnum() {
		return keywordnum;
	}

	public String getKeywordname() {
		return keywordname;
	}

	public int getCategorynum() {
		return categorynum;
	}

	public String getUserid() {
		return userid;
	}

	public void setKeywordnum(int keywordnum) {
		this.keywordnum = keywordnum;
	}

	public void setKeywordname(String keywordname) {
		this.keywordname = keywordname;
	}

	public void setCategorynum(int categorynum) {
		this.categorynum = categorynum;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	@Override
	public String toString() {
		return "Keyword [keywordnum=" + keywordnum + ", keywordname=" + keywordname + ", categorynum=" + categorynum
				+ ", userid=" + userid + "]";
	}
	
	
}
