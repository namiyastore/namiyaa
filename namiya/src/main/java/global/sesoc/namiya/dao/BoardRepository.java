package global.sesoc.namiya.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.namiya.vo.Board;
import global.sesoc.namiya.vo.Interest;
import global.sesoc.namiya.vo.Members;

@Repository
public class BoardRepository {
	@Autowired
	SqlSession session;

	public int insertBrd(Board board) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		int result = mapper.insertBrd(board);
		
		return result;
	}

	public  List<HashMap<String, Object>> selectList(Map<String,String> parm, int startRecord, int countPerPage) {
		RowBounds rb = new RowBounds(startRecord, countPerPage);
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		
		List<HashMap<String, Object>> map = mapper.selectList(parm, rb);
		
		return map;
	}

	public Board selectOne(int boardnum) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		Board board = mapper.selectOne(boardnum);
		
		return board;
	}

	public int deleteOne(int boardnum) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		int result = mapper.deleteOne(boardnum);
		
		return result;
	}

	public int boardUpdate(Board board) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		int result = mapper.boardUpdate(board);
		
		return result;
	}

	public int getTotalPage(Map<String, String> parm) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		int recordCount = mapper.getTotalPage(parm);
		
		return recordCount;
	}

	public Members selectMember(String userid) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		Members member = mapper.selectMember(userid);
		
		return member;
	}

	public Interest selectItr(Interest interest) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		Interest itr = mapper.selectItr(interest);
		
		return itr;
	}
}
