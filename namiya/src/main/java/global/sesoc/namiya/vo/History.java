package global.sesoc.namiya.vo;

public class History {
	private int historynum;
	private String sellerid;
	private String buyerid;
	private String regdate;
	
	public History() {}

	public History(int historynum, String sellerid, String buyerid, String regdate) {
		super();
		this.historynum = historynum;
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
		return "History [historynum=" + historynum + ", sellerid=" + sellerid + ", buyerid=" + buyerid + ", regdate="
				+ regdate + "]";
	}
	
	
	
}
