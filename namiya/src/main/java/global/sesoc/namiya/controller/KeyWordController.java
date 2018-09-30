package global.sesoc.namiya.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import global.sesoc.namiya.dao.KeywordRepository;
import global.sesoc.namiya.dao.MembersRepository;
import global.sesoc.namiya.vo.Keyword;
import global.sesoc.namiya.vo.Members;

@Controller
public class KeyWordController {
	@Autowired
	KeywordRepository repository;
	@Autowired
	MembersRepository Members_repository;
	
	@RequestMapping(value="keywordList")
	public String keywordList(HttpSession session ,Model model) {
		String userid = session.getAttribute("loginId").toString();
		
		List<Keyword> klist = repository.kListAll(userid);
		
		model.addAttribute("klist", klist);
		
		//myurl을 가져오는 코드		
				
				Members m = new Members();
				
				m.setUserid(userid);
				
				Members result1 = Members_repository.selectOne(m);
				model.addAttribute("myurl", result1.getMyurl());
		return "mypage/keyword";
	}
	
	@RequestMapping(value="kInsert",method = RequestMethod.POST )
	public String keyInsert(Keyword keyword) {
		repository.kInsert(keyword);
		return "redirect:keywordList";
	}
	
	//키워드 등록할때 창 이동
	@RequestMapping(value="keywordRegistry",method = RequestMethod.GET )
	public String keyInsert() {
		return "mypage/keywordReg";
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
