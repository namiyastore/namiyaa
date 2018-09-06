package global.sesoc.namiya.dao;

import java.util.List;
import java.util.Map;

import global.sesoc.namiya.vo.Interest;

/*interest
iListAll
iSelectOne
iDelete
iPaging
iInsert
*/

public interface InterestMapper {
	public List<Interest> iListAll();
	public int iInsert(Interest interest);
	public int iDelete(int interestnum);
	public Interest iSelectOne(int interestnum);
	public int iUpdate(Interest interest);
};