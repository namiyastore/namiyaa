package global.sesoc.namiya.vo;

public class Keywordchk {    
    private int pnum;
	private String userid;
	private int boardnum;
	
	public Keywordchk() {
		// TODO Auto-generated constructor stub
	}

	public Keywordchk(int pnum, String userid, int boardnum) {
		super();
		this.pnum = pnum;
		this.userid = userid;
		this.boardnum = boardnum;
	}

	public int getPnum() {
		return pnum;
	}

	public String getUserid() {
		return userid;
	}

	public int getBoardnum() {
		return boardnum;
	}

	public void setPnum(int pnum) {
		this.pnum = pnum;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public void setBoardnum(int boardnum) {
		this.boardnum = boardnum;
	}

	@Override
	public String toString() {
		return "Keywordchk [pnum=" + pnum + ", userid=" + userid + ", boardnum=" + boardnum + "]";
	}
	
	
}
