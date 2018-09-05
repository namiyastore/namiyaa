package global.sesoc.namiya.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import global.sesoc.namiya.vo.Board;

public interface SearchMapper {
	
	/**
	 * 등록된 전체 글 개수( 검색 )
	 * @return
	 */
	public int getTotalBoard(String searchWord);

	/**
	 * 등록된 전체 글 검색
	 * @param map
	 * @param rb
	 * @return
	 */
	public List<Board> selectAll(Map<String, String> map, RowBounds rb);

	/**
	 * 등록된 전체 글 개수( 카테고리 : 대분류 )
	 * @param parseInt
	 * @return
	 */
	public int getTotalBoardbyMajorCategory(int parentnum);

	/**
	 * 등록된 전체 글 검색(대분류)
	 * @param rb
	 * @return
	 */
	public List<Board> selectAllbyCategory(int parentnum, RowBounds rb);
	
	/**
	 * 등록된 전체 글 개수( 카테고리 : 중분류 )
	 * @param parseInt
	 * @return
	 */
	public int getTotalBoardbyMediumCategory(int parentnum);

	/**
	 * 등록된 전체 글 검색(중분류)
	 * @param rb
	 * @return
	 */
	public List<Board> selectAllbyCategoryMedium(int parentnum, RowBounds rb);

	/**
	 * 등록된 전체 글 개수( 카테고리 : 소분류 )
	 * @param parseInt
	 * @return
	 */
	public int getTotalBoardbyMinorCategory(int parentnum);

	/**
	 * 등록된 전체 글 검색(소분류)
	 * @param rb
	 * @return
	 */
	public List<Board> selectAllbyCategoryMinor(int parentnum, RowBounds rb);

	/**
	 * 실시간 알림
	 * @return
	 */
	public Board noticeForAll();
}
