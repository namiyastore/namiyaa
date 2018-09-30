package global.sesoc.namiya.vo;

/**
 * @author JW Lim
 *
 */
public class Interest {
	private int interestnum;
	private String userid;
	private int boardnum;
	private String title;
	public Interest() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Interest(int interestnum, String userid, int boardnum, String title) {
		super();
		this.interestnum = interestnum;
		this.userid = userid;
		this.boardnum = boardnum;
		this.title = title;
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
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	@Override
	public String toString() {
		return "Interest [interestnum=" + interestnum + ", userid=" + userid + ", boardnum=" + boardnum + ", title="
				+ title + "]";
	}
	
	
}
