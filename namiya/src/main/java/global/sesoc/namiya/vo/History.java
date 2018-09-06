package global.sesoc.namiya.vo;

public class History {
	private int historynum;
	private int boardnum;
	private String sellerid;
	private String buyerid;
	private String regdate;
	public History() {
		super();
		// TODO Auto-generated constructor stub
	}
	public History(int historynum, int boardnum, String sellerid, String buyerid, String regdate) {
		super();
		this.historynum = historynum;
		this.boardnum = boardnum;
		this.sellerid = sellerid;
		this.buyerid = buyerid;
		this.regdate = regdate;
	}
	public int getHistorynum() {
		return historynum;
	}
	public void setHistorynum(int historynum) {
		this.historynum = historynum;
	}
	public int getBoardnum() {
		return boardnum;
	}
	public void setBoardnum(int boardnum) {
		this.boardnum = boardnum;
	}
	public String getSellerid() {
		return sellerid;
	}
	public void setSellerid(String sellerid) {
		this.sellerid = sellerid;
	}
	public String getBuyerid() {
		return buyerid;
	}
	public void setBuyerid(String buyerid) {
		this.buyerid = buyerid;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	@Override
	public String toString() {
		return "History [historynum=" + historynum + ", boardnum=" + boardnum + ", sellerid=" + sellerid + ", buyerid="
				+ buyerid + ", regdate=" + regdate + "]";
	}
	
	
}
