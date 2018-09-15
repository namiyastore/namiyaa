package global.sesoc.namiya.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.namiya.vo.Product;
import global.sesoc.namiya.vo.Profile;

@Repository
public class ProfileRepository {
	@Autowired
	SqlSession session;
	
	public Profile select(String userid) {
		ProfileMapper mapper = session.getMapper(ProfileMapper.class);
		Profile list = mapper.select(userid);
		return list;
	}
	
	public int update(Profile profile) {
		ProfileMapper mapper = session.getMapper(ProfileMapper.class);
		int cnt = mapper.update(profile);
		return cnt;
	}
		
}
