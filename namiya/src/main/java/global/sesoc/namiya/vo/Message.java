package global.sesoc.namiya.vo;

public class Message {
	
	private int messagenum;
	private String writerid;
	private String msg_title;
	private String msg_content;
	private String regdate;
	private String userid;
	private int copy;
	
	public Message() {}

	public Message(int messagenum, String writerid, String msg_title, String msg_content, String regdate, String userid,
			int copy) {
		super();
		this.messagenum = messagenum;
		this.writerid = writerid;
		this.msg_title = msg_title;
		this.msg_content = msg_content;
		this.regdate = regdate;
		this.userid = userid;
		this.copy = copy;
	}

	public int getMessagenum() {
		return messagenum;
	}

	public void setMessagenum(int messagenum) {
		this.messagenum = messagenum;
	}

	public String getWriterid() {
		return writerid;
	}

	public void setWriterid(String writerid) {
		this.writerid = writerid;
	}

	public String getMsg_title() {
		return msg_title;
	}

	public void setMsg_title(String msg_title) {
		this.msg_title = msg_title;
	}

	public String getMsg_content() {
		return msg_content;
	}

	public void setMsg_content(String msg_content) {
		this.msg_content = msg_content;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public int getCopy() {
		return copy;
	}

	public void setCopy(int copy) {
		this.copy = copy;
	}

	@Override
	public String toString() {
		return "Message [messagenum=" + messagenum + ", writerid=" + writerid + ", msg_title=" + msg_title
				+ ", msg_content=" + msg_content + ", regdate=" + regdate + ", userid=" + userid + ", copy=" + copy
				+ "]";
	}
	
	
}
