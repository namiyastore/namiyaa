package global.sesoc.namiya.vo;

public class Saving {

	private int saving_seq;		// 고유번호
	private String userid;		// 사용자 아이디
	private int point;			// 포인트
	private String type;		// 타입(양도,재능기부)
	private String regdate;		// 기록날짜
	
	public Saving() {}

	public Saving(int saving_seq, String userid, int point, String type, String regdate) {
		super();
		this.saving_seq = saving_seq;
		this.userid = userid;
		this.point = point;
		this.type = type;
		this.regdate = regdate;
	}

	public int getSaving_seq() {
		return saving_seq;
	}

	public String getUserid() {
		return userid;
	}

	public int getPoint() {
		return point;
	}

	public String getType() {
		return type;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setSaving_seq(int saving_seq) {
		this.saving_seq = saving_seq;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public void setType(String type) {
		this.type = type;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	@Override
	public String toString() {
		return "Saving [saving_seq=" + saving_seq + ", userid=" + userid + ", point=" + point + ", type=" + type
				+ ", regdate=" + regdate + "]";
	}
	
}
