package global.sesoc.namiya.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import global.sesoc.namiya.dao.BoardRepository;
import global.sesoc.namiya.dao.CategoriesRepository;
import global.sesoc.namiya.dao.ProductRepository;
import global.sesoc.namiya.util.FileService;
import global.sesoc.namiya.vo.Board;
import global.sesoc.namiya.vo.Categories;
import global.sesoc.namiya.vo.Product;

@Controller
public class MyStoreController {
	@Autowired
	CategoriesRepository repository;
	
	@Autowired
	BoardRepository b_repository;
	
	@Autowired
	ProductRepository p_repository;
	
	final String uploadPath = "/boardfile";
	
	// myStore 띄우기 
	@RequestMapping(value="/myStore")
	public String myStore() {
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
	public String setting() {
		
		return "mystore/setting";
	}
	
	// 프로필 편집창 띄우기 
	@RequestMapping(value="/profileEdit")
	public String profileEdit() {
		
		return "mystore/profileEdit";
	}
}
