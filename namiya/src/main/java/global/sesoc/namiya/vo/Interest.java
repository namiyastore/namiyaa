package global.sesoc.namiya.vo;

public class Interest {
	private int interestnum;
	private String userid;
	private int boardnum;
	
	public Interest() {}

	public Interest(int interestnum, String userid, int boardnum) {
		super();
		this.interestnum = interestnum;
		this.userid = userid;
		this.boardnum = boardnum;
	}

	public int getInterestnum() {
		return interestnum;
	}

	public void setInterestnum(int interestnum) {
		this.interestnum = interestnum;
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
		return "Interest [interestnum=" + interestnum + ", userid=" + userid + ", boardnum=" + boardnum + "]";
	}
	
	
}
