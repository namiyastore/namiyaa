package global.sesoc.namiya.vo;

public class Keyword {
	private int keywordnum;
	private String keywordname;
	private String category;
	private String userid;
	
	public Keyword() {}

	public Keyword(int keywordnum, String keywordname, String category, String userid) {
		super();
		this.keywordnum = keywordnum;
		this.keywordname = keywordname;
		this.category = category;
		this.userid = userid;
	}

	public int getKeywordnum() {
		return keywordnum;
	}

	public void setKeywordnum(int keywordnum) {
		this.keywordnum = keywordnum;
	}

	public String getKeywordname() {
		return keywordname;
	}

	public void setKeywordname(String keywordname) {
		this.keywordname = keywordname;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	@Override
	public String toString() {
		return "Keyword [keywordnum=" + keywordnum + ", keywordname=" + keywordname + ", category=" + category
				+ ", userid=" + userid + "]";
	}
	
	
	
}
