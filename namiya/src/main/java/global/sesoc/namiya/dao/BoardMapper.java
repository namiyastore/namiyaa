package global.sesoc.namiya.dao;

import java.util.List;
import java.util.Map;

import global.sesoc.namiya.vo.Board;


public interface BoardMapper {

	public int insertBrd(Board board); // 글작성

	public List<Board> selectGiveList(String service); // 양도글 불러오기
	
}