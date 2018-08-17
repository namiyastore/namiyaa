package global.sesoc.namiya.vo;

public class Saving {

	private String userid;
	private int point;
	private int priority;
	
	public Saving() {}

	public Saving(String userid, int point, int priority) {
		super();
		this.userid = userid;
		this.point = point;
		this.priority = priority;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public int getPriority() {
		return priority;
	}

	public void setPriority(int priority) {
		this.priority = priority;
	}

	@Override
	public String toString() {
		return "Saving [userid=" + userid + ", point=" + point + ", priority=" + priority + "]";
	}
	
	
}
