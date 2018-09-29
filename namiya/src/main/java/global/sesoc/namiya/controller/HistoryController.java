package global.sesoc.namiya.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import global.sesoc.namiya.dao.BoardRepository;
import global.sesoc.namiya.dao.HistoryRepository;
import global.sesoc.namiya.dao.ProductRepository;
import global.sesoc.namiya.vo.Board;
import global.sesoc.namiya.vo.History;
import global.sesoc.namiya.vo.Product;

@Controller
public class HistoryController {
	@Autowired
	HistoryRepository repositroy;
	
	@Autowired
	ProductRepository p_repository;
	
	@Autowired
	BoardRepository b_repository;
	
	@RequestMapping(value="historyList", method = RequestMethod.GET)
	public String historyListAll(Model model, HttpSession session) {
		String userid = (String) session.getAttribute("loginId");
		
		List<History> hlist = repositroy.hListAll(userid);
		List<Product> plist = new ArrayList<Product>();
		List<Board> blist = new ArrayList<Board>();
		int productnum[] = new int[hlist.size()];
		
		for (int i=0; i < hlist.size(); i++) {
			productnum[i] = hlist.get(i).getProductnum();
			plist.add(p_repository.selectPdt(productnum[i]));
			blist.add(b_repository.selectBoard(productnum[i]));
		}
		
		System.out.println(hlist);
		System.out.println(plist);
		System.out.println(blist);
		model.addAttribute("hlist", hlist);
		model.addAttribute("plist", plist);
		model.addAttribute("blist", blist);
		
		return "mypage/history";
	}
	
	@RequestMapping(value = "hInsert", method = RequestMethod.POST)
	public String hInsert(History history) {
		System.out.println("넘어오는가?7"+history);
		repositroy.hInsert(history);
		return "redirect:historyList";
	}
	
	@RequestMapping(value="hDelete", method = RequestMethod.GET)
	public String hDelete(int historynum) {
		repositroy.hDelete(historynum);
		return "redirect:historyList";
	}
	
	@RequestMapping(value = "hSelectOne", method = RequestMethod.GET)
	public String hSelectOne(int historynum, Model model) {
		History selectedHistory = repositroy.hSelectOne(historynum);
		model.addAttribute("selectedhistory", selectedHistory);
		return "mypage/history";
	}
	
	@RequestMapping(value = "hUpdate", method = RequestMethod.POST)
	public String hUpdate(History history) {
		System.out.println("넘어오는가?9"+history);
		repositroy.hUpdate(history);
		return "redirect:historyList";
	}

}
