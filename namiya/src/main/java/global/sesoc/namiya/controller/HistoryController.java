package global.sesoc.namiya.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.swing.plaf.synth.SynthSeparatorUI;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import global.sesoc.namiya.dao.BoardRepository;
import global.sesoc.namiya.dao.HistoryRepository;
import global.sesoc.namiya.dao.ProductRepository;
import global.sesoc.namiya.dao.ProfileRepository;
import global.sesoc.namiya.util.PageNavigator;
import global.sesoc.namiya.vo.Board;
import global.sesoc.namiya.vo.History;
import global.sesoc.namiya.vo.Message;
import global.sesoc.namiya.vo.Product;
import global.sesoc.namiya.vo.Profile;

@Controller
public class HistoryController {
	@Autowired
	HistoryRepository repository;
	
	@Autowired
	ProductRepository p_repository;
	
	@Autowired
	BoardRepository b_repository;
	
	@Autowired
	ProfileRepository profile_repository;
	
	@RequestMapping(value="historyList", method = RequestMethod.GET)
	public String historyListAll(Model model, HttpSession session,
			@RequestParam(value = "currentPage", defaultValue="1") int currentPage) {
		String userid = (String) session.getAttribute("loginId");
		
		//페이징 관련코드 0928
		int totalRecordCount = repository.getHistoryRecordCount(userid);
		PageNavigator navi = new PageNavigator(currentPage, totalRecordCount,10,5);
		
		System.out.println("181003 currentPage and totalRecordCount? " + currentPage + totalRecordCount);
		
		List<History> hlist = repository.hListAll(userid,navi.getStartRecord(),navi.getCountPerPage());
		
		System.out.println("181003검사???"+navi.getStartRecord() +", "+navi.getCountPerPage());
		
		//여기까지 페이징관련 코드 0928
		
		List<Product> plist = new ArrayList<Product>();
		List<Board> blist = new ArrayList<Board>();
		int productnum[] = new int[hlist.size()];
		
		for (int i=0; i < hlist.size(); i++) {
			productnum[i] = hlist.get(i).getProductnum();
			plist.add(p_repository.selectPdt(productnum[i]));
			blist.add(b_repository.selectBoard(productnum[i]));
		}
		
		/*System.out.println(hlist);
		System.out.println(plist);
		System.out.println(blist);*/
		
		//프로필사진 갱신
		Profile profile = profile_repository.select(userid);
		model.addAttribute("profile",profile);
				
		model.addAttribute("hlist", hlist);
		model.addAttribute("plist", plist);
		model.addAttribute("blist", blist);
		//페이징 처리위한 모델
		model.addAttribute("navi", navi);
		model.addAttribute("currentPage", currentPage);
		
		return "mypage/history";
	}
	
	@RequestMapping(value = "hInsert", method = RequestMethod.POST)
	public String hInsert(History history) {
		repository.hInsert(history);
		return "redirect:historyList";
	}
	
	@RequestMapping(value="hDelete", method = RequestMethod.GET)
	public String hDelete(int historynum) {
		repository.hDelete(historynum);
		return "redirect:historyList";
	}
	
	@RequestMapping(value = "hSelectOne", method = RequestMethod.GET)
	public String hSelectOne(int historynum, Model model) {
		History selectedHistory = repository.hSelectOne(historynum);
		model.addAttribute("selectedhistory", selectedHistory);
		return "mypage/history";
	}
	
	@RequestMapping(value = "hUpdate", method = RequestMethod.POST)
	public String hUpdate(History history) {
		repository.hUpdate(history);
		return "redirect:historyList";
	}

}
