package global.sesoc.namiya.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.namiya.dao.CategoriesRepository;
import global.sesoc.namiya.dao.SearchRepository;
import global.sesoc.namiya.util.PageNavigator;
import global.sesoc.namiya.vo.Board;
import global.sesoc.namiya.vo.Categories;

@Controller
public class SearchController {
	
	@Autowired
	CategoriesRepository repository;
	
	@Autowired
	SearchRepository search_repository;
	
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
	public String result
	(
		@RequestParam(value="currentPage1", defaultValue="1") int currentPage1,
		@RequestParam(value="currentPage2", defaultValue="1") int currentPage2,
		@RequestParam(value="currentPage3", defaultValue="1") int currentPage3,
		@RequestParam(value="currentPage4", defaultValue="1") int currentPage4,
		@RequestParam(value="searchWord", defaultValue="") String searchWord,
		@RequestParam(value="parentnum", defaultValue="") String parentnum,
		@RequestParam(value="searchFlag", defaultValue="off") String searchFlag,
		@RequestParam(value="categoryGroup", defaultValue="none") String categoryGroup,
		Model model
	) {
		int totalRecordCount = 0;
		PageNavigator navi = null;
		List<Board> list = null;
		
		// 검색버튼 클릭
		if(searchFlag.equals("on"))	{
			totalRecordCount = search_repository.getTotalBoard(searchWord);
			navi = new PageNavigator(currentPage1, totalRecordCount, 5, 5);
			list = search_repository.selectAll(searchWord, navi.getStartRecord(), navi.getCountPerPage());
		}
		// 카테고리 클릭
		else if(searchFlag.equals("off")){
			int pnum = Integer.parseInt(parentnum);
			
			if(categoryGroup.equals("major")) {
				totalRecordCount = search_repository.getTotalBoardbyMajorCategory(pnum);
				navi = new PageNavigator(currentPage2, totalRecordCount, 5, 5);
				list = search_repository.selectAllbyCategory(pnum, navi.getStartRecord(), navi.getCountPerPage());
			}
			else if(categoryGroup.equals("medium")) {
				totalRecordCount = search_repository.getTotalBoardbyMediumCategory(pnum);
				navi = new PageNavigator(currentPage3, totalRecordCount, 5, 5);
				list = search_repository.selectAllbyCategoryMedium(pnum, navi.getStartRecord(), navi.getCountPerPage());
			}
			else if(categoryGroup.equals("minor")) {
				totalRecordCount = search_repository.getTotalBoardbyMinorCategory(pnum);
				navi = new PageNavigator(currentPage4, totalRecordCount, 5, 5);
				list = search_repository.selectAllbyCategoryMinor(pnum, navi.getStartRecord(), navi.getCountPerPage());
			}
		}
		
		model.addAttribute("list", list);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("navi", navi);
		model.addAttribute("currentPage1", currentPage1);
		model.addAttribute("currentPage2", currentPage2);
		model.addAttribute("currentPage3", currentPage3);
		model.addAttribute("currentPage4", currentPage4);
		
		model.addAttribute("totalRecordCount", totalRecordCount);
		model.addAttribute("searchFlag", searchFlag);
		model.addAttribute("parentnum", parentnum);
		model.addAttribute("categoryGroup", categoryGroup);
		
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
	
	/**
	 * 카테고리 중분류 가져오기
	 * @param categorynum
	 * @return
	 */
	@RequestMapping(value="mediumCategory", method=RequestMethod.GET)
	public @ResponseBody List<Categories> mediumCategory(int categorynum) {
		List<Categories> m_list = repository.selectMlist(categorynum);
		System.out.println(m_list);
		
		return m_list;
	}
	
	/**
	 * 카테고리 소분류 가져오기
	 * @param categorynum
	 * @return
	 */
	@RequestMapping(value="minerCategory", method=RequestMethod.GET)
	public @ResponseBody List<Categories> minerCategory(int categorynum) {
		List<Categories> s_list = repository.selectSlist(categorynum);
		System.out.println(s_list);
		
		return s_list;
	}
	
	/*
	 * 실시간 알림
	 */
	@RequestMapping(value="noticeForAll", method=RequestMethod.GET)
	public @ResponseBody Board noticeForAll() {
		Board result = search_repository.noticeForAll();
		System.out.println(result);
		
		return result;
	}
	
}
