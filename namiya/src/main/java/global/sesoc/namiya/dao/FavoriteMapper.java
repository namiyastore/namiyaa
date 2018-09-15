package global.sesoc.namiya.dao;

import java.util.List;
import java.util.Map;

import global.sesoc.namiya.vo.Favorite;


public interface FavoriteMapper {
	public List<Favorite> fListAll();
	public int fInsert(Favorite favorite);
	public int fDelete(int favoritenum);
	public Favorite fSelect(Favorite favorite);
	public Favorite fSelectOne(int favoritenum);
	public List<Map<String,String>> fList(String userid);
	public int fUpdate(Favorite favorite);
}