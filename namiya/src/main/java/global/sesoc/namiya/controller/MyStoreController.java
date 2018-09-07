package global.sesoc.namiya.controller;


import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.nio.file.Files;
import java.nio.file.Paths;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.plaf.synth.SynthSeparatorUI;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import global.sesoc.namiya.dao.BoardRepository;
import global.sesoc.namiya.dao.CategoriesRepository;
import global.sesoc.namiya.dao.MystoreRepository;
import global.sesoc.namiya.dao.ProductRepository;
import global.sesoc.namiya.dao.ReviewRepository;
import global.sesoc.namiya.util.FileService;
import global.sesoc.namiya.util.PageNavigator;
import global.sesoc.namiya.vo.Board;
import global.sesoc.namiya.vo.Categories;
import global.sesoc.namiya.vo.Mystore;
import global.sesoc.namiya.vo.Product;
import global.sesoc.namiya.vo.Review;

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
	
	@Autowired
	ReviewRepository r_repository;
	
	final String uploadPath = "/boardfile";
	
	// myStore 띄우기 
	@RequestMapping(value="/myStore")
	public String myStore(Model model) {
		
		List<Map<String,String>> list = m_repository.selectAll("aaa");
		model.addAttribute("list", list);
		System.out.println(list);
		return "mystore/myStore";
	}
	
	// 사진 보여주기 
	@RequestMapping(value=uploadPath+"/{image_name:.+}", method= RequestMethod.GET) 
	public String getContentMediaImage(@PathVariable("image_name")String image_name, HttpServletResponse response) throws UnsupportedEncodingException, IOException {
		// 확장자 확인 // 
			
		 String[] filename_seperate = image_name.split("\\."); 
		 String exp = "";
		   
		 if( filename_seperate.length <= 1 ) { 
		      // 확장자 에러 // 
		      /*String resultMsg = new MessageMaker().getErrorMessage("Wrong file name.");
		      response.getOutputStream().write(resultMsg.getBytes(SystemInfo.ENCODING)); */
		      response.getOutputStream().flush();
		    return null; 
		 } else { 
		    exp = filename_seperate[1]; 
		 } 
		   // 파일 세팅 and 송신 //
		 File file = new File(uploadPath+"/"+image_name );
		 if( ! file.exists() ) {
		      // 파일 없음 //
		      /*String resultMsg = new MessageMaker().getErrorMessage("Not exist that file.");
		      response.getOutputStream().write(resultMsg.getBytes(SystemInfo.ENCODING)); */
		    response.getOutputStream().flush(); 
		    return null; 
	  } 
		 response.setContentType("image/"+exp);
		 int cur;
		 try{
		    FileInputStream fileIn = new FileInputStream(file); 
		    BufferedInputStream bufIn = new BufferedInputStream(fileIn);
		    ServletOutputStream ostream = response.getOutputStream(); 
		    while( (cur=bufIn.read()) != -1 ){ 
		       ostream.write(cur);
		    } 
		    ostream.flush();
		    bufIn.close(); 
		 }catch(Exception e){
		      e.printStackTrace();
		 } 
		 return null;
	}
		
	// 게시글 삭제하기 
	@ResponseBody
	@RequestMapping(value="/deleted", method=RequestMethod.GET)
	public int giveDelete(int boardnum) {
		Board board = b_repository.selectOne(boardnum);
		String fullPath = uploadPath + "/" + board.getSavedfile();
		FileService.deleteFile(fullPath);
		
		int result = b_repository.deleteOne(boardnum);
			
		return result;
	}

	
	
	/** 양도 관련 controller **/
	// give 페이지 띄우기 
	@RequestMapping(value="/give")
	public String give(Model model) {
		String service = "양도";
		String userid = "aaa";
		Map<String, String> parm = new HashMap<String, String>();
		parm.put("service", service);
		parm.put("userid", userid);
		List<HashMap<String, Object>> map = b_repository.selectList(parm);
		
		model.addAttribute("map", map);
		
		return "mystore/give";
	}
	
	// give글작성 폼 + 대분류 불러오기 
	@RequestMapping(value="/giveForm")
	public String giveForm(Model model) {
		List<Categories> c_list = repository.selectClist();
		model.addAttribute("c_list", c_list);
		
		return "mystore/giveForm";
	}
	
	// 중분류 불러오기
	@ResponseBody
	@RequestMapping(value="/selectMlist", method=RequestMethod.GET)
	public List<Categories> selectMlist(int categorynum) {
		List<Categories> m_list = repository.selectMlist(categorynum);
		
		return m_list;
	}
	
	// 소분류 불러오기 
	@ResponseBody
	@RequestMapping(value="/selectSlist", method=RequestMethod.GET)
	public List<Categories> selectSlist(int categorynum) {
		List<Categories> s_list = repository.selectSlist(categorynum);

		return s_list;
	}
	
	// give 글작성
	@RequestMapping(value="/write", method=RequestMethod.POST)
	public String write(Board board, MultipartFile upload, HttpSession session, Product product) {
		String originalfile = upload.getOriginalFilename();
		String savedfile = FileService.saveFile(upload, uploadPath);
		String userid = "aaa";

		int result1 = p_repository.insertPdt(product);
		Product pr = p_repository.selectOne();
		
		board.setUserid(userid);
		board.setProductnum(pr.getProductnum());

		board.setOriginalfile(originalfile);
		board.setSavedfile(savedfile);
		
		int result2 = b_repository.insertBrd(board);

		return "redirect:/give";
	}
	
	// give 글 상세보기 
	@RequestMapping(value="/giveView", method=RequestMethod.GET)
	public String giveView(int boardnum, Model model) {
		Board board = b_repository.selectOne(boardnum);
		int productnum = board.getProductnum();
		
		HashMap<String, Object> map = p_repository.seletPC(productnum);
		String fullPath="";
		if (board.getSavedfile() != null)
			fullPath = uploadPath + "/" + board.getSavedfile();
			try {
				String type = Files.probeContentType(Paths.get(fullPath));
				if(type != null && type.contains("image")){
					model.addAttribute("type", type);
				} else {
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		model.addAttribute("board", board);
		model.addAttribute("map", map);
		
		return "mystore/giveView";
	}
	
	// 게시글 수정폼 불러오기 
	@RequestMapping(value="/giveUpdate", method=RequestMethod.GET)
	public String giveUpdate(Model model, int boardnum) {
		Board board = b_repository.selectOne(boardnum);
		List<Categories> c_list = repository.selectClist();
		int productnum = board.getProductnum();
		HashMap<String, Object> map = p_repository.seletPC(productnum);

		model.addAttribute("board", board);
		model.addAttribute("map", map);
		model.addAttribute("c_list", c_list);
		
		return "mystore/giveUpdate";
	}
	
	// 게시글 수정하기 
	@RequestMapping(value="/update", method=RequestMethod.POST)
	public String update(Board board, Product product, MultipartFile upload) {
		int boardnum = board.getBoardnum();
		Board old = b_repository.selectOne(boardnum);
		
		// 첨부한 경우 
		if (upload.getSize() != 0) {
			String fullPath = uploadPath + "/" + old.getSavedfile();
			System.out.println(fullPath);
			
			FileService.deleteFile(fullPath);
			String originalfile = upload.getOriginalFilename();
			String savedfile = FileService.saveFile(upload, uploadPath);
			
			System.out.println("오리지널 파일 :" + originalfile);
			System.out.println("저장된 파일 :" + savedfile);
			
			board.setOriginalfile(originalfile);
			board.setSavedfile(savedfile);
			
		} else {
			if(old.getOriginalfile() != null && old.getSavedfile() != null) {
				board.setOriginalfile(old.getOriginalfile());
				board.setSavedfile(old.getSavedfile());
			} else {
				board.setOriginalfile("");
				board.setSavedfile("");
			}
		}
		
		int productnum = old.getProductnum();
		
		
		Product pr = p_repository.selectPdt(productnum);
		pr.setCategorynum(product.getCategorynum());
		pr.setProductname(product.getProductname());
		
		int result1 = p_repository.updatePdt(pr);
		int result2 = b_repository.boardUpdate(board);
		
		return "redirect:/give";
	}
	
	// 등록된 사진 지우기 
	@RequestMapping(value="/deletefile", method=RequestMethod.GET)
	public String deletefile(int boardnum, RedirectAttributes rttr, HttpSession session) {
		Board board = b_repository.selectOne(boardnum);
		String fullPath = uploadPath + "/" + board.getSavedfile();
		FileService.deleteFile(fullPath);
		
		board.setOriginalfile("");
		board.setSavedfile("");

		int result = b_repository.boardUpdate(board);
		
		rttr.addAttribute("boardnum", boardnum);
		return "redirect:/giveUpdate";
	}
	
	
	
	/** 교환 관련 controller **/
	// trade 창 띄우기 
	@RequestMapping(value="/trade")
	public String trade(Model model) {
		String service = "교환";
		String userid= "aaa";
		Map<String, String> parm = new HashMap<String, String>();
		parm.put("service", service);
		parm.put("userid", userid);
		List<HashMap<String, Object>> map = b_repository.selectList(parm);
		model.addAttribute("map", map);
		return "mystore/trade";
	}
	
	// trade 글 작성 폼 불러오기
	@RequestMapping(value="/tradeForm")
	public String tradeForm(Model model) {
		List<Categories> c_list = repository.selectClist();
		model.addAttribute("c_list", c_list);
		
		return "mystore/tradeForm";
	}
	
	// tradeform 작성 
	@RequestMapping(value="/tradewrite", method=RequestMethod.POST) 
	public String tradewrite(Board board, MultipartFile upload, HttpSession session, Product product) {
		String originalfile = upload.getOriginalFilename();
		String savedfile = FileService.saveFile(upload, uploadPath);
		String userid = "aaa";

		int result1 = p_repository.insertPdt(product);
		Product pr = p_repository.selectOne();
		
		board.setUserid(userid);
		board.setProductnum(pr.getProductnum());

		board.setOriginalfile(originalfile);
		board.setSavedfile(savedfile);
		
		int result2 = b_repository.insertBrd(board);

		return "redirect:/trade";
	}
	
	// trade 게시판 상세보기 
	@RequestMapping(value="/tradeView", method=RequestMethod.GET)
	public String tradeView(int boardnum, Model model) {
		Board board = b_repository.selectOne(boardnum);
		int productnum = board.getProductnum();
		
		HashMap<String, Object> map = p_repository.seletPC(productnum);
		
		String fullPath="";
		if (board.getSavedfile() != null)
			fullPath = uploadPath + "/" + board.getSavedfile();
			try {
				String type = Files.probeContentType(Paths.get(fullPath));
				if(type != null && type.contains("image")){
					model.addAttribute("type", type);
				} else {
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		model.addAttribute("board", board);
		model.addAttribute("map", map);
		
		return "mystore/tradeView";
	}
	
	// 교환글 수정폼 불러오기 
	@RequestMapping(value="/tradeUpdate", method=RequestMethod.GET)
	public String tradeUpdate(Model model, int boardnum) {
		Board board = b_repository.selectOne(boardnum);
		List<Categories> c_list = repository.selectClist();
		int productnum = board.getProductnum();
		HashMap<String, Object> map = p_repository.seletPC(productnum);

		model.addAttribute("board", board);
		model.addAttribute("map", map);
		model.addAttribute("c_list", c_list);
			
		return "mystore/tradeUpdate";
	}
	
	// 교환 게시글 수정하기 
	@RequestMapping(value="/tradeupdate", method=RequestMethod.POST)
	public String tradeupdate(Board board, Product product, MultipartFile upload) {
		int boardnum = board.getBoardnum();
		Board old = b_repository.selectOne(boardnum);
			
		// 첨부한 경우 
		if (upload.getSize() != 0) {
			String fullPath = uploadPath + "/" + old.getSavedfile();
				
			FileService.deleteFile(fullPath);
			String originalfile = upload.getOriginalFilename();
			String savedfile = FileService.saveFile(upload, uploadPath);
			
			System.out.println("오리지널 파일 :" + originalfile);
			System.out.println("저장된 파일 :" + savedfile);
			
			board.setOriginalfile(originalfile);
			board.setSavedfile(savedfile);
				
		} else {
			if(old.getOriginalfile() != null && old.getSavedfile() != null) {
				board.setOriginalfile(old.getOriginalfile());
				board.setSavedfile(old.getSavedfile());
			} else {
				board.setOriginalfile("");
				board.setSavedfile("");
			}
		}
			
		int productnum = old.getProductnum();
			
			
		Product pr = p_repository.selectPdt(productnum);
		pr.setCategorynum(product.getCategorynum());
		pr.setProductname(product.getProductname());
			
		int result1 = p_repository.updatePdt(pr);
		int result2 = b_repository.boardUpdate(board);
			
		return "redirect:/trade";
	}	
		
	// 등록된 사진 지우기 
	@RequestMapping(value="/deleteTradeFile", method=RequestMethod.GET)
	public String deleteTradeFile(int boardnum, RedirectAttributes rttr, HttpSession session) {
		Board board = b_repository.selectOne(boardnum);
		String fullPath = uploadPath + "/" + board.getSavedfile();
		FileService.deleteFile(fullPath);
		
		board.setOriginalfile("");
		board.setSavedfile("");

		int result = b_repository.boardUpdate(board);
			
		rttr.addAttribute("boardnum", boardnum);
		return "redirect:/tradeUpdate";
	}
		
	
	
	/** 재능기부 관련 controller **/
	// talent 창 띄우기 
	@RequestMapping(value="/talent")
	public String talent(Model model) {
		String service = "재능기부";
		String userid= "aaa";
		Map<String, String> parm = new HashMap<String, String>();
		parm.put("service", service);
		parm.put("userid", userid);
		List<HashMap<String, Object>> map = b_repository.selectList(parm);
		model.addAttribute("map", map);
		return "mystore/talent";
	}
	
	// talent 글 작성 폼 불러오기
	@RequestMapping(value="/talentForm")
	public String talentForm(Model model) {
		List<Categories> c_list = repository.selectClist();
		model.addAttribute("c_list", c_list);
		
		return "mystore/talentForm";
	}
	
	// talentform 작성 
	@RequestMapping(value="/talentwrite", method=RequestMethod.POST) 
	public String talentwrite(Board board, MultipartFile upload, HttpSession session, Product product) {
		String originalfile = upload.getOriginalFilename();
		String savedfile = FileService.saveFile(upload, uploadPath);
		String userid = "aaa";
			
		int result1 = p_repository.insertPdt(product);
		Product pr = p_repository.selectOne();
			
		board.setUserid(userid);
		board.setProductnum(pr.getProductnum());

		board.setOriginalfile(originalfile);
		board.setSavedfile(savedfile);
			
		int result2 = b_repository.insertBrd(board);

		return "redirect:/talent";
	}
	
	// 재능기부 글 상세보기 
	@RequestMapping(value="/talentView", method=RequestMethod.GET)
	public String talentView(int boardnum, Model model) {
		Board board = b_repository.selectOne(boardnum);
		int productnum = board.getProductnum();
		
		HashMap<String, Object> map = p_repository.seletPC(productnum);
		
		String fullPath="";
		if (board.getSavedfile() != null)
			fullPath = uploadPath + "/" + board.getSavedfile();
			try {
				String type = Files.probeContentType(Paths.get(fullPath));
				if(type != null && type.contains("image")){
					model.addAttribute("type", type);
				} else {
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		model.addAttribute("board", board);
		model.addAttribute("map", map);
		
		return "mystore/talentView";
	}
	
	// 재능기부 수정폼 불러오기 
		@RequestMapping(value="/talentUpdate", method=RequestMethod.GET)
		public String talentUpdate(Model model, int boardnum) {
			Board board = b_repository.selectOne(boardnum);
			List<Categories> c_list = repository.selectClist();
			int productnum = board.getProductnum();
			HashMap<String, Object> map = p_repository.seletPC(productnum);

			model.addAttribute("board", board);
			model.addAttribute("map", map);
			model.addAttribute("c_list", c_list);
				
			return "mystore/talentUpdate";
		}
		
	// 재능기부 게시글 수정하기 
	@RequestMapping(value="/talentupdate", method=RequestMethod.POST)
	public String talentupdate(Board board, Product product, MultipartFile upload) {
		int boardnum = board.getBoardnum();
		Board old = b_repository.selectOne(boardnum);
				
		// 첨부한 경우 
		if (upload.getSize() != 0) {
			String fullPath = uploadPath + "/" + old.getSavedfile();
			System.out.println(fullPath);
					
			FileService.deleteFile(fullPath);
			String originalfile = upload.getOriginalFilename();
			String savedfile = FileService.saveFile(upload, uploadPath);
				
			System.out.println("오리지널 파일 :" + originalfile);
			System.out.println("저장된 파일 :" + savedfile);
				
			board.setOriginalfile(originalfile);
			board.setSavedfile(savedfile);
					
		} else {
			if(old.getOriginalfile() != null && old.getSavedfile() != null) {
				board.setOriginalfile(old.getOriginalfile());
				board.setSavedfile(old.getSavedfile());
			} else {
				board.setOriginalfile("");
				board.setSavedfile("");
			}
		}
				
		int productnum = old.getProductnum();
				
				
		Product pr = p_repository.selectPdt(productnum);
		pr.setCategorynum(product.getCategorynum());
		pr.setProductname(product.getProductname());
				
		int result1 = p_repository.updatePdt(pr);
		int result2 = b_repository.boardUpdate(board);
				
		return "redirect:/talent";
	}	
			
	// 등록된 사진 지우기 
	@RequestMapping(value="/deleteTalentFile", method=RequestMethod.GET)
	public String deleteTalentFile(int boardnum, RedirectAttributes rttr, HttpSession session) {
		Board board = b_repository.selectOne(boardnum);
		String fullPath = uploadPath + "/" + board.getSavedfile();
		FileService.deleteFile(fullPath);
			
		board.setOriginalfile("");
		board.setSavedfile("");

		int result = b_repository.boardUpdate(board);
				
		rttr.addAttribute("boardnum", boardnum);
		
		return "redirect:/talentUpdate";
	}
	
		
		
	/** 후기게시판 관련 controller **/
	// review 창 띄우기 
	@RequestMapping(value="/review")
	public String review(Model model) {
		String store_owner = "bbb";
		
		List<Review> list = r_repository.selectReviewAll(store_owner);
		model.addAttribute("list", list);
		
		return "mystore/review";
	}
	
	// review 작성하기 
	@RequestMapping(value="/insertReview", method=RequestMethod.POST)
	public String insertReview(Review review) {
		int result = r_repository.insertReview(review);
		
		return "redirect:/review";
	}
	
	// review 삭제 
	@ResponseBody
	@RequestMapping(value="/deleteReview", method=RequestMethod.GET)
	public String deleteReview(int reviewnum) {
		int result = r_repository.deleteReview(reviewnum);
		
		return "delete!";
	}
	
	/** setting 게시판 controller **/
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
		PageNavigator navi = new PageNavigator(currentPage, totalItemCount,4,4);
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
