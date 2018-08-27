package global.sesoc.namiya.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.namiya.dao.CategoriesRepository;
import global.sesoc.namiya.vo.Categories;

@Controller
public class SearchController {
	
	@Autowired
	CategoriesRepository repository;
	
	/**
	 * 검색 페이지로 이동
	 * @return
	 */
	@RequestMapping(value="search", method=RequestMethod.GET)
	public String search() {
		
		return "search";
	}
	
	/**
	 * 검색결과 페이지로 이동
	 * @return
	 */
	@RequestMapping(value="result", method=RequestMethod.GET)
	public String result() {
		
		return "result";
	}
	
	/**
	 * 카테고리 대분류 가져오기
	 * @return
	 */
	@RequestMapping(value="majorCategory", method=RequestMethod.GET)
	public @ResponseBody List<Categories> majorCategory() {
		List<Categories> c_list = repository.selectClist();
		System.out.println(c_list);
		
		return c_list;
	}
	
	@RequestMapping(value="mediumCategory", method=RequestMethod.GET)
	public @ResponseBody List<Categories> mediumCategory(int categorynum) {
		List<Categories> m_list = repository.selectMlist(categorynum);
		System.out.println(m_list);
		
		return m_list;
	}
	
	@RequestMapping(value="minerCategory", method=RequestMethod.GET)
	public @ResponseBody List<Categories> minerCategory(int categorynum) {
		List<Categories> s_list = repository.selectSlist(categorynum);
		System.out.println(s_list);
		
		return s_list;
	}
}
