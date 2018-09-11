package global.sesoc.namiya.dao;

import java.util.List;

import global.sesoc.namiya.vo.Review;


public interface ReviewMapper {
	public List<Review> selectReviewAll(String store_owner); // 후기게시판 글 불러오기

	public int insertReview(Review review); // 후기 작성하기 

	public int deleteReview(int reviewnum); // 후기 삭제하기
	
}