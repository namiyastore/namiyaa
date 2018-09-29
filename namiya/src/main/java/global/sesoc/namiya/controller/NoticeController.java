package global.sesoc.namiya.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import global.sesoc.namiya.dao.MembersRepository;
import global.sesoc.namiya.dao.NoticeRepository;
import global.sesoc.namiya.vo.Members;
import global.sesoc.namiya.vo.Notice;

@Controller
public class NoticeController {
	@Autowired
	NoticeRepository repository;
	@Autowired
	MembersRepository Members_repository;
	
	@RequestMapping(value = "noticeList", method = RequestMethod.GET)
	public String noticeList(Model model,HttpSession session) {
		String userid = session.getAttribute("loginId").toString();
		List<Notice> nlist = repository.nListAll(userid);
		model.addAttribute("nlist", nlist);
		
		//myurl을 가져오는 코드 시작		
				
				Members m = new Members();
				
				m.setUserid(userid);
				
				Members result1 = Members_repository.selectOne(m);
				model.addAttribute("myurl", result1.getMyurl());
		//myrul가져오는 코드 여기까지
				
		return "mypage/notice";
	}
	
	@RequestMapping(value = "nInsert", method = RequestMethod.POST)
	public String nInsert(Notice notice) {
		repository.nInsert(notice);
		return "redirect:noticeList";
	}
	
	@RequestMapping(value="nDelete", method = RequestMethod.GET)
	public String nDelete(int noticenum) {
		repository.nDelete(noticenum);
		return "redirect:noticeList";
	}
	
	@RequestMapping(value = "nSelectOne", method = RequestMethod.GET)
	public String nSelectOne(int noticenum,Model model) {
		Notice selectednotice = repository.nSelectOne(noticenum);
		model.addAttribute("selectednotice", selectednotice);
		return "mypage/notice";
	}
	
	@RequestMapping(value = "nUpdate", method = RequestMethod.POST)
	public String nUpdate(Notice notice) {
		System.out.println("넘어오나?6"+notice);
		repository.nUpdate(notice);
		return "redirect:noticeList";
	}

}
