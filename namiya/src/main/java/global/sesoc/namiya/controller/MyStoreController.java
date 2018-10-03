package global.sesoc.namiya.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.plaf.synth.SynthSeparatorUI;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
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
import global.sesoc.namiya.dao.HistoryRepository;
import global.sesoc.namiya.dao.InterestRepository;
import global.sesoc.namiya.dao.MembersRepository;
import global.sesoc.namiya.dao.MystoreRepository;
import global.sesoc.namiya.dao.ProductRepository;
import global.sesoc.namiya.dao.ProfileRepository;
import global.sesoc.namiya.dao.ReviewRepository;
import global.sesoc.namiya.dao.SavingRepository;
import global.sesoc.namiya.util.FileService;
import global.sesoc.namiya.util.PageNavigator;
import global.sesoc.namiya.vo.Board;
import global.sesoc.namiya.vo.Categories;
import global.sesoc.namiya.vo.History;
import global.sesoc.namiya.vo.Interest;
import global.sesoc.namiya.vo.Members;
import global.sesoc.namiya.vo.Message;
import global.sesoc.namiya.vo.Mystore;
import global.sesoc.namiya.vo.Product;
import global.sesoc.namiya.vo.Profile;
import global.sesoc.namiya.vo.Review;
import global.sesoc.namiya.vo.Saving;
import global.sesoc.namiya.vo.Wish;

@Controller
@Configuration
@EnableScheduling
public class MyStoreController {
	@Autowired
	CategoriesRepository repository;

	@Autowired
	BoardRepository b_repository;

	@Autowired
	ProductRepository p_repository;

	@Autowired
	ReviewRepository r_repository;

	@Autowired
	MystoreRepository m_repository;

	@Autowired
	InterestRepository i_repository;

	@Autowired
	MembersRepository mb_repository;

	@Autowired
	SavingRepository s_repository;

	@Autowired
	HistoryRepository h_repository;

	@Autowired
	ProfileRepository pf_repository;

	final String uploadPath = "/home/img/boardfile";

	final int COUNT_PER_PAGE = 5;

	/**
	 * deal_end 시간 카운트
	 * 
	 * @throws Exception
	 **/

	@Scheduled(cron = "*/30 * * * * *")
	public void updateDeal_end() throws Exception {
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		Date today = Calendar.getInstance().getTime();
		String date = df.format(today);
		Product product = new Product();
		int datecom;
//		System.out.println("cron test:" + date);

		List<History> list = h_repository.selecthListAll();

		for (int i = 0; i < list.size(); i++) {
//			System.out.println(list.get(i).getDeal_end());
			if (list.get(i).getDeal_end() != null) {
				if (date.compareTo(list.get(i).getDeal_end()) >= 0) {
//					System.out.println("if들어감");
					int productnum = list.get(i).getProductnum();
					product = p_repository.selectPdt(productnum);
//					System.out.println(product);

					product.setSstatus("진행완료");
					int result = p_repository.updatePstt2(product);
//					System.out.println("schedule의 result:" + result);
				} else {
//					System.out.println("update는 안됐지");
				}
			} else {
//				System.out.println("if안들어감 : " + list.get(i).getDeal_end());
			}
		}

//		System.out.println("한바뀌 돌았다");
	}

