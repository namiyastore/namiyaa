package global.sesoc.namiya.vo;

public class History {
	 private int historynum;
	 private int productnum;
	 private String sellerid;
	 private String buyerid;
	 private String deal_start;
	 private String deal_end;
	 
	public History(int historynum, int productnum, String sellerid, String buyerid, String deal_start,
			String deal_end) {
		this.historynum = historynum;
		this.productnum = productnum;
		this.sellerid = sellerid;
		this.buyerid = buyerid;
		this.deal_start = deal_start;
		this.deal_end = deal_end;
	}

	public History() {
	
	}

	public int getHistorynum() {
		return historynum;
	}

	public void setHistorynum(int historynum) {
		this.historynum = historynum;
	}

	public int getProductnum() {
		return productnum;
	}

	public void setProductnum(int productnum) {
		this.productnum = productnum;
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

	public String getDeal_start() {
		return deal_start;
	}

	public void setDeal_start(String deal_start) {
		this.deal_start = deal_start;
	}

	public String getDeal_end() {
		return deal_end;
	}

	public void setDeal_end(String deal_end) {
		this.deal_end = deal_end;
	}

	@Override
	public String toString() {
		return "History [historynum=" + historynum + ", productnum=" + productnum + ", sellerid=" + sellerid
				+ ", buyerid=" + buyerid + ", deal_start=" + deal_start + ", deal_end=" + deal_end + "]";
	}
	 
}
