package global.sesoc.namiya.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.namiya.vo.Categories;

@Repository
public class CategoriesRepository {
	@Autowired
	SqlSession session;
	
	public List<Categories> selectClist() {
		CategoriesMapper mapper = session.getMapper(CategoriesMapper.class);
		List<Categories> list = mapper.selectClist();
		
		return list;
	}

	public List<Categories> selectMlist(int categorynum) {
		CategoriesMapper mapper = session.getMapper(CategoriesMapper.class);
		List<Categories> list = mapper.selectMlist(categorynum);
		
		return list;
	}

	public List<Categories> selectSlist(int categorynum) {
		CategoriesMapper mapper = session.getMapper(CategoriesMapper.class);
		List<Categories> list = mapper.selectSlist(categorynum);
		
		return list;
	}

	
		
}
