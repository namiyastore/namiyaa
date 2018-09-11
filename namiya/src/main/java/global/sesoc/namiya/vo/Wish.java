package global.sesoc.namiya.vo;

public class Wish {
	private int wishnum;
	private int boardnum;
	private String userid;
	
	public Wish(int wishnum, int boardnum, String userid) {
		this.wishnum = wishnum;
		this.boardnum = boardnum;
		this.userid = userid;
	}

	public Wish() {
		
	}

	public int getWishnum() {
		return wishnum;
	}

	public void setWishnum(int wishnum) {
		this.wishnum = wishnum;
	}

	public int getBoardnum() {
		return boardnum;
	}

	public void setBoardnum(int boardnum) {
		this.boardnum = boardnum;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	@Override
	public String toString() {
		return "Wish [wishnum=" + wishnum + ", boardnum=" + boardnum + ", userid=" + userid + "]";
	}
	
}
