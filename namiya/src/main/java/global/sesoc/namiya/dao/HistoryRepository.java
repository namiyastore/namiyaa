package global.sesoc.namiya.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.namiya.vo.History;

@Repository
public class HistoryRepository{
	@Autowired
	SqlSession session;

	public List<History> hListAll(String userid) {
		HistoryMapper mapper = session.getMapper(HistoryMapper.class);
		List<History> list = mapper.hListAll(userid);
		return list;
	}

	public int hInsert(History history) {
		HistoryMapper mapper = session.getMapper(HistoryMapper.class);
		System.out.println("넘어오는가?8"+ history);
		int result = mapper.hInsert(history);
		return result;
	}

	public int hDelete(int hitorynum) {
		HistoryMapper mapper = session.getMapper(HistoryMapper.class);
		int result = mapper.hDelete(hitorynum);
		return result;
	}

	public History hSelectOne(int historynum) {
		HistoryMapper mapper = session.getMapper(HistoryMapper.class);
		History history = mapper.hSelectOne(historynum);
		return history;
	}
	
	public int hUpdate(History history) {
		HistoryMapper mapper = session.getMapper(HistoryMapper.class);
		System.out.println("넘어오는가?10"+history);
		int result = mapper.hUpdate(history);
		return result;
	}

	public History selectHst(int productnum) {
		HistoryMapper mapper = session.getMapper(HistoryMapper.class);
		History history = mapper.selectHst(productnum);
		
		return history;
	}

	public List<History> selecthListAll() {
		HistoryMapper mapper = session.getMapper(HistoryMapper.class);
		List<History> list = mapper.selecthListAll();
		
		return list;
	}

}
