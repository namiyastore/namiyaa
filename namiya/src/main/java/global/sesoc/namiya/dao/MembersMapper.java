package global.sesoc.namiya.dao;

import java.util.List;
import java.util.Map;

import global.sesoc.namiya.vo.Members;


public interface MembersMapper {

	public Members selectOne(Members m);

	public int insertMembers(Members members);
	
}