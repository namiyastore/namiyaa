package global.sesoc.namiya.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.omg.CORBA.RepositoryIdHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import global.sesoc.namiya.dao.InterestRepository;
import global.sesoc.namiya.dao.MembersRepository;
import global.sesoc.namiya.vo.Interest;
import global.sesoc.namiya.vo.Members;

@Controller
public class InterestController {
	@Autowired
	InterestRepository repository;
	@Autowired
	MembersRepository Members_repository;
	
	@RequestMapping(value="interestList",method = RequestMethod.GET)
	public String interest(HttpSession session ,Model model) {
		

		//myurl을 가져오는 코드		
		String userid = session.getAttribute("loginId").toString();
		System.out.println("0930 userid? " + userid);
		List<Interest> ilist = repository.iListAll(userid);
		Members m = new Members();
		
		m.setUserid(userid);
		
		Members result1 = Members_repository.selectOne(m);
		model.addAttribute("myurl", result1.getMyurl());
//		여기는 리스트 뿌려주는 코드 
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
