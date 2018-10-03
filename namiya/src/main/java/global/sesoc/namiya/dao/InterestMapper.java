package global.sesoc.namiya.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import global.sesoc.namiya.vo.Interest;

public interface InterestMapper {
	public List<Interest> iListAll(String userid, RowBounds rb);
	public int iInsert(Interest interest);
	public int iDelete(int interestnum);
	public Interest iSelectOne(int interestnum);
	public int iUpdate(Interest interest);
	public int getHistoryRecordCount(String userid);
};