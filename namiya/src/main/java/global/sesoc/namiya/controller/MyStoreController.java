package global.sesoc.namiya.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import global.sesoc.namiya.dao.BoardRepository;
import global.sesoc.namiya.dao.CategoriesRepository;
import global.sesoc.namiya.dao.MystoreRepository;
import global.sesoc.namiya.dao.ProductRepository;
import global.sesoc.namiya.util.FileService;
import global.sesoc.namiya.util.PageNavigator;
import global.sesoc.namiya.vo.Board;
import global.sesoc.namiya.vo.Categories;
import global.sesoc.namiya.vo.Mystore;
import global.sesoc.namiya.vo.Product;

@Controller
public class MyStoreController {
	@Autowired
	CategoriesRepository repository;
	
	@Autowired
	BoardRepository b_repository;
	
	@Autowired
	ProductRepository p_repository;
	
	@Autowired
	MystoreRepository m_repository;
	
	final String uploadPath = "/boardfile";
	
	// myStore 띄우기 
	@RequestMapping(value="/myStore")
	public String myStore(Model model) {
		
		List<Map<String,String>> list = m_repository.selectAll("aaa");
		model.addAttribute("list", list);
		System.out.println(list);
		return "mystore/myStore";
	}
	
	// give 페이지 띄우기 
	@RequestMapping(value="/give")
	public String give(Model model) {
		String service = "양도";
		List<Board> list = b_repository.selectGiveList(service);
		//System.out.println(list);
		model.addAttribute("list", list);
		
		return "mystore/give";
	}
	
	// give글작성 폼 + 대분류 불러오기 
	@RequestMapping(value="/giveForm")
	public String giveForm(Model model) {
		List<Categories> c_list = repository.selectClist();
		model.addAttribute("c_list", c_list);
		//System.out.println(c_list);
		
		return "mystore/giveForm";
	}
	
	// 중분류 불러오기
	@ResponseBody
	@RequestMapping(value="/selectMlist", method=RequestMethod.GET)
	public List<Categories> selectMlist(int categorynum) {
		List<Categories> m_list = repository.selectMlist(categorynum);
		//System.out.println(m_list);
		
		return m_list;
	}
	
	// 소분류 불러오기 
	@ResponseBody
	@RequestMapping(value="/selectSlist", method=RequestMethod.GET)
	public List<Categories> selectSlist(int categorynum) {
		List<Categories> s_list = repository.selectSlist(categorynum);
		//System.out.println(s_list);
		return s_list;
	}
	
	// give 글작성
	@RequestMapping(value="/write", method=RequestMethod.POST)
	public String write(Board board, MultipartFile upload, HttpSession session, Product product) {
		System.out.println(product);
		//String originalfile = upload.getOriginalFilename();
		//String savedfile = FileService.saveFile(upload, uploadPath);
		// String userid = (String) session.getAttribute("loginId"); -> 로그인, 회원가입 연결되면 하기
		String userid = "aaa";

		int result1 = p_repository.insertPdt(product);
		System.out.println("product result : "+result1);
		Product pr = p_repository.selectOne();
		System.out.println("pr: "+pr);
		
		board.setUserid(userid);
		board.setProductnum(pr.getProductnum());
		System.out.println("board : "+board);

		//board.setOriginalfile(originalfile);
		//board.setSavedfile(savedfile);
		
		int result2 = b_repository.insertBrd(board);
		System.out.println("board result : "+result2);
		return "redirect:/give";
	}
	
	// trade 창 띄우기 
	@RequestMapping(value="/trade")
	public String trade() {
		
		return "mystore/trade";
	}
	
	// trade 글 작성 폼
	@RequestMapping(value="/tradeForm")
	public String tradeForm() {
		
		return "mystore/tradeForm";
	}
	
	// talent 창 띄우기 
	@RequestMapping(value="/talent")
	public String talent() {
		
		return "mystore/talent";
	}
	
	// talent 글 작성 폼
	@RequestMapping(value="/talentForm")
	public String talentForm() {
		
		return "mystore/talentForm";
	}
	
	// review 창 띄우기 
	@RequestMapping(value="/review")
	public String review() {
		
		return "mystore/review";
	}
	
	// 임시 : setting
	@RequestMapping(value="/setting")
	public String setting(Model model) {
		
		List<Map<String,String>> list = m_repository.selectAll("aaa");
		model.addAttribute("list", list);
		System.out.println(list);
		return "mystore/setting";
	}
	
	// 프로필 편집창 띄우기 
	@RequestMapping(value="/profileEdit")
	public String profileEdit() {
		
		return "mystore/profileEdit";
	}
	
	// 미니룸 정보 저장
	@ResponseBody
	@RequestMapping(value="/saveMiniRoom", method=RequestMethod.POST)
	public List<Mystore> saveMiniRoom(@RequestBody List<Mystore> list , Model model) {
		
		//System.out.println(list.get(0));
		
		m_repository.deleteAll("aaa");
		for (int i = 0; i < list.size(); i++) {
			list.get(i).setUserid("aaa");
			list.get(i).setImageorder(i);
			System.out.println(list.get(i));
			m_repository.insert(list.get(i));
		}
		
		return list;
	}
	
	// 가구 반환
	@ResponseBody
	@RequestMapping(value="/reqFurniture", method=RequestMethod.GET)
	public Map<String, Object> reqFurniture(
			@RequestParam(value="currentPage",defaultValue="1") int currentPage,
			@RequestParam(value="searchItem", defaultValue="type") String searchItem,
			@RequestParam(value="searchWord", defaultValue="background") String searchWord,
			Model model) {
		
		int totalItemCount = m_repository.getItemCount(searchItem,searchWord);
		PageNavigator navi = new PageNavigator(currentPage, totalItemCount);
		List<Map<String,Object>> list = m_repository.selectUserItem(searchItem,searchWord, navi.getStartRecord(), navi.getCountPerPage());
		System.out.println("list: "+ list);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("list", list);
		map.put("totalPage", navi.getTotalRecordCount());
		map.put("navi", navi);
		
		
		//int srow = COUNT_PER_PAGE * (currentPage -1) + 1;
		//int erow = (totalPageCount == currentPage) ?  : COUNT_PER_PAGE * currentPage;
		
		return map;
	}
	
}
