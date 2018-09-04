package global.sesoc.namiya.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.namiya.vo.Board;

@Repository
public class BoardRepository {
	@Autowired
	SqlSession session;

	public int insertBrd(Board board) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		int result = mapper.insertBrd(board);
		
		return result;
	}

	public  List<HashMap<String, Object>> selectList(Map<String,String> parm) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		 List<HashMap<String, Object>> map = mapper.selectList(parm);
		
		return map;
	}

	public Board selectOne(int boardnum) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		Board board = mapper.selectOne(boardnum);
		
		return board;
	}


	public int getTotalPage(String service, String userid) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		int recordCount = mapper.getTotalPage(service, userid);
		return recordCount;
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
	
	
		
}
