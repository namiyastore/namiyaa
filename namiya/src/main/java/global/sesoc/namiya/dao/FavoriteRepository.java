package global.sesoc.namiya.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.namiya.vo.Favorite;

@Repository
public class FavoriteRepository{
	@Autowired
	SqlSession session;

	public List<Favorite> fListAll() {
		
		FavoriteMapper mapper = session.getMapper(FavoriteMapper.class);
		
		List<Favorite> list = mapper.fListAll();
		
		return list;
	}

	public int fInsert(Favorite favorite) {
		FavoriteMapper mapper = session.getMapper(FavoriteMapper.class);
		
//		System.out.println("넘어왔나?2" + favorite);
		int result = mapper.fInsert(favorite);
		
		return result;
	}

	public int fDelete(int favoritenum) {
		FavoriteMapper mapper = session.getMapper(FavoriteMapper.class);
		
		int result = mapper.fDelete(favoritenum);
		
		return result;
	}
	

	public Favorite fSelectOne(int favoritenum) {
		FavoriteMapper mapper = session.getMapper(FavoriteMapper.class);
		Favorite favorite = mapper.fSelectOne(favoritenum);
		return favorite;
	}
	
	public List<Map<String,String>> fList(String userid){
		FavoriteMapper mapper = session.getMapper(FavoriteMapper.class);
		List<Map<String,String>> list = mapper.fList(userid);
		System.out.println("뽑아보자: "+list);
		return list;
	}
	
	public Favorite fSelect(Favorite favorite) {
		FavoriteMapper mapper = session.getMapper(FavoriteMapper.class);
		Favorite f = mapper.fSelect(favorite);
		return f;
	}
	
	public int fUpdate(Favorite favorite) {
		FavoriteMapper mapper = session.getMapper(FavoriteMapper.class);
		System.out.println("넘어왔나?5" + favorite);
		int result = mapper.fUpdate(favorite);
		System.out.println(result);
		return result;
	}
		
}
