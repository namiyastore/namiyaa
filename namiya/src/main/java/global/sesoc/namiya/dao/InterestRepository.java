package global.sesoc.namiya.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.namiya.vo.Favorite;
import global.sesoc.namiya.vo.Interest;

@Repository
public class InterestRepository {
	@Autowired
	SqlSession session;

	public List<Interest> iListAll(String userid, int startRecord, int countPerPage) {
		InterestMapper mapper = session.getMapper(InterestMapper.class);
		
		RowBounds rb = new RowBounds(startRecord, countPerPage);
		List<Interest> list = mapper.iListAll(userid,rb);

		return list;
	}

	public int iInsert(Interest interest) {
		InterestMapper mapper = session.getMapper(InterestMapper.class);
		
		int result = mapper.iInsert(interest);
		return result;
	}

	public int iDelete(int interestnum) {
		InterestMapper mapper = session.getMapper(InterestMapper.class);
		int result = mapper.iDelete(interestnum);
		
		return result;
	}

	public Interest iSelectOne(int interestnum) {
		InterestMapper mapper = session.getMapper(InterestMapper.class);
		Interest ins = mapper.iSelectOne(interestnum);
		return ins;
	}
	
	public int iUpdate(Interest interest) {
		InterestMapper mapper = session.getMapper(InterestMapper.class);
		int result = mapper.iUpdate(interest);
		return result;
	}
	
	//페이징관련
		public int getHistoryRecordCount(String userid) {
			HistoryMapper mapper = session.getMapper(HistoryMapper.class);
			int recordCount =  mapper.getHistoryRecordCount(userid);
			/*System.out.println("1003 거래이력 글 갯수? " + recordCount);*/
			return recordCount;
		}

}
