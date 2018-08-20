package global.sesoc.namiya.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import global.sesoc.namiya.dao.BoardRepository;
import global.sesoc.namiya.dao.CategoriesRepository;
import global.sesoc.namiya.util.FileService;
import global.sesoc.namiya.vo.Board;
import global.sesoc.namiya.vo.Categories;

@Controller
public class MyStoreController {
	@Autowired
	CategoriesRepository repository;
	
	@Autowired
	BoardRepository b_repository;
	
	final String uploadPath = "/boardfile";
	
	// myStore 띄우기 
	@RequestMapping(value="/myStore")
	public String myStore() {
		return "mystore/myStore";
	}
	
	// give 페이지 띄우기 
	@RequestMapping(value="/give")
	public String give() {
		
		return "mystore/give";
	}
	
	// 대분류 불러오기 
	@RequestMapping(value="/giveForm")
	public String giveForm(Model model) {
		List<Categories> c_list = repository.selectClist();
		model.addAttribute("c_list", c_list);
		System.out.println(c_list);
		
		return "mystore/giveForm";
	}
	
	// 중분류 불러오기
	@ResponseBody
	@RequestMapping(value="/selectMlist", method=RequestMethod.GET)
	public List<Categories> selectMlist(int categorynum) {
		List<Categories> m_list = repository.selectMlist(categorynum);
		System.out.println(m_list);
		
		return m_list;
	}
	
	// 소분류 불러오기 
	@ResponseBody
	@RequestMapping(value="/selectSlist", method=RequestMethod.GET)
	public List<Categories> selectSlist(int categorynum) {
		List<Categories> s_list = repository.selectSlist(categorynum);
		System.out.println(s_list);
		return s_list;
	}
	
	// 글작성
	@RequestMapping(value="write", method=RequestMethod.POST)
	public String write(Board board, MultipartFile upload, HttpSession session) {
		System.out.println(board);
		String originalfile = upload.getOriginalFilename();
		String savedfile = FileService.saveFile(upload, uploadPath);
		String userid = (String) session.getAttribute("loginId");
		
		board.setOriginalfile(originalfile);
		board.setSavedfile(savedfile);
		board.setUserid(userid);
		
		int result = b_repository.insert(board);
		
		return "redirect:/give";
	}
}
