package global.sesoc.namiya.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.namiya.vo.Review;

@Repository
public class ReviewRepository {
	@Autowired
	SqlSession session;
	
	public List<Review> selectReviewAll(String store_owner) {
		ReviewMapper mapper = session.getMapper(ReviewMapper.class);
		List<Review> list = mapper.selectReviewAll(store_owner);
		
		return list;
	}

	public int insertReview(Review review) {
		ReviewMapper mapper = session.getMapper(ReviewMapper.class);
		int result = mapper.insertReview(review);
		
		return result;
	}

	public int deleteReview(int reviewnum) {
		ReviewMapper mapper = session.getMapper(ReviewMapper.class);
		int result = mapper.deleteReview(reviewnum);
		
		return result;
	}
	
	
		
}
