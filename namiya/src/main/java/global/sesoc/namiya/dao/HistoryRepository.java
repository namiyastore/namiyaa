package global.sesoc.namiya.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.namiya.vo.History;
import global.sesoc.namiya.vo.Message;

@Repository
public class HistoryRepository{
	@Autowired
	SqlSession session;

	public List<History> hListAll(String userid, int startRecord, int countPerPage) {
		HistoryMapper mapper = session.getMapper(HistoryMapper.class);
		RowBounds rb = new RowBounds(startRecord,countPerPage);
		
		List<History> list = mapper.hListAll(userid,rb);
		return list;
	}
	//페이징관련
	public int getHistoryRecordCount(String userid) {
		HistoryMapper mapper = session.getMapper(HistoryMapper.class);
		int recordCount =  mapper.getHistoryRecordCount(userid);
		/*System.out.println("1003 거래이력 글 갯수? " + recordCount);*/
		return recordCount;
	}

	public int hInsert(History history) {
		HistoryMapper mapper = session.getMapper(HistoryMapper.class);
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
