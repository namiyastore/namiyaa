package global.sesoc.namiya.vo;

public class Categories {
	private int categorynum;
	private String categoryname;
	private int depth;
	private int parentnum;
	
	public Categories() {}
	
	public Categories(int categorynum, String categoryname, int depth, int parentnum) {
		super();
		this.categorynum = categorynum;
		this.categoryname = categoryname;
		this.depth = depth;
		this.parentnum = parentnum;
	}

	public int getCategorynum() {
		return categorynum;
	}

	public void setCategorynum(int categorynum) {
		this.categorynum = categorynum;
	}

	public String getCategoryname() {
		return categoryname;
	}

	public void setCategoryname(String categoryname) {
		this.categoryname = categoryname;
	}

	public int getDepth() {
		return depth;
	}

	public void setDepth(int depth) {
		this.depth = depth;
	}

	public int getParentnum() {
		return parentnum;
	}

	public void setParentnum(int parentnum) {
		this.parentnum = parentnum;
	}

	@Override
	public String toString() {
		return "Categories [categorynum=" + categorynum + ", categoryname=" + categoryname + ", depth=" + depth
				+ ", parentnum=" + parentnum + "]";
	}
	
	
	
	
}
