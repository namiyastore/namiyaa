package global.sesoc.namiya.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import global.sesoc.namiya.vo.Board;


public interface BoardMapper {

	public int insertBrd(Board board); // 글작성

	public List<HashMap<String, Object>> selectList(Map<String, String> parm); // 양도글 불러오기

	public Board selectOne(int boardnum); // give 글 상세보기 

	public int getTotalPage(String service, String userid); // 전체 글 개수 알아내기

	public int deleteOne(int boardnum); // 게시글 삭제하기 

	public int boardUpdate(Board board); // 게시글 수정하기 
	
}