	/** 공통부분 **/
	// 사진 보여주기
	@RequestMapping(value = uploadPath + "/{image_name:.+}", method = RequestMethod.GET)
	public String getContentMediaImage(@PathVariable("image_name") String image_name, HttpServletResponse response)
			throws UnsupportedEncodingException, IOException {
		// 확장자 확인 //

		String[] filename_seperate = image_name.split("\\.");
		String exp = "";

		if (filename_seperate.length <= 1) {
			// 확장자 에러 //
			/*
			 * String resultMsg = new MessageMaker().getErrorMessage("Wrong file name.");
			 * response.getOutputStream().write(resultMsg.getBytes(SystemInfo.ENCODING));
			 */
			response.getOutputStream().flush();
			return null;
		} else {
			exp = filename_seperate[1];
		}
		// 파일 세팅 and 송신 //
		File file = new File(uploadPath + "/" + image_name);
		if (!file.exists()) {
			// 파일 없음 //
			/*
			 * String resultMsg = new
			 * MessageMaker().getErrorMessage("Not exist that file.");
			 * response.getOutputStream().write(resultMsg.getBytes(SystemInfo.ENCODING));
			 */
			response.getOutputStream().flush();
			return null;
		}
		response.setContentType("image/" + exp);
		int cur;
		try {
			FileInputStream fileIn = new FileInputStream(file);
			BufferedInputStream bufIn = new BufferedInputStream(fileIn);
			ServletOutputStream ostream = response.getOutputStream();
			while ((cur = bufIn.read()) != -1) {
				ostream.write(cur);
			}
			ostream.flush();
			bufIn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	// 게시글 삭제하기
	@ResponseBody
	@RequestMapping(value = "/myStore" + "/{miniurl:.+}" + "/deleted", method = RequestMethod.GET)
	public int giveDelete(int boardnum, @PathVariable("miniurl") String miniurl) {
		Board board = b_repository.selectOne(boardnum);
		String fullPath = uploadPath + "/" + board.getSavedfile();
		FileService.deleteFile(fullPath);

		int result = b_repository.deleteOne(boardnum);
		int productnum = board.getProductnum();
		History history = h_repository.selectHst(productnum);

		int result2 = h_repository.hDelete(history.getHistorynum());

		return result;
	}

	/** 양도 관련 controller **/
	// give 페이지 띄우기
	@RequestMapping(value = "/myStore" + "/{miniurl:.+}" + "/give")
	public String give(Model model, HttpSession session,
			@RequestParam(value = "currentPage", defaultValue = "1") int currentPage,
			@PathVariable("miniurl") String miniurl) {
		String service = "양도";

		Members m = new Members();
		m.setMyurl(miniurl);
		Members member = mb_repository.selectUrl(m);
		String userid = member.getUserid();

		Map<String, String> parm = new HashMap<String, String>();
		parm.put("service", service);
		parm.put("userid", userid);

		int totalRecordCount = b_repository.getTotalPage(parm);
		PageNavigator navi = new PageNavigator(currentPage, totalRecordCount, 5, 5);

		List<HashMap<String, Object>> map = b_repository.selectList(parm, navi.getStartRecord(),
				navi.getCountPerPage());
		model.addAttribute("map", map);
		model.addAttribute("navi", navi);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("userid", userid);

		return "mystore/give";
	}

	// give글작성 폼 + 대분류 불러오기
	@RequestMapping(value = "/myStore" + "/{miniurl:.+}" + "/giveForm")
	public String giveForm(Model model, @PathVariable("miniurl") String miniurl) {
		List<Categories> c_list = repository.selectClist();
		model.addAttribute("c_list", c_list);

		return "mystore/giveForm";
	}

	// 중분류 불러오기
	@ResponseBody
	@RequestMapping(value = "/myStore" + "/{miniurl:.+}" + "/selectMlist", method = RequestMethod.GET)
	public List<Categories> selectMlist(int categorynum, @PathVariable("miniurl") String miniurl) {
		List<Categories> m_list = repository.selectMlist(categorynum);

		return m_list;
	}

	// 소분류 불러오기
	@ResponseBody
	@RequestMapping(value = "/myStore" + "/{miniurl:.+}" + "/selectSlist", method = RequestMethod.GET)
	public List<Categories> selectSlist(int categorynum, @PathVariable("miniurl") String miniurl) {
		List<Categories> s_list = repository.selectSlist(categorynum);

		return s_list;
	}

	// give 글작성
	@RequestMapping(value = "/myStore" + "/{miniurl:.+}" + "/write", method = RequestMethod.POST)
	public String write(Board board, MultipartFile upload, HttpSession session, Product product, History history,
			@PathVariable("miniurl") String miniurl) {
		String originalfile = upload.getOriginalFilename();
		String savedfile = FileService.saveFile(upload, uploadPath);

		Members m = new Members();
		m.setMyurl(miniurl);
		Members member = mb_repository.selectUrl(m);
		String userid = member.getUserid();

		int result1 = p_repository.insertPdt(product);
		Product pr = p_repository.selectOne();

		board.setUserid(userid);
		board.setProductnum(pr.getProductnum());

		board.setOriginalfile(originalfile);
		board.setSavedfile(savedfile);

		int result2 = b_repository.insertBrd(board);

		history.setProductnum(pr.getProductnum());
		history.setSellerid(userid);

		int result3 = b_repository.insertHst(history);

		Saving saving = new Saving();

		saving.setType(board.getService());
		saving.setUserid(userid);

		int result = 0;

		if (s_repository.pointTodayCount(saving) > 0) {
			result = s_repository.pointCheck(saving);
		}

		if (saving.getType().equals("양도") && result == 0) {
			int result4 = s_repository.pointAdd(saving);
		} else if (saving.getType().equals("재능기부") && result < 30) {
			int result5 = s_repository.pointAdd(saving);
		}

		return "redirect:/" + "myStore/" + miniurl + "/give";
	}

	// give 글 상세보기
	@RequestMapping(value = "/myStore" + "/{miniurl:.+}" + "/giveView", method = RequestMethod.GET)
	public String giveView(int boardnum, Model model, @PathVariable("miniurl") String miniurl) {
		Board board = b_repository.selectOne(boardnum);
		int productnum = board.getProductnum();

		Members m = new Members();
		m.setMyurl(miniurl);
		Members member = mb_repository.selectUrl(m);
		String userid = member.getUserid();

		HashMap<String, Object> map = p_repository.seletPC(productnum);
		String fullPath = "";
		if (board.getSavedfile() != null)
			fullPath = uploadPath + "/" + board.getSavedfile();
		try {
			String type = Files.probeContentType(Paths.get(fullPath));
			if (type != null && type.contains("image")) {
				model.addAttribute("type", type);
			} else {
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

		model.addAttribute("board", board);
		model.addAttribute("map", map);
		model.addAttribute("userid", userid);

		return "mystore/giveView";
	}

	// 게시글 수정폼 불러오기
	@RequestMapping(value = "/myStore" + "/{miniurl:.+}" + "/giveUpdate", method = RequestMethod.GET)
	public String giveUpdate(Model model, int boardnum, @PathVariable("miniurl") String miniurl) {
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
	@RequestMapping(value = "/myStore" + "/{miniurl:.+}" + "/update", method = RequestMethod.POST)
	public String update(Board board, Product product, MultipartFile upload, @PathVariable("miniurl") String miniurl) {
		int boardnum = board.getBoardnum();
		Board old = b_repository.selectOne(boardnum);

		// 첨부한 경우
		if (upload.getSize() != 0) {
			String fullPath = uploadPath + "/" + old.getSavedfile();
//			System.out.println(fullPath);

			FileService.deleteFile(fullPath);
			String originalfile = upload.getOriginalFilename();
			String savedfile = FileService.saveFile(upload, uploadPath);

//			System.out.println("오리지널 파일 :" + originalfile);
//			System.out.println("저장된 파일 :" + savedfile);

			board.setOriginalfile(originalfile);
			board.setSavedfile(savedfile);

		} else {
			if (old.getOriginalfile() != null && old.getSavedfile() != null) {
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

		return "redirect:/" + "myStore/" + miniurl + "/give";
	}

	// 등록된 사진 지우기
	@RequestMapping(value = "/myStore" + "/{miniurl:.+}" + "/deletefile", method = RequestMethod.GET)
	public String deletefile(int boardnum, RedirectAttributes rttr, HttpSession session,
			@PathVariable("miniurl") String miniurl) {
		Board board = b_repository.selectOne(boardnum);
		String fullPath = uploadPath + "/" + board.getSavedfile();
		FileService.deleteFile(fullPath);

		board.setOriginalfile("");
		board.setSavedfile("");

		int result = b_repository.boardUpdate(board);

		rttr.addAttribute("boardnum", boardnum);
		return "redirect:/" + "myStore/" + miniurl + "/giveUpdate";
	}

	/** 교환 관련 controller **/
	// trade 창 띄우기
	@RequestMapping(value = "/myStore" + "/{miniurl:.+}" + "/trade")
	public String trade(Model model, HttpSession session,
			@RequestParam(value = "currentPage", defaultValue = "1") int currentPage,
			@PathVariable("miniurl") String miniurl) {
		String service = "교환";

		Members m = new Members();
		m.setMyurl(miniurl);
		Members member = mb_repository.selectUrl(m);
		String userid = member.getUserid();

		Map<String, String> parm = new HashMap<String, String>();
		parm.put("service", service);
		parm.put("userid", userid);

		int totalRecordCount = b_repository.getTotalPage(parm);
		PageNavigator navi = new PageNavigator(currentPage, totalRecordCount, 5, 5);

		List<HashMap<String, Object>> map = b_repository.selectList(parm, navi.getStartRecord(),
				navi.getCountPerPage());
		model.addAttribute("map", map);
		model.addAttribute("navi", navi);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("userid", userid);

		return "mystore/trade";
	}

	// trade 글 작성 폼 불러오기
	@RequestMapping(value = "/myStore" + "/{miniurl:.+}" + "/tradeForm")
	public String tradeForm(Model model, @PathVariable("miniurl") String miniurl) {
		List<Categories> c_list = repository.selectClist();
		model.addAttribute("c_list", c_list);

		return "mystore/tradeForm";
	}

	// tradeform 작성
	@RequestMapping(value = "/myStore" + "/{miniurl:.+}" + "/tradewrite", method = RequestMethod.POST)
	public String tradewrite(Board board, MultipartFile upload, HttpSession session, Product product, History history,
			@PathVariable("miniurl") String miniurl) {
		String originalfile = upload.getOriginalFilename();
		String savedfile = FileService.saveFile(upload, uploadPath);

		Members m = new Members();
		m.setMyurl(miniurl);
		Members member = mb_repository.selectUrl(m);
		String userid = member.getUserid();

		int result1 = p_repository.insertPdt(product);
		Product pr = p_repository.selectOne();

		board.setUserid(userid);
		board.setProductnum(pr.getProductnum());

		board.setOriginalfile(originalfile);
		board.setSavedfile(savedfile);

		int result2 = b_repository.insertBrd(board);

		history.setProductnum(pr.getProductnum());
		history.setSellerid(userid);

		int result3 = b_repository.insertHst(history);

		return "redirect:/" + "myStore/" + miniurl + "/trade";
	}

	// trade 게시판 상세보기
	@RequestMapping(value = "/myStore" + "/{miniurl:.+}" + "/tradeView", method = RequestMethod.GET)
	public String tradeView(int boardnum, Model model, @PathVariable("miniurl") String miniurl) {
		Board board = b_repository.selectOne(boardnum);
		int productnum = board.getProductnum();

		Members m = new Members();
		m.setMyurl(miniurl);
		Members member = mb_repository.selectUrl(m);
		String userid = member.getUserid();

		HashMap<String, Object> map = p_repository.seletPC(productnum);

		String fullPath = "";
		if (board.getSavedfile() != null)
			fullPath = uploadPath + "/" + board.getSavedfile();
		try {
			String type = Files.probeContentType(Paths.get(fullPath));
			if (type != null && type.contains("image")) {
				model.addAttribute("type", type);
			} else {
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

		model.addAttribute("board", board);
		model.addAttribute("map", map);
		model.addAttribute("userid", userid);

		return "mystore/tradeView";
	}

	// 교환글 수정폼 불러오기
	@RequestMapping(value = "/myStore" + "/{miniurl:.+}" + "/tradeUpdate", method = RequestMethod.GET)
	public String tradeUpdate(Model model, int boardnum, @PathVariable("miniurl") String miniurl) {
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
	@RequestMapping(value = "/myStore" + "/{miniurl:.+}" + "/tradeupdate", method = RequestMethod.POST)
	public String tradeupdate(Board board, Product product, MultipartFile upload,
			@PathVariable("miniurl") String miniurl) {
		int boardnum = board.getBoardnum();
		Board old = b_repository.selectOne(boardnum);

		// 첨부한 경우
		if (upload.getSize() != 0) {
			String fullPath = uploadPath + "/" + old.getSavedfile();
//			System.out.println(fullPath);

			FileService.deleteFile(fullPath);
			String originalfile = upload.getOriginalFilename();
			String savedfile = FileService.saveFile(upload, uploadPath);

//			System.out.println("오리지널 파일 :" + originalfile);
//			System.out.println("저장된 파일 :" + savedfile);

			board.setOriginalfile(originalfile);
			board.setSavedfile(savedfile);

		} else {
			if (old.getOriginalfile() != null && old.getSavedfile() != null) {
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

		return "redirect:/" + "myStore/" + miniurl + "/trade";
	}

	// 등록된 사진 지우기
	@RequestMapping(value = "/myStore" + "/{miniurl:.+}" + "/deleteTradeFile", method = RequestMethod.GET)
	public String deleteTradeFile(int boardnum, RedirectAttributes rttr, HttpSession session,
			@PathVariable("miniurl") String miniurl) {
		Board board = b_repository.selectOne(boardnum);
		String fullPath = uploadPath + "/" + board.getSavedfile();
		FileService.deleteFile(fullPath);

		board.setOriginalfile("");
		board.setSavedfile("");

		int result = b_repository.boardUpdate(board);

		rttr.addAttribute("boardnum", boardnum);
		return "redirect:/" + "myStore/" + miniurl + "/tradeUpdate";
	}

	/** 재능기부 관련 controller **/
	// talent 창 띄우기
	@RequestMapping(value = "/myStore" + "/{miniurl:.+}" + "/talent")
	public String talent(Model model, HttpSession session,
			@RequestParam(value = "currentPage", defaultValue = "1") int currentPage,
			@PathVariable("miniurl") String miniurl) {
		String service = "재능기부";

		Members m = new Members();
		m.setMyurl(miniurl);
		Members member = mb_repository.selectUrl(m);
		String userid = member.getUserid();
		Map<String, String> parm = new HashMap<String, String>();
		parm.put("service", service);
		parm.put("userid", userid);

		int totalRecordCount = b_repository.getTotalPage(parm);
		PageNavigator navi = new PageNavigator(currentPage, totalRecordCount, 5, 5);

		List<HashMap<String, Object>> map = b_repository.selectList(parm, navi.getStartRecord(),
				navi.getCountPerPage());
		model.addAttribute("map", map);
		model.addAttribute("navi", navi);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("userid", userid);

		return "mystore/talent";
	}

	// talent 글 작성 폼 불러오기
	@RequestMapping(value = "/myStore" + "/{miniurl:.+}" + "/talentForm")
	public String talentForm(Model model, @PathVariable("miniurl") String miniurl) {
		List<Categories> c_list = repository.selectClist();
		model.addAttribute("c_list", c_list);

		return "mystore/talentForm";
	}

	// talentform 작성
	@RequestMapping(value = "/myStore" + "/{miniurl:.+}" + "/talentwrite", method = RequestMethod.POST)
	public String talentwrite(Board board, MultipartFile upload, HttpSession session, Product product, History history,
			@PathVariable("miniurl") String miniurl) {
		String originalfile = upload.getOriginalFilename();
		String savedfile = FileService.saveFile(upload, uploadPath);

		Members m = new Members();
		m.setMyurl(miniurl);
		Members member = mb_repository.selectUrl(m);
		String userid = member.getUserid();

		int result1 = p_repository.insertPdt(product);
		Product pr = p_repository.selectOne();

		board.setUserid(userid);
		board.setProductnum(pr.getProductnum());

		board.setOriginalfile(originalfile);
		board.setSavedfile(savedfile);

		int result2 = b_repository.insertBrd(board);

		history.setProductnum(pr.getProductnum());
		history.setSellerid(userid);

		int result3 = b_repository.insertHst(history);

		Saving saving = new Saving();

		saving.setType(board.getService());
		saving.setUserid(userid);

		int result = 0;

		if (s_repository.pointTodayCount(saving) > 0) {
			result = s_repository.pointCheck(saving);
		}

		if (saving.getType().equals("양도") && result == 0) {
			int result4 = s_repository.pointAdd(saving);
		} else if (saving.getType().equals("재능기부") && result < 30) {
			int result5 = s_repository.pointAdd(saving);
		}

		return "redirect:/" + "myStore/" + miniurl + "/talent";
	}

	// 재능기부 글 상세보기
	@RequestMapping(value = "/myStore" + "/{miniurl:.+}" + "/talentView", method = RequestMethod.GET)
	public String talentView(int boardnum, Model model, @PathVariable("miniurl") String miniurl) {
		Board board = b_repository.selectOne(boardnum);
		int productnum = board.getProductnum();

		Members m = new Members();
		m.setMyurl(miniurl);
		Members member = mb_repository.selectUrl(m);
		String userid = member.getUserid();

		HashMap<String, Object> map = p_repository.seletPC(productnum);

		String fullPath = "";
		if (board.getSavedfile() != null)
			fullPath = uploadPath + "/" + board.getSavedfile();
		try {
			String type = Files.probeContentType(Paths.get(fullPath));
			if (type != null && type.contains("image")) {
				model.addAttribute("type", type);
			} else {
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

		model.addAttribute("board", board);
		model.addAttribute("map", map);
		model.addAttribute("userid", userid);

		return "mystore/talentView";
	}

	// 재능기부 수정폼 불러오기
	@RequestMapping(value = "/myStore" + "/{miniurl:.+}" + "/talentUpdate", method = RequestMethod.GET)
	public String talentUpdate(Model model, int boardnum, @PathVariable("miniurl") String miniurl) {
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
	@RequestMapping(value = "/myStore" + "/{miniurl:.+}" + "/talentupdate", method = RequestMethod.POST)
	public String talentupdate(Board board, Product product, MultipartFile upload,
			@PathVariable("miniurl") String miniurl) {
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
			if (old.getOriginalfile() != null && old.getSavedfile() != null) {
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

		return "redirect:/" + "myStore/" + miniurl + "/talent";
	}

	// 등록된 사진 지우기
	@RequestMapping(value = "/myStore" + "/{miniurl:.+}" + "/deleteTalentFile", method = RequestMethod.GET)
	public String deleteTalentFile(int boardnum, RedirectAttributes rttr, HttpSession session,
			@PathVariable("miniurl") String miniurl) {
		Board board = b_repository.selectOne(boardnum);
		String fullPath = uploadPath + "/" + board.getSavedfile();
		FileService.deleteFile(fullPath);

		board.setOriginalfile("");
		board.setSavedfile("");

		int result = b_repository.boardUpdate(board);

		rttr.addAttribute("boardnum", boardnum);

		return "redirect:/" + "myStore/" + miniurl + "/talentUpdate";
	}

	/** 후기게시판 관련 controller **/
	// review 창 띄우기
	@RequestMapping(value = "/myStore" + "/{miniurl:.+}" + "/review")
	public String review(Model model, @RequestParam(value = "currentPage", defaultValue = "1") int currentPage,
			@PathVariable("miniurl") String miniurl) {
		Members m = new Members();
		m.setMyurl(miniurl);
		Members member = mb_repository.selectUrl(m);
		String store_owner = member.getUserid();

		int totalRecordCount = b_repository.reviewgetTotalPage(store_owner);
		PageNavigator navi = new PageNavigator(currentPage, totalRecordCount, 5, 5);

//		System.out.println(member);
		List<Review> list = r_repository.selectReviewAll(store_owner, navi.getStartRecord(), navi.getCountPerPage());

		model.addAttribute("navi", navi);
		model.addAttribute("list", list);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("store_owner", store_owner);

		return "mystore/review";
	}
	
	// review 작성하기
	@RequestMapping(value = "/myStore" + "/{miniurl:.+}" + "/insertReview", method = RequestMethod.POST)
	public String insertReview(Review review, @PathVariable("miniurl") String miniurl) {
//		System.out.println(review);
		int result = r_repository.insertReview(review);

		return "redirect:/" + "myStore/" + miniurl + "/review";
	}

	// review 삭제
	@ResponseBody
	@RequestMapping(value = "/myStore" + "/{miniurl:.+}" + "/deleteReview", method = RequestMethod.GET)
	public String deleteReview(int reviewnum, @PathVariable("miniurl") String miniurl) {
		int result = r_repository.deleteReview(reviewnum);

		return "delete!";
	}

	/** interest controller **/
	@ResponseBody
	@RequestMapping(value = "/myStore" + "/{miniurl:.+}"
			+ "/selectItr", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public String selectItr(@RequestBody Interest interest, @PathVariable("miniurl") String miniurl) {
//		System.out.println(interest);
		Map<String, String> parm = new HashMap<String, String>();
		parm.put("userid", interest.getUserid());
		parm.put("boardnum", "" + interest.getBoardnum());
//		System.out.println(interest);

		Interest itr = b_repository.selectItr(parm);
//		System.out.println("itr:" + itr);

		if (itr == null) {
//			System.out.println("itr null");

			int result = b_repository.insertItr(interest);
//			System.out.println(result);
			return "관심상품 목록에 추가되었습니다!";
		} else {
			return "이미 관심상품목록에 존재합니다!";
		}
	}

	/** 거래내역 controller **/
	@RequestMapping(value = "/deal", method = RequestMethod.GET)
	public String deal(int historynum, Model model) {
		// 양도신청자 띄우기
		History history = b_repository.selectHst(historynum);
		int productnum = history.getProductnum();
		Product product = p_repository.selectPdt(productnum);

		Board board = b_repository.selectBoard(productnum);
		List<Wish> wlist = b_repository.selectWishAll(board.getBoardnum());

		// 오늘 날짜
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		Date today = Calendar.getInstance().getTime();
		String date = df.format(today);

		// 결과 넘기기
		model.addAttribute("wlist", wlist);
		model.addAttribute("history", history);
		model.addAttribute("board", board);
		model.addAttribute("product", product);

		return "mystore/deal";
	}

	/** 쪽지보내기 controller **/
	// 쪽지 보내는 창 띄우기
	@RequestMapping(value = "/sendMsg", method = RequestMethod.GET)
	public String sendMsg(String userid, Model model) {
		model.addAttribute("userid", userid);

		return "mystore/sendMsg";
	}

	// 쪽지보내기
	@RequestMapping(value = "/insertMsg", method = RequestMethod.POST)
	public String insertMsg(Message message, Model model) {
//		System.out.println(message);
		int result = b_repository.insertMsg(message);

		model.addAttribute("userid", message.getUserid());

//		System.out.println("쪽지보내기 result: " + result);

		return "redirect:/sendMsg";

	}

	/** 양도신청 controller **/
	@ResponseBody
	@RequestMapping(value = "/myStore" + "/{miniurl:.+}"
			+ "/DontusePoint", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public String selectWish(@RequestBody Wish wish, Model model, @PathVariable("miniurl") String miniurl) {
//		System.out.println(wish);
		Map<String, String> param = new HashMap<String, String>();
		param.put("userid", wish.getUserid());
		param.put("boardnum", "" + wish.getBoardnum());

		Board board = b_repository.selectOne(wish.getBoardnum());
//		System.out.println(board);

		Product product = p_repository.selectPdt(board.getProductnum());
//		System.out.println(product);

		String status = "진행중";

		product.setSstatus(status);

		int pudt = p_repository.updatePstt(product);

//		System.out.println("update product :" + product);
//		System.out.println("product 결과:" + pudt);

		History history = b_repository.selectHstone(board.getProductnum());

//		System.out.println("history거래내역:" + history);

		List<Wish> wlist = b_repository.selectWish(param);
//		System.out.println(wlist);

		if (wlist.size() == 0) {
//			System.out.println(wlist);

			int result = b_repository.insertWish(wish);

			String deal_end = null;
			String deal_start = null;

			// deal_start 설정
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			Date today = Calendar.getInstance().getTime();
			deal_start = df.format(today);

			history.setDeal_start(deal_start);

			// deal_end 설정
			Date date = new Date();
			SimpleDateFormat sdformat = new SimpleDateFormat("yyyy-MM-dd");
			Calendar cal = Calendar.getInstance();
			cal.setTime(date);
			cal.add(Calendar.DATE, 1);
			deal_end = sdformat.format(cal.getTime());

			history.setDeal_end(deal_end);

			int result2 = b_repository.updateHst(history);

//			System.out.println("history update 결과:" + result2);

			return "양도신청을 완료했습니다!";
		} else {
			return "이미 양도신청을 했습니다!";
		}
	}

	/** 당첨자 추천 **/
	@ResponseBody
	@RequestMapping(value = "/selectWinner", method = RequestMethod.POST)
	public Map<String, String> selectWinner(int historynum, Model model, HttpSession session) {
		String sellerid = (String)session.getAttribute("loginId");
		History history = b_repository.selectHst(historynum);
		int productnum = history.getProductnum();
		Board board = b_repository.selectBoard(productnum);
		List<Wish> wlist = b_repository.selectWishAll(board.getBoardnum());

		String[] winner = new String[wlist.size()];

		for (int i = 0; i < wlist.size(); i++) {
			winner[i] = wlist.get(i).getUserid();
			System.out.println(winner[i]);
		}

//		System.out.println("신청자목록:" + wlist);

		int wn = (int) ((Math.random() * winner.length) - 1);
//		System.out.println(wn);

		String winid = winner[wn];
//		System.out.println("당첨자:" + winid);
		history.setBuyerid(winid);

		Product product = p_repository.selectPdt(productnum);
		product.setSstatus("추첨완료");

		int result = b_repository.updateBuyer(history);
		int result2 = p_repository.updatePstt(product);
//		System.out.println("winner : " + winner[wn]);
		
		Map<String,String> map = new HashMap<String,String>();
		map.put("winnerid", winid);
		map.put("sellerid", sellerid);
		
		return map;
	}

	/** 포인트 확인 controller **/
	@RequestMapping(value = "/myStore" + "/{miniurl:.+}" + "/checkPoint")
	public String checkPoint(@PathVariable("miniurl") String miniurl, HttpSession session, Model model, int boardnum) {
		String userid = (String) session.getAttribute("loginId");
		int point_total = s_repository.pointTotal(userid);
		model.addAttribute("point_total", point_total);
		model.addAttribute("boardnum", boardnum);
		return "mystore/checkPoint";
	}

	@ResponseBody
	@RequestMapping(value = "/myStore" + "/{miniurl:.+}"
			+ "/usePoint", method = RequestMethod.GET, produces = "application/text; charset=utf8")
	public String UsePoint(Model model, @PathVariable("miniurl") String miniurl, String userid, int usepoint,
			int boardnum) {
//		System.out.println(userid);
//		System.out.println(usepoint);

		Wish wish = new Wish();
		wish.setBoardnum(boardnum);
		wish.setUserid(userid);

		Map<String, String> param = new HashMap<String, String>();
		param.put("userid", wish.getUserid());
		param.put("boardnum", "" + wish.getBoardnum());

		Board board = b_repository.selectOne(wish.getBoardnum());
//		System.out.println(board);

		Product product = p_repository.selectPdt(board.getProductnum());
//		System.out.println(product);

		String status = "진행중";

		product.setSstatus(status);

		int pudt = p_repository.updatePstt(product);

//		System.out.println("update product :" + product);
//		System.out.println("product 결과:" + pudt);

		History history = b_repository.selectHstone(board.getProductnum());

//		System.out.println("history거래내역:" + history);

		List<Wish> wlist = b_repository.selectWish(param);

		// Wish wsh = b_repository.selectWish(param);
//		System.out.println(wlist);

		if (wlist.size() == 0) {
//			System.out.println("wish null");
			Saving saving = new Saving();

			saving.setPoint(-(usepoint));
			saving.setUserid(userid);

			int result = s_repository.pointMinus(saving);
//			System.out.println(result);

			int a = usepoint / 200;

			for (int i = 0; i <= a; i++) {
				int result1 = b_repository.insertWish(wish);
//				System.out.println(result1);
			}

			String deal_end = null;
			String deal_start = null;

			// deal_start 설정
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			Date today = Calendar.getInstance().getTime();
			deal_start = df.format(today);

			history.setDeal_start(deal_start);

//			System.out.println("deal_start:" + deal_start);
			// deal_end 설정
			Date date = new Date();
			SimpleDateFormat sdformat = new SimpleDateFormat("yyyy-MM-dd");
			Calendar cal = Calendar.getInstance();
			cal.setTime(date);
			cal.add(Calendar.DATE, 1);
			deal_end = sdformat.format(cal.getTime());

			history.setDeal_end(deal_end);

//			System.out.println("deal_end:" + deal_end);

//			System.out.println("set deal_end history:" + history);

			int result2 = b_repository.updateHst(history);

//			System.out.println("history update 결과:" + result2);

			return "양도신청을 완료했습니다!";
		} else {
			return "이미 양도신청을 했습니다!";
		}
	}

}
