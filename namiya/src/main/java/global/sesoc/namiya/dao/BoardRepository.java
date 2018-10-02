package global.sesoc.namiya.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.namiya.vo.Board;
import global.sesoc.namiya.vo.History;
import global.sesoc.namiya.vo.Interest;
import global.sesoc.namiya.vo.Members;
import global.sesoc.namiya.vo.Message;
import global.sesoc.namiya.vo.Wish;

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

	public Interest selectItr(Map<String, String> parm) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		Interest itr = mapper.selectItr(parm);
		
		return itr;
	}

	public int insertItr(Interest interest) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		int result = mapper.insertItr(interest);
		
		return result;
	}

	public int insertHst(History history) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		int result = mapper.insertHst(history);
		
		return result;
	}

	public List<Wish> selectWish(Map<String, String> param) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		List<Wish> wlist = mapper.selectWish(param);
		
		return wlist;
	}

	public int insertWish(Wish wish) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		int result = mapper.insertWish(wish);
		
		return result;
	}

	public List<Wish> selectWishAll(int boardnum) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		List<Wish> list = mapper.selectWishAll(boardnum);
		
		return list;
	}

	public History selectHst(int historynum) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		History history = mapper.selectHst(historynum);
		
		return history;
	}

	public Board selectBoard(int productnum) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		Board board = mapper.selectBoard(productnum);
		
		return board;
	}

	public int insertMsg(Message message) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		int result = mapper.insertMsg(message);
		
		return result;
	}

	public History selectHstone(int productnum) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		History history = mapper.selectHstone(productnum);
		
		return history;
	}

	public int updateHst(History history) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		int result = mapper.updateHst(history);
		
		return result;
	}

	public int updateBuyer(History history) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		int result = mapper.updateBuyer(history);
		
		return result;
	}

	public int reviewgetTotalPage(String store_owner) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		int recordCount = mapper.reviewgetTotalPage(store_owner);
		
		return recordCount;
	}

	public List<Board> selectAll() {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		List<Board> result = mapper.selectAll();
		
		return result;
	}
}
