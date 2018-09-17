package global.sesoc.namiya.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.namiya.vo.Members;

@Repository
public class MembersRepository {
	@Autowired
	SqlSession session;

	public Members selectOne(Members m) {
		MembersMapper mapper = session.getMapper(MembersMapper.class);
		Members member = new Members();
		member = mapper.selectOne(m);
		
		return member;
	}

	public int insertMembers(Members members) {
		MembersMapper mapper = session.getMapper(MembersMapper.class);
		int result = 0;
		result = mapper.insertMembers(members);
		return result;
	}

	public int updateMembers(Members member) {
		MembersMapper mapper = session.getMapper(MembersMapper.class);
		int result = 0;
		result = mapper.updateMembers(member);
		return result;
	}
	
	public Members selectUrl(Members m) {
	      MembersMapper mapper = session.getMapper(MembersMapper.class);
	      Members member = new Members();
	      member = mapper.selectUrl(m);
	      
	      return member;
	   }
	
	public int updateURL(Members m) {
	      MembersMapper mapper = session.getMapper(MembersMapper.class);
	      int result = 0;
	      result = mapper.updateURL(m);
	      return result;
	   }

	public Members selectid(String userid) {
	      MembersMapper mapper = session.getMapper(MembersMapper.class);
	      Members member = new Members();
	      member = mapper.selectid(userid);
	      
	      return member;
	   }
	
		
}
