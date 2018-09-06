package global.sesoc.namiya.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import global.sesoc.namiya.dao.HistoryRepository;
import global.sesoc.namiya.vo.History;

@Controller
public class HistoryController {
	@Autowired
	HistoryRepository repositroy;
	
	@RequestMapping(value="historyList", method = RequestMethod.GET)
	public String historyListAll(Model model) {
		
		List<History> hlist = repositroy.hListAll();
		
		model.addAttribute("hlist", hlist);
		
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
