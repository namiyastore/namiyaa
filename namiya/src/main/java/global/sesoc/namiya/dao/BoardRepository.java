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

	public int insert(Board board) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		int result = mapper.insert(board);
		
		return result;
	}
	
	
		
}
