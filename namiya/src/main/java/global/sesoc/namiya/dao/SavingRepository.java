package global.sesoc.namiya.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.namiya.vo.Saving;

@Repository
public class SavingRepository {
	
	@Autowired
	SqlSession session;
	
	/*
	 * 포인트 확인(String : type -> '양도' 또는 '기부')
	 * ajax로 호출
	 */
	public int pointCheck(Saving saving) {
		SavingMapper mapper = session.getMapper(SavingMapper.class);
		
		int result = mapper.pointCheck(saving);
		
		return result;
	}

	/*
	 * 포인트 추가(String : type -> '양도' 또는 '재능기부')
	 * ajax로 호출
	 */
	public int pointAdd(Saving saving) {
		SavingMapper mapper = session.getMapper(SavingMapper.class);
		int result = mapper.pointAdd(saving);
		
		return result;
	}

	/*
	 * 총 포인트
	 * ajax로 호출
	 */
	public int pointTotal(String userid) {
		SavingMapper mapper = session.getMapper(SavingMapper.class);
		int result = mapper.pointTotal(userid);
		
		return result;
	}

	/*
	 * 포인트 사용(int : point -> 사용할 포인트양)
	 * ajax로 호출
	 */
	public int pointMinus(Saving saving) {
		SavingMapper mapper = session.getMapper(SavingMapper.class);
		int result = mapper.pointMinus(saving);
		
		return result;
	}

	/*
	 * 포인트 기록 조회
	 */
	public List<Saving> pointRecord(String userid) {
		SavingMapper mapper = session.getMapper(SavingMapper.class);
		List<Saving> result = mapper.pointRecord(userid);
		
		return result;
	}
		
}
