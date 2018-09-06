package global.sesoc.namiya.controller;

import java.util.List;

import org.omg.CORBA.RepositoryIdHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import global.sesoc.namiya.dao.InterestRepository;
import global.sesoc.namiya.vo.Interest;

@Controller
public class InterestController {
	@Autowired
	InterestRepository repository;
	
	@RequestMapping(value="interestList",method = RequestMethod.GET)
	public String interest(Model model) {
		
		List<Interest> ilist = repository.iListAll();
		
//		System.out.println("db에서 넘어왔나?"+ilist);
		
		model.addAttribute("ilist", ilist);
		
		return "mypage/interest";
	}
	
	@RequestMapping(value="iInsert", method = RequestMethod.POST)
	public String iInsert(Interest interest) {
		
		repository.iInsert(interest);
		
		return "redirect:interestList";	
		}
	@RequestMapping(value="iDelete",method = RequestMethod.GET)
	public String iDelete(int interestnum) {
		repository.iDelete(interestnum);
		
		return "redirect:interestList";
	}
	
	@RequestMapping(value = "iSelectOne", method = RequestMethod.GET)
	public String iSelectOne(int interestnum,Model model) {
		Interest selectedInterest = repository.iSelectOne(interestnum);
		model.addAttribute("selectedInterest",selectedInterest);
		return "mypage/interest";
	}
	
	@RequestMapping(value="iUpdate", method = RequestMethod.POST)
	public String iUpdate(Interest interest) {
		repository.iUpdate(interest);
		
		return "redirect:interestList";
	}

}
