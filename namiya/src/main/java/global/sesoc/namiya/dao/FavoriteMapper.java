package global.sesoc.namiya.dao;

import java.util.List;
import java.util.Map;

import global.sesoc.namiya.vo.Favorite;


public interface FavoriteMapper {
	public List<Favorite> fListAll();
	public int fInsert(Favorite favorite);
	public int fDelete(int favoritenum);
	public Favorite fSelectOne(int favoritenum);
	public int fUpdate(Favorite favorite);
}