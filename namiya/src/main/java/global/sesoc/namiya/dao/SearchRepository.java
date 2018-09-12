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
public class SearchRepository {
	
	@Autowired
	SqlSession session;
	
	public int getTotalBoard(String searchWord) {
		SearchMapper mapper = session.getMapper(SearchMapper.class);
		
		int result = mapper.getTotalBoard(searchWord);		
		
		return result;
	}

	public List<Board> selectAll(String searchWord, int startRecord, int countPerPage) {
		RowBounds rb = new RowBounds(startRecord,countPerPage);
		
		SearchMapper mapper = session.getMapper(SearchMapper.class);		
		Map<String,String> map = new HashMap<String,String>();
		
		map.put("searchWord", searchWord);
		
		List<Board> result = mapper.selectAll(map, rb);
		
		return result;
	}

	/*
	 * 대분류(total)
	 */
	public int getTotalBoardbyMajorCategory(int parentnum) {
		SearchMapper mapper = session.getMapper(SearchMapper.class);
		
		int result = mapper.getTotalBoardbyMajorCategory(parentnum);
		
		return result;
	}

	/**
	 * 대분류(카테고리 검색결과)
	 * @param startRecord
	 * @param countPerPage
	 * @return
	 */
	public List<Board> selectAllbyCategory(int parentnum, int startRecord, int countPerPage) {
		RowBounds rb = new RowBounds(startRecord,countPerPage);
		
		SearchMapper mapper = session.getMapper(SearchMapper.class);
		
		List<Board> result = mapper.selectAllbyCategory(parentnum, rb);
		
		return result;
	}

	/*
	 * 중분류(total)
	 */
	public int getTotalBoardbyMediumCategory(int pnum) {
		SearchMapper mapper = session.getMapper(SearchMapper.class);
		
		int result = mapper.getTotalBoardbyMediumCategory(pnum);
		
		return result;
	}

	/**
	 * 중분류(카테고리 검색결과)
	 * @param startRecord
	 * @param countPerPage
	 * @return
	 */
	public List<Board> selectAllbyCategoryMedium(int pnum, int startRecord, int countPerPage) {
		RowBounds rb = new RowBounds(startRecord,countPerPage);
		
		SearchMapper mapper = session.getMapper(SearchMapper.class);
		
		List<Board> result = mapper.selectAllbyCategoryMedium(pnum, rb);
		
		return result;
	}

	/*
	 * 소분류(total)
	 */
	public int getTotalBoardbyMinorCategory(int pnum) {
		SearchMapper mapper = session.getMapper(SearchMapper.class);
		
		int result = mapper.getTotalBoardbyMinorCategory(pnum);
		
		return result;
	}

	/**
	 * 소분류(카테고리 검색결과)
	 * @param startRecord
	 * @param countPerPage
	 * @return
	 */
	public List<Board> selectAllbyCategoryMinor(int pnum, int startRecord, int countPerPage) {
		RowBounds rb = new RowBounds(startRecord,countPerPage);
		
		SearchMapper mapper = session.getMapper(SearchMapper.class);
		
		List<Board> result = mapper.selectAllbyCategoryMinor(pnum, rb);
		
		return result;
	}

	public Board noticeForAll() {
		SearchMapper mapper = session.getMapper(SearchMapper.class);
		Board result = mapper.noticeForAll();
		
		return result;
	}
	
}
