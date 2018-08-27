package global.sesoc.namiya.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

	public List<Board> selectGiveList(String service) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		List<Board> list = mapper.selectGiveList(service);
		
		return list;
	}
	
	
		
}
