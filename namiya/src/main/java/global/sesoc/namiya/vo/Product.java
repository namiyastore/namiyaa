package global.sesoc.namiya.vo;

public class Product {
	
	private int productnum;
	private int categorynum;
	private String productname;
	private String sstatus;
	
	public Product() {}

	public Product(int productnum, int categorynum, String productname, String sstatus) {
		super();
		this.productnum = productnum;
		this.categorynum = categorynum;
		this.productname = productname;
		this.sstatus = sstatus;
	}

	public int getProductnum() {
		return productnum;
	}

	public void setProductnum(int productnum) {
		this.productnum = productnum;
	}

	public int getCategorynum() {
		return categorynum;
	}

	public void setCategorynum(int categorynum) {
		this.categorynum = categorynum;
	}

	public String getProductname() {
		return productname;
	}

	public void setProductname(String productname) {
		this.productname = productname;
	}

	public String getSstatus() {
		return sstatus;
	}

	public void setSstatus(String sstatus) {
		this.sstatus = sstatus;
	}

	@Override
	public String toString() {
		return "Product [productnum=" + productnum + ", categorynum=" + categorynum + ", productname=" + productname
				+ ", sstatus=" + sstatus + "]";
	}
	
	
}
