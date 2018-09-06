package global.sesoc.namiya.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import global.sesoc.namiya.dao.KeywordRepository;
import global.sesoc.namiya.vo.Keyword;

@Controller
public class KeyWordController {
	@Autowired
	KeywordRepository repository;
	
	@RequestMapping(value="keywordList")
	public String keywordList(Model model) {
		List<Keyword> klist = repository.kListAll();
		System.out.println("db에서1"+klist);
		
		model.addAttribute("klist", klist);
		return "mypage/keyword";
	}
	
	@RequestMapping(value="kInsert",method = RequestMethod.POST )
	public String keyInsert(Keyword keyword) {
		repository.kInsert(keyword);
		return "redirect:keywordList";
	}
	
	@RequestMapping(value = "kDelete", method=RequestMethod.GET)
	public String kDelete(int keywordnum) {
		repository.kDelete(keywordnum);
		return "redirect:keywordList";
	}
	
	@RequestMapping(value="kSelectOne", method=RequestMethod.GET)
	public String kSelectOne(int keywordnum,Model model) {
		Keyword selectedkeyword = repository.kSelectOne(keywordnum);
		model.addAttribute("selectedkeyword", selectedkeyword);
		return "mypage/keyword";
	}
	
	@RequestMapping(value="kUpdate", method = RequestMethod.POST)
	public String kUpdate(Keyword keyword) {
		repository.kUpdate(keyword);
		return "redirect:keywordList";
	}

}
