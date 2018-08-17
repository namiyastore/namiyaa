package global.sesoc.namiya.vo;


public class Board {
	
	private int boardnum;
	private int productnum;
	private String userid; 
	private String regdate;
	private String title; 		
	private String content; 
	private String service; 
	private String originalfile;
	private String savedfile;
	 

	public Board() {}


	public Board(int boardnum, int productnum, String userid, String regdate, String title, String content,
			String service, String originalfile, String savedfile) {
		super();
		this.boardnum = boardnum;
		this.productnum = productnum;
		this.userid = userid;
		this.regdate = regdate;
		this.title = title;
		this.content = content;
		this.service = service;
		this.originalfile = originalfile;
		this.savedfile = savedfile;
	}


	public int getBoardnum() {
		return boardnum;
	}


	public void setBoardnum(int boardnum) {
		this.boardnum = boardnum;
	}


	public int getProductnum() {
		return productnum;
	}


	public void setProductnum(int productnum) {
		this.productnum = productnum;
	}


	public String getUserid() {
		return userid;
	}


	public void setUserid(String userid) {
		this.userid = userid;
	}


	public String getRegdate() {
		return regdate;
	}


	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}


	public String getContent() {
		return content;
	}


	public void setContent(String content) {
		this.content = content;
	}


	public String getService() {
		return service;
	}


	public void setService(String service) {
		this.service = service;
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


	@Override
	public String toString() {
		return "Board [boardnum=" + boardnum + ", productnum=" + productnum + ", userid=" + userid + ", regdate="
				+ regdate + ", title=" + title + ", content=" + content + ", service=" + service + ", originalfile="
				+ originalfile + ", savedfile=" + savedfile + "]";
	}

	

}
