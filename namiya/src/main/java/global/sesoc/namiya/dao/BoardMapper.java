package global.sesoc.namiya.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import global.sesoc.namiya.vo.Board;
import global.sesoc.namiya.vo.History;
import global.sesoc.namiya.vo.Interest;
import global.sesoc.namiya.vo.Members;
import global.sesoc.namiya.vo.Message;
import global.sesoc.namiya.vo.Wish;


public interface BoardMapper {

	public int insertBrd(Board board); // 글작성

	public List<HashMap<String, Object>> selectList(Map<String, String> parm, RowBounds rb); // 양도글 불러오기

	public Board selectOne(int boardnum); // give 글 상세보기 

	public int deleteOne(int boardnum); // 게시글 삭제하기 

	public int boardUpdate(Board board); // 게시글 수정하기 

	public int getTotalPage(Map<String, String> parm); // 전체 글 개수 알아내기

	public Members selectMember(String userid); // 멤버찾기

	public Interest selectItr(Map<String, String> parm); // interest 중복 찾기 

	public int insertItr(Interest interest); // interest 넣기

	public int insertHst(History history); // history에 넣기

	public List<Wish> selectWish(Map<String, String> param); // wish에서 동일한 값 찾기

	public int insertWish(Wish wish); // wish목록에 넣기

	public List<Wish> selectWishAll(int boardnum); // wishlist불러오기

	public History selectHst(int historynum); // history 찾기 

	public Board selectBoard(int productnum); // productnum으로  찾기

	public int insertMsg(Message message); // 쪽지 보내기 

	public History selectHstone(int productnum); // 상품번호로 거래내역 찾기

	public int updateHst(History history); // 날짜 카운트 업데이트

	public int updateBuyer(History history); // 구매자 업데이트

	public int reviewgetTotalPage(String store_owner);

	public List<Board> selectAll();
}