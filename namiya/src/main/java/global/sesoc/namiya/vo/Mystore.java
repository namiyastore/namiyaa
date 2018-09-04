package global.sesoc.namiya.vo;

public class Mystore {
	private int imagenum;
	private String userid;
	private int itemnum;
	private int currentframe;
	private String px;
	private String py;
	private int imageorder;
	private String type;
	
	public Mystore() {}

	public Mystore(int imagenum, String userid, int itemnum, int currentframe, String px, String py, int imageorder,
			String type) {
		super();
		this.imagenum = imagenum;
		this.userid = userid;
		this.itemnum = itemnum;
		this.currentframe = currentframe;
		this.px = px;
		this.py = py;
		this.imageorder = imageorder;
		this.type = type;
	}

	public int getImagenum() {
		return imagenum;
	}

	public void setImagenum(int imagenum) {
		this.imagenum = imagenum;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public int getItemnum() {
		return itemnum;
	}

	public void setItemnum(int itemnum) {
		this.itemnum = itemnum;
	}

	public int getCurrentframe() {
		return currentframe;
	}

	public void setCurrentframe(int currentframe) {
		this.currentframe = currentframe;
	}

	public String getPx() {
		return px;
	}

	public void setPx(String px) {
		this.px = px;
	}

	public String getPy() {
		return py;
	}

	public void setPy(String py) {
		this.py = py;
	}

	public int getImageorder() {
		return imageorder;
	}

	public void setImageorder(int imageorder) {
		this.imageorder = imageorder;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	@Override
	public String toString() {
		return "Mystore [imagenum=" + imagenum + ", userid=" + userid + ", itemnum=" + itemnum + ", currentframe="
				+ currentframe + ", px=" + px + ", py=" + py + ", imageorder=" + imageorder + ", type=" + type + "]";
	}

	
	
	
}
