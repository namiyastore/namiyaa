package global.sesoc.namiya.vo;

public class Favorite {
	private int favoritenum;
	private String myurl;
	private String userid;
	
	public Favorite() {}
	
	public Favorite(int favoritenum, String myurl, String userid) {
		super();
		this.favoritenum = favoritenum;
		this.myurl = myurl;
		this.userid = userid;
	}



	public int getFavoritenum() {
		return favoritenum;
	}

	public void setFavoritenum(int favoritenum) {
		this.favoritenum = favoritenum;
	}

	public String getMyurl() {
		return myurl;
	}

	public void setMyurl(String myurl) {
		this.myurl = myurl;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	@Override
	public String toString() {
		return "Favorite [favoritenum=" + favoritenum + ", myurl=" + myurl + ", userid=" + userid + "]";
	}

	
	
}
