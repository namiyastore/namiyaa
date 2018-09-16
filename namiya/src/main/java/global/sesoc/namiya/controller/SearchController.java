package global.sesoc.namiya.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

import com.google.gson.Gson;

import global.sesoc.namiya.dao.CategoriesRepository;
import global.sesoc.namiya.dao.MembersRepository;
import global.sesoc.namiya.dao.ProfileRepository;
import global.sesoc.namiya.dao.SearchRepository;
import global.sesoc.namiya.util.PageNavigator;
import global.sesoc.namiya.vo.Board;
import global.sesoc.namiya.vo.Categories;
import global.sesoc.namiya.vo.Members;
import global.sesoc.namiya.vo.Product;
import global.sesoc.namiya.vo.Profile;

@Controller
public class SearchController {
	
	@Autowired
	CategoriesRepository repository;
	
	@Autowired
	SearchRepository search_repository;
	
	@Autowired
	ProfileRepository profile_repository;
	
	@Autowired
	MembersRepository Members_repository;
	
	/**
	 * 검색 페이지로 이동
	 * @return
	 */
	@RequestMapping(value="search", method=RequestMethod.GET)
	public String search(HttpSession session, Model model) {
		String userid = session.getAttribute("loginId").toString();
		
		Members m = new Members();
		
		m.setUserid(userid);
		
		Members result1 = Members_repository.selectOne(m);
		
		model.addAttribute("myurl",result1.getMyurl());
		
		return "search";
	}
	
	/**
	 * 실시간 페이지 첫내용 확인
	 * @return
	 */
	@RequestMapping(value="searchPageInit", method=RequestMethod.GET)
	public @ResponseBody List<Board> searchPageInit() {
		int totalRecordCount = 0;
		PageNavigator navi = null;
		List<Board> result = null;
		int pageCountSet = 10;
				
		totalRecordCount = search_repository.getTotalBoard("");
		navi = new PageNavigator(1, totalRecordCount, pageCountSet, pageCountSet);
		result = search_repository.selectAll("", navi.getStartRecord(), navi.getCountPerPage());
				
		return result;
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
		String myurl,
		Model model
	) {
		int totalRecordCount = 0;
		PageNavigator navi = null;
		List<Board> list = null;
		int pageCountSet = 10;
		
		// 검색버튼 클릭
		if(searchFlag.equals("on"))	{
			totalRecordCount = search_repository.getTotalBoard(searchWord);
			navi = new PageNavigator(currentPage1, totalRecordCount, pageCountSet, pageCountSet);
			list = search_repository.selectAll(searchWord, navi.getStartRecord(), navi.getCountPerPage());
		}
		// 카테고리 클릭
		else if(searchFlag.equals("off")){
			int pnum = Integer.parseInt(parentnum);
			
			if(categoryGroup.equals("major")) {
				totalRecordCount = search_repository.getTotalBoardbyMajorCategory(pnum);
				navi = new PageNavigator(currentPage2, totalRecordCount, pageCountSet, pageCountSet);
				list = search_repository.selectAllbyCategory(pnum, navi.getStartRecord(), navi.getCountPerPage());
			}
			else if(categoryGroup.equals("medium")) {
				totalRecordCount = search_repository.getTotalBoardbyMediumCategory(pnum);
				navi = new PageNavigator(currentPage3, totalRecordCount, pageCountSet, pageCountSet);
				list = search_repository.selectAllbyCategoryMedium(pnum, navi.getStartRecord(), navi.getCountPerPage());
			}
			else if(categoryGroup.equals("minor")) {
				totalRecordCount = search_repository.getTotalBoardbyMinorCategory(pnum);
				navi = new PageNavigator(currentPage4, totalRecordCount, pageCountSet, pageCountSet);
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
		
		model.addAttribute("myurl", myurl);
		
		return "result";
	}
	
	/*
	 * 내정보 확인
	 */
	@RequestMapping(value="myPage", method=RequestMethod.GET)
	public String myPage() {
		
		return "mypage/myPage";
	}
	
	/**
	 * 카테고리 대분류 가져오기
	 * @return
	 */
	@RequestMapping(value="majorCategory", method=RequestMethod.GET)
	public @ResponseBody List<Categories> majorCategory(String lang) {
		
		Map<String,String> map = new HashMap<String,String>();
		
		map.put("lang", lang);
		
		List<Categories> c_list = repository.Clist(map);
		
		return c_list;
	}
	
	/**
	 * 카테고리 중분류 가져오기
	 * @param categorynum
	 * @return
	 */
	@RequestMapping(value="mediumCategory", method=RequestMethod.GET)
	public @ResponseBody List<Categories> mediumCategory(int categorynum, String lang) {		
		List<Categories> m_list = repository.Mlist(categorynum, lang);
		
		return m_list;
	}
	
	/**
	 * 카테고리 소분류 가져오기
	 * @param categorynum
	 * @return
	 */
	@RequestMapping(value="minerCategory", method=RequestMethod.GET)
	public @ResponseBody List<Categories> minerCategory(int categorynum, String lang) {
		List<Categories> s_list = repository.Slist(categorynum, lang);
		
		return s_list;
	}
	
	/*
	 * 실시간 알림
	 */
	@RequestMapping(value="noticeForAll", method=RequestMethod.GET)
	public @ResponseBody Board noticeForAll(String lang) {
		Board result = search_repository.noticeForAll();
		
		if(result != null) {
			if(lang.equals("en")) {
				if(result.getService().equals("양도"))
					result.setService("Transfer");
				else if(result.getService().equals("재능기부"))
					result.setService("Talent donation");
				else if(result.getService().equals("교환"))
					result.setService("barter");
			}
			else if(lang.equals("ja")) {
				if(result.getService().equals("양도"))
					result.setService("譲渡");
				else if(result.getService().equals("재능기부"))
					result.setService("才能寄付");
				else if(result.getService().equals("교환"))
					result.setService("才能");
			}
		}
		
		return result;
	}
	
	@RequestMapping(value="selectItemRanking", method=RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public @ResponseBody String selectItemRanking(HttpSession session) {
		String lang = session.getAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME).toString();
		Map<String,String> map = new HashMap<String,String>();
		map.put("lang", lang);
		List<Product> result = search_repository.selectItemRanking(map);
		
		Gson gson = new Gson();
		
		String json = gson.toJson(result);
		
		return json;
	}
	
}
