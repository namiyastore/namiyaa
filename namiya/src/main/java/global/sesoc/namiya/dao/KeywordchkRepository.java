package global.sesoc.namiya.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.namiya.vo.Keyword;
import global.sesoc.namiya.vo.Keywordchk;

@Repository
public class KeywordchkRepository {
	@Autowired
	SqlSession session;

	public int selectCount(Keywordchk keywordchk) {
		KeywordchkMapper mapper = session.getMapper(KeywordchkMapper.class);
		int result = mapper.selectCount(keywordchk);
		return result;
	}

	public int insertKeywordchk(Keywordchk keywordchk) {
		KeywordchkMapper mapper = session.getMapper(KeywordchkMapper.class);
		int result = mapper.insertKeywordchk(keywordchk);
		return result;
	}

	public int deleteKeywordchk() {
		KeywordchkMapper mapper = session.getMapper(KeywordchkMapper.class);
		int result = mapper.deleteKeywordchk();
		return result;
	}

	

	
	
		
}
