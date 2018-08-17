package global.sesoc.namiya.vo;

public class Mystore {
	
	private int imagenum;
	private String userid;
	private int totalframes;
	private int currentframe;
	private int width;
	private int height;
	private String filename;
	private String px;
	private String py;
	
	public Mystore() {}

	public Mystore(int imagenum, String userid, int totalframes, int currentframe, int width, int height,
			String filename, String px, String py) {
		super();
		this.imagenum = imagenum;
		this.userid = userid;
		this.totalframes = totalframes;
		this.currentframe = currentframe;
		this.width = width;
		this.height = height;
		this.filename = filename;
		this.px = px;
		this.py = py;
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

	public int getTotalframes() {
		return totalframes;
	}

	public void setTotalframes(int totalframes) {
		this.totalframes = totalframes;
	}

	public int getCurrentframe() {
		return currentframe;
	}

	public void setCurrentframe(int currentframe) {
		this.currentframe = currentframe;
	}

	public int getWidth() {
		return width;
	}

	public void setWidth(int width) {
		this.width = width;
	}

	public int getHeight() {
		return height;
	}

	public void setHeight(int height) {
		this.height = height;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
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

	@Override
	public String toString() {
		return "Mystore [imagenum=" + imagenum + ", userid=" + userid + ", totalframes=" + totalframes
				+ ", currentframe=" + currentframe + ", width=" + width + ", height=" + height + ", filename="
				+ filename + ", px=" + px + ", py=" + py + "]";
	}
	
	
}
