package global.sesoc.namiya.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

	public List<Categories> Clist(Map<String,String> map) {
		CategoriesMapper mapper = session.getMapper(CategoriesMapper.class);
		List<Categories> list = mapper.Clist(map);
		
		return list;
	}

	public List<Categories> Mlist(int categorynum, String lang) {
		CategoriesMapper mapper = session.getMapper(CategoriesMapper.class);
		
		Map<String,Object> map = new HashMap<String,Object>();
		
		map.put("categorynum", categorynum);
		map.put("lang", lang);
		
		List<Categories> list = mapper.Mlist(map);
		
		return list;
	}

	public List<Categories> Slist(int categorynum, String lang) {
		CategoriesMapper mapper = session.getMapper(CategoriesMapper.class);
		
		Map<String,Object> map = new HashMap<String,Object>();
		
		map.put("categorynum", categorynum);
		map.put("lang", lang);
		
		List<Categories> list = mapper.Slist(map);
		
		return list;
	}
		
}
