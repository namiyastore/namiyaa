package global.sesoc.namiya.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.namiya.vo.Keyword;

@Repository
public class KeywordRepository {
	@Autowired
	SqlSession session;

	public List<Keyword> kListAll() {
		KeywordMapper mapper = session.getMapper(KeywordMapper.class);
		List<Keyword> klist = mapper.kListAll();
		return klist;
	}

	public int kInsert(Keyword keyword) {
		KeywordMapper mapper = session.getMapper(KeywordMapper.class);
		int result = mapper.kInsert(keyword);
		return result;
	}

	public int kDelete(int keywordnum) {
		KeywordMapper mapper = session.getMapper(KeywordMapper.class);
		int result = mapper.kDelete(keywordnum);
		return result;
	}

	public Keyword kSelectOne(int keywordnum) {
		KeywordMapper mapper = session.getMapper(KeywordMapper.class);
		Keyword kword = mapper.kSelectOne(keywordnum);
		return kword;
	}

	public int kUpdate(Keyword keyword) {
		KeywordMapper mapper = session.getMapper(KeywordMapper.class);
		int result = mapper.kUpdate(keyword);
		return result;
	}
	
		
}
