package global.sesoc.namiya.dao;

import java.util.List;

import global.sesoc.namiya.vo.Saving;


public interface SavingMapper {
	
	/*
	 * 포인트 확인(String : type -> '양도' 또는 '기부')
	 * ajax로 호출
	 */
	public int pointCheck(Saving saving);
	
	/*
	 * 포인트 추가(String : type -> '양도' 또는 '재능기부')
	 * ajax로 호출
	 */
	public int pointAdd(Saving saving);
	
	/*
	 * 총 포인트
	 * ajax로 호출
	 */
	public int pointTotal(String userid);
	
	/*
	 * 포인트 사용(int : point -> 사용할 포인트양)
	 * ajax로 호출
	 */
	public int pointMinus(Saving saving);
	
	/*
	 * 포인트 기록 조회
	 */
	public List<Saving> pointRecord(String userid);
}