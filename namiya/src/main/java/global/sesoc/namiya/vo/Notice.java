package global.sesoc.namiya.vo;

public class Notice {
	
	private int noticenum;
	private String userid;
	private int boardnum;
	
	public Notice() {}

	public Notice(int noticenum, String userid, int boardnum) {
		super();
		this.noticenum = noticenum;
		this.userid = userid;
		this.boardnum = boardnum;
	}

	public int getNoticenum() {
		return noticenum;
	}

	public void setNoticenum(int noticenum) {
		this.noticenum = noticenum;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public int getBoardnum() {
		return boardnum;
	}

	public void setBoardnum(int boardnum) {
		this.boardnum = boardnum;
	}

	@Override
	public String toString() {
		return "Notice [noticenum=" + noticenum + ", userid=" + userid + ", boardnum=" + boardnum + "]";
	}
	
	
}
