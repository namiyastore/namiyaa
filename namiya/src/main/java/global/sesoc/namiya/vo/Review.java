package global.sesoc.namiya.vo;

public class Review {
	
	private int reviewnum;
	private String userid;
	private String review_content;
	private String regdate;
	private String store_owner;
	
	public Review () {}

	public Review(int reviewnum, String userid, String review_content, String regdate, String store_owner) {
		super();
		this.reviewnum = reviewnum;
		this.userid = userid;
		this.review_content = review_content;
		this.regdate = regdate;
		this.store_owner = store_owner;
	}

	public int getReviewnum() {
		return reviewnum;
	}

	public void setReviewnum(int reviewnum) {
		this.reviewnum = reviewnum;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getReview_content() {
		return review_content;
	}

	public void setReview_content(String review_content) {
		this.review_content = review_content;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public String getStore_owner() {
		return store_owner;
	}

	public void setStore_owner(String store_owner) {
		this.store_owner = store_owner;
	}

	@Override
	public String toString() {
		return "Review [reviewnum=" + reviewnum + ", userid=" + userid + ", review_content=" + review_content
				+ ", regdate=" + regdate + ", store_owner=" + store_owner + "]";
	}
	
	
}
