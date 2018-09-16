package global.sesoc.namiya.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.namiya.vo.Linenotify;

@Repository
public class LinenotifyRepository {
	
	@Autowired
	SqlSession session;

	public int insertNotifyToken(Linenotify linenotify) {
		LinenotifyMapper mapper = session.getMapper(LinenotifyMapper.class);
		int result = mapper.insertNotifyToken(linenotify);
				
		return result;
	}

	public Linenotify selectOne(String userid) {
		LinenotifyMapper mapper = session.getMapper(LinenotifyMapper.class);
		Linenotify result = mapper.selectOne(userid);
		
		return result;
	}
	
	
	
}
